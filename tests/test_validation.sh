#!/usr/bin/env bash
# Automated test suite for Agent Constitution validation tooling.

set -euo pipefail
TEST_EXIT=0

echo "🔍 Running Agent Constitution Validation Test Suite (POSIX Bash)..."

# Test 1: Self-compliance check of agent-constitution repo
echo ""
echo "Test 1: Self-compliance check of agent-constitution repo..."
if ./scripts/validate-constitution.sh .; then
    echo "PASS: Test 1 passed successfully."
else
    echo "FAIL: Test 1 failed - repository did not pass self-validation!"
    TEST_EXIT=1
fi

# Test 2: Detect missing mandatory file in empty directory
echo ""
echo "Test 2: Assert failure on empty directory..."
TEMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'agent-const-test')
if ./scripts/validate-constitution.sh "$TEMP_DIR"; then
    echo "FAIL: Test 2 failed - validator should have returned non-zero exit code for empty directory!"
    TEST_EXIT=1
else
    echo "PASS: Test 2 passed - correctly caught missing files in empty directory."
fi
rm -rf "$TEMP_DIR"

# Test 3: Test install.sh into temp directory and validate it
echo ""
echo "Test 3: End-to-end install and validate in new directory..."
INSTALL_TEST_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'agent-const-install')
./scripts/install.sh "$INSTALL_TEST_DIR"
if ./scripts/validate-constitution.sh "$INSTALL_TEST_DIR"; then
    echo "PASS: Test 3 passed - install and validate cycle succeeded."
else
    echo "FAIL: Test 3 failed - installed repository did not pass validation!"
    TEST_EXIT=1
fi
rm -rf "$INSTALL_TEST_DIR"

echo ""
if [ $TEST_EXIT -eq 0 ]; then
    echo "ALL TESTS PASSED (3/3)"
else
    echo "TEST SUITE FAILED"
fi

exit $TEST_EXIT
