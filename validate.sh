#!/usr/bin/env bash
# ============================================================================
# Kracked_Skills (KD) - Validation Script v5.0.0
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

TARGET_DIR="${1:-.}"
ERRORS=0
WARNINGS=0

log_pass() { echo -e "  ${GREEN}[PASS]${NC} $1"; }
log_fail() { echo -e "  ${RED}[FAIL]${NC} $1"; ((ERRORS++)); }
log_warn() { echo -e "  ${YELLOW}[WARN]${NC} $1"; ((WARNINGS++)); }

# ---------------------------------------------------------------------------
# File Integrity Check
# ---------------------------------------------------------------------------
check_file_integrity() {
    echo ""
    echo -e "  ${BOLD}File Integrity Check${NC}"
    echo -e "  ────────────────────────────────"

    local required_dirs=(
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
        "${KD_DIR}/config/agents"
        "${KD_DIR}/testsprite"
        "${KD_DIR}/tool-selector"
        "${KD_DIR}/analytics"
        "${KD_DIR}/git-integration"
        "${KD_DIR}/exporters"
        "${KD_DIR}/commands"
        "${KD_DIR}/artifacts"
    )

    for dir in "${required_dirs[@]}"; do
        if [[ -d "${TARGET_DIR}/${dir}" ]]; then
            log_pass "Directory: ${dir}/"
        else
            log_fail "Missing directory: ${dir}/"
        fi
    done

    local required_files=(
        "${KD_DIR}/prompts/system-prompt.md"
        "${KD_DIR}/config/settings.json"
        "${KD_DIR}/config/language/en.json"
        "${KD_DIR}/config/language/ms.json"
        "${KD_DIR}/config/agents/personalities.json"
        "${KD_DIR}/testsprite/testsprite-core.js"
        "${KD_DIR}/tool-selector/tool-selector.js"
        "${KD_DIR}/tool-selector/knowledge-base.json"
        "${KD_DIR}/analytics/agent-performance.json"
        "${KD_DIR}/KD_output/status/status.md"
    )

    for file in "${required_files[@]}"; do
        if [[ -f "${TARGET_DIR}/${file}" ]]; then
            log_pass "File: ${file}"
        else
            log_fail "Missing file: ${file}"
        fi
    done

    # Check roles (13 roles in v5.0.0)
    local roles=("analyst" "product-manager" "architect" "tech-lead" "engineer" "qa" "security" "devops" "release-manager" "ux-designer" "data-scientist" "mobile-developer" "database-admin")
    for role in "${roles[@]}"; do
        local path="${KD_DIR}/prompts/roles/${role}.md"
        if [[ -f "${TARGET_DIR}/${path}" ]]; then
            log_pass "Role: ${role}"
        else
            log_fail "Missing role: ${path}"
        fi
    done

    # Check stages (8 stages in v5.0.0)
    local stages=("discovery" "brainstorm" "requirements" "architecture" "implementation" "quality" "deployment" "release")
    for stage in "${stages[@]}"; do
        local path="${KD_DIR}/prompts/stages/${stage}.md"
        if [[ -f "${TARGET_DIR}/${path}" ]]; then
            log_pass "Stage: ${stage}"
        else
            log_fail "Missing stage: ${path}"
        fi
    done

    # Check multi-agent
    local multi=("party-mode" "agent-swarm" "confidence-scoring" "conflict-resolution" "aggregation")
    for m in "${multi[@]}"; do
        local path="${KD_DIR}/prompts/multi-agent/${m}.md"
        if [[ -f "${TARGET_DIR}/${path}" ]]; then
            log_pass "Multi-Agent: ${m}"
        else
            log_fail "Missing multi-agent: ${path}"
        fi
    done
}

# ---------------------------------------------------------------------------
# Config Validation
# ---------------------------------------------------------------------------
check_config_valid() {
    echo ""
    echo -e "  ${BOLD}Configuration Check${NC}"
    echo -e "  ────────────────────────────────"

    local config="${TARGET_DIR}/${KD_DIR}/config/settings.json"
    if [[ ! -f "$config" ]]; then
        log_fail "settings.json not found"
        return
    fi

    # Check valid JSON (basic check)
    if python3 -c "import json; json.load(open('${config}'))" 2>/dev/null || \
       python -c "import json; json.load(open('${config}'))" 2>/dev/null; then
        log_pass "settings.json is valid JSON"
    else
        # Fallback: basic brace check
        local open_braces close_braces
        open_braces=$(grep -o '{' "$config" | wc -l)
        close_braces=$(grep -o '}' "$config" | wc -l)
        if [[ "$open_braces" -eq "$close_braces" && "$open_braces" -gt 0 ]]; then
            log_pass "settings.json structure appears valid"
        else
            log_fail "settings.json has malformed JSON"
        fi
    fi

    # Check required fields
    for field in "version" "language" "target_tool"; do
        if grep -q "\"${field}\"" "$config"; then
            log_pass "Config field: ${field}"
        else
            log_fail "Missing config field: ${field}"
        fi
    done

    # Check language value
    local lang
    lang=$(grep -o '"language"[[:space:]]*:[[:space:]]*"[^"]*"' "$config" | grep -o '"[^"]*"$' | tr -d '"' || echo "")
    case "$lang" in
        EN|MS) log_pass "Language value: ${lang}" ;;
        *)     log_fail "Invalid language value: '${lang}' (expected EN or MS)" ;;
    esac

    # Check target_tool value
    local tool
    tool=$(grep -o '"target_tool"[[:space:]]*:[[:space:]]*"[^"]*"' "$config" | grep -o '"[^"]*"$' | tr -d '"' || echo "")
    case "$tool" in
        claude-code|cursor|antigravity|cline|kilocode|roo) log_pass "Target tool: ${tool}" ;;
        *) log_fail "Invalid target_tool: '${tool}' (expected claude-code, cursor, antigravity, cline, kilocode, or roo)" ;;
    esac
}

