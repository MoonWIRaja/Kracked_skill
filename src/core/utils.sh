#!/usr/bin/env bash
# ============================================================================
# KRACKED_skill (KD) - Utility Functions
# AI Skill by KRACKEDDEVS | https://krackeddevs.com/
# ============================================================================

# Colors
readonly KD_RED='\033[0;31m'
readonly KD_GREEN='\033[0;32m'
readonly KD_YELLOW='\033[1;33m'
readonly KD_BLUE='\033[0;34m'
readonly KD_CYAN='\033[0;36m'
readonly KD_MAGENTA='\033[0;35m'
readonly KD_BOLD='\033[1m'
readonly KD_NC='\033[0m'

# ---------------------------------------------------------------------------
# Logging
# ---------------------------------------------------------------------------
kd_log_info()    { echo -e "  ${KD_BLUE}[INFO]${KD_NC}    $1"; }
kd_log_success() { echo -e "  ${KD_GREEN}[SUCCESS]${KD_NC} $1"; }
kd_log_warn()    { echo -e "  ${KD_YELLOW}[WARN]${KD_NC}    $1"; }
kd_log_error()   { echo -e "  ${KD_RED}[ERROR]${KD_NC}   $1"; }
kd_log_debug()   { [[ "${KD_DEBUG:-false}" == true ]] && echo -e "  ${KD_MAGENTA}[DEBUG]${KD_NC}   $1"; }

# ---------------------------------------------------------------------------
# String Utilities
# ---------------------------------------------------------------------------
kd_trim() {
    local var="$*"
    var="${var#"${var%%[![:space:]]*}"}"
    var="${var%"${var##*[![:space:]]}"}"
    echo -n "$var"
}

kd_to_upper() {
    echo "$1" | tr '[:lower:]' '[:upper:]'
}

kd_to_lower() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

# ---------------------------------------------------------------------------
# Date Utilities
# ---------------------------------------------------------------------------
kd_date_iso() {
    date -u +"%Y-%m-%dT%H:%M:%SZ"
}

kd_date_short() {
    date +"%Y-%m-%d"
}

kd_timestamp() {
    date +"%Y%m%d_%H%M%S"
}

# ---------------------------------------------------------------------------
# File Utilities
# ---------------------------------------------------------------------------
kd_file_exists() {
    [[ -f "$1" ]]
}

kd_dir_exists() {
    [[ -d "$1" ]]
}

kd_ensure_dir() {
    mkdir -p "$1"
}

kd_backup_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        cp "$file" "${file}.backup.$(kd_timestamp)"
    fi
}

# ---------------------------------------------------------------------------
# Prompt Utilities
# ---------------------------------------------------------------------------
kd_confirm() {
    local prompt="${1:-Continue?}"
    local default="${2:-Y}"

    if [[ "$default" == "Y" ]]; then
        read -rp "  ${prompt} [Y/n]: " answer
        answer="${answer:-Y}"
    else
        read -rp "  ${prompt} [y/N]: " answer
        answer="${answer:-N}"
    fi

    [[ "$answer" =~ ^[Yy]$ ]]
}

kd_select_option() {
    local prompt="$1"
    shift
    local options=("$@")

    echo ""
    echo -e "  ${KD_BOLD}${prompt}${KD_NC}"
    for i in "${!options[@]}"; do
        echo -e "    ${KD_CYAN}[$((i+1))]${KD_NC} ${options[$i]}"
    done
    echo ""

    while true; do
        read -rp "  Enter choice [1-${#options[@]}]: " choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#options[@]} )); then
            echo "${options[$((choice-1))]}"
            return
        fi
        echo -e "  ${KD_RED}Invalid choice.${KD_NC}"
    done
}

# ---------------------------------------------------------------------------
# Version Utilities
# ---------------------------------------------------------------------------
kd_version_compare() {
    # Returns: 0 if equal, 1 if $1 > $2, 2 if $1 < $2
    if [[ "$1" == "$2" ]]; then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++)); do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++)); do
        if [[ -z "${ver2[i]:-}" ]]; then
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]})); then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]})); then
            return 2
        fi
    done
    return 0
}
