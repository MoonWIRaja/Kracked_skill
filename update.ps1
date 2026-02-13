<#
.SYNOPSIS
    KRACKED_skill (KD) v2.0.0-beta - PowerShell Update Script (Windows)
    AI Skill by KRACKEDDEVS - https://krackeddevs.com/
.PARAMETER TargetDir
    Target project directory (default: current directory)
.PARAMETER Help
    Show help
#>

param(
    [string]$TargetDir = ".",
    [switch]$Help
)

$ErrorActionPreference = 'Stop'

$KD_VERSION = "2.0.0-beta"
$KD_DIR = ".kracked"
$KD_REPO = "MoonWIRaja/Kracked_skill"
$KD_RAW_URL = "https://raw.githubusercontent.com/$KD_REPO/main"

# ---------------------------------------------------------------------------
# Logging
# ---------------------------------------------------------------------------
function Write-Info    { param([string]$Msg) Write-Host "  [INFO]    $Msg" -ForegroundColor Cyan }
function Write-Ok      { param([string]$Msg) Write-Host "  [SUCCESS] $Msg" -ForegroundColor Green }
function Write-Warn    { param([string]$Msg) Write-Host "  [WARN]    $Msg" -ForegroundColor Yellow }
function Write-Err     { param([string]$Msg) Write-Host "  [ERROR]   $Msg" -ForegroundColor Red }

# ---------------------------------------------------------------------------
# Usage
# ---------------------------------------------------------------------------
if ($Help) {
    Write-Host ''
    Write-Host 'Usage: .\update.ps1 [OPTIONS]'
    Write-Host ''
    Write-Host 'Options:'
    Write-Host '  -TargetDir [path]    Target project directory (default: .)'
    Write-Host '  -Help                Show this help'
    Write-Host ''
    Write-Host 'Examples:'
    Write-Host '  .\update.ps1'
    Write-Host '  .\update.ps1 -TargetDir C:\Projects\MyApp'
    Write-Host ''
    exit 0
}

