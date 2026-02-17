#!/usr/bin/env bash
# ============================================================================
# Kracked_Skills (KD) - Installation Script
# AI Skill by KRACKEDDEVS
# https://krackeddevs.com/
# ============================================================================

set -euo pipefail

# Error trap
trap 'echo "Error on line $LINENO"' ERR

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------
readonly KD_VERSION="5.0.0"
readonly KD_REPO="MoonWIRaja/Kracked_Skills"
readonly KD_RAW_URL="https://raw.githubusercontent.com/${KD_REPO}/main"
readonly KD_DIR=".kracked"
readonly KD_SITE="https://krackeddevs.com/"

# Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly MAGENTA='\033[0;35m'
readonly BOLD='\033[1m'
readonly NC='\033[0m' # No Color

# Defaults
TARGET_DIR="."
TARGET_TOOLS=""
LANGUAGE=""
NON_INTERACTIVE=false
FORCE_INSTALL=false
VERBOSE=false

# ---------------------------------------------------------------------------
# Banner
# ---------------------------------------------------------------------------
print_banner() {
    echo -e "${CYAN}"
    cat << 'BANNER'
╔═══════════════════════════════════════════════════════════════════════╗
║                                                                       ║
║  ██╗  ██╗██████╗                                                      ║
║  ██║  ██╔╝██╔══██╗                                                    ║
║  █████╔╝ ██║  ██║    AI Skill by KRACKEDDEVS                          ║
║  ██╔═██╗ ██║  ██║    https://krackeddevs.com/                         ║
║  ██║  ██╗██████╔╝                                                     ║
║  ╚═╝  ╚═╝╚═════╝                                                      ║
║                                                                       ║
╚═══════════════════════════════════════════════════════════════════════╝
BANNER
    echo -e "${NC}"
    echo -e "${BOLD}  Kracked_Skills v${KD_VERSION}${NC}"
    echo -e "  Structured Multi-Role AI Product Execution System"
    echo ""
}

# ---------------------------------------------------------------------------
# Logging Helpers
# ---------------------------------------------------------------------------
log_info()    { echo -e "  ${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "  ${GREEN}[SUCCESS]${NC} $1"; }
log_warn()    { echo -e "  ${YELLOW}[WARN]${NC} $1"; }
log_error()   { echo -e "  ${RED}[ERROR]${NC} $1"; }
log_verbose() { if [[ "$VERBOSE" == true ]]; then echo -e "  ${MAGENTA}[DEBUG]${NC} $1"; fi; }

# ---------------------------------------------------------------------------
# Usage
# ---------------------------------------------------------------------------
show_usage() {
    cat << 'USAGE'
Usage: install.sh [TARGET_DIR] [OPTIONS]

Arguments:
    TARGET_DIR       Target project directory (default: current directory)

Options:
    --target=<tools>     AI tools (comma-separated): claude-code, cursor, antigravity, cline, kilocode, roo-code, all
    --language=<lang>    Language preference: EN, MS
    --non-interactive    Skip interactive prompts, use defaults
    --force              Overwrite existing installation
    --verbose            Show detailed output
    --help               Show this help message

Examples:
    curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_skill/main/install.sh | bash
    bash install.sh /path/to/project --target=claude-code,cursor,cline --language=MS
    bash install.sh . --target=all --language=EN
    bash install.sh . --non-interactive --force
USAGE
}

# ---------------------------------------------------------------------------
# Dependency Checks
# ---------------------------------------------------------------------------
check_dependencies() {
    log_info "Checking dependencies..."

    # Check bash version
    if [[ "${BASH_VERSINFO[0]}" -lt 4 ]]; then
        log_warn "Bash 4+ recommended (current: ${BASH_VERSION}). Proceeding anyway."
    fi

    # Temporarily disable exit-on-error for checks
    set +e

    # Check for download tool
    local has_curl=false
    local has_wget=false

    if type curl >/dev/null 2>&1; then
        has_curl=true
        log_verbose "curl found: $(type curl)"
    fi

    if type wget >/dev/null 2>&1; then
        has_wget=true
        log_verbose "wget found: $(type wget)"
    fi

    if [[ "$has_curl" == false && "$has_wget" == false ]]; then
        set -e
        log_error "Neither curl nor wget found. Please install one of them."
        log_error "  Ubuntu/Debian: sudo apt install curl"
        log_error "  macOS: brew install curl"
        log_error "  CentOS/RHEL: sudo yum install curl"
        exit 1
    fi

    # Check for git (optional)
    if type git >/dev/null 2>&1; then
        log_verbose "git found: $(type git)"
    else
        log_verbose "git not found (optional)"
    fi

    # Re-enable exit-on-error
    set -e

    # Check write permission
    if [[ ! -w "${TARGET_DIR}" ]]; then
        log_error "No write permission to ${TARGET_DIR}"
        log_error "Try: chmod u+w ${TARGET_DIR}"
        exit 1
    fi

    log_success "All dependencies satisfied."
}

# ---------------------------------------------------------------------------
# Platform Detection
# ---------------------------------------------------------------------------
detect_platform() {
    log_info "Detecting platform..."
    local platform="unknown"
    local uname_out

    uname_out="$(uname -s)"
    case "${uname_out}" in
        Linux*)
            if grep -qi microsoft /proc/version 2>/dev/null; then
                platform="wsl"
                log_info "Detected platform: Windows (WSL)"
            else
                platform="linux"
                log_info "Detected platform: Linux"
            fi
            ;;
        Darwin*)
            platform="macos"
            log_info "Detected platform: macOS"
            ;;
        CYGWIN*|MINGW*|MSYS*)
            platform="windows-git"
            log_info "Detected platform: Windows (Git Bash)"
            ;;
        *)
            platform="unknown"
            log_warn "Unknown platform: ${uname_out}. Proceeding anyway."
            ;;
    esac

    echo "$platform"
}

