<# 
.SYNOPSIS
    KRACKED_skill (KD) v2.0.0-beta — PowerShell Installation Script (Windows)
    AI Skill by KRACKEDDEVS - https://krackeddevs.com/
.PARAMETER TargetDir
    Target project directory (default: current directory)
.PARAMETER Target
    AI tool targets (comma-separated): claude-code, cursor, antigravity, all
.PARAMETER Language
    Language preference: EN, MS
.PARAMETER NonInteractive
    Skip interactive prompts, use defaults
.PARAMETER Force
    Overwrite existing installation
.PARAMETER Help
    Show usage help
#>
param(
    [string]$TargetDir = ".",
    [string]$Target = "",
    [ValidateSet("EN", "MS", "")]
    [string]$Language = "",
    [switch]$NonInteractive,
    [switch]$Force,
    [switch]$Help
)

$ErrorActionPreference = "Stop"

# Constants
$KD_VERSION = "3.0.0"
$KD_REPO = "MoonWIRaja/Kracked_skill"
$KD_RAW_URL = "https://raw.githubusercontent.com/$KD_REPO/main"
$KD_DIR = ".kracked"
$KD_SITE = "https://krackeddevs.com/"

# ---------------------------------------------------------------------------
# Banner
# ---------------------------------------------------------------------------
function Show-Banner {
    Write-Host ""
    Write-Host "  =======================================================================" -ForegroundColor Cyan
    Write-Host "                                                                          " -ForegroundColor Cyan
    Write-Host "   KD    AI Skill by KRACKEDDEVS                                         " -ForegroundColor Cyan
    Write-Host "         https://krackeddevs.com/                                         " -ForegroundColor Cyan
    Write-Host "                                                                          " -ForegroundColor Cyan
    Write-Host "  =======================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Kracked_Skills v$KD_VERSION" -ForegroundColor White
    Write-Host "  Structured Multi-Role AI Product Execution System"
    Write-Host ""
}

# ---------------------------------------------------------------------------
# Logging
# ---------------------------------------------------------------------------
function Write-Info    { param([string]$Msg) Write-Host "  [INFO]    $Msg" -ForegroundColor Blue }
function Write-Ok      { param([string]$Msg) Write-Host "  [SUCCESS] $Msg" -ForegroundColor Green }
function Write-Warn    { param([string]$Msg) Write-Host "  [WARN]    $Msg" -ForegroundColor Yellow }
function Write-Err     { param([string]$Msg) Write-Host "  [ERROR]   $Msg" -ForegroundColor Red }

# ---------------------------------------------------------------------------
# Usage
# ---------------------------------------------------------------------------
if ($Help) {
    Write-Host ''
    Write-Host 'Usage: .\install.ps1 [OPTIONS]'
    Write-Host ''
    Write-Host 'Options:'
    Write-Host '  -TargetDir [path]        Target project directory (default: .)'
    Write-Host '  -Target [tools]          AI tools (comma-separated): claude-code, cursor, antigravity, all'
    Write-Host '  -Language [lang]         Language: EN, MS'
    Write-Host '  -NonInteractive          Skip prompts, use defaults'
    Write-Host '  -Force                   Overwrite existing installation'
    Write-Host '  -Help                    Show this help'
    Write-Host ''
    Write-Host 'Examples:'
    Write-Host '  .\install.ps1'
    Write-Host '  .\install.ps1 -Target claude-code -Language EN'
    Write-Host '  .\install.ps1 -Target "claude-code,cursor" -Language EN'
    Write-Host '  .\install.ps1 -Target all -Language MS'
    Write-Host '  .\install.ps1 -TargetDir C:\Projects\MyApp -Target cursor -Language MS'
    Write-Host '  .\install.ps1 -NonInteractive -Force'
    Write-Host ''
    exit 0
}

