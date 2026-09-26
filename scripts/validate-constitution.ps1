param (
    [string]$TargetDir = "."
)

$ErrorActionPreference = "Stop"
$global:exitCode = 0

Write-Host "Validating Agent Constitution Compliance in: $TargetDir" -ForegroundColor Cyan

function Check-FileExists($Path, $Description) {
    $fullPath = Join-Path $TargetDir $Path
    if (-not (Test-Path -Path $fullPath -PathType Leaf)) {
        Write-Host "FAIL: Missing mandatory file: $Path ($Description)" -ForegroundColor Red
        $global:exitCode = 1
    } else {
        Write-Host "PASS: Found file: $Path" -ForegroundColor Green
    }
}

function Check-DirExists($Path) {
    $fullPath = Join-Path $TargetDir $Path
    if (-not (Test-Path -Path $fullPath -PathType Container)) {
        Write-Host "FAIL: Missing directory: $Path" -ForegroundColor Red
        $global:exitCode = 1
    } else {
        Write-Host "PASS: Found directory: $Path" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "--- 1. Checking Core Files ---" -ForegroundColor DarkGray
Check-FileExists "AGENTS.md" "Master Behavioral Contract"
Check-FileExists "CONTEXT.md" "Persistent Project Memory"
Check-FileExists "TASKS.md" "Active Task Ledger"

Write-Host ""
Write-Host "--- 2. Checking Template Population ---" -ForegroundColor DarkGray
$contextPath = Join-Path $TargetDir "CONTEXT.md"
if (Test-Path $contextPath) {
    $contextContent = Get-Content $contextPath -Raw
    if ($contextContent -match "<short title>") {
        Write-Host "WARN: CONTEXT.md still contains raw template placeholders (<short title>)" -ForegroundColor Yellow
    }
    if ($contextContent.Length -lt 200) {
        Write-Host "WARN: CONTEXT.md seems too short (< 200 characters). Ensure it has project details." -ForegroundColor Yellow
    }
}

$tasksPath = Join-Path $TargetDir "TASKS.md"
if (Test-Path $tasksPath) {
    $tasksContent = Get-Content $tasksPath -Raw
    if ($tasksContent -match "<task description>") {
        Write-Host "WARN: TASKS.md still contains raw template placeholders (<task description>)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "--- 3. Checking Protocol Documentation (23 Master Protocols) ---" -ForegroundColor DarkGray
Check-DirExists "docs"
$mandatoryDocs = @(
    "agent-decision-matrix.md",
    "anti-hallucination-evidence.md",
    "architecture-standards.md",
    "coding-standards.md",
    "context-memory.md",
    "deployment-guide.md",
    "drift-prevention-and-circuit-breakers.md",
    "frontend-design-and-aesthetics.md",
    "git-and-github-push-guardrails.md",
    "incident-response.md",
    "limitless-first-principles-agency.md",
    "monorepo-and-multirepo-governance.md",
    "non-regression-policy.md",
    "proactive-autonomous-agency.md",
    "safe-execution-guardrails.md",
    "security-and-depth.md",
    "subagent-orchestration.md",
    "surgical-editing-and-scope-containment.md",
    "task-management.md",
    "tdd-and-verification.md",
    "token-economy-and-max-output.md",
    "transforming-legacy-projects.md",
    "universal-stack-detection.md"
)

foreach ($doc in $mandatoryDocs) {
    $docPath = Join-Path "docs" $doc
    Check-FileExists $docPath "Constitutional Protocol"
}

Write-Host ""
Write-Host "--- 4. Checking Operational Templates ---" -ForegroundColor DarkGray
Check-DirExists "templates"
$mandatoryTemplates = @(
    "ADR.md",
    "AUDIT_REPORT.md",
    "CONTEXT.md",
    "HANDOFF.md",
    "INCIDENT_POSTMORTEM.md",
    "PHASE_PLAN.md",
    "SECURITY_CHECKLIST.md",
    "TASKS.md"
)

foreach ($tpl in $mandatoryTemplates) {
    $tplPath = Join-Path "templates" $tpl
    Check-FileExists $tplPath "Operational Template"
}

Write-Host ""
Write-Host "--- 5. Checking Language Specifications ---" -ForegroundColor DarkGray
$langDir = Join-Path "docs" "languages"
Check-DirExists $langDir
$mandatoryLanguages = @(
    "cpp.md", "csharp.md", "go.md", "java-kotlin.md", "nodejs.md",
    "php.md", "python.md", "react-web.md", "ruby.md", "rust.md",
    "sql.md", "terraform.md"
)

foreach ($lang in $mandatoryLanguages) {
    $langPath = Join-Path $langDir $lang
    Check-FileExists $langPath "Language Specification"
}

Write-Host ""
Write-Host "--- 6. Checking AI Tool Adapters ---" -ForegroundColor DarkGray
$adapters = @(
    "CLAUDE.md", ".cursorrules", ".windsurfrules", ".clinerules",
    "GEMINI.md", ".github/copilot-instructions.md", ".aider.conf.yml",
    ".continue/config.json", ".zed/settings.json"
)
$adapterFound = $false
foreach ($adapter in $adapters) {
    $adapterPath = Join-Path $TargetDir $adapter
    if (Test-Path $adapterPath) {
        $adapterFound = $true
        Write-Host "PASS: Active Adapter: $adapter" -ForegroundColor Green
    }
}

if (-not $adapterFound) {
    Write-Host "FAIL: No tool adapters found (at least one adapter required)" -ForegroundColor Red
    $global:exitCode = 1
}

Write-Host ""
if ($global:exitCode -eq 0) {
    Write-Host "SUCCESS: Repository is 100% compliant with Agent Constitution standard!" -ForegroundColor Green
} else {
    Write-Host "FAILED: Validation failed. Please review missing files above or run install script." -ForegroundColor Red
}

exit $global:exitCode
