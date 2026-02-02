param(
  [Parameter(Mandatory = $true)][string]$BranchName,
  [string]$BaseBranch,
  [switch]$DeleteRemoteBranch,
  [switch]$Force,
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"

function Get-GitOutput {
  param([Parameter(Mandatory = $true)][string[]]$Args)
  if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "git is required but was not found on PATH."
  }
  $out = & git @Args 2>&1
  if ($LASTEXITCODE -ne 0) {
    throw ("git " + ($Args -join " ") + " failed with exit code " + $LASTEXITCODE + ": " + ($out | Out-String).Trim())
  }
  return ($out | Out-String).Trim()
}

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

function Try-Invoke-Git {
  param([Parameter(Mandatory = $true)][string[]]$Args)
  if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    return [pscustomobject]@{ Ok = $false; Output = "git not found on PATH." }
  }
  $out = & git @Args 2>&1
  $ok = ($LASTEXITCODE -eq 0)
  return [pscustomobject]@{ Ok = $ok; Output = ($out | Out-String).Trim() }
}

function Resolve-BaseBranch {
  param([string]$Candidate)
  if (-not [string]::IsNullOrWhiteSpace($Candidate)) { return $Candidate }

  $branches = Get-GitOutput @("branch", "--format=%(refname:short)")
  $list = @()
  if (-not [string]::IsNullOrWhiteSpace($branches)) {
    $list = $branches -split "`n" | ForEach-Object { $_.Trim() } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
  }

  if ($list -contains "main") { return "main" }
  if ($list -contains "master") { return "master" }
  return $null
}

function Test-IsProtectedBranch {
  param([Parameter(Mandatory = $true)][string]$Name)
  $n = $Name.Trim()
  if ([string]::IsNullOrWhiteSpace($n)) { return $true }
  $protected = @(
    "main",
    "master",
    "develop",
    "dev",
    "release/*",
    "hotfix/*"
  )
  foreach ($p in $protected) {
    if ($n -like $p) { return $true }
  }
  return $false
}

function Test-BranchExists {
  param([Parameter(Mandatory = $true)][string]$Name)
  & git show-ref --verify --quiet ("refs/heads/" + $Name) | Out-Null
  return ($LASTEXITCODE -eq 0)
}

function Test-BranchInAnyWorktree {
  param([Parameter(Mandatory = $true)][string]$Name)
  $porcelain = Get-GitOutput @("worktree", "list", "--porcelain")
  foreach ($raw in ($porcelain -split "`r?`n")) {
    $line = $raw.Trim()
    if ($line.StartsWith("branch ")) {
      $ref = $line.Substring("branch ".Length).Trim()
      if ($ref -eq ("refs/heads/" + $Name)) { return $true }
    }
  }
  return $false
}

function Test-IsMergedIntoBase {
  param(
    [Parameter(Mandatory = $true)][string]$Name,
    [Parameter(Mandatory = $true)][string]$Base
  )
  & git merge-base --is-ancestor $Name $Base 2>&1 | Out-Null
  return ($LASTEXITCODE -eq 0)
}

$repoRoot = $null
try {
  $repoRoot = Get-GitOutput @("rev-parse", "--show-toplevel")
} catch {
  throw "This script must be run inside a git repository."
}

Push-Location $repoRoot
try {
  $branch = $BranchName.Trim()
  if ([string]::IsNullOrWhiteSpace($branch)) { throw "BranchName is required." }

  if (Test-IsProtectedBranch -Name $branch) {
    throw "Refusing to delete protected branch '$branch'."
  }

  if (-not (Test-BranchExists -Name $branch)) {
    throw "Branch not found: '$branch'."
  }

  if (Test-BranchInAnyWorktree -Name $branch) {
    throw "Refusing to delete branch '$branch' because it is checked out in a worktree. Remove that worktree first."
  }

  $base = Resolve-BaseBranch -Candidate $BaseBranch
  if ([string]::IsNullOrWhiteSpace($base)) {
    if (-not $Force) {
      throw "Base branch not found (main/master). Provide -BaseBranch or use -Force."
    }
  } else {
    if (-not (Test-IsMergedIntoBase -Name $branch -Base $base)) {
      if (-not $Force) {
        throw "Refusing to delete branch '$branch' because it is not merged into '$base'. Use -Force to override."
      }
    }
  }

  Write-Host ("Repo root: " + $repoRoot)
  Write-Host ("Branch: " + $branch)
  if ($base) { Write-Host ("Base: " + $base) }
  if ($DeleteRemoteBranch) { Write-Host "Remote delete: requested" }
  if ($Force) { Write-Host "Force: enabled" }

  if ($DryRun) { exit 0 }

  Invoke-Git @("branch", "-D", $branch)
  Write-Host ("Branch deleted (local): " + $branch)

  if ($DeleteRemoteBranch) {
    $hasOrigin = $true
    try {
      [void](Get-GitOutput @("remote", "get-url", "origin"))
    } catch {
      $hasOrigin = $false
    }

    if (-not $hasOrigin) {
      Write-Host "Remote 'origin' not found; skipping remote branch delete."
      exit 0
    }

    $res = Try-Invoke-Git @("push", "origin", "--delete", $branch)
    if ($res.Ok) {
      Write-Host ("Branch deleted (origin): " + $branch)
      [void](Try-Invoke-Git @("fetch", "origin", "--prune"))
      exit 0
    }

    $text = $res.Output
    if ($text -match "remote ref does not exist" -or $text -match "unable to delete" -or $text -match "not found") {
      Write-Host "Remote branch not found (or already deleted); skipping remote branch delete."
      exit 0
    }

    Write-Host "Unable to delete remote branch (origin). Skipping."
  }
} finally {
  Pop-Location
}