# ---------------------------------------------------------------------------
# Interactive Prompts
# ---------------------------------------------------------------------------
function Ask-Target {
    if ($Target) {
        if ($Target -eq 'all') { return @('claude-code', 'cursor', 'antigravity') }
        return ($Target -split ',').Trim()
    }
    if ($NonInteractive) { return @('claude-code') }

    Write-Host ""
    Write-Host '  Select target AI tool(s) - choose multiple with commas (e.g. 1,3):' -ForegroundColor White
    Write-Host "    [1] Claude Code" -ForegroundColor Cyan
    Write-Host "    [2] Cursor" -ForegroundColor Cyan
    Write-Host "    [3] Antigravity" -ForegroundColor Cyan
    Write-Host "    [A] All of the above" -ForegroundColor Yellow
    Write-Host ""

    while ($true) {
        $choice = (Read-Host '  Enter choice(s) [1-3, A]').Trim()

        if ($choice -match '^[Aa]$') {
            return @('claude-code', 'cursor', 'antigravity')
        }

        $selections = @()
        $valid = $true
        foreach ($c in ($choice -split ',')) {
            switch ($c.Trim()) {
                "1" { $selections += 'claude-code' }
                "2" { $selections += 'cursor' }
                "3" { $selections += 'antigravity' }
                default { $valid = $false }
            }
        }

        if ($valid -and $selections.Count -gt 0) {
            return ($selections | Select-Object -Unique)
        }

        Write-Host "  Invalid choice. Enter numbers 1-3 separated by commas, or A for all." -ForegroundColor Red
    }
}

function Ask-Language {
    if ($Language) { return $Language }
    if ($NonInteractive) { return "EN" }

    Write-Host ""
    Write-Host "  Select preferred language:" -ForegroundColor White
    Write-Host "    [EN] English" -ForegroundColor Cyan
    Write-Host "    [MS] Bahasa Melayu" -ForegroundColor Cyan
    Write-Host ""

    while ($true) {
        $choice = (Read-Host '  Enter choice [EN/MS]').ToUpper()
        switch ($choice) {
            "EN" { return "EN" }
            "MS" { return "MS" }
            default { Write-Host "  Invalid choice. Please enter EN or MS." -ForegroundColor Red }
        }
    }
}

