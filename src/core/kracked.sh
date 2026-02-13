#!/usr/bin/env bash
# ============================================================================
# KRACKED_skill (KD) - Core Initialization
# AI Skill by KRACKEDDEVS | https://krackeddevs.com/
# ============================================================================

# Source utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/utils.sh"

# ---------------------------------------------------------------------------
# Core Constants
# ---------------------------------------------------------------------------
readonly KD_CORE_VERSION="1.0.0"
readonly KD_SYSTEM_PROMPT_PATH="prompts/system-prompt.md"
readonly KD_STATUS_FILE="status.md"
readonly KD_CONFIG_FILE="config/settings.json"

# ---------------------------------------------------------------------------
# Initialization
# ---------------------------------------------------------------------------
kd_init() {
    local project_root="$1"
    local kd_dir="${project_root}/.kracked"

    if [[ ! -d "$kd_dir" ]]; then
        kd_log_error "KD not installed. Run install.sh first."
        return 1
    fi

    # Load config
    if [[ -f "${kd_dir}/${KD_CONFIG_FILE}" ]]; then
        KD_LANGUAGE=$(kd_get_config_value "${kd_dir}/${KD_CONFIG_FILE}" "language")
        KD_TARGET=$(kd_get_config_value "${kd_dir}/${KD_CONFIG_FILE}" "target_tool")
        KD_PROJECT=$(kd_get_config_value "${kd_dir}/${KD_CONFIG_FILE}" "project_name")
    else
        kd_log_error "Config file not found: ${kd_dir}/${KD_CONFIG_FILE}"
        return 1
    fi

    # Load language
    source "${SCRIPT_DIR}/language.sh"
    kd_load_language "${kd_dir}" "$KD_LANGUAGE"

    export KD_INITIALIZED=true
    export KD_ROOT="$project_root"
    export KD_DIR="$kd_dir"
}

# ---------------------------------------------------------------------------
# Config Helpers
# ---------------------------------------------------------------------------
kd_get_config_value() {
    local config_file="$1"
    local key="$2"
    grep -o "\"${key}\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" "$config_file" | \
        grep -o '"[^"]*"$' | tr -d '"'
}

kd_set_config_value() {
    local config_file="$1"
    local key="$2"
    local value="$3"

    if command -v sed &>/dev/null; then
        sed -i "s/\"${key}\"[[:space:]]*:[[:space:]]*\"[^\"]*\"/\"${key}\": \"${value}\"/" "$config_file"
    fi
}

# ---------------------------------------------------------------------------
# Project State
# ---------------------------------------------------------------------------
kd_get_project_root() {
    local dir="${1:-.}"
    while [[ "$dir" != "/" ]]; do
        if [[ -d "${dir}/.kracked" ]]; then
            echo "$dir"
            return 0
        fi
        dir="$(dirname "$dir")"
    done
    return 1
}

kd_ensure_initialized() {
    if [[ "${KD_INITIALIZED:-false}" != true ]]; then
        local root
        root=$(kd_get_project_root "$(pwd)") || {
            kd_log_error "KD not found. Run install.sh in your project directory."
            return 1
        }
        kd_init "$root"
    fi
}
