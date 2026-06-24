# bluesclaude installer for Windows (PowerShell).
# Usage:
#   irm https://raw.githubusercontent.com/azviya/bluesclaude/main/install.ps1 | iex

$ErrorActionPreference = 'Stop'

$GithubUsername = 'azviya'
$Repo = "https://raw.githubusercontent.com/$GithubUsername/bluesclaude/main"
$Dest = Join-Path $env:LOCALAPPDATA 'Programs\bluesclaude'

New-Item -ItemType Directory -Force -Path $Dest | Out-Null

Write-Host "Installing bluesclaude to $Dest ..."
Invoke-WebRequest -UseBasicParsing "$Repo/bluesclaude.ps1" -OutFile (Join-Path $Dest 'bluesclaude.ps1')

# A .cmd shim so `bluesclaude` works from cmd.exe and PowerShell alike.
$shim = @'
@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0bluesclaude.ps1" %*
'@
Set-Content -Path (Join-Path $Dest 'bluesclaude.cmd') -Value $shim -Encoding ASCII

# Put the install dir on the user PATH if it isn't already.
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
if (-not $userPath) { $userPath = '' }
if ($userPath -notlike "*$Dest*") {
  $newPath = if ($userPath) { "$userPath;$Dest" } else { $Dest }
  [Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
  $env:Path = "$env:Path;$Dest"
  Write-Host "Added $Dest to your user PATH."
  Write-Host 'Open a NEW terminal for it to take effect.'
}

Write-Host 'Installed. Run: bluesclaude'
