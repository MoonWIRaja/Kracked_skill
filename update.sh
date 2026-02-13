#!/usr/bin/env bash
# ============================================================================
# KRACKED_skill (KD) v2.0.0-beta — Update Script
# AI Skill by KRACKEDDEVS | https://krackeddevs.com/
# Works on: macOS, Linux, Git Bash (Windows), WSL
# ============================================================================

set -euo pipefail

readonly KD_VERSION="2.0.0-beta"
readonly KD_DIR=".kracked"
readonly KD_REPO="MoonWIRaja/Kracked_skill"
readonly KD_RAW_URL="https://raw.githubusercontent.com/${KD_REPO}/main"

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly NC='\033[0m'

log_info()    { echo -e "  ${CYAN}[INFO]${NC}    $1"; }
log_success() { echo -e "  ${GREEN}[SUCCESS]${NC} $1"; }
log_warn()    { echo -e "  ${YELLOW}[WARN]${NC}    $1"; }
log_error()   { echo -e "  ${RED}[ERROR]${NC}   $1"; }

TARGET_DIR="${1:-.}"

# ---------------------------------------------------------------------------
# Download Helper
# ---------------------------------------------------------------------------
download_file() {
    local url="$1"
    local dest="$2"

    mkdir -p "$(dirname "$dest")"

    if command -v curl &>/dev/null; then
        curl -fsSL "$url" -o "$dest" 2>/dev/null
    elif command -v wget &>/dev/null; then
        wget -qO "$dest" "$url" 2>/dev/null
    else
        log_error "Neither curl nor wget found."
        return 1
    fi
}

# ---------------------------------------------------------------------------
# Version Comparison
# ---------------------------------------------------------------------------
check_current_version() {
    if [[ -f "${TARGET_DIR}/${KD_DIR}/config/settings.json" ]]; then
        grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' \
            "${TARGET_DIR}/${KD_DIR}/config/settings.json" | \
            grep -o '"[^"]*"$' | tr -d '"'
    else
        echo "0.0.0"
    fi
}

fetch_latest_version() {
    local tmp_version
    tmp_version=$(mktemp)

    if download_file "${KD_RAW_URL}/VERSION" "$tmp_version"; then
        tr -d '[:space:]' < "$tmp_version"
        rm -f "$tmp_version"
    else
        rm -f "$tmp_version"
        echo "unknown"
    fi
}

version_gt() {
    [ "$(printf '%s\n' "$1" "$2" | sort -V | head -n1)" != "$1" ]
}

# ---------------------------------------------------------------------------
# Backup Config + Status
# ---------------------------------------------------------------------------
backup_config() {
    local backup_dir="${TARGET_DIR}/${KD_DIR}/.backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"

    # Backup user config
    if [[ -f "${TARGET_DIR}/${KD_DIR}/config/settings.json" ]]; then
        cp "${TARGET_DIR}/${KD_DIR}/config/settings.json" "$backup_dir/"
    fi

    # Backup status.md (new path)
    if [[ -f "${TARGET_DIR}/${KD_DIR}/KD_output/status/status.md" ]]; then
        cp "${TARGET_DIR}/${KD_DIR}/KD_output/status/status.md" "$backup_dir/"
    fi

    # Backup all KD_output content
    if [[ -d "${TARGET_DIR}/${KD_DIR}/KD_output" ]]; then
        cp -r "${TARGET_DIR}/${KD_DIR}/KD_output" "$backup_dir/KD_output_backup"
    fi

    echo "$backup_dir"
}

