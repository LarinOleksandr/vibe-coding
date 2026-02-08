param(
  [switch]$DryRun
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

$repoRoot = $null
try {
  $repoRoot = Get-GitOutput @("rev-parse", "--show-toplevel")
} catch {
  throw "This script must be run inside a git repository."
}

Push-Location $repoRoot
try {
  if (-not (Test-Path ".githooks/pre-commit")) {
    throw "Missing '.githooks/pre-commit'. Ensure the repo contains the hooks before installing."
  }

  if ($DryRun) {
    Write-Host "Dry run: would set git config core.hooksPath to '.githooks'."
    exit 0
  }

  Invoke-Git @("config", "core.hooksPath", ".githooks")
  Write-Host "Git hooks installed (core.hooksPath=.githooks)."
} finally {
  Pop-Location
}
