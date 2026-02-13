#!/usr/bin/env bash
# ============================================================================
# KRACKED_skill (KD) - Update Script
# AI Skill by KRACKEDDEVS | https://krackeddevs.com/
# ============================================================================

set -euo pipefail

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
    if command -v curl &>/dev/null; then
        curl -fsSL "$url" -o "$dest" 2>/dev/null
    elif command -v wget &>/dev/null; then
        wget -qO "$dest" "$url" 2>/dev/null
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
        cat "$tmp_version"
        rm -f "$tmp_version"
    else
        rm -f "$tmp_version"
        echo "unknown"
    fi
}

version_gt() {
    # Returns 0 if $1 > $2
    [ "$(printf '%s\n' "$1" "$2" | sort -V | head -n1)" != "$1" ]
}

# ---------------------------------------------------------------------------
# Backup Config
# ---------------------------------------------------------------------------
backup_config() {
    local backup_dir="${TARGET_DIR}/${KD_DIR}/.backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"

    # Backup user config
    if [[ -f "${TARGET_DIR}/${KD_DIR}/config/settings.json" ]]; then
        cp "${TARGET_DIR}/${KD_DIR}/config/settings.json" "$backup_dir/"
    fi

    # Backup status.md
    if [[ -f "${TARGET_DIR}/status.md" ]]; then
        cp "${TARGET_DIR}/status.md" "$backup_dir/"
    fi

    echo "$backup_dir"
}

# ---------------------------------------------------------------------------
# Restore Config
# ---------------------------------------------------------------------------
restore_config() {
    local backup_dir="$1"

    if [[ -f "${backup_dir}/settings.json" ]]; then
        cp "${backup_dir}/settings.json" "${TARGET_DIR}/${KD_DIR}/config/settings.json"
        log_info "Settings restored."
    fi

    if [[ -f "${backup_dir}/status.md" ]]; then
        cp "${backup_dir}/status.md" "${TARGET_DIR}/status.md"
        log_info "status.md restored."
    fi
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
    echo ""
    echo -e "  ${BOLD}KD Update${NC}"
    echo -e "  AI Skill by KRACKEDDEVS | https://krackeddevs.com/"
    echo ""

    # Check if KD is installed
    if [[ ! -d "${TARGET_DIR}/${KD_DIR}" ]]; then
        log_error "KD is not installed in ${TARGET_DIR}"
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
    log_info "Backing up configuration..."
    local backup_dir
    backup_dir=$(backup_config)
    log_success "Backup created at ${backup_dir}"

    # Download and run installer
    log_info "Downloading update..."
    local install_script
    install_script=$(mktemp)

    if download_file "${KD_RAW_URL}/install.sh" "$install_script"; then
        # Get current settings
        local target_tool
        target_tool=$(grep -o '"target_tool"[[:space:]]*:[[:space:]]*"[^"]*"' \
            "${TARGET_DIR}/${KD_DIR}/config/settings.json" | \
            grep -o '"[^"]*"$' | tr -d '"' || echo "claude-code")

        local language
        language=$(grep -o '"language"[[:space:]]*:[[:space:]]*"[^"]*"' \
            "${TARGET_DIR}/${KD_DIR}/config/settings.json" | \
            grep -o '"[^"]*"$' | tr -d '"' || echo "EN")

        # Run installer with force
        bash "$install_script" "$TARGET_DIR" \
            --target="$target_tool" \
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

    # Restore user config
    restore_config "$backup_dir"

    log_success "KD updated to v${latest_version}!"
}

main "$@"
