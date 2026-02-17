#!/usr/bin/env bash
# ============================================================================
# Kracked_Skills (KD) - Uninstallation Script
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

log_info() { echo -e " ${CYAN}[INFO]${NC} $1"; }
log_success() { echo -e " ${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e " ${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e " ${RED}[ERROR]${NC} $1"; }

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

    # Remove adapter folders
    local folders=".antigravity .agent .claude .cursor .cline .clinerules .kilocode .kilo .roo .roo-code"
    for f in $folders; do
        if [[ -d "${TARGET_DIR}/$f" ]]; then
            rm -rf "${TARGET_DIR}/$f"
            log_info "Removed $f/ directory"
        fi
    done

    # Remove root configuration files
    local files="CLAUDE.md .cursorrules .clinerules .kilocode .kilocodemodes .roo"
    for f in $files; do
        if [[ -f "${TARGET_DIR}/$f" ]]; then
            rm -f "${TARGET_DIR}/$f"
            log_info "Removed configuration file: $f"
        fi
    done
}

# ---------------------------------------------------------------------------
# Confirm
# ---------------------------------------------------------------------------
confirm_uninstall() {
    echo ""
    echo -e " ${BOLD}Kracked_Skills Uninstallation${NC}"
    echo -e " Directory: ${CYAN}$(cd "$TARGET_DIR" && pwd)${NC}"
    echo ""
    echo -e " ${YELLOW}This will remove:${NC}"
    echo -e " - ${KD_DIR}/ directory (all KD files)"
    echo -e " - Adapter files (CLAUDE.md, .cursorrules, .clinerules, .kilocode, .roo)"
    echo -e " - Adapter directories (.claude/, .cursor/, .antigravity/, .agent/, .cline/, .kilocode/, .roo/)"
    echo -e " - status.md (backup will be created)"
    echo ""
    echo -e " ${GREEN}This will NOT remove:${NC}"
    echo -e " - Your project source files"
    echo -e " - The status.md backup"
    echo ""

    # Explicitly print prompt to TTY to ensure visibility in pipes
    if [ -c /dev/tty ]; then
        printf " Proceed with uninstallation? [y/N]: " > /dev/tty
    else
        printf " Proceed with uninstallation? [y/N]: "
    fi

    # Disable exit-on-error for read
    set +e
    local confirm=""
    if [ -c /dev/tty ]; then
        read confirm < /dev/tty
    else
        read confirm
    fi
    set -e

    # Default to No
    confirm="${confirm:-N}"

    # Use Case instead of Regex for maximum compatibility
    case "$confirm" in
        [yY][eE][sS]|[yY])
            ;;
        *)
            log_info "Uninstallation cancelled."; exit 0
            ;;
    esac
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
    echo -e "${GREEN} Kracked_Skills has been uninstalled successfully.${NC}"
    echo -e " Your status.md backup has been preserved."
    echo ""
}

main "$@"
