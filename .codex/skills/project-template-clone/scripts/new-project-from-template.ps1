param(
  [Parameter(Mandatory = $true)][string]$NewProjectName,
  [Parameter()][string]$DestinationPath,
  [Parameter()][string]$TemplatePath = (Get-Location).Path,
  [Parameter()][string]$ConfigPath,
  [Parameter()][switch]$InitGit = $true,
  [Parameter()][switch]$AllowExistingDestination,
  [Parameter()][switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Test-CommandExists {
  param([Parameter(Mandatory = $true)][string]$Name)
  return [bool](Get-Command $Name -ErrorAction SilentlyContinue)
}

function Get-TextEncodingFromBytes {
  param([Parameter(Mandatory = $true)][byte[]]$Bytes)

  if ($Bytes.Length -ge 3 -and $Bytes[0] -eq 0xEF -and $Bytes[1] -eq 0xBB -and $Bytes[2] -eq 0xBF) {
    return [Text.UTF8Encoding]::new($true, $true) # UTF-8 with BOM, throw on invalid
  }
  if ($Bytes.Length -ge 2 -and $Bytes[0] -eq 0xFF -and $Bytes[1] -eq 0xFE) {
    return [Text.UnicodeEncoding]::new($false, $true) # UTF-16 LE, throw on invalid
  }
  if ($Bytes.Length -ge 2 -and $Bytes[0] -eq 0xFE -and $Bytes[1] -eq 0xFF) {
    return [Text.UnicodeEncoding]::new($true, $true) # UTF-16 BE, throw on invalid
  }
  return [Text.UTF8Encoding]::new($false, $true) # UTF-8 without BOM, throw on invalid
}

function Read-TextFileSafely {
  param([Parameter(Mandatory = $true)][string]$Path)

  $bytes = [IO.File]::ReadAllBytes($Path)
  $encoding = Get-TextEncodingFromBytes -Bytes $bytes

  try {
    $text = $encoding.GetString($bytes)
    return @{
      Text = $text
      Encoding = $encoding
    }
  } catch {
    return $null
  }
}

function Write-TextFileSafely {
  param(
    [Parameter(Mandatory = $true)][string]$Path,
    [Parameter(Mandatory = $true)][string]$Text,
    [Parameter(Mandatory = $true)][System.Text.Encoding]$Encoding
  )

  $bytes = $Encoding.GetBytes($Text)
  [IO.File]::WriteAllBytes($Path, $bytes)
}

function Resolve-OptionalPath {
  param([Parameter(Mandatory = $true)][string]$Path)
  if ([string]::IsNullOrWhiteSpace($Path)) { return $null }
  return (Resolve-Path -LiteralPath $Path).Path
}

$templateFullPath = (Resolve-Path -LiteralPath $TemplatePath).Path
$destinationFullPath = $null

if ([string]::IsNullOrWhiteSpace($DestinationPath)) {
  $templateParent = Split-Path -Path $templateFullPath -Parent
  $destinationFullPath = [IO.Path]::GetFullPath((Join-Path -Path $templateParent -ChildPath $NewProjectName))
} else {
  $destinationFullPath = [IO.Path]::GetFullPath((Join-Path -Path (Get-Location).Path -ChildPath $DestinationPath))
}

if (-not $ConfigPath) {
  $defaultConfig = Join-Path -Path $PSScriptRoot -ChildPath "../assets/template-clone.config.json"
  $ConfigPath = $defaultConfig
}

if ($destinationFullPath.TrimEnd('\') -eq $templateFullPath.TrimEnd('\')) {
  throw "DestinationPath cannot be the same as TemplatePath."
}

if ($destinationFullPath.StartsWith($templateFullPath, [StringComparison]::OrdinalIgnoreCase)) {
  throw "DestinationPath cannot be inside TemplatePath (would cause recursive copy)."
}

if ((Test-Path -LiteralPath $destinationFullPath) -and (-not $AllowExistingDestination)) {
  throw "Destination folder already exists. Use -AllowExistingDestination to allow writing into it: $destinationFullPath"
}

if (-not (Test-CommandExists -Name 'robocopy')) {
  throw "robocopy is required (Windows)."
}

$config = @{
  exclude = @{
    dirs = @()
    files = @()
  }
  deleteAfterCopy = @()
  replacements = @()
  textExtensions = @(
    ".md", ".txt",
    ".json", ".jsonc",
    ".yml", ".yaml",
    ".toml",
    ".js", ".jsx", ".ts", ".tsx",
    ".css", ".scss",
    ".html",
    ".ps1", ".sh",
    ".env.example"
  )
}

if ($ConfigPath) {
  $configFullPath = Resolve-OptionalPath -Path $ConfigPath
  if (-not $configFullPath) { throw "ConfigPath not found: $ConfigPath" }

  $configJson = Get-Content -LiteralPath $configFullPath -Raw -Encoding UTF8 | ConvertFrom-Json

  if ($configJson.exclude -and $configJson.exclude.dirs) { $config.exclude.dirs = @($configJson.exclude.dirs) }
  if ($configJson.exclude -and $configJson.exclude.files) { $config.exclude.files = @($configJson.exclude.files) }
  if ($configJson.deleteAfterCopy) { $config.deleteAfterCopy = @($configJson.deleteAfterCopy) }
  if ($configJson.replacements) { $config.replacements = @($configJson.replacements) }
  if ($configJson.textExtensions) { $config.textExtensions = @($configJson.textExtensions) }
}

$alwaysDeleteAfterCopy = @(
  "docs-ai/agents-artifacts",
  "docs-ai/project-knowledge"
)

$skeletonRoot = (Resolve-Path -LiteralPath (Join-Path -Path $PSScriptRoot -ChildPath "../assets/skeleton")).Path
$skeletonDocsAiRoot = Join-Path -Path $skeletonRoot -ChildPath "docs-ai"

$alwaysRestoreFromSkeleton = @(
  "docs-ai/agents-artifacts",
  "docs-ai/project-knowledge"
)

$defaultExcludeDirs = @(
  ".worktrees",
  "node_modules",
  "dist",
  "build",
  ".next",
  ".turbo",
  ".cache",
  "coverage",
  ".pnpm-store",
  ".yarn",
  ".venv",
  "venv",
  "__pycache__",

  # Best-effort skip during copy (we also delete after copy to be safe).
  "docs-ai\\agents-artifacts",
  "docs-ai\\project-knowledge"
)

$defaultExcludeFiles = @(
  ".env",
  ".env.local",
  ".env.development.local",
  ".env.test.local",
  ".env.production.local",
  "Thumbs.db",
  ".DS_Store"
)

$excludeDirs = New-Object System.Collections.Generic.List[string]
$excludeFiles = New-Object System.Collections.Generic.List[string]

foreach ($d in $defaultExcludeDirs) { if ($d) { [void]$excludeDirs.Add($d) } }
foreach ($d in $config.exclude.dirs) { if ($d) { [void]$excludeDirs.Add([string]$d) } }

foreach ($f in $defaultExcludeFiles) { if ($f) { [void]$excludeFiles.Add($f) } }
foreach ($f in $config.exclude.files) { if ($f) { [void]$excludeFiles.Add([string]$f) } }

[void]$excludeDirs.Add(".git")

$robocopyArgs = New-Object System.Collections.Generic.List[string]
[void]$robocopyArgs.Add($templateFullPath)
[void]$robocopyArgs.Add($destinationFullPath)
[void]$robocopyArgs.Add("/E")
[void]$robocopyArgs.Add("/COPY:DAT")
[void]$robocopyArgs.Add("/DCOPY:DAT")
[void]$robocopyArgs.Add("/R:1")
[void]$robocopyArgs.Add("/W:1")
[void]$robocopyArgs.Add("/NP")
[void]$robocopyArgs.Add("/NFL")
[void]$robocopyArgs.Add("/NDL")
[void]$robocopyArgs.Add("/NJH")
[void]$robocopyArgs.Add("/NJS")

if ($DryRun) {
  [void]$robocopyArgs.Add("/L")
}

if ($excludeDirs.Count -gt 0) {
  [void]$robocopyArgs.Add("/XD")
  foreach ($d in ($excludeDirs | Select-Object -Unique)) {
    $dir = [string]$d
    if ($dir -match "[\\\\/]") {
      [void]$robocopyArgs.Add((Join-Path -Path $templateFullPath -ChildPath $dir))
    } else {
      [void]$robocopyArgs.Add($dir)
    }
  }
}

if ($excludeFiles.Count -gt 0) {
  [void]$robocopyArgs.Add("/XF")
  foreach ($f in ($excludeFiles | Select-Object -Unique)) { [void]$robocopyArgs.Add($f) }
}

if (-not $DryRun) {
  New-Item -ItemType Directory -Path $destinationFullPath -Force | Out-Null
}

Write-Host "TemplatePath:     $templateFullPath"
Write-Host "DestinationPath:  $destinationFullPath"
Write-Host "NewProjectName:   $NewProjectName"
Write-Host "DryRun:           $($DryRun.IsPresent)"
if ($ConfigPath) { Write-Host "ConfigPath:       $ConfigPath" }

Write-Host ""
Write-Host "Copying files with robocopy..."
& robocopy @robocopyArgs
$robocopyExit = $LASTEXITCODE

# Robocopy exit codes: 0-7 are success states (including "some files copied" and "extra files").
if ($robocopyExit -gt 7) {
  throw "robocopy failed with exit code $robocopyExit"
}

if ($DryRun) {
  Write-Host ""
  Write-Host "Dry run completed. No files were copied or changed."
  exit 0
}

$deleteAfterCopy = @($alwaysDeleteAfterCopy + $config.deleteAfterCopy) | Where-Object { $_ } | Select-Object -Unique

foreach ($relPath in $deleteAfterCopy) {
  if (-not $relPath) { continue }
  $target = Join-Path -Path $destinationFullPath -ChildPath ([string]$relPath)
  if (Test-Path -LiteralPath $target) {
    Remove-Item -LiteralPath $target -Recurse -Force
    Write-Host "Deleted after copy: $relPath"
  }
}

foreach ($relPath in $alwaysRestoreFromSkeleton) {
  $source = Join-Path -Path $skeletonRoot -ChildPath ([string]$relPath)
  $dest = Join-Path -Path $destinationFullPath -ChildPath ([string]$relPath)

  if (-not (Test-Path -LiteralPath $source)) {
    throw "Skeleton is missing required path: $source"
  }

  New-Item -ItemType Directory -Path $dest -Force | Out-Null

  Write-Host "Restoring scaffold from skeleton: $relPath"
  & robocopy $source $dest /E /COPY:DAT /DCOPY:DAT /R:1 /W:1 /NP /NFL /NDL /NJH /NJS | Out-Null
  $copyExit = $LASTEXITCODE
  if ($copyExit -gt 7) {
    throw "robocopy (skeleton restore) failed with exit code $copyExit for: $relPath"
  }
}

if ($InitGit) {
  if (Test-CommandExists -Name 'git') {
    & git -C $destinationFullPath init | Out-Null
    Write-Host "Initialized new git repo (git init)."
  } else {
    Write-Host "Warning: git not found; skipped git init."
  }
}

if ($config.replacements.Count -gt 0) {
  $templateName = Split-Path -Path $templateFullPath -Leaf

  $replacementPairs = @()
  foreach ($r in $config.replacements) {
    if (-not $r) { continue }
    if (-not $r.from) { continue }
    $from = [string]$r.from
    $to = [string]$r.to
    $to = $to.Replace("{{NewProjectName}}", $NewProjectName).Replace("{{TemplateName}}", $templateName)
    $replacementPairs += ,@($from, $to)
  }

  if ($replacementPairs.Count -gt 0) {
    Write-Host "Applying text replacements..."

    $textExtensions = New-Object System.Collections.Generic.HashSet[string]([StringComparer]::OrdinalIgnoreCase)
    foreach ($ext in $config.textExtensions) {
      if (-not $ext) { continue }
      $textExtensions.Add([string]$ext) | Out-Null
    }

    $files = Get-ChildItem -LiteralPath $destinationFullPath -Recurse -File -Force |
      Where-Object {
        $_.FullName -notmatch "\\\\\.git(\\\\|$)"
      }

    foreach ($file in $files) {
      $ext = $file.Extension
      if (-not $textExtensions.Contains($ext) -and -not $textExtensions.Contains($file.Name)) {
        continue
      }

      $read = Read-TextFileSafely -Path $file.FullName
      if (-not $read) { continue }

      $original = $read.Text
      $updated = $original

      foreach ($pair in $replacementPairs) {
        $updated = $updated.Replace($pair[0], $pair[1])
      }

      if ($updated -ne $original) {
        Write-TextFileSafely -Path $file.FullName -Text $updated -Encoding $read.Encoding
      }
    }
  }
}

Write-Host ""
Write-Host "Done."
