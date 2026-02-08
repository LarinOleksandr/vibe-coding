param(
  [switch]$Verbose
)

$ErrorActionPreference = "Stop"

function Resolve-FullPath {
  param([Parameter(Mandatory = $true)][string]$PathLike)
  try {
    return [System.IO.Path]::GetFullPath($PathLike)
  } catch {
    throw "Invalid path: $PathLike"
  }
}

function Get-GitOutput {
  param([Parameter(Mandatory = $true)][string[]]$Args)
  if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "git is required but was not found on PATH."
  }

  $out = & git @Args
  if ($LASTEXITCODE -ne 0) { throw ("git " + ($Args -join " ") + " failed with exit code " + $LASTEXITCODE) }
  return ($out | Out-String).Trim()
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

function Get-GitFiles {
  if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "git is required but was not found on PATH."
  }

  $out = & git ls-files
  if ($LASTEXITCODE -ne 0) { throw "git ls-files failed." }
  return ($out | ForEach-Object { $_.Trim() } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
}

function Get-TargetFiles {
  $files = Get-GitFiles

  return $files | Where-Object {
    ($_ -eq "AGENTS.md") -or
    ($_ -like ".codex/skills/*") -or
    ($_ -like "docs/*") -or
    ($_ -like "docs-ai/*")
  } | Where-Object {
    $_.ToLowerInvariant().EndsWith(".md") -or $_.ToLowerInvariant().EndsWith(".ps1")
  }
}

function Find-AbsolutePaths {
  param([Parameter(Mandatory = $true)][string[]]$Files)

  $patterns = @(
    # Windows drive absolute paths
    "(?i)\b[A-Z]:\\",
    "(?i)\b[A-Z]:/",
    # Common OS user home absolutes
    "/Users/",
    "/home/"
  )

  $hits = @()
  foreach ($file in $Files) {
    if (-not (Test-Path $file)) { continue }

    foreach ($pattern in $patterns) {
      $matches = Select-String -Path $file -Pattern $pattern -AllMatches -SimpleMatch:$false -Encoding UTF8 -ErrorAction SilentlyContinue
      foreach ($m in $matches) {
        $hits += [pscustomobject]@{
          File = $file
          Line = $m.LineNumber
          Text = $m.Line.Trim()
          Pattern = $pattern
        }
      }
    }
  }

  return $hits
}

$anchorRoot = Resolve-AnchorRoot
$worktreeRoot = Get-GitOutput @("rev-parse", "--show-toplevel")
$anchorRootFull = Resolve-FullPath $anchorRoot
$worktreesRoot = Resolve-FullPath (Join-Path $anchorRootFull ".worktrees")
$worktreeRootFull = Resolve-FullPath $worktreeRoot

$inWorktree = Test-PathIsUnder -Parent $worktreesRoot -Child $worktreeRootFull
if (-not $inWorktree) {
  Write-Host "Verification failed: not running inside a worktree under '.worktrees/...'."
  Write-Host "Fix: run the worktree gate first:"
  Write-Host '  powershell -NoProfile -ExecutionPolicy Bypass -File scripts/git-worktree-ensure.ps1 -ThreadName "<thread name>"'
  exit 1
}

$targets = Get-TargetFiles
if ($Verbose) {
  Write-Host ("Verifying " + $targets.Count + " tracked files...")
}

$hits = Find-AbsolutePaths -Files $targets

if ($hits.Count -gt 0) {
  Write-Host "Verification failed: absolute OS paths found. Use KB_ROOTS aliases (ROOT_*/KB_*/DOC_*) or repo-relative paths."
  Write-Host ""
  $hits | Sort-Object File, Line | Select-Object -First 200 | ForEach-Object {
    Write-Host ("- " + $_.File + ":" + $_.Line + " :: " + $_.Text)
  }
  if ($hits.Count -gt 200) {
    Write-Host ("... plus " + ($hits.Count - 200) + " more.")
  }
  exit 1
}

Write-Host "Verification passed."