# ---------------------------------------------------------------------------
# Interactive Prompts
# ---------------------------------------------------------------------------
ask_target() {
    if [[ -n "$TARGET_TOOLS" ]]; then
        if [[ "$TARGET_TOOLS" == "all" ]]; then
            TARGET_TOOLS="claude-code,cursor,antigravity,cline,kilocode,roo-code"
        fi
        return
    fi

    if [[ "$NON_INTERACTIVE" == true ]]; then
        TARGET_TOOLS="claude-code"
        return
    fi

    echo ""
    echo -e "  ${BOLD}Select target AI tool(s) — choose multiple with commas (e.g. 1,3):${NC}"
    echo -e "  ${CYAN}[1]${NC} Claude Code"
    echo -e "  ${CYAN}[2]${NC} Cursor"
    echo -e "  ${CYAN}[3]${NC} Antigravity"
    echo -e "  ${CYAN}[4]${NC} Cline"
    echo -e "  ${CYAN}[5]${NC} Kilo Code"
    echo -e "  ${CYAN}[6]${NC} Roo Code"
    echo -e "  ${YELLOW}[A]${NC} All of the above"
    echo ""

    # Disable exit-on-error for interactive loop
    set +e
    while true; do
        if [ -c /dev/tty ]; then
            printf "  Enter choice(s) [1-6, A]: " > /dev/tty
            read choice < /dev/tty
        else
            printf "  Enter choice(s) [1-6, A]: "
            read choice
        fi

        choice=$(echo "$choice" | tr '[:lower:]' '[:upper:]')

        if [[ "$choice" == "A" ]]; then
            TARGET_TOOLS="claude-code,cursor,antigravity,cline,kilocode,roo-code"
            break
        fi

        local selections=""
        local valid=true
        IFS=',' read -ra parts <<< "$choice"
        for part in "${parts[@]}"; do
            part=$(echo "$part" | tr -d ' ')
            case "$part" in
                1) selections="${selections:+$selections,}claude-code" ;;
                2) selections="${selections:+$selections,}cursor" ;;
                3) selections="${selections:+$selections,}antigravity" ;;
                4) selections="${selections:+$selections,}cline" ;;
                5) selections="${selections:+$selections,}kilocode" ;;
                6) selections="${selections:+$selections,}roo-code" ;;
                *) valid=false ;;
            esac
        done

        if [[ "$valid" == true && -n "$selections" ]]; then
            TARGET_TOOLS="$selections"
            break
        fi

        echo -e "  ${RED}Invalid choice. Enter numbers 1-6 separated by commas, or A for all.${NC}"
    done
    # Re-enable exit-on-error
    set -e
}

