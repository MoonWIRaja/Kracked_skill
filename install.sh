#!/usr/bin/env bash
# ============================================================================
# KRACKED_skill (KD) - Installation Script
# AI Skill by KRACKEDDEVS
# https://krackeddevs.com/
# ============================================================================

set -euo pipefail

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------
readonly KD_VERSION="1.0.0"
readonly KD_REPO="MoonWIRaja/Kracked_skill"
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
TARGET_TOOL=""
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
║   ██╗  ██╗██████╗                                                     ║
║   ██║ ██╔╝██╔══██╗                                                    ║
║   █████╔╝ ██║  ██║    AI Skill by KRACKEDDEVS                         ║
║   ██╔═██╗ ██║  ██║    https://krackeddevs.com/                        ║
║   ██║  ██╗██████╔╝                                                    ║
║   ╚═╝  ╚═╝╚═════╝                                                     ║
║                                                                       ║
╚═══════════════════════════════════════════════════════════════════════╝
BANNER
    echo -e "${NC}"
    echo -e "${BOLD}  KRACKED_skill v${KD_VERSION}${NC}"
    echo -e "  Structured Multi-Role AI Product Execution System"
    echo ""
}

# ---------------------------------------------------------------------------
# Logging Helpers
# ---------------------------------------------------------------------------
log_info()    { echo -e "  ${BLUE}[INFO]${NC}    $1"; }
log_success() { echo -e "  ${GREEN}[SUCCESS]${NC} $1"; }
log_warn()    { echo -e "  ${YELLOW}[WARN]${NC}    $1"; }
log_error()   { echo -e "  ${RED}[ERROR]${NC}   $1"; }
log_verbose() { [[ "$VERBOSE" == true ]] && echo -e "  ${MAGENTA}[DEBUG]${NC}   $1"; }

# ---------------------------------------------------------------------------
# Usage
# ---------------------------------------------------------------------------
show_usage() {
    cat << 'USAGE'
Usage: install.sh [TARGET_DIR] [OPTIONS]

Arguments:
  TARGET_DIR                  Target project directory (default: current directory)

Options:
  --target=<tool>             AI tool target: claude-code, cursor, antigravity
  --language=<lang>           Language preference: EN, MS
  --non-interactive           Skip interactive prompts, use defaults
  --force                     Overwrite existing installation
  --verbose                   Show detailed output
  --help                      Show this help message

Examples:
  curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_skill/main/install.sh | bash
  bash install.sh /path/to/project --target=claude-code --language=MS
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

    # Check for download tool
    local has_curl=false
    local has_wget=false

    if command -v curl &>/dev/null; then
        has_curl=true
        log_verbose "curl found: $(command -v curl)"
    fi

    if command -v wget &>/dev/null; then
        has_wget=true
        log_verbose "wget found: $(command -v wget)"
    fi

    if [[ "$has_curl" == false && "$has_wget" == false ]]; then
        log_error "Neither curl nor wget found. Please install one of them."
        log_error "  Ubuntu/Debian: sudo apt install curl"
        log_error "  macOS: brew install curl"
        log_error "  CentOS/RHEL: sudo yum install curl"
        exit 1
    fi

    # Check for git (optional)
    if command -v git &>/dev/null; then
        log_verbose "git found: $(command -v git)"
    else
        log_verbose "git not found (optional)"
    fi

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
    if [[ -n "$TARGET_TOOL" ]]; then
        return
    fi

    if [[ "$NON_INTERACTIVE" == true ]]; then
        TARGET_TOOL="claude-code"
        return
    fi

    echo ""
    echo -e "  ${BOLD}Select target AI tool:${NC}"
    echo -e "    ${CYAN}[1]${NC} Claude Code"
    echo -e "    ${CYAN}[2]${NC} Cursor"
    echo -e "    ${CYAN}[3]${NC} Antigravity"
    echo ""

    while true; do
        read -rp "  Enter choice [1-3]: " choice
        case "$choice" in
            1) TARGET_TOOL="claude-code"; break ;;
            2) TARGET_TOOL="cursor"; break ;;
            3) TARGET_TOOL="antigravity"; break ;;
            *) echo -e "  ${RED}Invalid choice. Please enter 1, 2, or 3.${NC}" ;;
        esac
    done
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
    echo -e "    ${CYAN}[EN]${NC} English"
    echo -e "    ${CYAN}[MS]${NC} Bahasa Melayu"
    echo ""

    while true; do
        read -rp "  Enter choice [EN/MS]: " choice
        choice=$(echo "$choice" | tr '[:lower:]' '[:upper:]')
        case "$choice" in
            EN) LANGUAGE="EN"; break ;;
            MS) LANGUAGE="MS"; break ;;
            *) echo -e "  ${RED}Invalid choice. Please enter EN or MS.${NC}" ;;
        esac
    done
}

