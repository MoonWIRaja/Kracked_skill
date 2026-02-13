#!/usr/bin/env bash
# ============================================================================
# KRACKED_skill (KD) - Validation Functions
# AI Skill by KRACKEDDEVS | https://krackeddevs.com/
# ============================================================================

# ---------------------------------------------------------------------------
# Input Validation
# ---------------------------------------------------------------------------
kd_validate_not_empty() {
    local value="$1"
    local field_name="$2"
    if [[ -z "$value" ]]; then
        kd_log_error "${field_name} cannot be empty."
        return 1
    fi
    return 0
}

kd_validate_option() {
    local value="$1"
    local field_name="$2"
    shift 2
    local valid_options=("$@")

    for opt in "${valid_options[@]}"; do
        if [[ "$value" == "$opt" ]]; then
            return 0
        fi
    done

    kd_log_error "Invalid ${field_name}: '${value}'. Valid options: ${valid_options[*]}"
    return 1
}

# ---------------------------------------------------------------------------
# File Validation
# ---------------------------------------------------------------------------
kd_validate_json() {
    local file="$1"

    if [[ ! -f "$file" ]]; then
        kd_log_error "File not found: ${file}"
        return 1
    fi

    # Try python first
    if command -v python3 &>/dev/null; then
        python3 -c "import json; json.load(open('${file}'))" 2>/dev/null && return 0
    elif command -v python &>/dev/null; then
        python -c "import json; json.load(open('${file}'))" 2>/dev/null && return 0
    fi

    # Fallback: basic structure check
    local open_braces close_braces
    open_braces=$(grep -o '{' "$file" | wc -l)
    close_braces=$(grep -o '}' "$file" | wc -l)

    if [[ "$open_braces" -eq "$close_braces" && "$open_braces" -gt 0 ]]; then
        return 0
    fi

    kd_log_error "Invalid JSON: ${file}"
    return 1
}

kd_validate_markdown_sections() {
    local file="$1"
    shift
    local required_sections=("$@")
    local missing=0

    for section in "${required_sections[@]}"; do
        if ! grep -q "$section" "$file"; then
            kd_log_error "Missing section: ${section} in $(basename "$file")"
            ((missing++))
        fi
    done

    return "$missing"
}

# ---------------------------------------------------------------------------
# Installation Validation
# ---------------------------------------------------------------------------
kd_validate_installation() {
    local kd_dir="$1"
    local errors=0

    # Required directories
    local dirs=("prompts" "prompts/roles" "prompts/stages" "prompts/multi-agent" "templates" "checklists" "config" "config/language")
    for dir in "${dirs[@]}"; do
        if [[ ! -d "${kd_dir}/${dir}" ]]; then
            kd_log_error "Missing directory: ${dir}/"
            ((errors++))
        fi
    done

    # Required files
    local files=("prompts/system-prompt.md" "config/settings.json")
    for file in "${files[@]}"; do
        if [[ ! -f "${kd_dir}/${file}" ]]; then
            kd_log_error "Missing file: ${file}"
            ((errors++))
        fi
    done

    return "$errors"
}