ask_language() {
    if [[ -n "$LANGUAGE" ]]; then
        return
    fi

    if [[ "$NON_INTERACTIVE" == true ]]; then
        LANGUAGE="EN"
        return
    fi

    echo ""
    echo -e "  ${BOLD}Select preferred language:${NC}"
    echo -e "  ${CYAN}[EN]${NC} English"
    echo -e "  ${CYAN}[MS]${NC} Bahasa Melayu"
    echo ""

    # Disable exit-on-error for interactive loop
    set +e
    while true; do
        if [ -c /dev/tty ]; then
            printf "  Enter choice [EN/MS]: " > /dev/tty
            read choice < /dev/tty
        else
            printf "  Enter choice [EN/MS]: "
            read choice
        fi

        choice=$(echo "$choice" | tr '[:lower:]' '[:upper:]')
        case "$choice" in
            EN) LANGUAGE="EN"; break ;;
            MS) LANGUAGE="MS"; break ;;
            *)  echo -e "  ${RED}Invalid choice. Please enter EN or MS.${NC}" ;;
        esac
    done
    # Re-enable exit-on-error
    set -e
}

confirm_installation() {
    if [[ "$NON_INTERACTIVE" == true ]]; then
        return
    fi

    echo ""
    echo -e "  ${BOLD}Installation Summary:${NC}"
    echo -e "  Target(s):  ${CYAN}${TARGET_TOOLS}${NC}"
    echo -e "  Language:   ${CYAN}${LANGUAGE}${NC}"
    echo -e "  Directory:  ${CYAN}$(cd "$TARGET_DIR" && pwd)${NC}"
    echo ""

    # Disable exit-on-error for interactive input
    set +e
    if [ -c /dev/tty ]; then
        printf "  Proceed with installation? [Y/n]: " > /dev/tty
        read confirm < /dev/tty
    else
        printf "  Proceed with installation? [Y/n]: "
        read confirm
    fi
    set -e

    confirm="${confirm:-Y}"
    case "$confirm" in
        [yY][eE][sS]|[yY]) ;;
        *) log_info "Installation cancelled."; exit 0 ;;
    esac
}

# ---------------------------------------------------------------------------
# Check Existing Installation
# ---------------------------------------------------------------------------
check_existing() {
    if [[ -d "${TARGET_DIR}/${KD_DIR}" ]]; then
        if [[ "$FORCE_INSTALL" == true ]]; then
            log_warn "Existing installation found. Overwriting (--force)."
            rm -rf "${TARGET_DIR}/${KD_DIR}"
        else
            log_error "KD is already installed in this directory."
            log_error "Use --force to overwrite, or run uninstall.sh first."
            exit 1
        fi
    fi
}

# ---------------------------------------------------------------------------
# Download Helper
# ---------------------------------------------------------------------------
download_file() {
    local url="$1"
    local dest="$2"

    # Ensure parent directory exists
    mkdir -p "$(dirname "$dest")"

    if command -v curl &>/dev/null; then
        curl -fsSL "$url" -o "$dest" 2>/dev/null
    elif command -v wget &>/dev/null; then
        wget -qO "$dest" "$url" 2>/dev/null
    fi
}