# ---------------------------------------------------------------------------
# Download Helper
# ---------------------------------------------------------------------------
function Get-RemoteFile {
    param([string]$Url, [string]$Dest)

    $parentDir = Split-Path -Parent $Dest
    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    try {
        Invoke-WebRequest -Uri $Url -OutFile $Dest -UseBasicParsing -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

# ---------------------------------------------------------------------------
# Version
# ---------------------------------------------------------------------------
function Get-CurrentVersion {
    $settingsPath = Join-Path $TargetDir "$KD_DIR\config\settings.json"
    if (Test-Path $settingsPath) {
        $json = Get-Content $settingsPath -Raw | ConvertFrom-Json
        if ($json.version) { return $json.version }
    }
    return "0.0.0"
}

function Get-LatestVersion {
    $tmpFile = [System.IO.Path]::GetTempFileName()
    try {
        if (Get-RemoteFile -Url "$KD_RAW_URL/VERSION" -Dest $tmpFile) {
            $ver = (Get-Content $tmpFile -Raw).Trim()
            Remove-Item $tmpFile -Force -ErrorAction SilentlyContinue
            return $ver
        }
    } catch {}
    Remove-Item $tmpFile -Force -ErrorAction SilentlyContinue
    return "unknown"
}

# ---------------------------------------------------------------------------
# Backup
# ---------------------------------------------------------------------------
function Backup-Config {
    $timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
    $backupDir = Join-Path $TargetDir "$KD_DIR\.backup_$timestamp"
    New-Item -ItemType Directory -Path $backupDir -Force | Out-Null

    # Backup settings
    $settingsPath = Join-Path $TargetDir "$KD_DIR\config\settings.json"
    if (Test-Path $settingsPath) {
        Copy-Item $settingsPath -Destination $backupDir
    }

    # Backup status.md
    $statusPath = Join-Path $TargetDir "$KD_DIR\KD_output\status\status.md"
    if (Test-Path $statusPath) {
        Copy-Item $statusPath -Destination $backupDir
    }

    # Backup all KD_output
    $kdOutputPath = Join-Path $TargetDir "$KD_DIR\KD_output"
    if (Test-Path $kdOutputPath) {
        Copy-Item $kdOutputPath -Destination (Join-Path $backupDir "KD_output_backup") -Recurse
    }

    return $backupDir
}

# ---------------------------------------------------------------------------
# Restore
# ---------------------------------------------------------------------------
function Restore-Config {
    param([string]$BackupDir)

    $settingsBackup = Join-Path $BackupDir "settings.json"
    if (Test-Path $settingsBackup) {
        $dest = Join-Path $TargetDir "$KD_DIR\config\settings.json"
        Copy-Item $settingsBackup -Destination $dest -Force
        Write-Info "Settings restored."
    }

    $statusBackup = Join-Path $BackupDir "status.md"
    if (Test-Path $statusBackup) {
        $dest = Join-Path $TargetDir "$KD_DIR\KD_output\status\status.md"
        Copy-Item $statusBackup -Destination $dest -Force
        Write-Info "status.md restored."
    }

    # Restore KD_output content
    $kdOutputBackup = Join-Path $BackupDir "KD_output_backup"
    if (Test-Path $kdOutputBackup) {
        Get-ChildItem $kdOutputBackup -Directory | ForEach-Object {
            if ($_.Name -ne "status") {
                $dest = Join-Path $TargetDir "$KD_DIR\KD_output\$($_.Name)"
                Copy-Item $_.FullName -Destination $dest -Recurse -Force
            }
        }
        Write-Info "KD_output content restored."
    }
}

# ---------------------------------------------------------------------------
# Read Current Settings
# ---------------------------------------------------------------------------
function Get-CurrentTargets {
    $settingsPath = Join-Path $TargetDir "$KD_DIR\config\settings.json"
    if (Test-Path $settingsPath) {
        $json = Get-Content $settingsPath -Raw | ConvertFrom-Json
        if ($json.target_tools) {
            return ($json.target_tools -join ',')
        }
        if ($json.target_tool) {
            return $json.target_tool
        }
    }
    return "claude-code"
}

function Get-CurrentLanguage {
    $settingsPath = Join-Path $TargetDir "$KD_DIR\config\settings.json"
    if (Test-Path $settingsPath) {
        $json = Get-Content $settingsPath -Raw | ConvertFrom-Json
        if ($json.language) { return $json.language }
    }
    return "EN"
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "  ========================================" -ForegroundColor Cyan
Write-Host "    KD Update - KRACKED_skill" -ForegroundColor White
Write-Host "    AI Skill by KRACKEDDEVS" -ForegroundColor White
Write-Host "  ========================================" -ForegroundColor Cyan
Write-Host ""

# Check if KD is installed
$kdPath = Join-Path $TargetDir $KD_DIR
if (-not (Test-Path $kdPath)) {
    Write-Err "KD is not installed in $TargetDir"
    Write-Err "Run install.ps1 first to install KD."
    exit 1
}

$currentVersion = Get-CurrentVersion
Write-Info "Current version: $currentVersion"

$latestVersion = Get-LatestVersion
if ($latestVersion -eq "unknown") {
    Write-Err "Could not fetch latest version. Check your internet connection."
    exit 1
}

Write-Info "Latest version:  $latestVersion"

if ($currentVersion -eq $latestVersion) {
    Write-Ok "You are already on the latest version ($currentVersion)."
    exit 0
}

Write-Host ""
Write-Host "  Update available: " -NoNewline
Write-Host "$currentVersion" -ForegroundColor Yellow -NoNewline
Write-Host " -> " -NoNewline
Write-Host "$latestVersion" -ForegroundColor Green

$confirm = Read-Host "  Proceed with update? [Y/n]"
if ($confirm -and $confirm -notmatch '^[Yy]$') {
    Write-Info "Update cancelled."
    exit 0
}

# Backup
Write-Info "Backing up configuration and output files..."
$backupDir = Backup-Config
Write-Ok "Backup created at $backupDir"

# Get current settings
$targetTools = Get-CurrentTargets
$language = Get-CurrentLanguage

Write-Info "Restoring with: target=$targetTools, language=$language"

# Download and run installer
Write-Info "Downloading update..."
$tmpInstaller = [System.IO.Path]::GetTempFileName() + ".ps1"

if (Get-RemoteFile -Url "$KD_RAW_URL/install.ps1" -Dest $tmpInstaller) {
    try {
        & $tmpInstaller -TargetDir $TargetDir -Target $targetTools -Language $language -Force -NonInteractive
    } catch {
        Write-Err "Update failed: $_"
        Write-Info "Restoring backup..."
        Restore-Config -BackupDir $backupDir
        Remove-Item $tmpInstaller -Force -ErrorAction SilentlyContinue
        exit 1
    }
    Remove-Item $tmpInstaller -Force -ErrorAction SilentlyContinue
} else {
    Write-Err "Failed to download update."
    Write-Info "Restoring backup..."
    Restore-Config -BackupDir $backupDir
    exit 1
}

# Restore user config and output
Restore-Config -BackupDir $backupDir

Write-Host ""
Write-Ok "KD updated to v$latestVersion!"
Write-Host ""
Write-Host "  What's new:" -ForegroundColor White
Write-Host "    * Type " -NoNewline
Write-Host "/KD" -ForegroundColor Cyan -NoNewline
Write-Host " for the interactive command menu"
Write-Host "    * New " -NoNewline
Write-Host "/KD-brainstorm" -ForegroundColor Cyan -NoNewline
Write-Host " stage for ideation"
Write-Host "    * Named agent personalities in multi-agent modes"
Write-Host "    * Auto-debug before status updates"
Write-Host "    * Organized epics-and-stories directory"
Write-Host ""
