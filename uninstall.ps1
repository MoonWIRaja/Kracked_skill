<#
.SYNOPSIS
    Kracked_Skills (KD) - PowerShell Uninstallation Script (Windows)
    AI Skill by KRACKEDDEVS | https://krackeddevs.com/
.PARAMETER TargetDir
    Target project directory (default: current directory)
#>

param(
    [string]$TargetDir = "."
)

$ErrorActionPreference = 'Stop'

$KD_DIR = ".kracked"

# ---------------------------------------------------------------------------
# Logging
# ---------------------------------------------------------------------------
function Write-Info    { param([string]$Msg) Write-Host "  [INFO]    $Msg" -ForegroundColor Cyan }
function Write-Ok      { param([string]$Msg) Write-Host "  [SUCCESS] $Msg" -ForegroundColor Green }
function Write-Warn    { param([string]$Msg) Write-Host "  [WARN]    $Msg" -ForegroundColor Yellow }
function Write-Err     { param([string]$Msg) Write-Host "  [ERROR]   $Msg" -ForegroundColor Red }

# ---------------------------------------------------------------------------
# Check KD Exists
# ---------------------------------------------------------------------------
if (-not (Test-Path -Path (Join-Path $TargetDir $KD_DIR))) {
    Write-Err "KD is not installed in $TargetDir"
    Write-Err "No $KD_DIR\ directory found."
    exit 1
}

# ---------------------------------------------------------------------------
# Confirm
# ---------------------------------------------------------------------------
$absPath = (Get-Item $TargetDir).FullName
Write-Host ""
Write-Host "  Kracked_Skills Uninstallation" -ForegroundColor White
Write-Host "  Directory: $absPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "  This will remove:" -ForegroundColor Yellow
Write-Host "    - $KD_DIR\ directory (all KD files)"
Write-Host "    - Adapter files (CLAUDE.md, .cursorrules, .antigravity/)"
Write-Host "    - status.md (backup will be created)"
Write-Host ""
Write-Host "  This will NOT remove:" -ForegroundColor Green
Write-Host "    - Your project source files"
Write-Host "    - The status.md backup"
Write-Host ""

$confirm = Read-Host "  Proceed with uninstallation? [y/N]"
if ($confirm -and $confirm -notmatch '^[Yy]$') {
    Write-Info "Uninstallation cancelled."
    exit 0
}

# ---------------------------------------------------------------------------
# Backup status.md
# ---------------------------------------------------------------------------
$statusFile = Join-Path $TargetDir "$KD_DIR\KD_output\status\status.md"
if (Test-Path $statusFile) {
    $timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
    $backupName = "status.md.backup.$timestamp"
    Copy-Item $statusFile -Destination (Join-Path $TargetDir $backupName)
    Write-Info "status.md backed up as $backupName"
}

# ---------------------------------------------------------------------------
# Remove Files
# ---------------------------------------------------------------------------
# Remove .kracked directory
Remove-Item -Path (Join-Path $TargetDir $KD_DIR) -Recurse -Force
Write-Ok "Removed $KD_DIR\ directory"

# Remove adapter files/folders
$adapters = @(".antigravity", ".agent", ".claude", ".cursor", ".cline", ".kilo", ".roo")
foreach ($a in $adapters) {
    $p = Join-Path $TargetDir $a
    if (Test-Path $p) {
        Remove-Item $p -Recurse -Force
        Write-Info "Removed $a/"
    }
}

# Legacy root files
$legacy = @("CLAUDE.md", ".cursorrules", ".clinerules", ".kilocode", ".kilocodemodes")
foreach ($f in $legacy) {
    $p = Join-Path $TargetDir $f
    if (Test-Path $p) {
        Remove-Item $p -Force
        Write-Info "Removed legacy file: $f"
    }
}

Write-Host ""
Write-Ok "  Kracked_Skills has been uninstalled successfully."
Write-Host "  Your status.md backup has been preserved."
Write-Host ""
