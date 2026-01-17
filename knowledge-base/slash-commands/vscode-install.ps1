# vscode-install.ps1
# Copies all files from ./prompts into the Codex prompts folder

$CodexDir = Join-Path $env:USERPROFILE ".codex\prompts"
New-Item -ItemType Directory -Force -Path $CodexDir | Out-Null

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$PromptsDir = Join-Path $ScriptDir "prompts"

$Files = Get-ChildItem -Path $PromptsDir -File

if ($Files.Count -eq 0) {
  Write-Output "No files found in prompts folder."
  exit 0
}

foreach ($File in $Files) {
  $OutFile = Join-Path $CodexDir $File.Name
  Copy-Item $File.FullName $OutFile -Force
  Write-Output "Installed to Codex: $OutFile"
}

Write-Output "Done. Restart Codex / VS Code to load commands."
