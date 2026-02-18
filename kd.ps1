<# 
.SYNOPSIS
    KD v5.0.0 — PowerShell Wrapper for TUI
    AI Skill by KRACKEDDEVS - https://krackeddevs.com/
.DESCRIPTION
    Downloads and runs KD TUI for installing, updating, or uninstalling KD.
.PARAMETER Command
    Command to run: install, update, uninstall, about, help
.PARAMETER Target
    Target AI tool(s) for install
.PARAMETER Language
    Language preference for install
.PARAMETER NonInteractive
    Skip prompts, use defaults
.PARAMETER Force
    Force operation
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
function Main {
    Show-Banner

    # Check Node.js
    if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
        Write-Host "  Error: Node.js is not installed." -ForegroundColor Red
        Write-Host "  Please install Node.js from https://nodejs.org/" -ForegroundColor Gray
        exit 1
    }

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
        # Download and run remote TUI
        Write-Host "  Downloading KD TUI..." -ForegroundColor Cyan
        
        $tempDir = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "kd-tui-$(Get-Random)")
        New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
        
        try {
            # Download files
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
                $destPath = Join-Path $tempDir $file.Dest
                $destDir = Split-Path $destPath -Parent
                if (-not (Test-Path $destDir)) {
                    New-Item -ItemType Directory -Path $destDir -Force | Out-Null
                }
                Invoke-WebRequest -Uri $file.Url -OutFile $destPath -UseBasicParsing
            }
            
            # Install dependencies
            if (Get-Command npm -ErrorAction SilentlyContinue) {
                Write-Host "  Installing dependencies..." -ForegroundColor Cyan
                Push-Location $tempDir
                npm install --silent 2>$null
                Pop-Location
            }
            
            Write-Host "  Launching KD TUI..." -ForegroundColor Green
            Write-Host ""
            
            # Build args
            $args = @($Command)
            if ($Target) { $args += "--target", $Target }
            if ($Language) { $args += "--lang", $Language }
            if ($NonInteractive) { $args += "--non-interactive" }
            if ($Force) { $args += "--force" }
            
            # Run
            Push-Location $tempDir
            node kd.js @args
            Pop-Location
            
        } finally {
            # Cleanup
            Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

# Run
Main