# ---------------------------------------------------------------------------
# Create Directory Structure
# ---------------------------------------------------------------------------
create_directories() {
    log_info "Creating KD directory structure..."

    # Create all directories explicitly to avoid loop/variable issues in Bash 3.2
    mkdir -p "${TARGET_DIR}/${KD_DIR}"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/prompts"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/prompts/roles"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/prompts/stages"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/prompts/multi-agent"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/templates"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/checklists"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/workflows"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/config"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/config/language"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/config/agents"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/testsprite"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/tool-selector"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/git-integration"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/analytics"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/exporters"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/artifacts"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/KD_output"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/KD_output/status"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/KD_output/brainstorm"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/KD_output/product-brief"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/KD_output/PRD"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/KD_output/architecture"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/KD_output/epics-and-stories"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/KD_output/code-review"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/KD_output/deployment"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/KD_output/release"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/KD_output/decisions"
    mkdir -p "${TARGET_DIR}/${KD_DIR}/KD_output/risks"

    log_verbose "Directories created."
    log_success "Directory structure created."
}

# ---------------------------------------------------------------------------
# Download KD Files
# ---------------------------------------------------------------------------
download_files() {
    log_info "Downloading KD files..."

    local base="${KD_RAW_URL}/src"
    local files_downloaded=0
    local files_failed=0

    # ---- System Prompt ----
    download_and_track "${base}/prompts/system-prompt.md" \
        "${KD_DIR}/prompts/system-prompt.md" "System Prompt"
    download_and_track "${base}/prompts/role-switcher.md" \
        "${KD_DIR}/prompts/role-switcher.md" "Role Switcher"
    download_and_track "${base}/prompts/handoff-protocol.md" \
        "${KD_DIR}/prompts/handoff-protocol.md" "Handoff Protocol"
    download_and_track "${base}/prompts/conflict-resolution.md" \
        "${KD_DIR}/prompts/conflict-resolution.md" "Conflict Resolution"

    # ---- Roles ----
    local roles="_role-template analyst product-manager architect tech-lead engineer qa security devops release-manager ux-designer data-scientist mobile-developer database-admin"
    for role in $roles; do
        download_and_track "${base}/prompts/roles/${role}.md" \
            "${KD_DIR}/prompts/roles/${role}.md" "Role: ${role}"
    done

    # ---- Stages ----
    local stages="_stage-template discovery brainstorm requirements architecture implementation quality deployment release"
    for stage in $stages; do
        download_and_track "${base}/prompts/stages/${stage}.md" \
            "${KD_DIR}/prompts/stages/${stage}.md" "Stage: ${stage}"
    done

    # ---- Multi-Agent ----
    local multi="party-mode agent-swarm confidence-scoring conflict-resolution aggregation"
    for m in $multi; do
        download_and_track "${base}/prompts/multi-agent/${m}.md" \
            "${KD_DIR}/prompts/multi-agent/${m}.md" "Multi-Agent: ${m}"
    done

    # ---- Templates ----
    local templates="status product-brief prd architecture story-card deployment-plan release-notes decision-log risk-register"
    for tmpl in $templates; do
        download_and_track "${base}/templates/${tmpl}.md" \
            "${KD_DIR}/templates/${tmpl}.md" "Template: ${tmpl}"
    done

    # ---- Checklists ----
    local checklists="stage-completion decision-validation checkpoint-approval security-audit pre-deployment code-quality"
    for cl in $checklists; do
        download_and_track "${base}/checklists/${cl}.md" \
            "${KD_DIR}/checklists/${cl}.md" "Checklist: ${cl}"
    done

    # ---- Workflows ----
    local workflows="main quick-start full-product maintenance"
    for wf in $workflows; do
        download_and_track "${base}/workflows/${wf}.md" \
            "${KD_DIR}/workflows/${wf}.md" "Workflow: ${wf}"
    done

    # ---- Config ----
    download_and_track "${base}/config/settings-schema.json" \
        "${KD_DIR}/config/settings-schema.json" "Config: schema"
    download_and_track "${base}/config/defaults.json" \
        "${KD_DIR}/config/defaults.json" "Config: defaults"
    download_and_track "${base}/config/language/en.json" \
        "${KD_DIR}/config/language/en.json" "Language: EN"
    download_and_track "${base}/config/language/ms.json" \
        "${KD_DIR}/config/language/ms.json" "Language: MS"
    download_and_track "${base}/config/agents/personalities.json" \
        "${KD_DIR}/config/agents/personalities.json" "Config: Personalities"

    # ---- TestSprite ----
    download_and_track "${base}/testsprite/testsprite-core.js" \
        "${KD_DIR}/testsprite/testsprite-core.js" "TestSprite: Core"
    download_and_track "${base}/commands/testsprite.js" \
        "${KD_DIR}/testsprite/run.js" "TestSprite: CLI"

    # ---- Tool Selector ----
    download_and_track "${base}/tool-selector/tool-selector.js" \
        "${KD_DIR}/tool-selector/tool-selector.js" "Tool Selector: Logic"
    download_and_track "${base}/tool-selector/knowledge-base.json" \
        "${KD_DIR}/tool-selector/knowledge-base.json" "Tool Selector: KB"

    # ---- Git Integration ----
    download_and_track "${base}/git-integration/auto-commit.sh" \
        "${KD_DIR}/git-integration/auto-commit.sh" "Git: Auto-commit"
    download_and_track "${base}/git-integration/config.yaml" \
        "${KD_DIR}/git-integration/config.yaml" "Git: Config"

    # ---- Analytics ----
    download_and_track "${base}/analytics/agent-performance.json" \
        "${KD_DIR}/analytics/agent-performance.json" "Analytics: Perf"

    # ---- Exporters ----
    download_and_track "${base}/exporters/export-consolidated.sh" \
        "${KD_DIR}/exporters/export-consolidated.sh" "Export: Consolidated"
    download_and_track "${base}/exporters/export-jira.js" \
        "${KD_DIR}/exporters/export-jira.js" "Export: Jira"
    download_and_track "${base}/exporters/export-pdf.sh" \
        "${KD_DIR}/exporters/export-pdf.sh" "Export: PDF"

    # ---- Artifacts ----
    download_and_track "${base}/artifacts/manifest.yaml" \
        "${KD_DIR}/artifacts/manifest.yaml" "Artifacts: Manifest"

    log_success "KD files downloaded."
}

