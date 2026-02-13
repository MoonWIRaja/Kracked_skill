#!/usr/bin/env bash
# ============================================================================
# KRACKED_skill (KD) - Uninstallation Script
# AI Skill by KRACKEDDEVS | https://krackeddevs.com/
# ============================================================================

set -euo pipefail

readonly KD_DIR=".kracked"
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
# Check KD Exists
# ---------------------------------------------------------------------------
check_kracked_exists() {
    if [[ ! -d "${TARGET_DIR}/${KD_DIR}" ]]; then
        log_error "KD is not installed in ${TARGET_DIR}"
        log_error "No ${KD_DIR}/ directory found."
        exit 1
    fi
}

# ---------------------------------------------------------------------------
# Backup status.md
# ---------------------------------------------------------------------------
backup_status() {
    local status_file="${TARGET_DIR}/${KD_DIR}/KD_output/status/status.md"
    if [[ -f "$status_file" ]]; then
        local backup_name="status.md.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$status_file" "${TARGET_DIR}/${backup_name}"
        log_info "status.md backed up as ${backup_name}"
    fi
}

# ---------------------------------------------------------------------------
# Remove Files
# ---------------------------------------------------------------------------
remove_files() {
    # Remove .kracked directory
    rm -rf "${TARGET_DIR}/${KD_DIR}"
    log_success "Removed ${KD_DIR}/ directory"

    # Remove adapter files
    if [[ -f "${TARGET_DIR}/CLAUDE.md" ]]; then
        rm -f "${TARGET_DIR}/CLAUDE.md"
        log_info "Removed CLAUDE.md"
    fi

    if [[ -f "${TARGET_DIR}/.cursorrules" ]]; then
        rm -f "${TARGET_DIR}/.cursorrules"
        log_info "Removed .cursorrules"
    fi

    if [[ -d "${TARGET_DIR}/.antigravity" ]]; then
        rm -rf "${TARGET_DIR}/.antigravity"
        log_info "Removed .antigravity/"
    fi

    # Note: status.md is inside .kracked/KD_output/status/ and already removed with KD_DIR
}

# ---------------------------------------------------------------------------
# Confirm
# ---------------------------------------------------------------------------
confirm_uninstall() {
    echo ""
    echo -e "  ${BOLD}KD Uninstallation${NC}"
    echo -e "  Directory: ${CYAN}$(cd "$TARGET_DIR" && pwd)${NC}"
    echo ""
    echo -e "  ${YELLOW}This will remove:${NC}"
    echo -e "    - ${KD_DIR}/ directory (all KD files)"
    echo -e "    - Adapter files (CLAUDE.md, .cursorrules, .antigravity/)"
    echo -e "    - status.md (backup will be created)"
    echo ""
    echo -e "  ${GREEN}This will NOT remove:${NC}"
    echo -e "    - Your project source files"
    echo -e "    - The status.md backup"
    echo ""

    read -rp "  Proceed with uninstallation? [y/N]: " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        log_info "Uninstallation cancelled."
        exit 0
    fi
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
    check_kracked_exists
    confirm_uninstall
    backup_status
    remove_files

    echo ""
    echo -e "${GREEN}  KD has been uninstalled successfully.${NC}"
    echo -e "  Your status.md backup has been preserved."
    echo ""
}

main "$@"