function Confirm-Install {
    param([string[]]$T, [string]$L, [string]$D)

    if ($NonInteractive) { return }

    $targetList = $T -join ', '
    Write-Host ""
    Write-Host "  Installation Summary:" -ForegroundColor White
    Write-Host "    Target(s): $targetList" -ForegroundColor Cyan
    Write-Host "    Language:  $L" -ForegroundColor Cyan
    $resolvedDir = Resolve-Path $D
    Write-Host "    Directory: $resolvedDir" -ForegroundColor Cyan
    Write-Host ""

    $confirm = Read-Host "  Proceed with installation? [Y/n]"
    if ($confirm -and $confirm -notmatch '^[Yy]$') {
        Write-Info "Installation cancelled."
        exit 0
    }
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
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri $Url -OutFile $Dest -UseBasicParsing -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

function Get-AndTrack {
    param([string]$Url, [string]$Rel, [string]$Label)

    $dest = Join-Path $TargetDir $Rel
    if (Get-RemoteFile -Url $Url -Dest $dest) {
        # ok
    } else {
        Write-Warn "  Failed: $Label"
    }
}

# ---------------------------------------------------------------------------
# Create Directories
# ---------------------------------------------------------------------------
function New-KDDirs {
    Write-Info "Creating KD directory structure..."

    $dirs = @(
        $KD_DIR
        "$KD_DIR\prompts"
        "$KD_DIR\prompts\roles"
        "$KD_DIR\prompts\stages"
        "$KD_DIR\prompts\multi-agent"
        "$KD_DIR\templates"
        "$KD_DIR\checklists"
        "$KD_DIR\workflows"
        "$KD_DIR\config"
        "$KD_DIR\config\language"
        "$KD_DIR\KD_output"
        "$KD_DIR\KD_output\status"
        "$KD_DIR\KD_output\brainstorm"
        "$KD_DIR\KD_output\product-brief"
        "$KD_DIR\KD_output\PRD"
        "$KD_DIR\KD_output\architecture"
        "$KD_DIR\KD_output\epics-and-stories"
        "$KD_DIR\KD_output\code-review"
        "$KD_DIR\KD_output\deployment"
        "$KD_DIR\KD_output\release"
        "$KD_DIR\KD_output\decisions"
        "$KD_DIR\KD_output\risks"
    )

    foreach ($dir in $dirs) {
        $fullPath = Join-Path $TargetDir $dir
        if (-not (Test-Path $fullPath)) {
            New-Item -ItemType Directory -Path $fullPath -Force | Out-Null
        }
    }

    Write-Ok "Directory structure created."
}

# ---------------------------------------------------------------------------
# Download Files
# ---------------------------------------------------------------------------
function Get-KDFiles {
    Write-Info "Downloading KD files..."

    $base = "$KD_RAW_URL/src"

    # System Prompt
    Get-AndTrack "$base/prompts/system-prompt.md" "$KD_DIR\prompts\system-prompt.md" "System Prompt"

    # Roles
    foreach ($r in @('_role-template','analyst','product-manager','architect','tech-lead','engineer','qa','security','devops','release-manager')) {
        Get-AndTrack "$base/prompts/roles/$r.md" "$KD_DIR\prompts\roles\$r.md" "Role: $r"
    }

    # Stages (now 8 with brainstorm)
    foreach ($s in @('_stage-template','discovery','brainstorm','requirements','architecture','implementation','quality','deployment','release')) {
        Get-AndTrack "$base/prompts/stages/$s.md" "$KD_DIR\prompts\stages\$s.md" "Stage: $s"
    }

    # Multi-Agent
    foreach ($m in @('party-mode','agent-swarm','confidence-scoring','conflict-resolution','aggregation')) {
        Get-AndTrack "$base/prompts/multi-agent/$m.md" "$KD_DIR\prompts\multi-agent\$m.md" "Multi-Agent: $m"
    }

    # Templates
    foreach ($t in @('status','product-brief','prd','architecture','story-card','deployment-plan','release-notes','decision-log','risk-register')) {
        Get-AndTrack "$base/templates/$t.md" "$KD_DIR\templates\$t.md" "Template: $t"
    }

    # Checklists
    foreach ($c in @('stage-completion','decision-validation','checkpoint-approval','security-audit','pre-deployment','code-quality')) {
        Get-AndTrack "$base/checklists/$c.md" "$KD_DIR\checklists\$c.md" "Checklist: $c"
    }

    # Workflows
    foreach ($w in @('main','quick-start','full-product','maintenance')) {
        Get-AndTrack "$base/workflows/$w.md" "$KD_DIR\workflows\$w.md" "Workflow: $w"
    }

    # Config
    Get-AndTrack "$base/config/settings-schema.json" "$KD_DIR\config\settings-schema.json" "Config: schema"
    Get-AndTrack "$base/config/defaults.json" "$KD_DIR\config\defaults.json" "Config: defaults"
    Get-AndTrack "$base/config/language/en.json" "$KD_DIR\config\language\en.json" "Language: EN"
    Get-AndTrack "$base/config/language/ms.json" "$KD_DIR\config\language\ms.json" "Language: MS"

    Write-Ok "KD files downloaded."
}

# ---------------------------------------------------------------------------
# Create Config (settings.json)
# ---------------------------------------------------------------------------
function New-KDConfig {
    param([string[]]$T, [string]$L)

    Write-Info "Creating configuration..."

    $projName = Split-Path -Leaf (Resolve-Path $TargetDir)
    $now = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')

    $json = @{
        version = $KD_VERSION
        project_name = $projName
        language = $L
        target_tools = $T
        scale = 'auto'
        installed_date = $now
        site = $KD_SITE
        branding = 'KRACKEDDEVS'
        features = @{
            multi_agent = $true
            status_tracking = $true
            decision_validation = $true
            checkpoints = $true
            web_research = $true
            agent_personalities = $true
        }
    } | ConvertTo-Json -Depth 3

    $path = Join-Path $TargetDir "$KD_DIR\config\settings.json"
    [System.IO.File]::WriteAllText($path, $json, [System.Text.Encoding]::UTF8)

    Write-Ok "Configuration created."
}

# ---------------------------------------------------------------------------
# Initialize status.md (in KD_output/status/)
# ---------------------------------------------------------------------------
function New-StatusFile {
    param([string]$L)

    Write-Info "Initializing status.md..."

    $projName = Split-Path -Leaf (Resolve-Path $TargetDir)
    $d = Get-Date -Format 'yyyy-MM-dd'

    $tmpl = '# PROJECT STATUS

## Meta
- Project: __P__
- Domain: [to be defined]
- Language: __L__
- Scale: [to be determined by AI during /KD-analyze]
- Deadline: [not defined]
- Created: __D__
- Last Updated: __D__

## Current State
- Stage: Ready to begin
- Active Role: None
- Active Story: none
- Multi-Agent Mode: none

## Completed Stages
| Stage | Status | Completed Date | Key Artifact |
|-------|--------|----------------|--------------|
| Discovery | pending | - | - |
| Brainstorm | pending | - | - |
| Requirements | pending | - | - |
| Architecture | pending | - | - |
| Implementation | pending | - | - |
| Quality | pending | - | - |
| Deployment | pending | - | - |
| Release | pending | - | - |

## Completed Artifacts
| Artifact | Location | Stage | Date |
|----------|----------|-------|------|

## Architecture Decisions
| ID | Decision | Rationale | Impact | Date | Status |
|----|----------|-----------|--------|------|--------|

## Tech Stack
| Layer | Technology | Version | Reason |
|-------|------------|---------|--------|

## Dependencies
| Name | Type | Version | Status | Risk |
|------|------|---------|--------|------|

## Open Risks
| ID | Risk | Severity | Probability | Mitigation | Owner | Status |
|----|------|----------|-------------|------------|-------|--------|

## Security Notes
| Component | Classification | Protection | Audit Date |
|-----------|----------------|------------|------------|

## Deployment State
- Environment: development
- Last Deploy: N/A
- Status: pending
- Version: N/A

## Monitoring State
- Health Check: N/A
- Logs: N/A
- Alerts: none
- Dashboard: N/A

## Known Issues
| ID | Issue | Severity | Workaround | Status |
|----|-------|----------|------------|--------|

## Multi-Agent Sessions
| Session ID | Mode | Agents | Topic | Consensus | Result | Date |
|------------|------|--------|-------|-----------|--------|------|

## Next Actions
1. Run /KD-analyze to begin discovery phase

## Blockers
| ID | Blocker | Since | Impact | Resolution Plan |
|----|---------|-------|--------|-----------------|

## Change Log
| Timestamp | Stage | Change | Role | Reason |
|-----------|-------|--------|------|--------|
| __D__ | Init | KD installed v__V__ | System | Initial installation |'

    $content = $tmpl.Replace('__P__', $projName).Replace('__L__', $L).Replace('__D__', $d).Replace('__V__', $KD_VERSION)

    $path = Join-Path $TargetDir "$KD_DIR\KD_output\status\status.md"
    [System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)

    Write-Ok "status.md initialized."
}

# ---------------------------------------------------------------------------
# Adapter: Claude Code
# ---------------------------------------------------------------------------
function Setup-ClaudeCode {
    Write-Info "Setting up for Claude Code..."

    $url = "$KD_RAW_URL/src/adapters/claude-code/CLAUDE.md"
    $dest = Join-Path $TargetDir 'CLAUDE.md'
    if (-not (Get-RemoteFile -Url $url -Dest $dest)) {
        Write-Warn "Could not download CLAUDE.md, creating local copy..."
        $content = '# KD - AI Skill by KRACKEDDEVS
Read .kracked/prompts/system-prompt.md for full instructions.
Type /KD for command menu. Status: .kracked/KD_output/status/status.md'
        [System.IO.File]::WriteAllText($dest, $content, [System.Text.Encoding]::UTF8)
    }

    # Deploy slash command files
    $cmdDir = Join-Path $TargetDir '.claude\commands'
    New-Item -ItemType Directory -Path $cmdDir -Force | Out-Null
    $cmdNames = @(
        'KD','KD-analyze','KD-architecture','KD-brainstorm','KD-build-agent','KD-build-module','KD-build-workflow',
        'KD-code-review','KD-deployment-plan','KD-dev-story','KD-doc-project','KD-domain-research','KD-epics-and-stories',
        'KD-fix-course','KD-game-arch','KD-game-architect','KD-game-brainstorm','KD-game-brief','KD-game-designer',
        'KD-game-dev','KD-game-dev-story','KD-game-gdd','KD-game-narrative','KD-game-qa','KD-game-scrum-master',
        'KD-game-solo','KD-game-story','KD-game-test-auto','KD-game-test-design','KD-game-test-perf','KD-game-test-plan',
        'KD-game-writer','KD-help','KD-idea-coach','KD-idea-design-thinking','KD-idea-innovation','KD-idea-presenter',
        'KD-idea-problem-solving','KD-idea-solver','KD-idea-storyteller','KD-idea-storytelling','KD-idea-strategist',
        'KD-market-research','KD-party-mode','KD-prd','KD-product-brief','KD-project-context','KD-qa-automate','KD-quick-dev',
        'KD-quick-spec','KD-retrospective','KD-role-analyst','KD-role-architect','KD-role-bmad-master','KD-role-dev',
        'KD-role-pm','KD-role-qa','KD-role-scrum-master','KD-role-solo-dev','KD-role-tech-writer','KD-role-ux',
        'KD-scale-review','KD-sprint-planning','KD-sprint-status','KD-status','KD-swarm','KD-tech-research','KD-test-arch',
        'KD-test-atdd','KD-test-automate','KD-test-ci','KD-test-design','KD-test-frame','KD-test-nfr','KD-test-teach',
        'KD-test-trace','KD-ux-design','KD-validate','KD-validate-agent','KD-validate-workflow','KD-kickoff','KD-refactor','KD-test','KD-api-design'
    )
    foreach ($cmd in $cmdNames) {
        $cmdUrl = "$KD_RAW_URL/src/adapters/claude-code/commands/$cmd.md"
        $cmdDest = Join-Path $cmdDir "$cmd.md"
        Get-RemoteFile -Url $cmdUrl -Dest $cmdDest | Out-Null
    }
    Write-Verbose "  Deployed $($cmdNames.Count) slash commands to .claude/commands/"

    Write-Ok "Claude Code setup complete."
}

# ---------------------------------------------------------------------------
# Adapter: Cursor
# ---------------------------------------------------------------------------
function Setup-Cursor {
    Write-Info "Setting up for Cursor..."

    $url = "$KD_RAW_URL/src/adapters/cursor/.cursorrules"
    $dest = Join-Path $TargetDir '.cursorrules'
    if (-not (Get-RemoteFile -Url $url -Dest $dest)) {
        Write-Warn "Could not download .cursorrules, creating local copy..."
        $content = '# KD - AI Skill by KRACKEDDEVS
Read .kracked/prompts/system-prompt.md for full instructions.
Type /KD for command menu. Status: .kracked/KD_output/status/status.md'
        [System.IO.File]::WriteAllText($dest, $content, [System.Text.Encoding]::UTF8)
    }

    # Deploy slash command files
    $cmdDir = Join-Path $TargetDir '.cursor\commands'
    New-Item -ItemType Directory -Path $cmdDir -Force | Out-Null
    $cmdNames = @(
        'KD','KD-analyze','KD-architecture','KD-brainstorm','KD-build-agent','KD-build-module','KD-build-workflow',
        'KD-code-review','KD-deployment-plan','KD-dev-story','KD-doc-project','KD-domain-research','KD-epics-and-stories',
        'KD-fix-course','KD-game-arch','KD-game-architect','KD-game-brainstorm','KD-game-brief','KD-game-designer',
        'KD-game-dev','KD-game-dev-story','KD-game-gdd','KD-game-narrative','KD-game-qa','KD-game-scrum-master',
        'KD-game-solo','KD-game-story','KD-game-test-auto','KD-game-test-design','KD-game-test-perf','KD-game-test-plan',
        'KD-game-writer','KD-help','KD-idea-coach','KD-idea-design-thinking','KD-idea-innovation','KD-idea-presenter',
        'KD-idea-problem-solving','KD-idea-solver','KD-idea-storyteller','KD-idea-storytelling','KD-idea-strategist',
        'KD-market-research','KD-party-mode','KD-prd','KD-product-brief','KD-project-context','KD-qa-automate','KD-quick-dev',
        'KD-quick-spec','KD-retrospective','KD-role-analyst','KD-role-architect','KD-role-bmad-master','KD-role-dev',
        'KD-role-pm','KD-role-qa','KD-role-scrum-master','KD-role-solo-dev','KD-role-tech-writer','KD-role-ux',
        'KD-scale-review','KD-sprint-planning','KD-sprint-status','KD-status','KD-swarm','KD-tech-research','KD-test-arch',
        'KD-test-atdd','KD-test-automate','KD-test-ci','KD-test-design','KD-test-frame','KD-test-nfr','KD-test-teach',
        'KD-test-trace','KD-ux-design','KD-validate','KD-validate-agent','KD-validate-workflow','KD-kickoff','KD-refactor','KD-test','KD-api-design'
    )
    foreach ($cmd in $cmdNames) {
        $cmdUrl = "$KD_RAW_URL/src/adapters/cursor/commands/$cmd.md"
        $cmdDest = Join-Path $cmdDir "$cmd.md"
        Get-RemoteFile -Url $cmdUrl -Dest $cmdDest | Out-Null
    }
    Write-Verbose "  Deployed $($cmdNames.Count) slash commands to .cursor/commands/"

    Write-Ok "Cursor setup complete."
}

# ---------------------------------------------------------------------------
# Adapter: Antigravity
# ---------------------------------------------------------------------------
function Setup-Antigravity {
    Write-Info "Setting up for Antigravity..."

    $agDir = Join-Path $TargetDir '.antigravity'
    if (-not (Test-Path $agDir)) {
        New-Item -ItemType Directory -Path $agDir -Force | Out-Null
    }

    $url = "$KD_RAW_URL/src/adapters/antigravity/SKILL.md"
    $dest = Join-Path $agDir 'SKILL.md'
    if (-not (Get-RemoteFile -Url $url -Dest $dest)) {
        Write-Warn "Could not download SKILL.md, creating local copy..."
        $content = '---
name: KRACKED_skill (KD)
description: Structured Multi-Role AI Product Execution System by KRACKEDDEVS
---
Read .kracked/prompts/system-prompt.md for full instructions.
Type /KD for command menu. Status: .kracked/KD_output/status/status.md'
        [System.IO.File]::WriteAllText($dest, $content, [System.Text.Encoding]::UTF8)
    }

    # Deploy slash command files (Antigravity uses .agent/workflows/)
    $cmdDir = Join-Path $TargetDir '.agent\workflows'
    New-Item -ItemType Directory -Path $cmdDir -Force | Out-Null
    $cmdNames = @(
        'KD','KD-analyze','KD-architecture','KD-brainstorm','KD-build-agent','KD-build-module','KD-build-workflow',
        'KD-code-review','KD-deployment-plan','KD-dev-story','KD-doc-project','KD-domain-research','KD-epics-and-stories',
        'KD-fix-course','KD-game-arch','KD-game-architect','KD-game-brainstorm','KD-game-brief','KD-game-designer',
        'KD-game-dev','KD-game-dev-story','KD-game-gdd','KD-game-narrative','KD-game-qa','KD-game-scrum-master',
        'KD-game-solo','KD-game-story','KD-game-test-auto','KD-game-test-design','KD-game-test-perf','KD-game-test-plan',
        'KD-game-writer','KD-help','KD-idea-coach','KD-idea-design-thinking','KD-idea-innovation','KD-idea-presenter',
        'KD-idea-problem-solving','KD-idea-solver','KD-idea-storyteller','KD-idea-storytelling','KD-idea-strategist',
        'KD-market-research','KD-party-mode','KD-prd','KD-product-brief','KD-project-context','KD-qa-automate','KD-quick-dev',
        'KD-quick-spec','KD-retrospective','KD-role-analyst','KD-role-architect','KD-role-bmad-master','KD-role-dev',
        'KD-role-pm','KD-role-qa','KD-role-scrum-master','KD-role-solo-dev','KD-role-tech-writer','KD-role-ux',
        'KD-scale-review','KD-sprint-planning','KD-sprint-status','KD-status','KD-swarm','KD-tech-research','KD-test-arch',
        'KD-test-atdd','KD-test-automate','KD-test-ci','KD-test-design','KD-test-frame','KD-test-nfr','KD-test-teach',
        'KD-test-trace','KD-ux-design','KD-validate','KD-validate-agent','KD-validate-workflow','KD-kickoff','KD-refactor','KD-test','KD-api-design'
    )
    foreach ($cmd in $cmdNames) {
        $cmdUrl = "$KD_RAW_URL/src/adapters/antigravity/workflows/$cmd.md"
        $cmdDest = Join-Path $cmdDir "$cmd.md"
        Get-RemoteFile -Url $cmdUrl -Dest $cmdDest | Out-Null
    }
    Write-Verbose "  Deployed $($cmdNames.Count) slash commands to .agent/workflows/"

    Write-Ok "Antigravity setup complete."
}

# ---------------------------------------------------------------------------
# Print Success
# ---------------------------------------------------------------------------
function Show-Success {
    param([string[]]$T, [string]$L)

    $projDir = Resolve-Path $TargetDir
    $targetList = $T -join ', '

    Write-Host ""
    Write-Host "  =================================================================" -ForegroundColor Green
    Write-Host "  KD v$KD_VERSION installed successfully!" -ForegroundColor Green
    Write-Host "  AI Skill by KRACKEDDEVS" -ForegroundColor Green
    Write-Host "  $KD_SITE" -ForegroundColor Green
    Write-Host "  =================================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Adapters: $targetList" -ForegroundColor Cyan
    Write-Host ""

    if ($L -eq 'MS') {
        Write-Host "  Langkah Seterusnya:" -ForegroundColor White
        Write-Host ""
        Write-Host "    1. Baca system prompt:"
        Write-Host "       $projDir\$KD_DIR\prompts\system-prompt.md" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "    2. Mulakan AI tool anda dan taipkan:"
        Write-Host "       /KD" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "    3. Jejak kemajuan anda dalam:"
        Write-Host "       $projDir\$KD_DIR\KD_output\status\status.md" -ForegroundColor Cyan
    } else {
        Write-Host "  Next Steps:" -ForegroundColor White
        Write-Host ""
        Write-Host "    1. Read the system prompt:"
        Write-Host "       $projDir\$KD_DIR\prompts\system-prompt.md" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "    2. Open your AI tool and type:"
        Write-Host "       /KD" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "    3. Track your progress in:"
        Write-Host "       $projDir\$KD_DIR\KD_output\status\status.md" -ForegroundColor Cyan
    }

    Write-Host ""
    Write-Host "  KD finishes what it starts." -ForegroundColor White
    Write-Host ""
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
function Main {
    Show-Banner

    # Ensure target dir exists
    if (-not (Test-Path $TargetDir)) {
        New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
    }

    # Check existing
    $kdPath = Join-Path $TargetDir $KD_DIR
    if (Test-Path $kdPath) {
        if ($Force) {
            Write-Warn "Existing installation found. Overwriting (-Force)."
            Remove-Item -Path $kdPath -Recurse -Force
        } else {
            Write-Err "KD is already installed in this directory."
            Write-Err "Use -Force to overwrite."
            exit 1
        }
    }

    $psVer = $PSVersionTable.PSVersion.ToString()
    Write-Info "Platform: Windows `(PowerShell $psVer`)"

    # Prompts
    $selTargets = Ask-Target
    $selLang = Ask-Language
    Confirm-Install -T $selTargets -L $selLang -D $TargetDir

    # Install
    New-KDDirs
    Get-KDFiles
    New-KDConfig -T $selTargets -L $selLang
    New-StatusFile -L $selLang

    # Setup adapters (multiple)
    foreach ($t in $selTargets) {
        switch ($t) {
            'claude-code'  { Setup-ClaudeCode }
            'cursor'       { Setup-Cursor }
            'antigravity'  { Setup-Antigravity }
        }
    }

    Show-Success -T $selTargets -L $selLang
}

Main