confirm_installation() {
    if [[ "$NON_INTERACTIVE" == true ]]; then
        return
    fi

    echo ""
    echo -e "  ${BOLD}Installation Summary:${NC}"
    echo -e "    Target:    ${CYAN}${TARGET_TOOL}${NC}"
    echo -e "    Language:  ${CYAN}${LANGUAGE}${NC}"
    echo -e "    Directory: ${CYAN}$(cd "$TARGET_DIR" && pwd)${NC}"
    echo ""

    read -rp "  Proceed with installation? [Y/n]: " confirm
    confirm="${confirm:-Y}"

    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        log_info "Installation cancelled."
        exit 0
    fi
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

    local dirs=(
        "${KD_DIR}"
        "${KD_DIR}/prompts"
        "${KD_DIR}/prompts/roles"
        "${KD_DIR}/prompts/stages"
        "${KD_DIR}/prompts/multi-agent"
        "${KD_DIR}/templates"
        "${KD_DIR}/checklists"
        "${KD_DIR}/workflows"
        "${KD_DIR}/config"
        "${KD_DIR}/config/language"
    )

    for dir in "${dirs[@]}"; do
        mkdir -p "${TARGET_DIR}/${dir}"
        log_verbose "Created: ${dir}/"
    done

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

    # ---- Roles ----
    local roles=("_role-template" "analyst" "product-manager" "architect" "tech-lead" "engineer" "qa" "security" "devops" "release-manager")
    for role in "${roles[@]}"; do
        download_and_track "${base}/prompts/roles/${role}.md" \
            "${KD_DIR}/prompts/roles/${role}.md" "Role: ${role}"
    done

    # ---- Stages ----
    local stages=("_stage-template" "discovery" "requirements" "architecture" "implementation" "quality" "deployment" "release")
    for stage in "${stages[@]}"; do
        download_and_track "${base}/prompts/stages/${stage}.md" \
            "${KD_DIR}/prompts/stages/${stage}.md" "Stage: ${stage}"
    done

    # ---- Multi-Agent ----
    local multi=("party-mode" "agent-swarm" "confidence-scoring" "conflict-resolution" "aggregation")
    for m in "${multi[@]}"; do
        download_and_track "${base}/prompts/multi-agent/${m}.md" \
            "${KD_DIR}/prompts/multi-agent/${m}.md" "Multi-Agent: ${m}"
    done

    # ---- Templates ----
    local templates=("status" "product-brief" "prd" "architecture" "story-card" "deployment-plan" "release-notes" "decision-log" "risk-register")
    for tmpl in "${templates[@]}"; do
        download_and_track "${base}/templates/${tmpl}.md" \
            "${KD_DIR}/templates/${tmpl}.md" "Template: ${tmpl}"
    done

    # ---- Checklists ----
    local checklists=("stage-completion" "decision-validation" "checkpoint-approval" "security-audit" "error-recovery" "pre-deployment")
    for cl in "${checklists[@]}"; do
        download_and_track "${base}/checklists/${cl}.md" \
            "${KD_DIR}/checklists/${cl}.md" "Checklist: ${cl}"
    done

    # ---- Workflows ----
    local workflows=("main.flow" "quick-start.flow" "full-product.flow" "maintenance.flow")
    for wf in "${workflows[@]}"; do
        download_and_track "${base}/workflows/${wf}.md" \
            "${KD_DIR}/workflows/${wf}.md" "Workflow: ${wf}"
    done

    # ---- Config ----
    download_and_track "${base}/config/settings.schema.json" \
        "${KD_DIR}/config/settings.schema.json" "Config: schema"
    download_and_track "${base}/config/default-settings.json" \
        "${KD_DIR}/config/default-settings.json" "Config: defaults"
    download_and_track "${base}/config/language/en.json" \
        "${KD_DIR}/config/language/en.json" "Language: EN"
    download_and_track "${base}/config/language/ms.json" \
        "${KD_DIR}/config/language/ms.json" "Language: MS"

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
    "target_tool": "${TARGET_TOOL}",
    "scale": "auto",
    "installed_date": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
    "site": "${KD_SITE}",
    "branding": "KRACKEDDEVS",
    "features": {
        "multi_agent": true,
        "status_tracking": true,
        "decision_validation": true,
        "checkpoints": true
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

    cat > "${TARGET_DIR}/status.md" << STATUS
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

    cat > "${TARGET_DIR}/CLAUDE.md" << 'CLAUDE_ADAPTER'
# KD - AI Skill by KRACKEDDEVS

Official Site: https://krackeddevs.com/

## Activation

KD is active in this project. Read the system prompt:

```
Read the file at .kracked/prompts/system-prompt.md
```

## Quick Start Commands

| Command                    | Description                    |
|---------------------------|--------------------------------|
| /KD-analyze               | Start discovery phase          |
| /KD-product-brief         | Create product brief           |
| /KD-prd                   | Product requirements document  |
| /KD-architecture          | System architecture design     |
| /KD-epics-and-stories     | Create backlog                 |
| /KD-dev-story [id]        | Implement a story              |
| /KD-code-review           | Quality and security review    |
| /KD-deployment-plan       | Deployment strategy            |
| /KD-status                | Show current project state     |
| /KD-help                  | Display command reference      |

## Multi-Agent Commands

| Command                                         | Description              |
|------------------------------------------------|--------------------------|
| /KD-party-mode --agents=N --topic="topic"      | Parallel brainstorming   |
| /KD-swarm --agents=N --tasks="task1,task2"     | Parallel execution       |

## Workflow

1. Read `.kracked/prompts/system-prompt.md` for full instructions
2. Read `status.md` for current project state
3. Execute commands following workflow stages
4. Update `status.md` after each major action

## Files Reference

- System Prompt: `.kracked/prompts/system-prompt.md`
- Status: `status.md`
- Templates: `.kracked/templates/`
- Checklists: `.kracked/checklists/`

## Official Site

https://krackeddevs.com/
CLAUDE_ADAPTER

    log_success "Claude Code setup complete."
}

setup_cursor() {
    log_info "Setting up for Cursor..."

    cat > "${TARGET_DIR}/.cursorrules" << 'CURSOR_ADAPTER'
# KD - AI Skill by KRACKEDDEVS
# Official Site: https://krackeddevs.com/

You are operating with KD - Structured Multi-Role AI Product Execution System.

## Initialization

Before starting any work:
1. Read `.kracked/prompts/system-prompt.md` for full system instructions
2. Read `status.md` for current project state
3. Follow the workflow stage indicated in status.md

## Core Rules

1. SINGLE ROLE ACTIVATION
   Only one role active at a time.
   Always state: [ACTIVE ROLE: <Role Name>]

2. LANGUAGE CONSISTENCY
   Follow language preference in `.kracked/config/settings.json`
   - EN: English for all interactions
   - MS: Bahasa Melayu for all interactions
   - Code always in English

3. STATUS TRACKING
   Update `status.md` after every major decision or action.

4. DECISION VALIDATION
   For architecture, schema, deployment decisions:
   Run the decision validation block (see system-prompt.md)

5. CHECKPOINTS
   Stages require human approval:
   - /KD-product-brief
   - /KD-prd
   - /KD-architecture
   - /KD-deployment-plan (production)

## Commands

All commands start with /KD prefix:
- /KD-analyze - Discovery phase
- /KD-product-brief - Product brief
- /KD-prd - Requirements
- /KD-architecture - System design
- /KD-epics-and-stories - Create backlog
- /KD-dev-story [id] - Implementation
- /KD-code-review - Quality check
- /KD-deployment-plan - Deploy strategy
- /KD-status - Current state
- /KD-help - Command reference

## Multi-Agent

- /KD-party-mode --agents=N --topic="topic"
- /KD-swarm --agents=N --tasks="tasks"

## File Structure

Reference these files:
- System prompt: `.kracked/prompts/system-prompt.md`
- Templates: `.kracked/templates/`
- Checklists: `.kracked/checklists/`
- Status: `status.md`

## Error Handling

On errors, follow error recovery protocol in system-prompt.md.
Always document in status.md under Blockers section.
CURSOR_ADAPTER

    log_success "Cursor setup complete."
}

setup_antigravity() {
    log_info "Setting up for Antigravity..."

    mkdir -p "${TARGET_DIR}/.antigravity"

    cat > "${TARGET_DIR}/.antigravity/SKILL.md" << 'AG_SKILL'
---
name: KD
description: Structured Multi-Role AI Product Execution System by KRACKEDDEVS
---

# KD Skill

## Metadata
- Name: KD
- Version: 1.0.0
- Author: KRACKEDDEVS
- Site: https://krackeddevs.com/
- Description: Structured Multi-Role AI Product Execution System

## Activation

Read `.kracked/prompts/system-prompt.md` to activate KD.

## Commands

All commands use /KD prefix:

| Command                    | Description                    |
|---------------------------|--------------------------------|
| /KD-analyze               | Start discovery phase          |
| /KD-product-brief         | Create product brief           |
| /KD-prd                   | Product requirements document  |
| /KD-architecture          | System architecture design     |
| /KD-epics-and-stories     | Create backlog                 |
| /KD-dev-story [id]        | Implement a story              |
| /KD-code-review           | Quality and security review    |
| /KD-deployment-plan       | Deployment strategy            |
| /KD-status                | Show current project state     |
| /KD-help                  | Display command reference      |

## Multi-Agent Commands

| Command                                         | Description              |
|------------------------------------------------|--------------------------|
| /KD-party-mode --agents=N --topic="topic"      | Parallel brainstorming   |
| /KD-swarm --agents=N --tasks="task1,task2"     | Parallel execution       |

## Configuration

- Language: Set in `.kracked/config/settings.json`
- Status: `status.md`

## Workflow

1. Read `.kracked/prompts/system-prompt.md` for full instructions
2. Read `status.md` for current project state
3. Execute commands following workflow stages
4. Update `status.md` after each major action
AG_SKILL

    log_success "Antigravity setup complete."
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
        echo -e "    1. Baca system prompt:"
        echo -e "       ${CYAN}${project_dir}/${KD_DIR}/prompts/system-prompt.md${NC}"
        echo ""
        echo -e "    2. Mulakan AI tool anda dan mulakan dengan:"
        echo -e "       ${CYAN}/KD-analyze${NC}"
        echo ""
        echo -e "    3. Jejak kemajuan anda dalam:"
        echo -e "       ${CYAN}${project_dir}/status.md${NC}"
    else
        echo -e "  ${BOLD}Next Steps:${NC}"
        echo ""
        echo -e "    1. Read the system prompt:"
        echo -e "       ${CYAN}${project_dir}/${KD_DIR}/prompts/system-prompt.md${NC}"
        echo ""
        echo -e "    2. Open your AI tool and start with:"
        echo -e "       ${CYAN}/KD-analyze${NC}"
        echo ""
        echo -e "    3. Track your progress in:"
        echo -e "       ${CYAN}${project_dir}/status.md${NC}"
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
                TARGET_TOOL="${arg#*=}"
                case "$TARGET_TOOL" in
                    claude-code|cursor|antigravity) ;;
                    *) log_error "Invalid target: ${TARGET_TOOL}. Use: claude-code, cursor, antigravity"; exit 1 ;;
                esac
                ;;
            --language=*)
                LANGUAGE=$(echo "${arg#*=}" | tr '[:lower:]' '[:upper:]')
                case "$LANGUAGE" in
                    EN|MS) ;;
                    *) log_error "Invalid language: ${LANGUAGE}. Use: EN, MS"; exit 1 ;;
                esac
                ;;
            --non-interactive) NON_INTERACTIVE=true ;;
            --force) FORCE_INSTALL=true ;;
            --verbose) VERBOSE=true ;;
            --help) show_usage; exit 0 ;;
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

    # Setup adapter
    case "$TARGET_TOOL" in
        claude-code)  setup_claude_code ;;
        cursor)       setup_cursor ;;
        antigravity)  setup_antigravity ;;
    esac

    print_success
}

main "$@"
