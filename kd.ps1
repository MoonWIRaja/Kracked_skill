<# 
.SYNOPSIS
    KD v5.0.0 — PowerShell Wrapper for TUI
    AI Skill by KRACKEDDEVS - https://krackeddevs.com/
.DESCRIPTION
    Downloads and runs KD TUI for installing, updating, or uninstalling KD.
#>
param(
    [Parameter(Position=0)]
    [string]$Command = "",
    [string]$Target = "",
    [string]$Language = "",
    [switch]$NonInteractive,
    [switch]$Force
)

$ErrorActionPreference = "Stop"
$KD_VERSION = "5.0.0"
$KD_REPO = "MoonWIRaja/Kracked_Skills"
$KD_RAW_URL = "https://raw.githubusercontent.com/$KD_REPO/main"

# Banner
function Show-Banner {
    Write-Host ""
    Write-Host "  ╔═══════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "  ║                                                                       ║" -ForegroundColor Cyan
    Write-Host "  ║   ██╗  ██╗██████╗                                                     ║" -ForegroundColor Cyan
    Write-Host "  ║   ██║ ██╔╝██╔══██╗                                                    ║" -ForegroundColor Cyan
    Write-Host "  ║   █████╔╝ ██║  ██║    AI Skill by KRACKEDDEVS                          ║" -ForegroundColor Cyan
    Write-Host "  ║   ██╔═██╗ ██║  ██║    https://krackeddevs.com/                         ║" -ForegroundColor Cyan
    Write-Host "  ║   ██║  ██╗██████╔╝                                                    ║" -ForegroundColor Cyan
    Write-Host "  ║   ╚═╝  ╚═╝╚═════╝                                                     ║" -ForegroundColor Cyan
    Write-Host "  ║                                                                       ║" -ForegroundColor Cyan
    Write-Host "  ╚═══════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  KD v$KD_VERSION | Structured Multi-Role AI Product Execution System" -ForegroundColor Gray
    Write-Host ""
}

# Main
Show-Banner

# Check Node.js
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "  Error: Node.js is not installed." -ForegroundColor Red
    Write-Host "  Please install Node.js from https://nodejs.org/" -ForegroundColor Gray
    exit 1
}

# Save original directory
$ORIGINAL_DIR = Get-Location

# Check if we're in KD repo directory
if (Test-Path "kd.js") {
    # Run local TUI
    $args = @($Command)
    if ($Target) { $args += "--target", $Target }
    if ($Language) { $args += "--lang", $Language }
    if ($NonInteractive) { $args += "--non-interactive" }
    if ($Force) { $args += "--force" }
    
    node kd.js @args
} else {
    # Download KD to a local folder
    $KD_FOLDER = Join-Path $env:USERPROFILE ".kd-tui"
    
    Write-Host "  Setting up KD TUI..." -ForegroundColor Cyan
    
    # Create folder
    $screensFolder = Join-Path $KD_FOLDER "src/tui/screens"
    if (-not (Test-Path $screensFolder)) {
        New-Item -ItemType Directory -Path $screensFolder -Force | Out-Null
    }
    
    # Download files
    Write-Host "  Downloading files..." -ForegroundColor Cyan
    
    $files = @(
        @{ Url = "$KD_RAW_URL/kd.js"; Dest = "kd.js" },
        @{ Url = "$KD_RAW_URL/package.json"; Dest = "package.json" },
        @{ Url = "$KD_RAW_URL/src/tui/banner.js"; Dest = "src/tui/banner.js" },
        @{ Url = "$KD_RAW_URL/src/tui/screens/main-menu.js"; Dest = "src/tui/screens/main-menu.js" },
        @{ Url = "$KD_RAW_URL/src/tui/screens/install.js"; Dest = "src/tui/screens/install.js" },
        @{ Url = "$KD_RAW_URL/src/tui/screens/update.js"; Dest = "src/tui/screens/update.js" },
        @{ Url = "$KD_RAW_URL/src/tui/screens/uninstall.js"; Dest = "src/tui/screens/uninstall.js" },
        @{ Url = "$KD_RAW_URL/src/tui/screens/about.js"; Dest = "src/tui/screens/about.js" }
    )
    
    foreach ($file in $files) {
        $destPath = Join-Path $KD_FOLDER $file.Dest
        try {
            Invoke-WebRequest -Uri $file.Url -OutFile $destPath -UseBasicParsing
        } catch {
            Write-Host "  Warning: Failed to download $($file.Dest)" -ForegroundColor Yellow
        }
    }
    
    # Check if kd.js was downloaded
    $kdJsPath = Join-Path $KD_FOLDER "kd.js"
    if (-not (Test-Path $kdJsPath)) {
        Write-Host "  Error: Failed to download KD files." -ForegroundColor Red
        exit 1
    }
    
    # Install dependencies if needed
    $nodeModulesPath = Join-Path $KD_FOLDER "node_modules"
    if (-not (Test-Path $nodeModulesPath)) {
        # Use cmd /c to bypass PowerShell execution policy
        Write-Host "  Installing dependencies..." -ForegroundColor Cyan
        Set-Location $KD_FOLDER
        cmd /c "npm install --silent 2>nul"
        Set-Location $ORIGINAL_DIR
    }
    
    Write-Host "  Launching KD TUI..." -ForegroundColor Green
    Write-Host ""
    
    # Build args with install-dir
    $args = @("--install-dir", $ORIGINAL_DIR.Path, "--no-banner")
    if ($Command) { $args = @($Command) + $args }
    if ($Target) { $args += "--target", $Target }
    if ($Language) { $args += "--lang", $Language }
    if ($NonInteractive) { $args += "--non-interactive" }
    if ($Force) { $args += "--force" }
    
    # Run from KD folder
    Set-Location $KD_FOLDER
    node kd.js @args
    Set-Location $ORIGINAL_DIR
}