download_and_track() {
    local url="$1"
    local dest="${TARGET_DIR}/$2"
    local label="$3"

    log_verbose "Downloading ${label}..."
    if download_file "$url" "$dest"; then
        log_verbose "  ✓ ${label}"
    else
        log_warn "  ✗ Failed: ${label} (will use bundled fallback)"
    fi
}

deploy_commands() {
    local adapter="$1"
    local rel_dir="$2"
    local source_dir="$3"
    local target_cmd_dir="${TARGET_DIR}/${rel_dir}"

    mkdir -p "$target_cmd_dir"
    log_verbose "Created ${rel_dir}/ directory"

    local cmd_names="KD KD-analyze KD-architecture KD-brainstorm KD-build-agent KD-build-module KD-build-workflow KD-code-review KD-deployment-plan KD-dev-story KD-doc-project KD-domain-research KD-epics-and-stories KD-fix-course KD-game-arch KD-game-architect KD-game-brainstorm KD-game-brief KD-game-designer KD-game-dev KD-game-dev-story KD-game-gdd KD-game-narrative KD-game-qa KD-game-scrum-master KD-game-solo KD-game-story KD-game-test-auto KD-game-test-design KD-game-test-perf KD-game-test-plan KD-game-writer KD-help KD-idea-coach KD-idea-design-thinking KD-idea-innovation KD-idea-presenter KD-idea-problem-solving KD-idea-solver KD-idea-storyteller KD-idea-storytelling KD-idea-strategist KD-market-research KD-party-mode KD-prd KD-product-brief KD-project-context KD-qa-automate KD-quick-dev KD-quick-spec KD-retrospective KD-role-analyst KD-role-architect KD-role-bmad-master KD-role-dev KD-role-pm KD-role-qa KD-role-scrum-master KD-role-solo-dev KD-role-tech-writer KD-role-ux KD-scale-review KD-sprint-planning KD-sprint-status KD-status KD-swarm KD-tech-research KD-test-arch KD-test-atdd KD-test-automate KD-test-ci KD-test-design KD-test-frame KD-test-nfr KD-test-teach KD-test-trace KD-ux-design KD-validate KD-validate-agent KD-validate-workflow KD-kickoff KD-refactor KD-test KD-api-design KD-role-data-scientist KD-role-mobile-dev KD-role-dba KD-test-sprite KD-tool-selector"

    local downloaded=0
    for cmd in $cmd_names; do
        if download_file "${KD_RAW_URL}/src/adapters/${adapter}/${source_dir}/${cmd}.md" "${target_cmd_dir}/${cmd}.md"; then
            files_downloaded=$((files_downloaded + 1))
            downloaded=$((downloaded + 1))
        fi
    done

    log_verbose "Deployed ${downloaded} slash commands to ${rel_dir}/"
}

