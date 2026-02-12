# KRACKED Skill - PowerShell Installer
# Usage: iex "& {$(iwr https://raw.githubusercontent.com/moonwiraja/kracked-skill/main/install.ps1)}"

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

$PLUGIN_NAME = "kracked-skill"
$PLUGIN_REPO = "moonwiraja/kracked-skill"
$VERSION = "3.3.0"

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║ KRACKED v$VERSION - Claude Code Plugin Installer              ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Detect Claude Code directory
$claudeDir = Join-Path $env:USERPROFILE ".claude"
$pluginDir = Join-Path $claudeDir "plugins\$PLUGIN_NAME"

Write-Host "[i] Installation Directory: $pluginDir" -ForegroundColor Blue
Write-Host ""

# Create Claude directories
if (-not (Test-Path $claudeDir)) {
    Write-Host "[!] Claude Code directory not found. Creating..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $claudeDir -Force | Out-Null
}

$pluginsDir = Join-Path $claudeDir "plugins"
if (-not (Test-Path $pluginsDir)) {
    New-Item -ItemType Directory -Path $pluginsDir -Force | Out-Null
}

# Remove existing installation
if (Test-Path $pluginDir) {
    Write-Host "[!] Plugin already installed. Updating..." -ForegroundColor Yellow
    Remove-Item -Path $pluginDir -Recurse -Force -ErrorAction SilentlyContinue
}

try {
    # Check if git is available
    $gitAvailable = $false
    try {
        $null = Get-Command git -ErrorAction Stop
        $gitAvailable = $true
    } catch {}

    if ($gitAvailable) {
        Write-Host "[i] Cloning from GitHub..." -ForegroundColor Blue
        git clone --depth 1 "https://github.com/${PLUGIN_REPO}.git" $pluginDir 2>$null
    } else {
        # Download using PowerShell
        Write-Host "[i] Downloading plugin..." -ForegroundColor Blue
        $tempDir = Join-Path $env:TEMP $PLUGIN_NAME
        $zipFile = Join-Path $tempDir "plugin.zip"

        New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri "https://github.com/${PLUGIN_REPO}/archive/refs/heads/main.zip" `
            -OutFile $zipFile -UseBasicParsing

        Write-Host "[i] Extracting files..." -ForegroundColor Blue
        Expand-Archive -Path $zipFile -DestinationPath $pluginsDir -Force

        # Move to final location
        $extractedDir = Join-Path $pluginsDir "${PLUGIN_NAME}-main"
        if (Test-Path $extractedDir) {
            Move-Item -Path $extractedDir -Destination $pluginDir -Force
        }

        # Cleanup
        Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    }

    # Verify installation
    $pluginJson = Join-Path $pluginDir "plugin.json"
    if (Test-Path $pluginJson) {
        Write-Host ""
        Write-Host "[OK] Plugin installed successfully!" -ForegroundColor Green
        Write-Host ""
        Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
        Write-Host "Next Steps:" -ForegroundColor Green
        Write-Host "  1. Restart Claude Code" -ForegroundColor Yellow
        Write-Host "  2. Type /kracked-help to see all commands"
        Write-Host "  3. Type /analyze to start a new project"
        Write-Host "  4. Type /language EN or /language MS to select language"
        Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "[i] Documentation: https://github.com/${PLUGIN_REPO}" -ForegroundColor Blue
        Write-Host ""
    } else {
        throw "plugin.json not found after installation"
    }

} catch {
    Write-Host ""
    Write-Host "[X] Installation failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Manual installation:"
    Write-Host "  git clone https://github.com/${PLUGIN_REPO}.git `"$pluginDir"`"
    Write-Host ""
    exit 1
}
