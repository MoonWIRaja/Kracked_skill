#!/usr/bin/env bash
# ============================================================================
# KRACKED_skill (KD) - Language Handling
# AI Skill by KRACKEDDEVS | https://krackeddevs.com/
# ============================================================================

# Language strings associative array
declare -gA KD_STRINGS

# ---------------------------------------------------------------------------
# Load Language
# ---------------------------------------------------------------------------
kd_load_language() {
    local kd_dir="$1"
    local lang="${2:-EN}"
    local lang_file="${kd_dir}/config/language/$(echo "$lang" | tr '[:upper:]' '[:lower:]').json"

    if [[ ! -f "$lang_file" ]]; then
        kd_log_warn "Language file not found: ${lang_file}. Falling back to EN."
        lang_file="${kd_dir}/config/language/en.json"
    fi

    if [[ ! -f "$lang_file" ]]; then
        kd_log_error "No language files found."
        return 1
    fi

    # Parse JSON (basic key-value extraction)
    while IFS= read -r line; do
        local key value
        key=$(echo "$line" | grep -o '"[^"]*"[[:space:]]*:' | head -1 | tr -d '":' | xargs)
        value=$(echo "$line" | grep -o ':[[:space:]]*"[^"]*"' | head -1 | sed 's/^:[[:space:]]*//' | tr -d '"')

        if [[ -n "$key" && -n "$value" ]]; then
            KD_STRINGS["$key"]="$value"
        fi
    done < "$lang_file"

    export KD_CURRENT_LANGUAGE="$lang"
}

# ---------------------------------------------------------------------------
# Get String
# ---------------------------------------------------------------------------
kd_str() {
    local key="$1"
    local default="${2:-$key}"
    echo "${KD_STRINGS[$key]:-$default}"
}

# ---------------------------------------------------------------------------
# Get Current Language
# ---------------------------------------------------------------------------
kd_get_language() {
    echo "${KD_CURRENT_LANGUAGE:-EN}"
}

# ---------------------------------------------------------------------------
# Set Language
# ---------------------------------------------------------------------------
kd_set_language() {
    local kd_dir="$1"
    local new_lang="$2"

    new_lang=$(echo "$new_lang" | tr '[:lower:]' '[:upper:]')

    case "$new_lang" in
        EN|MS)
            kd_load_language "$kd_dir" "$new_lang"
            # Update config
            local config="${kd_dir}/config/settings.json"
            if [[ -f "$config" ]]; then
                sed -i "s/\"language\"[[:space:]]*:[[:space:]]*\"[^\"]*\"/\"language\": \"${new_lang}\"/" "$config"
            fi
            kd_log_success "Language set to: ${new_lang}"
            ;;
        *)
            kd_log_error "Unsupported language: ${new_lang}. Supported: EN, MS"
            return 1
            ;;
    esac
}