# ---------------------------------------------------------------------------
# Create Config
# ---------------------------------------------------------------------------
create_config() {
    log_info "Creating configuration..."

    cat > "${TARGET_DIR}/${KD_DIR}/config/settings.json" << SETTINGS
{
    "version": "${KD_VERSION}",
    "project_name": "$(basename "$(cd "$TARGET_DIR" && pwd)")",
    "language": "${LANGUAGE}",
    "target_tools": "${TARGET_TOOLS}",
    "scale": "auto",
    "installed_date": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
    "site": "${KD_SITE}",
    "branding": "KRACKEDDEVS",
    "features": {
        "multi_agent": true,
        "status_tracking": true,
        "decision_validation": true,
        "checkpoints": true,
        "web_research": true,
        "agent_personalities": true
    }
}
SETTINGS

    log_success "Configuration created."
}

# ---------------------------------------------------------------------------
# Initialize status.md
# ---------------------------------------------------------------------------
init_status() {
    log_info "Initializing status.md..."

    local project_name
    project_name="$(basename "$(cd "$TARGET_DIR" && pwd)")"
    local current_date
    current_date="$(date +"%Y-%m-%d")"

    cat > "${TARGET_DIR}/${KD_DIR}/KD_output/status/status.md" << STATUS
# PROJECT STATUS

## Meta
- Project: ${project_name}
- Domain: [to be defined]
- Language: ${LANGUAGE}
- Scale: [to be determined by AI during /KD-analyze]
- Deadline: [not defined]
- Created: ${current_date}
- Last Updated: ${current_date}

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
| ${current_date} | Init | KD installed v${KD_VERSION} | System | Initial installation |
STATUS

    log_success "status.md initialized."
}

# ---------------------------------------------------------------------------
# Adapter Setup
# ---------------------------------------------------------------------------

setup_claude_code() {
    log_info "Setting up for Claude Code..."

    mkdir -p "${TARGET_DIR}/.claude"
    local url="${KD_RAW_URL}/src/adapters/claude-code/CLAUDE.md"
    local dest="${TARGET_DIR}/.claude/CLAUDE.md"
    if download_file "$url" "$dest"; then
        log_verbose "Downloaded CLAUDE.md to .claude/"
    else
        log_warn "Could not download CLAUDE.md, creating local copy..."
        echo '# KD - AI Skill by KRACKEDDEVS
Read .kracked/prompts/system-prompt.md for full instructions.
Type /KD for command menu.
Status: .kracked/KD_output/status/status.md' > "$dest"
    fi

    deploy_commands "claude-code" ".claude/commands" "commands"
    log_success "Claude Code setup complete."
}

