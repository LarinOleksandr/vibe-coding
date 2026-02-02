param(
  [Parameter(Mandatory = $true)][string]$WorktreePath,
  [switch]$DeleteBranch,
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
  $out = & git @Args
  if ($LASTEXITCODE -ne 0) {
    throw ("git " + ($Args -join " ") + " failed with exit code " + $LASTEXITCODE)
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
  $out = & {
    param($gitArgs)
    $ErrorActionPreference = "Continue"
    & git @gitArgs 2>&1
  } $Args
  $ok = ($LASTEXITCODE -eq 0)
  return [pscustomobject]@{ Ok = $ok; Output = ($out | Out-String).Trim() }
}

function Resolve-BaseBranch {
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

function Test-IsMergedIntoBase {
  param(
    [Parameter(Mandatory = $true)][string]$Name,
    [Parameter(Mandatory = $true)][string]$Base
  )
  & git merge-base --is-ancestor $Name $Base 2>&1 | Out-Null
  return ($LASTEXITCODE -eq 0)
}

function Resolve-RepoRoot {
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

function Resolve-FullPath {
  param([Parameter(Mandatory = $true)][string]$PathLike)
  try {
    return [System.IO.Path]::GetFullPath($PathLike)
  } catch {
    throw "Invalid path: $PathLike"
  }
}

function Parse-WorktreeList {
  param([Parameter(Mandatory = $true)][string]$PorcelainText)
  $entries = @()
  $current = $null

  foreach ($raw in ($PorcelainText -split "`r?`n")) {
    $line = $raw.Trim()
    if ([string]::IsNullOrWhiteSpace($line)) { continue }

    if ($line.StartsWith("worktree ")) {
      if ($current) { $entries += $current }
      $current = [pscustomobject]@{
        Path = $line.Substring("worktree ".Length).Trim()
        BranchRef = $null
      }
      continue
    }

    if ($current -and $line.StartsWith("branch ")) {
      $current.BranchRef = $line.Substring("branch ".Length).Trim()
      continue
    }
  }

  if ($current) { $entries += $current }
  return $entries
}

$anchorRoot = Resolve-RepoRoot
Push-Location $anchorRoot
try {
  $anchorRootFull = Resolve-FullPath $anchorRoot
  $worktreesRootFull = Resolve-FullPath (Join-Path $anchorRootFull ".worktrees")

  $targetFull = Resolve-FullPath (Join-Path $anchorRootFull $WorktreePath)
  if (-not ($targetFull.StartsWith($worktreesRootFull, [System.StringComparison]::OrdinalIgnoreCase))) {
    throw "Refusing to remove worktree outside '$worktreesRootFull'. Provided: '$targetFull'."
  }

  $cwdFull = Resolve-FullPath (Get-Location).Path
  if ($cwdFull.StartsWith($targetFull, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Refusing to remove the worktree you are currently inside. cd to '$anchorRootFull' first, then rerun."
  }

  $porcelain = Get-GitOutput @("worktree", "list", "--porcelain")
  $entries = Parse-WorktreeList -PorcelainText $porcelain

  $match = $entries | Where-Object { (Resolve-FullPath $_.Path) -ieq $targetFull } | Select-Object -First 1
  if (-not $match) {
    if ($DryRun) {
      Write-Host ("Repo root: " + $anchorRootFull)
      Write-Host ("Worktree: " + $targetFull)
      Write-Host "DryRun: no registered worktree found at this path; real run would fail."
      exit 0
    }
    throw "No registered worktree found at '$targetFull'. Run 'git worktree list' to see known worktrees."
  }

  $branchName = $null
  if (-not [string]::IsNullOrWhiteSpace($match.BranchRef) -and $match.BranchRef.StartsWith("refs/heads/")) {
    $branchName = $match.BranchRef.Substring("refs/heads/".Length)
  }

  Write-Host ("Repo root: " + $anchorRootFull)
  Write-Host ("Worktree: " + $targetFull)
  if ($branchName) { Write-Host ("Branch: " + $branchName) }

  $removeArgs = @("worktree", "remove")
  if ($Force) { $removeArgs += "--force" }
  $removeArgs += $targetFull

  if ($DryRun) { exit 0 }

  Invoke-Git $removeArgs
  Write-Host "Worktree removed."

  if ($DeleteBranch) {
    if (-not $branchName) {
      throw "DeleteBranch requested, but branch name could not be detected for '$targetFull'."
    }

    if (Test-IsProtectedBranch -Name $branchName) {
      throw "Refusing to delete protected branch '$branchName'."
    }

    $base = Resolve-BaseBranch
    if ($base) {
      if (-not (Test-IsMergedIntoBase -Name $branchName -Base $base)) {
        if (-not $Force) {
          throw "Refusing to delete branch '$branchName' because it is not merged into '$base'. Use -Force to override."
        }
      }
    } else {
      if (-not $Force) {
        throw "Base branch not found (main/master). Use -Force to delete branch '$branchName' anyway."
      }
    }

    Invoke-Git @("branch", "-D", $branchName)
    Write-Host ("Branch deleted (local): " + $branchName)

    if ($DeleteRemoteBranch) {
      $hasOrigin = $true
      try {
        [void](Get-GitOutput @("remote", "get-url", "origin"))
      } catch {
        $hasOrigin = $false
      }

      if (-not $hasOrigin) {
        Write-Host "Remote 'origin' not found; skipping remote branch delete."
      } else {
        $res = Try-Invoke-Git @("push", "origin", "--delete", $branchName)
        if ($res.Ok) {
          Write-Host ("Branch deleted (origin): " + $branchName)
          [void](Try-Invoke-Git @("fetch", "origin", "--prune"))
        } else {
          $text = $res.Output
          if ($text -match "remote ref does not exist" -or $text -match "unable to delete" -or $text -match "not found") {
            Write-Host "Remote branch not found (or already deleted); skipping remote branch delete."
          } else {
            Write-Host "Unable to delete remote branch (origin). Skipping."
          }
        }
      }
    }
  }
} finally {
  Pop-Location
}
