<#
.SYNOPSIS
    Agent Constitution Universal Installer for Windows PowerShell
.DESCRIPTION
    Installs AGENTS.md, docs, templates, validation scripts, MCP server, and agent tool adapters into a target project.
.PARAMETER TargetDir
    The target directory where Agent Constitution should be installed. Defaults to current directory.
#>

param (
    [string]$TargetDir = "."
)

$ErrorActionPreference = "Stop"

Write-Host "Installing Agent Constitution into: $TargetDir" -ForegroundColor Cyan

$scriptRoot = Split-Path -Parent $PSScriptRoot

# Create destination directories
$docsDir = Join-Path $TargetDir "docs\languages"
$templatesDir = Join-Path $TargetDir "templates"
$scriptsDir = Join-Path $TargetDir "scripts"
$binDir = Join-Path $TargetDir "bin"
$benchmarksDir = Join-Path $TargetDir "benchmarks"
$githooksDir = Join-Path $TargetDir ".githooks"
$cursorRulesDir = Join-Path $TargetDir ".cursor\rules"
$githubDir = Join-Path $TargetDir ".github"
$continueDir = Join-Path $TargetDir ".continue"
$zedDir = Join-Path $TargetDir ".zed"
$vscodeDir = Join-Path $TargetDir ".vscode"

New-Item -ItemType Directory -Force -Path $docsDir | Out-Null
New-Item -ItemType Directory -Force -Path $templatesDir | Out-Null
New-Item -ItemType Directory -Force -Path $scriptsDir | Out-Null
New-Item -ItemType Directory -Force -Path $binDir | Out-Null
New-Item -ItemType Directory -Force -Path $benchmarksDir | Out-Null
New-Item -ItemType Directory -Force -Path $githooksDir | Out-Null
New-Item -ItemType Directory -Force -Path $cursorRulesDir | Out-Null
New-Item -ItemType Directory -Force -Path $githubDir | Out-Null
New-Item -ItemType Directory -Force -Path $continueDir | Out-Null
New-Item -ItemType Directory -Force -Path $zedDir | Out-Null
New-Item -ItemType Directory -Force -Path $vscodeDir | Out-Null

# Copy core files
Copy-Item -Path (Join-Path $scriptRoot "AGENTS.md") -Destination $TargetDir -Force
Copy-Item -Path (Join-Path $scriptRoot "docs\*") -Destination (Join-Path $TargetDir "docs") -Recurse -Force
Copy-Item -Path (Join-Path $scriptRoot "templates\*") -Destination (Join-Path $TargetDir "templates") -Recurse -Force
Copy-Item -Path (Join-Path $scriptRoot "scripts\*") -Destination (Join-Path $TargetDir "scripts") -Recurse -Force
Copy-Item -Path (Join-Path $scriptRoot "bin\*") -Destination (Join-Path $TargetDir "bin") -Recurse -Force
Copy-Item -Path (Join-Path $scriptRoot "benchmarks\*") -Destination (Join-Path $TargetDir "benchmarks") -Recurse -Force
Copy-Item -Path (Join-Path $scriptRoot ".githooks\*") -Destination (Join-Path $TargetDir ".githooks") -Recurse -Force

# Initialize CONTEXT.md and TASKS.md if missing
$contextPath = Join-Path $TargetDir "CONTEXT.md"
if (-not (Test-Path $contextPath)) {
    Copy-Item -Path (Join-Path $TargetDir "templates\CONTEXT.md") -Destination $contextPath
    Write-Host "  + Created CONTEXT.md from template" -ForegroundColor Green
}

$tasksPath = Join-Path $TargetDir "TASKS.md"
if (-not (Test-Path $tasksPath)) {
    Copy-Item -Path (Join-Path $TargetDir "templates\TASKS.md") -Destination $tasksPath
    Write-Host "  + Created TASKS.md from template" -ForegroundColor Green
}

# Copy adapters & plugin manifests
$adapters = @("CLAUDE.md", ".cursorrules", ".windsurfrules", ".clinerules", "GEMINI.md", ".aider.conf.yml", ".roomodes", "plugin.json", ".mcp.json")
foreach ($adapter in $adapters) {
    $src = Join-Path $scriptRoot $adapter
    if (Test-Path $src) {
        Copy-Item -Path $src -Destination $TargetDir -Force
    }
}

$cursorMcpSrc = Join-Path $scriptRoot ".cursor\mcp.json"
if (Test-Path $cursorMcpSrc) {
    Copy-Item -Path $cursorMcpSrc -Destination (Join-Path $TargetDir ".cursor") -Force
}

$mdcSrc = Join-Path $scriptRoot ".cursor\rules\agent-constitution.mdc"
if (Test-Path $mdcSrc) {
    Copy-Item -Path $mdcSrc -Destination $cursorRulesDir -Force
}

$copilotSrc = Join-Path $scriptRoot ".github\copilot-instructions.md"
if (Test-Path $copilotSrc) {
    Copy-Item -Path $copilotSrc -Destination $githubDir -Force
}

$continueSrc = Join-Path $scriptRoot ".continue\config.json"
if (Test-Path $continueSrc) {
    Copy-Item -Path $continueSrc -Destination $continueDir -Force
}

$zedSrc = Join-Path $scriptRoot ".zed\settings.json"
if (Test-Path $zedSrc) {
    Copy-Item -Path $zedSrc -Destination $zedDir -Force
}

$vscodeSrc = Join-Path $scriptRoot ".vscode\*"
if (Test-Path (Join-Path $scriptRoot ".vscode")) {
    Copy-Item -Path $vscodeSrc -Destination $vscodeDir -Force
}

Write-Host "Agent Constitution installed successfully!" -ForegroundColor Green
Write-Host "   Next steps:" -ForegroundColor Yellow
Write-Host "   1. Fill in your tech stack details in CONTEXT.md"
Write-Host "   2. Add your current goals in TASKS.md"
Write-Host "   3. Run 'powershell -ExecutionPolicy Bypass -File .\scripts\setup-hooks.ps1' to activate Git push guardrails"
Write-Host "   4. Start MCP server with 'node bin\mcp-server.js' or use Cursor/Claude Code/Roo Code natively"
Write-Host "   5. Point your AI agent at AGENTS.md and enjoy disciplined engineering!"