setup_cursor() {
    log_info "Setting up for Cursor..."

    mkdir -p "${TARGET_DIR}/.cursor"
    local url="${KD_RAW_URL}/src/adapters/cursor/.cursorrules"
    local dest="${TARGET_DIR}/.cursor/.cursorrules"
    if download_file "$url" "$dest"; then
        log_verbose "Downloaded .cursorrules to .cursor/"
    else
        log_warn "Could not download .cursorrules, creating local copy..."
        echo '# KD - AI Skill by KRACKEDDEVS
Read .kracked/prompts/system-prompt.md for full instructions.
Type /KD for command menu.
Status: .kracked/KD_output/status/status.md' > "$dest"
    fi

    deploy_commands "cursor" ".cursor/commands" "commands"
    log_success "Cursor setup complete."
}

setup_antigravity() {
    log_info "Setting up for Antigravity..."

    mkdir -p "${TARGET_DIR}/.agent"
    local url="${KD_RAW_URL}/src/adapters/antigravity/SKILL.md"
    local dest="${TARGET_DIR}/.agent/SKILL.md"
    if download_file "$url" "$dest"; then
        log_verbose "Downloaded SKILL.md to .agent/"
    else
        log_warn "Could not download SKILL.md, creating local copy..."
        echo '---
name: Kracked_Skills (KD)
description: Structured Multi-Role AI Product Execution System by KRACKEDDEVS
---
Read .kracked/prompts/system-prompt.md for full instructions.
Type /KD for command menu.
Status: .kracked/KD_output/status/status.md' > "$dest"
    fi

    deploy_commands "antigravity" ".agent/workflows" "workflows"
    log_success "Antigravity setup complete."
}

setup_cline() {
    log_info "Setting up for Cline (BMAD style)..."

    # Use .clinerules as folder name to match BMAD
    mkdir -p "${TARGET_DIR}/.clinerules"
    local url="${KD_RAW_URL}/src/adapters/cline/.clinerules"
    local dest="${TARGET_DIR}/.clinerules/.clinerules"
    if download_file "$url" "$dest"; then
        log_verbose "Downloaded .clinerules to .clinerules/"
    else
        log_warn "Could not download .clinerules, creating local copy..."
        echo '# KD - AI Skill by KRACKEDDEVS
Read .kracked/prompts/system-prompt.md for full instructions.
Type /KD for command menu.
Status: .kracked/KD_output/status/status.md' > "$dest"
    fi

    deploy_commands "cline" ".clinerules/workflows" "workflows"
    log_success "Cline setup complete."
}

setup_kilocode() {
    log_info "Setting up for Kilo Code (BMAD style)..."

    # Use .kilocode as folder name to match BMAD
    mkdir -p "${TARGET_DIR}/.kilocode"
    local url="${KD_RAW_URL}/src/adapters/kilocode/.kilocode"
    local dest="${TARGET_DIR}/.kilocode/.kilocode"
    if download_file "$url" "$dest"; then
        log_verbose "Downloaded .kilocode to .kilocode/"
    else
        log_warn "Could not download .kilocode, creating local copy..."
        echo '# KD - AI Skill by KRACKEDDEVS
Read .kracked/prompts/system-prompt.md for full instructions.
Type /KD for command menu.
Status: .kracked/KD_output/status/status.md' > "$dest"
    fi

    deploy_commands "kilocode" ".kilocode/workflows" "workflows"
    log_success "Kilo Code setup complete."
}

setup_roo_code() {
    log_info "Setting up for Roo Code..."

    mkdir -p "${TARGET_DIR}/.roo"
    local url="${KD_RAW_URL}/src/adapters/roo/.roo"
    local dest="${TARGET_DIR}/.roo/.roo"
    if download_file "$url" "$dest"; then
        log_verbose "Downloaded .roo to .roo/"
    else
        log_warn "Could not download .roo, creating local copy..."
        echo '# KD - AI Skill by KRACKEDDEVS
Read .kracked/prompts/system-prompt.md for full instructions.
Type /KD for command menu.
Status: .kracked/KD_output/status/status.md' > "$dest"
    fi

    deploy_commands "roo" ".roo/commands" "commands"
    log_success "Roo Code setup complete."
}

