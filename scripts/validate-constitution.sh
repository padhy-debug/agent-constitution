#!/usr/bin/env bash
# Verifies that a repository adheres to the Agent Constitution standard.
# Validates core behavioral files, template population, docs, templates, languages, and adapters.

set -euo pipefail

EXIT_CODE=0
TARGET_DIR="${1:-.}"

echo "🔍 Validating Agent Constitution Compliance in: $TARGET_DIR"

check_file() {
    local file="$TARGET_DIR/$1"
    local desc="$2"
    if [ ! -f "$file" ]; then
        echo "❌ Missing mandatory file: $1 ($desc)"
        EXIT_CODE=1
    else
        echo "✅ Found: $1"
    fi
}

check_dir() {
    local dir="$TARGET_DIR/$1"
    if [ ! -d "$dir" ]; then
        echo "❌ Missing directory: $1"
        EXIT_CODE=1
    else
        echo "✅ Found directory: $1"
    fi
}

echo ""
echo "--- [1] Checking Core Files ---"
check_file "AGENTS.md" "Master Behavioral Contract"
check_file "CONTEXT.md" "Persistent Project Memory"
check_file "TASKS.md" "Active Task Ledger"

echo ""
echo "--- [2] Checking Template Population ---"
if [ -f "$TARGET_DIR/CONTEXT.md" ]; then
    if grep -q "<short title>" "$TARGET_DIR/CONTEXT.md" 2>/dev/null; then
        echo "⚠️  Warning: CONTEXT.md still contains raw template placeholders (<short title>)"
    fi
fi

if [ -f "$TARGET_DIR/TASKS.md" ]; then
    if grep -q "<task description>" "$TARGET_DIR/TASKS.md" 2>/dev/null; then
        echo "⚠️  Warning: TASKS.md still contains raw template placeholders (<task description>)"
    fi
fi

echo ""
echo "--- [3] Checking Protocol Documentation (23 Master Protocols) ---"
check_dir "docs"
for doc in \
    "agent-decision-matrix.md" \
    "anti-hallucination-evidence.md" \
    "architecture-standards.md" \
    "coding-standards.md" \
    "context-memory.md" \
    "deployment-guide.md" \
    "drift-prevention-and-circuit-breakers.md" \
    "frontend-design-and-aesthetics.md" \
    "git-and-github-push-guardrails.md" \
    "incident-response.md" \
    "limitless-first-principles-agency.md" \
    "monorepo-and-multirepo-governance.md" \
    "non-regression-policy.md" \
    "proactive-autonomous-agency.md" \
    "safe-execution-guardrails.md" \
    "security-and-depth.md" \
    "subagent-orchestration.md" \
    "surgical-editing-and-scope-containment.md" \
    "task-management.md" \
    "tdd-and-verification.md" \
    "token-economy-and-max-output.md" \
    "transforming-legacy-projects.md" \
    "universal-stack-detection.md"
do
    check_file "docs/$doc" "Constitutional Protocol"
done

echo ""
echo "--- [4] Checking Operational Templates ---"
check_dir "templates"
for tpl in \
    "ADR.md" \
    "AUDIT_REPORT.md" \
    "CONTEXT.md" \
    "HANDOFF.md" \
    "INCIDENT_POSTMORTEM.md" \
    "PHASE_PLAN.md" \
    "SECURITY_CHECKLIST.md" \
    "TASKS.md"
do
    check_file "templates/$tpl" "Operational Template"
done

echo ""
echo "--- [5] Checking Language Specifications ---"
check_dir "docs/languages"
for lang in \
    "cpp.md" "csharp.md" "go.md" "java-kotlin.md" "nodejs.md" \
    "php.md" "python.md" "react-web.md" "ruby.md" "rust.md" \
    "sql.md" "terraform.md"
do
    check_file "docs/languages/$lang" "Language Specification"
done

echo ""
echo "--- [6] Checking AI Tool Adapters ---"
ADAPTER_FOUND=0
for adapter in \
    "CLAUDE.md" ".cursorrules" ".windsurfrules" ".clinerules" \
    "GEMINI.md" ".github/copilot-instructions.md" ".aider.conf.yml" \
    ".continue/config.json" ".zed/settings.json"
do
    if [ -f "$TARGET_DIR/$adapter" ]; then
        echo "✅ Active Adapter: $adapter"
        ADAPTER_FOUND=1
    fi
done

if [ $ADAPTER_FOUND -eq 0 ]; then
    echo "❌ No tool adapters found (at least one adapter required)"
    EXIT_CODE=1
fi

echo ""
if [ $EXIT_CODE -eq 0 ]; then
    echo "🎉 Repository is 100% compliant with Agent Constitution standard!"
else
    echo "❌ Validation failed. Please review missing files above or run install script."
fi

exit $EXIT_CODE
