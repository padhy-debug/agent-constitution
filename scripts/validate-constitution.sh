#!/usr/bin/env bash
# Verifies that a repository contains the necessary Agent Constitution files
# and that CONTEXT.md and TASKS.md are populated.

set -euo pipefail

EXIT_CODE=0

echo "🔍 Validating Agent Constitution Compliance..."

check_file() {
    if [ ! -f "$1" ]; then
        echo "❌ Missing mandatory file: $1"
        EXIT_CODE=1
    else
        echo "✅ Found: $1"
    fi
}

check_file "AGENTS.md"
check_file "CONTEXT.md"
check_file "TASKS.md"

# Check if CONTEXT.md has been touched from the default template
if grep -q "<short title>" CONTEXT.md 2>/dev/null; then
    echo "⚠️ Warning: CONTEXT.md appears to contain unpopulated template placeholders."
fi

if [ $EXIT_CODE -eq 0 ]; then
    echo "🎉 Repository is compliant with Agent Constitution!"
else
    echo "❌ Validation failed. Please run ./scripts/install.sh to fix missing files."
fi

exit $EXIT_CODE