# ---------------------------------------------------------------------------
# Status Validation
# ---------------------------------------------------------------------------
check_status_valid() {
    echo ""
    echo -e "  ${BOLD}Status File Check${NC}"
    echo -e "  ────────────────────────────────"

    local status="${TARGET_DIR}/${KD_DIR}/KD_output/status/status.md"
    if [[ ! -f "$status" ]]; then
        log_fail "status.md not found at ${status}"
        return
    fi

    # Check required sections
    local sections=(
        "## Meta"
        "## Current State"
        "## Completed Stages"
        "## Architecture Decisions"
        "## Tech Stack"
        "## Next Actions"
    )

    for section in "${sections[@]}"; do
        if grep -q "$section" "$status"; then
            log_pass "Section: ${section}"
        else
            log_fail "Missing section in status.md: ${section}"
        fi
    done
}

# ---------------------------------------------------------------------------
# Adapter Validation
# ---------------------------------------------------------------------------
check_adapter_valid() {
    echo ""
    echo -e "  ${BOLD}Adapter Check${NC}"
    echo -e "  ────────────────────────────────"

    local config="${TARGET_DIR}/${KD_DIR}/config/settings.json"
    local tool
    tool=$(grep -o '"target_tool"[[:space:]]*:[[:space:]]*"[^"]*"' "$config" 2>/dev/null | grep -o '"[^"]*"$' | tr -d '"' || echo "")

    case "$tool" in
        claude-code)
            if [[ -f "${TARGET_DIR}/CLAUDE.md" ]]; then
                log_pass "Claude Code adapter: CLAUDE.md"
            else
                log_fail "Missing: CLAUDE.md"
            fi
            ;;
        cursor)
            if [[ -f "${TARGET_DIR}/.cursorrules" ]]; then
                log_pass "Cursor adapter: .cursorrules"
            else
                log_fail "Missing: .cursorrules"
            fi
            ;;
        antigravity)
            if [[ -f "${TARGET_DIR}/.antigravity/SKILL.md" ]]; then
                log_pass "Antigravity adapter: .antigravity/SKILL.md"
            else
                log_fail "Missing: .antigravity/SKILL.md"
            fi
            ;;
        cline)
            if [[ -f "${TARGET_DIR}/.clinerules" ]]; then
                log_pass "Cline adapter: .clinerules"
            else
                log_fail "Missing: .clinerules"
            fi
            ;;
        kilocode)
            if [[ -f "${TARGET_DIR}/.kilocode" ]]; then
                log_pass "Kilo Code adapter: .kilocode"
            else
                log_fail "Missing: .kilocode"
            fi
            ;;
        roo)
            if [[ -f "${TARGET_DIR}/.roo" ]]; then
                log_pass "Roo Code adapter: .roo"
            else
                log_fail "Missing: .roo"
            fi
            ;;
        *)
            log_warn "Unknown target tool: '${tool}'"
            ;;
    esac
}

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
print_summary() {
    echo ""
    echo -e "  ${BOLD}═══════════════════════════════════════════${NC}"
    if [[ "$ERRORS" -eq 0 ]]; then
        echo -e "  ${GREEN}✓ Validation PASSED${NC}"
        echo -e "  ${GREEN} All checks passed with ${WARNINGS} warning(s).${NC}"
    else
        echo -e "  ${RED}✗ Validation FAILED${NC}"
        echo -e "  ${RED} ${ERRORS} error(s), ${WARNINGS} warning(s).${NC}"
        echo -e ""
        echo -e "  ${YELLOW}Fix: Re-run install.sh --force to repair installation.${NC}"
    fi
    echo -e "  ${BOLD}═══════════════════════════════════════════${NC}"
    echo ""
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
    echo ""
    echo -e "  ${BOLD}KD Validation v5.0.0${NC}"
    echo -e "  AI Skill by KRACKEDDEVS | https://krackeddevs.com/"

    check_file_integrity
    check_config_valid
    check_status_valid
    check_adapter_valid
    print_summary

    exit "$ERRORS"
}

main "$@"