# ---------------------------------------------------------------------------
# Restore Config + Status
# ---------------------------------------------------------------------------
restore_config() {
    local backup_dir="$1"

    if [[ -f "${backup_dir}/settings.json" ]]; then
        cp "${backup_dir}/settings.json" "${TARGET_DIR}/${KD_DIR}/config/settings.json"
        log_info "Settings restored."
    fi

    if [[ -f "${backup_dir}/status.md" ]]; then
        cp "${backup_dir}/status.md" "${TARGET_DIR}/${KD_DIR}/KD_output/status/status.md"
        log_info "status.md restored."
    fi

    # Restore all KD_output content (epics, stories, etc.)
    if [[ -d "${backup_dir}/KD_output_backup" ]]; then
        for category in "${backup_dir}/KD_output_backup"/*/; do
            local category_name
            category_name=$(basename "$category")
            if [[ "$category_name" != "status" ]]; then
                if [[ -d "$category" ]]; then
                    cp -r "$category" "${TARGET_DIR}/${KD_DIR}/KD_output/${category_name}"
                fi
            fi
        done
        log_info "KD_output content restored."
    fi
}

# ---------------------------------------------------------------------------
# Read current target tools from settings
# ---------------------------------------------------------------------------
get_current_targets() {
    if [[ -f "${TARGET_DIR}/${KD_DIR}/config/settings.json" ]]; then
        # Try multi-target format first
        local targets
        targets=$(grep -o '"target_tools"[[:space:]]*:[[:space:]]*\[[^]]*\]' \
            "${TARGET_DIR}/${KD_DIR}/config/settings.json" 2>/dev/null | \
            grep -o '"[a-z-]*"' | tr -d '"' | paste -sd',' - 2>/dev/null || true)

        if [[ -n "$targets" ]]; then
            echo "$targets"
            return
        fi

        # Fallback: single target format
        targets=$(grep -o '"target_tool"[[:space:]]*:[[:space:]]*"[^"]*"' \
            "${TARGET_DIR}/${KD_DIR}/config/settings.json" | \
            grep -o '"[^"]*"$' | tr -d '"' || echo "claude-code")
        echo "$targets"
    else
        echo "claude-code"
    fi
}

get_current_language() {
    if [[ -f "${TARGET_DIR}/${KD_DIR}/config/settings.json" ]]; then
        grep -o '"language"[[:space:]]*:[[:space:]]*"[^"]*"' \
            "${TARGET_DIR}/${KD_DIR}/config/settings.json" | \
            grep -o '"[^"]*"$' | tr -d '"' || echo "EN"
    else
        echo "EN"
    fi
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
    echo ""
    echo -e "  ${BOLD}========================================${NC}"
    echo -e "  ${BOLD}  KD Update — KRACKED_skill${NC}"
    echo -e "  ${BOLD}  AI Skill by KRACKEDDEVS${NC}"
    echo -e "  ${BOLD}========================================${NC}"
    echo ""

    # Check if KD is installed
    if [[ ! -d "${TARGET_DIR}/${KD_DIR}" ]]; then
        log_error "KD is not installed in ${TARGET_DIR}"
        log_error "Run install.sh first to install KD."
        exit 1
    fi

    local current_version
    current_version=$(check_current_version)
    log_info "Current version: ${current_version}"

    local latest_version
    latest_version=$(fetch_latest_version)

    if [[ "$latest_version" == "unknown" ]]; then
        log_error "Could not fetch latest version. Check your internet connection."
        exit 1
    fi

    log_info "Latest version:  ${latest_version}"

    if ! version_gt "$latest_version" "$current_version"; then
        log_success "You are already on the latest version (${current_version})."
        exit 0
    fi

    echo ""
    echo -e "  Update available: ${YELLOW}${current_version}${NC} → ${GREEN}${latest_version}${NC}"
    read -rp "  Proceed with update? [Y/n]: " confirm
    confirm="${confirm:-Y}"

    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        log_info "Update cancelled."
        exit 0
    fi

    # Backup
    log_info "Backing up configuration and output files..."
    local backup_dir
    backup_dir=$(backup_config)
    log_success "Backup created at ${backup_dir}"

    # Get current settings
    local target_tools
    target_tools=$(get_current_targets)
    local language
    language=$(get_current_language)

    log_info "Restoring with: target=${target_tools}, language=${language}"

    # Download and run installer
    log_info "Downloading update..."
    local install_script
    install_script=$(mktemp)

    if download_file "${KD_RAW_URL}/install.sh" "$install_script"; then
        bash "$install_script" "$TARGET_DIR" \
            --target="$target_tools" \
            --language="$language" \
            --force \
            --non-interactive

        rm -f "$install_script"
    else
        rm -f "$install_script"
        log_error "Failed to download update."
        log_info "Restoring backup..."
        restore_config "$backup_dir"
        exit 1
    fi

    # Restore user config and output
    restore_config "$backup_dir"

    echo ""
    log_success "KD updated to v${latest_version}!"
    echo ""
    echo -e "  ${BOLD}What's new:${NC}"
    echo -e "    • Type ${CYAN}/KD${NC} for the interactive command menu"
    echo -e "    • New ${CYAN}/KD-brainstorm${NC} stage for ideation"
    echo -e "    • Named agent personalities in multi-agent modes"
    echo -e "    • Auto-debug before status updates"
    echo -e "    • Organized epics-and-stories directory"
    echo ""
}

main "$@"
