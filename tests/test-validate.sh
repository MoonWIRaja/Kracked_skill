#!/usr/bin/env bash
# ============================================================================
# KRACKED_skill (KD) - Validation Test
# Tests the validation script
# ============================================================================

set -euo pipefail

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly NC='\033[0m'

PASS=0
FAIL=0

log_pass() { echo -e "  ${GREEN}[PASS]${NC} $1"; ((PASS++)); }
log_fail() { echo -e "  ${RED}[FAIL]${NC} $1"; ((FAIL++)); }

# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------

test_validate_fails_no_install() {
    echo ""
    echo "  Test: validate fails when KD not installed"

    local tmp_dir
    tmp_dir=$(mktemp -d)

    if ! bash validate.sh "$tmp_dir" 2>/dev/null; then
        log_pass "Correctly fails on missing installation"
    else
        log_fail "Should fail on missing installation"
    fi

    rm -rf "$tmp_dir"
}

test_validate_detects_missing_config() {
    echo ""
    echo "  Test: validate detects missing config"

    local tmp_dir
    tmp_dir=$(mktemp -d)
    mkdir -p "${tmp_dir}/.kracked/config"

    if ! bash validate.sh "$tmp_dir" 2>/dev/null; then
        log_pass "Correctly detects missing config"
    else
        log_fail "Should detect missing config"
    fi

    rm -rf "$tmp_dir"
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
    echo ""
    echo "  KD Validation Test Suite"
    echo "  ────────────────────────"

    test_validate_fails_no_install
    test_validate_detects_missing_config

    echo ""
    echo "  ────────────────────────"
    echo -e "  Results: ${GREEN}${PASS} passed${NC}, ${RED}${FAIL} failed${NC}"
    echo ""

    exit "$FAIL"
}

main "$@"