# ---------------------------------------------------------------------------
# Print Success
# ---------------------------------------------------------------------------
print_success() {
    local project_dir
    project_dir="$(cd "$TARGET_DIR" && pwd)"

    echo ""
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}  KD v${KD_VERSION} installed successfully!${NC}"
    echo -e "${GREEN}  AI Skill by KRACKEDDEVS${NC}"
    echo -e "${GREEN}  ${KD_SITE}${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    if [[ "$LANGUAGE" == "MS" ]]; then
        echo -e "  ${BOLD}Langkah Seterusnya:${NC}"
        echo ""
        echo -e "  1. Baca system prompt:"
        echo -e "     ${CYAN}${project_dir}/${KD_DIR}/prompts/system-prompt.md${NC}"
        echo ""
        echo -e "  2. Mulakan AI tool anda dan taipkan:"
        echo -e "     ${CYAN}/KD${NC}"
        echo ""
        echo -e "  3. Jejak kemajuan anda dalam:"
        echo -e "     ${CYAN}${project_dir}/${KD_DIR}/KD_output/status/status.md${NC}"
    else
        echo -e "  ${BOLD}Next Steps:${NC}"
        echo ""
        echo -e "  1. Read the system prompt:"
        echo -e "     ${CYAN}${project_dir}/${KD_DIR}/prompts/system-prompt.md${NC}"
        echo ""
        echo -e "  2. Open your AI tool and type:"
        echo -e "     ${CYAN}/KD${NC}"
        echo ""
        echo -e "  3. Track your progress in:"
        echo -e "     ${CYAN}${project_dir}/${KD_DIR}/KD_output/status/status.md${NC}"
    fi

    echo ""
    echo -e "  ${BOLD}KD finishes what it starts.${NC}"
    echo ""
}

# ---------------------------------------------------------------------------
# Parse Arguments
# ---------------------------------------------------------------------------
parse_args() {
    local positional_set=false

    for arg in "$@"; do
        case "$arg" in
            --target=*)
                TARGET_TOOLS="${arg#*=}"
                if [[ "$TARGET_TOOLS" == "all" ]]; then
                    TARGET_TOOLS="claude-code,cursor,antigravity,cline,kilocode,roo-code"
                fi
                ;;
            --language=*)
                LANGUAGE=$(echo "${arg#*=}" | tr '[:lower:]' '[:upper:]')
                case "$LANGUAGE" in
                    EN|MS) ;;
                    *) log_error "Invalid language: ${LANGUAGE}. Use: EN, MS"; exit 1 ;;
                esac
                ;;
            --non-interactive)
                NON_INTERACTIVE=true
                ;;
            --force)
                FORCE_INSTALL=true
                ;;
            --verbose)
                VERBOSE=true
                ;;
            --help)
                show_usage
                exit 0
                ;;
            -*)
                log_error "Unknown option: ${arg}"
                show_usage
                exit 1
                ;;
            *)
                if [[ "$positional_set" == false ]]; then
                    TARGET_DIR="$arg"
                    positional_set=true
                fi
                ;;
        esac
    done
}



# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
    parse_args "$@"
    print_banner
    check_dependencies
    detect_platform
    check_existing
    ask_target
    ask_language
    confirm_installation
    
    create_directories
    download_files
    create_config
    init_status

    # Setup adapters (multiple)
    IFS=',' read -ra targets <<< "$TARGET_TOOLS"
    for tool in $(echo "$TARGET_TOOLS" | tr ',' ' '); do
        case "$tool" in
            claude-code) setup_claude_code ;;
            cursor)      setup_cursor ;;
            antigravity) setup_antigravity ;;
            cline)       setup_cline ;;
            kilocode)    setup_kilocode ;;
            roo-code)    setup_roo_code ;;
        esac
    done

    print_success
}

main "$@"