param(
  [string]$ThreadName,
  [string]$BaseBranch,
  [switch]$NoPull,
  [switch]$DryRun,
  [switch]$Json
)

$ErrorActionPreference = "Stop"

function Invoke-Git {
  param([Parameter(Mandatory = $true)][string[]]$Args)
  if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "git is required but was not found on PATH."
  }
  & git @Args
  if ($LASTEXITCODE -ne 0) {
    throw ("git " + ($Args -join " ") + " failed with exit code " + $LASTEXITCODE)
  }
}

function Get-GitOutput {
  param([Parameter(Mandatory = $true)][string[]]$Args)
  if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "git is required but was not found on PATH."
  }
  $out = & git @Args
  if ($LASTEXITCODE -ne 0) {
    throw ("git " + ($Args -join " ") + " failed with exit code " + $LASTEXITCODE)
  }
  return ($out | Out-String).Trim()
}

function Resolve-FullPath {
  param([Parameter(Mandatory = $true)][string]$PathLike)
  try {
    return [System.IO.Path]::GetFullPath($PathLike)
  } catch {
    throw "Invalid path: $PathLike"
  }
}

function Resolve-AnchorRoot {
  $worktreeRoot = $null
  try {
    $worktreeRoot = Get-GitOutput @("rev-parse", "--show-toplevel")
  } catch {
    throw "This script must be run inside a git repository."
  }

  $commonDir = $null
  try {
    $commonDir = Get-GitOutput @("rev-parse", "--git-common-dir")
  } catch {
    return $worktreeRoot
  }

  $worktreeRootFull = Resolve-FullPath $worktreeRoot
  $commonDirFull = $commonDir
  if (-not [System.IO.Path]::IsPathRooted($commonDirFull)) {
    $commonDirFull = Resolve-FullPath (Join-Path $worktreeRootFull $commonDirFull)
  } else {
    $commonDirFull = Resolve-FullPath $commonDirFull
  }

  if ($commonDirFull.ToLowerInvariant().EndsWith("\.git") -or $commonDirFull.ToLowerInvariant().EndsWith("/.git")) {
    return (Split-Path $commonDirFull -Parent)
  }

  return $worktreeRoot
}

function Test-PathIsUnder {
  param(
    [Parameter(Mandatory = $true)][string]$Parent,
    [Parameter(Mandatory = $true)][string]$Child
  )

  $p = Resolve-FullPath $Parent
  $c = Resolve-FullPath $Child

  $pNorm = $p.TrimEnd("\", "/") + "\"
  $cNorm = $c.TrimEnd("\", "/") + "\"

  return $cNorm.ToLowerInvariant().StartsWith($pNorm.ToLowerInvariant())
}

function Ensure-GitHooksInstalled {
  param(
    [Parameter(Mandatory = $true)][string]$AnchorRootFull,
    [switch]$DryRun
  )

  $hooksFile = Join-Path $AnchorRootFull ".githooks/pre-commit"
  if (-not (Test-Path $hooksFile)) { return }

  $hooksPath = $null
  try {
    $hooksPath = Get-GitOutput @("config", "--get", "core.hooksPath")
  } catch {
    $hooksPath = ""
  }

  if (-not [string]::IsNullOrWhiteSpace($hooksPath)) { return }

  if ($DryRun) { return }

  Invoke-Git @("config", "core.hooksPath", ".githooks")
}

$anchorRoot = Resolve-AnchorRoot
$currentTop = Get-GitOutput @("rev-parse", "--show-toplevel")
$currentTopFull = Resolve-FullPath $currentTop
$anchorRootFull = Resolve-FullPath $anchorRoot
Ensure-GitHooksInstalled -AnchorRootFull $anchorRootFull -DryRun:$DryRun
$worktreesRoot = Resolve-FullPath (Join-Path $anchorRootFull ".worktrees")
$isInWorktree = Test-PathIsUnder -Parent $worktreesRoot -Child $currentTopFull

if ($isInWorktree) {
  $branch = Get-GitOutput @("rev-parse", "--abbrev-ref", "HEAD")
  if ($branch -ne "main" -and $branch -ne "master") {
    $payload = [pscustomobject]@{
      AnchorRoot = $anchorRootFull
      WorktreeRoot = $currentTopFull
      BranchName = $branch
      Created = $false
    }
    if ($Json) { $payload | ConvertTo-Json -Compress } else { Write-Host ("Already in worktree: " + $currentTopFull) }
    exit 0
  }

  # Worktree exists, but it is on a protected base branch. Treat as unsafe for task work.
  $isInWorktree = $false
}

if ([string]::IsNullOrWhiteSpace($ThreadName)) {
  throw "Not in a worktree. Provide -ThreadName to create a safe per-task worktree under '.worktrees/'."
}

$startScript = Join-Path $PSScriptRoot "git-worktree-start.ps1"

$args = @(
  "-NoProfile",
  "-ExecutionPolicy", "Bypass",
  "-File", $startScript,
  "-ThreadName", $ThreadName,
  "-Json"
)
if (-not [string]::IsNullOrWhiteSpace($BaseBranch)) { $args += @("-BaseBranch", $BaseBranch) }
if ($NoPull) { $args += "-NoPull" }
if ($DryRun) { $args += "-DryRun" }

$startJson = & powershell @args
if ($LASTEXITCODE -ne 0) { throw "Failed to compute worktree info." }
$start = $startJson | ConvertFrom-Json

if (-not $DryRun) {
  $createArgs = @(
    "-NoProfile",
    "-ExecutionPolicy", "Bypass",
    "-File", $startScript,
    "-ThreadName", $ThreadName
  )
  if (-not [string]::IsNullOrWhiteSpace($BaseBranch)) { $createArgs += @("-BaseBranch", $BaseBranch) }
  if ($NoPull) { $createArgs += "-NoPull" }
  & powershell @createArgs | Out-Null
  if ($LASTEXITCODE -ne 0) { throw "Failed to create worktree." }
}

$payload = [pscustomobject]@{
  AnchorRoot = $start.AnchorRoot
  WorktreeRoot = $start.WorktreeFullPath
  BranchName = $start.BranchName
  Created = (-not $DryRun)
}

if ($Json) {
  $payload | ConvertTo-Json -Compress
} else {
  Write-Host ("Worktree ready: " + $payload.WorktreeRoot)
  Write-Host ("Branch: " + $payload.BranchName)
  Write-Host ("Next: cd " + $payload.WorktreeRoot)
}
