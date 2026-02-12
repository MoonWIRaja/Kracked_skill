@echo off
REM KRACKED Skill - One-Line Installer for Claude Code Plugin (Windows)
REM Supports: Windows 10/11 with PowerShell or Command Prompt

setlocal enabledelayedexpansion

REM Plugin info
set PLUGIN_NAME=kracked-skill
set PLUGIN_REPO=KrackedAI/kracked-skill
set VERSION=3.3.0

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║ KRACKED v%VERSION% - Claude Code Plugin Installer              ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

REM Detect Claude Code directory
if exist "%USERPROFILE%\.claude" (
    set CLAUDE_DIR=%USERPROFILE%\.claude
) else (
    echo [!] Claude Code directory not found. Creating...
    mkdir "%USERPROFILE%\.claude" 2>nul
    set CLAUDE_DIR=%USERPROFILE%\.claude
)

set PLUGIN_DIR=%CLAUDE_DIR%\plugins\%PLUGIN_NAME%

echo [i] Installation Directory: %PLUGIN_DIR%
echo.

REM Create plugins directory
if not exist "%CLAUDE_DIR%\plugins" mkdir "%CLAUDE_DIR%\plugins"

REM Check if plugin already exists
if exist "%PLUGIN_DIR%" (
    echo [!] Plugin already installed. Updating...
    rmdir /s /q "%PLUGIN_DIR%" 2>nul
)

REM Download using PowerShell
echo [i] Downloading %PLUGIN_NAME%...
echo.

powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/%PLUGIN_REPO%/archive/refs/heads/main.zip' -OutFile '%TEMP%\kracked-skill.zip' -UseBasicParsing}"

if errorlevel 1 (
    echo [X] Download failed. Please check your internet connection.
    pause
    exit /b 1
)

REM Extract using PowerShell
echo [i] Extracting files...
powershell -Command "Expand-Archive -Path '%TEMP%\kracked-skill.zip' -DestinationPath '%CLAUDE_DIR%\plugins' -Force"

REM Move to correct directory
if exist "%CLAUDE_DIR%\plugins\kracked-skill-main" (
    move "%CLAUDE_DIR%\plugins\kracked-skill-main" "%PLUGIN_DIR%" >nul
)

REM Cleanup
del "%TEMP%\kracked-skill.zip" 2>nul

REM Verify installation
if exist "%PLUGIN_DIR%\plugin.json" (
    echo.
    echo [OK] Plugin installed successfully!
    echo.
    echo ══════════════════════════════════════════════════════════════
    echo Next Steps:
    echo   1. Restart Claude Code
    echo   2. Type /kracked-help to see all commands
    echo   3. Type /analyze to start a new project
    echo   4. Type /language EN or /language MS to select language
    echo ══════════════════════════════════════════════════════════════
    echo.
    echo [i] Documentation: https://github.com/%PLUGIN_REPO%
    echo.
) else (
    echo [X] Installation verification failed. Please check manually.
    pause
    exit /b 1
)

pause
