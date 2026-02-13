#!/usr/bin/env bash
# ============================================================================
# KRACKED_skill (KD) - Install Test
# Tests the installation process
# ============================================================================

set -euo pipefail

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly NC='\033[0m'

PASS=0
FAIL=0
TEST_DIR=""

log_pass() { echo -e "  ${GREEN}[PASS]${NC} $1"; ((PASS++)); }
log_fail() { echo -e "  ${RED}[FAIL]${NC} $1"; ((FAIL++)); }

setup() {
    TEST_DIR=$(mktemp -d)
    echo "  Test directory: ${TEST_DIR}"
}

cleanup() {
    if [[ -n "$TEST_DIR" && -d "$TEST_DIR" ]]; then
        rm -rf "$TEST_DIR"
    fi
}

trap cleanup EXIT

# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------

test_install_creates_directory() {
    echo ""
    echo "  Test: install creates .kracked directory"

    bash install.sh "$TEST_DIR" --target=claude-code --language=EN --non-interactive --force 2>/dev/null

    if [[ -d "${TEST_DIR}/.kracked" ]]; then
        log_pass "Directory .kracked/ created"
    else
        log_fail "Directory .kracked/ not created"
    fi
}

test_install_creates_status() {
    echo ""
    echo "  Test: install creates status.md"

    if [[ -f "${TEST_DIR}/status.md" ]]; then
        log_pass "status.md created"
    else
        log_fail "status.md not created"
    fi
}

test_install_creates_settings() {
    echo ""
    echo "  Test: install creates settings.json"

    if [[ -f "${TEST_DIR}/.kracked/config/settings.json" ]]; then
        log_pass "settings.json created"
    else
        log_fail "settings.json not created"
    fi
}

test_install_creates_adapter() {
    echo ""
    echo "  Test: install creates adapter file"

    if [[ -f "${TEST_DIR}/CLAUDE.md" ]]; then
        log_pass "CLAUDE.md adapter created"
    else
        log_fail "CLAUDE.md adapter not created"
    fi
}

test_install_creates_prompts() {
    echo ""
    echo "  Test: install creates system prompt"

    if [[ -f "${TEST_DIR}/.kracked/prompts/system-prompt.md" ]]; then
        log_pass "system-prompt.md created"
    else
        log_fail "system-prompt.md not created"
    fi
}

test_validate_passes() {
    echo ""
    echo "  Test: validate.sh passes on fresh install"

    if bash validate.sh "$TEST_DIR" 2>/dev/null; then
        log_pass "Validation passes"
    else
        log_fail "Validation fails on fresh install"
    fi
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
    echo ""
    echo "  KD Install Test Suite"
    echo "  ─────────────────────"

    setup

    test_install_creates_directory
    test_install_creates_status
    test_install_creates_settings
    test_install_creates_adapter
    test_install_creates_prompts
    test_validate_passes

    echo ""
    echo "  ─────────────────────"
    echo -e "  Results: ${GREEN}${PASS} passed${NC}, ${RED}${FAIL} failed${NC}"
    echo ""

    exit "$FAIL"
}

main "$@"
