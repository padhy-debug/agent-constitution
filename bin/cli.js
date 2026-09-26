#!/usr/bin/env node

/**
 * Agent Constitution CLI
 * Zero-dependency universal installer & compliance validator.
 * Usage:
 *   npx agent-constitution init [targetDir]
 *   npx agent-constitution validate [targetDir]
 *   npx agent-constitution hooks [targetDir]
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const rawArgs = process.argv.slice(2);
const command = rawArgs[0] || 'help';
const nonFlagArgs = rawArgs.slice(1).filter((a) => !a.startsWith('-'));
const targetDir = path.resolve(process.cwd(), nonFlagArgs[0] || '.');
const rootDir = path.resolve(__dirname, '..');

function copyRecursiveSync(src, dest) {
  const exists = fs.existsSync(src);
  const stats = exists && fs.statSync(src);
  const isDirectory = exists && stats.isDirectory();
  if (isDirectory) {
    if (!fs.existsSync(dest)) fs.mkdirSync(dest, { recursive: true });
    fs.readdirSync(src).forEach((childItemName) => {
      copyRecursiveSync(path.join(src, childItemName), path.join(dest, childItemName));
    });
  } else {
    fs.copyFileSync(src, dest);
  }
}

function init() {
  console.log(`🧠 Initializing Agent Constitution in: ${targetDir}`);

  // Create required subdirectories
  ['docs', 'templates', 'scripts', 'bin', 'benchmarks', '.githooks', '.cursor/rules', '.github', '.continue', '.zed', '.vscode'].forEach((dir) => {
    fs.mkdirSync(path.join(targetDir, dir), { recursive: true });
  });

  // Copy AGENTS.md
  fs.copyFileSync(path.join(rootDir, 'AGENTS.md'), path.join(targetDir, 'AGENTS.md'));
  console.log('  + Installed AGENTS.md (Master Behavioral Contract)');

  // Copy docs, templates, scripts, bin, benchmarks, .githooks
  copyRecursiveSync(path.join(rootDir, 'docs'), path.join(targetDir, 'docs'));
  copyRecursiveSync(path.join(rootDir, 'templates'), path.join(targetDir, 'templates'));
  copyRecursiveSync(path.join(rootDir, 'scripts'), path.join(targetDir, 'scripts'));
  copyRecursiveSync(path.join(rootDir, 'bin'), path.join(targetDir, 'bin'));
  copyRecursiveSync(path.join(rootDir, 'benchmarks'), path.join(targetDir, 'benchmarks'));
  copyRecursiveSync(path.join(rootDir, '.githooks'), path.join(targetDir, '.githooks'));
  console.log('  + Installed docs/, templates/, scripts/, bin/, benchmarks/, and .githooks/');

  // Initialize CONTEXT.md and TASKS.md if missing
  const contextPath = path.join(targetDir, 'CONTEXT.md');
  if (!fs.existsSync(contextPath)) {
    fs.copyFileSync(path.join(targetDir, 'templates', 'CONTEXT.md'), contextPath);
    console.log('  + Created CONTEXT.md from template');
  }

  const tasksPath = path.join(targetDir, 'TASKS.md');
  if (!fs.existsSync(tasksPath)) {
    fs.copyFileSync(path.join(targetDir, 'templates', 'TASKS.md'), tasksPath);
    console.log('  + Created TASKS.md from template');
  }

  // Copy tool adapters, plugins, and custom modes
  const adapters = ['CLAUDE.md', '.cursorrules', '.windsurfrules', '.clinerules', 'GEMINI.md', '.aider.conf.yml', '.roomodes', 'plugin.json', '.mcp.json'];
  adapters.forEach((adapter) => {
    const src = path.join(rootDir, adapter);
    if (fs.existsSync(src)) {
      fs.copyFileSync(src, path.join(targetDir, adapter));
    }
  });

  // Copy cursor mdc, copilot, continue, zed, cursor mcp, and vscode configs
  const mdcSrc = path.join(rootDir, '.cursor', 'rules', 'agent-constitution.mdc');
  if (fs.existsSync(mdcSrc)) {
    fs.copyFileSync(mdcSrc, path.join(targetDir, '.cursor', 'rules', 'agent-constitution.mdc'));
  }

  const cursorMcpSrc = path.join(rootDir, '.cursor', 'mcp.json');
  if (fs.existsSync(cursorMcpSrc)) {
    fs.copyFileSync(cursorMcpSrc, path.join(targetDir, '.cursor', 'mcp.json'));
  }

  const copilotSrc = path.join(rootDir, '.github', 'copilot-instructions.md');
  if (fs.existsSync(copilotSrc)) {
    fs.copyFileSync(copilotSrc, path.join(targetDir, '.github', 'copilot-instructions.md'));
  }

  const continueSrc = path.join(rootDir, '.continue', 'config.json');
  if (fs.existsSync(continueSrc)) {
    fs.copyFileSync(continueSrc, path.join(targetDir, '.continue', 'config.json'));
  }

  const zedSrc = path.join(rootDir, '.zed', 'settings.json');
  if (fs.existsSync(zedSrc)) {
    fs.copyFileSync(zedSrc, path.join(targetDir, '.zed', 'settings.json'));
  }

  const vscodeSrc = path.join(rootDir, '.vscode');
  if (fs.existsSync(vscodeSrc)) {
    copyRecursiveSync(vscodeSrc, path.join(targetDir, '.vscode'));
  }

  console.log('\n🎉 Agent Constitution installed successfully!');
  console.log('\nNext steps:');
  console.log('  1. Fill in your tech stack and scale horizon in CONTEXT.md');
  console.log('  2. Define your active goals in TASKS.md');
  console.log('  3. Run "npx agent-constitution hooks" to activate pre-commit & pre-push guardrails.');
  console.log('  4. Point your AI agent at AGENTS.md and enjoy disciplined engineering!');
}

function validate() {
  console.log(`🔍 Validating Agent Constitution in: ${targetDir}`);
  const isWindows = process.platform === 'win32';
  const scriptName = isWindows ? 'validate-constitution.ps1' : 'validate-constitution.sh';
  const scriptPath = path.join(targetDir, 'scripts', scriptName);

  if (!fs.existsSync(scriptPath)) {
    console.error(`❌ Validator script not found at ${scriptPath}. Run init first.`);
    process.exit(1);
  }

  try {
    if (isWindows) {
      execSync(`powershell -ExecutionPolicy Bypass -File "${scriptPath}" -TargetDir "${targetDir}"`, { stdio: 'inherit' });
    } else {
      execSync(`bash "${scriptPath}" "${targetDir}"`, { stdio: 'inherit' });
    }
  } catch (err) {
    process.exit(1);
  }
}

function hooks() {
  console.log(`🔗 Configuring Git Hooks in: ${targetDir}`);
  const isWindows = process.platform === 'win32';
  const scriptName = isWindows ? 'setup-hooks.ps1' : 'setup-hooks.sh';
  const scriptPath = path.join(targetDir, 'scripts', scriptName);

  if (!fs.existsSync(scriptPath)) {
    console.error(`❌ Setup script not found at ${scriptPath}. Run init first.`);
    process.exit(1);
  }

  try {
    if (isWindows) {
      execSync(`powershell -ExecutionPolicy Bypass -File "${scriptPath}"`, { stdio: 'inherit', cwd: targetDir });
    } else {
      execSync(`bash "${scriptPath}"`, { stdio: 'inherit', cwd: targetDir });
    }
  } catch (err) {
    process.exit(1);
  }
}

function benchmark() {
  console.log(`📊 Running 100% Empirical Benchmark in: ${targetDir}`);
  const benchScript = path.join(targetDir, 'benchmarks', 'run-benchmarks.js');
  const fallbackScript = path.join(rootDir, 'benchmarks', 'run-benchmarks.js');
  const scriptPath = fs.existsSync(benchScript) ? benchScript : fallbackScript;

  if (!fs.existsSync(scriptPath)) {
    console.error(`❌ Benchmark script not found. Run init first.`);
    process.exit(1);
  }

  try {
    execSync(`node "${scriptPath}" "${targetDir}"`, { stdio: 'inherit' });
  } catch (err) {
    process.exit(1);
  }
}

function runMcp() {
  const mcpServer = path.join(rootDir, 'bin', 'mcp-server.js');
  require('child_process').spawn('node', [mcpServer], { stdio: 'inherit' });
}

function doctor() {
  console.log(`🩺 Running Agent Constitution Doctor in: ${targetDir}\n`);
  let issues = 0;
  let warnings = 0;

  // 1. Check Git repository
  const gitDir = path.join(targetDir, '.git');
  if (fs.existsSync(gitDir)) {
    console.log('  ✅ Git repository detected');
    try {
      const branch = execSync('git rev-parse --abbrev-ref HEAD', { cwd: targetDir, encoding: 'utf8' }).trim();
      if (branch === 'main' || branch === 'master') {
        console.log(`  ⚠️  Warning: Currently on protected branch '${branch}'. Always use feature branches (feat/, fix/) for AI agent work.`);
        warnings++;
      } else {
        console.log(`  ✅ Active branch: '${branch}' (safe for agent development)`);
      }
    } catch (e) {}

    let hooksActive = false;
    try {
      const hooksPath = execSync('git config core.hooksPath', { cwd: targetDir, encoding: 'utf8' }).trim();
      if (hooksPath === '.githooks') hooksActive = true;
    } catch (e) {}
    if (!hooksActive && fs.existsSync(path.join(gitDir, 'hooks', 'pre-push'))) {
      hooksActive = true;
    }

    if (hooksActive) {
      console.log('  ✅ Git safety hooks active (.githooks / pre-push)');
    } else {
      console.log('  ⚠️  Warning: Git safety hooks NOT activated. Run "npx agent-constitution hooks" to prevent unwanted pushes.');
      warnings++;
    }
  } else {
    console.log('  ⚠️  Warning: No .git directory detected. Git guardrails require a git repository.');
    warnings++;
  }

  // 2. Check Core files
  const coreFiles = ['AGENTS.md', 'CONTEXT.md', 'TASKS.md'];
  coreFiles.forEach((file) => {
    const filePath = path.join(targetDir, file);
    if (fs.existsSync(filePath)) {
      console.log(`  ✅ Found ${file}`);
    } else {
      console.log(`  ❌ Missing ${file}. Run "npx agent-constitution init" to bootstrap.`);
      issues++;
    }
  });

  // 3. Check CONTEXT.md and TASKS.md population
  const contextPath = path.join(targetDir, 'CONTEXT.md');
  if (fs.existsSync(contextPath)) {
    const content = fs.readFileSync(contextPath, 'utf8');
    if (content.includes('<short title>') || content.includes('<language(s)>')) {
      console.log('  ⚠️  Warning: CONTEXT.md contains raw template placeholders. Update tech stack & Do-Not-Touch list.');
      warnings++;
    } else {
      console.log('  ✅ CONTEXT.md is customized with project context');
    }
  }

  // 4. Check AI Tool Adapters
  const adapters = ['CLAUDE.md', '.cursorrules', '.windsurfrules', '.clinerules', 'GEMINI.md', '.github/copilot-instructions.md', '.aider.conf.yml', '.continue/config.json', '.zed/settings.json'];
  const foundAdapters = adapters.filter((a) => fs.existsSync(path.join(targetDir, a)));
  if (foundAdapters.length > 0) {
    console.log(`  ✅ Configured AI Adapters (${foundAdapters.length}): ${foundAdapters.slice(0, 4).join(', ')}${foundAdapters.length > 4 ? '...' : ''}`);
  } else {
    console.log('  ❌ No AI tool adapters found. Run "npx agent-constitution init" to install.');
    issues++;
  }

  // 5. Check MCP Configuration
  const hasMcp = fs.existsSync(path.join(targetDir, '.mcp.json')) || fs.existsSync(path.join(targetDir, '.cursor', 'mcp.json'));
  if (hasMcp) {
    console.log('  ✅ MCP Server configuration active (.mcp.json / .cursor/mcp.json)');
  } else {
    console.log('  ⚠️  Warning: No MCP server auto-discovery config found.');
    warnings++;
  }

  console.log('\n────────────────────────────────────────────────────────────────');
  if (issues === 0 && warnings === 0) {
    console.log('🎉 Doctor Verdict: PERFECT HEALTH! Repository is 100% fortified for AI development.');
  } else if (issues === 0) {
    console.log(`💡 Doctor Verdict: GOOD HEALTH with ${warnings} minor warning(s). Review recommendations above.`);
  } else {
    console.log(`❌ Doctor Verdict: FOUND ${issues} CRITICAL ISSUE(S). Run "npx agent-constitution init" to resolve.`);
    process.exit(1);
  }
}

function diffGuard() {
  console.log(`🛡️ Running Autonomous Diff Guard in: ${targetDir}\n`);

  try {
    execSync('git rev-parse --is-inside-work-tree', { cwd: targetDir, stdio: 'ignore' });
  } catch (err) {
    console.log('⚠️ Git is not initialized. Skipping diff inspection.');
    return;
  }

  let rawDiff = '';
  try {
    rawDiff = execSync('git diff HEAD', { cwd: targetDir, encoding: 'utf8' });
  } catch (err) {
    try {
      rawDiff = execSync('git diff', { cwd: targetDir, encoding: 'utf8' });
    } catch (e) {
      rawDiff = '';
    }
  }

  let changedFiles = [];
  try {
    const statusOutput = execSync('git status --porcelain', { cwd: targetDir, encoding: 'utf8' });
    changedFiles = statusOutput
      .split('\n')
      .map(line => line.trim().slice(3))
      .filter(Boolean);
  } catch (e) {}

  console.log(`  📁 Changed Files Count: ${changedFiles.length}`);

  let violations = [];

  const maxFilesArg = rawArgs.find(a => a.startsWith('--max-files='));
  const maxFiles = maxFilesArg ? parseInt(maxFilesArg.split('=')[1], 10) : 15;
  const allowLarge = rawArgs.includes('--allow-large-diff');

  // Check 1: Blast Radius File Count
  if (changedFiles.length > maxFiles && !allowLarge) {
    violations.push(`Blast Radius Alert: ${changedFiles.length} files modified in a single turn (limit: ${maxFiles}). Minimal Viable Diff (MVD) mandates surgical containment. Use --max-files=<N> or --allow-large-diff if this is a planned multi-file milestone.`);
  }

  // Check 2: Do-Not-Touch files from CONTEXT.md
  const contextPath = path.join(targetDir, 'CONTEXT.md');
  if (fs.existsSync(contextPath)) {
    const contextContent = fs.readFileSync(contextPath, 'utf8');
    const dntMatch = contextContent.match(/## Do-Not-Touch List\s*([\s\S]*?)(?=##|$)/);
    if (dntMatch) {
      const dntLines = dntMatch[1].split('\n').map(l => l.replace(/^[-*\s`]+/, '').trim()).filter(Boolean);
      for (const file of changedFiles) {
        for (const dnt of dntLines) {
          if (dnt && dnt.length > 2 && file.includes(dnt)) {
            violations.push(`Do-Not-Touch Violation: '${file}' matches protected pattern '${dnt}' in CONTEXT.md.`);
          }
        }
      }
    }
  }

  // Check 3: Placeholder tokens in added lines
  const addedLines = rawDiff
    .split('\n')
    .filter(l => l.startsWith('+') && !l.startsWith('+++'));

  const placeholderPatterns = [
    { pattern: /\bTODO\b/i, desc: 'Unimplemented TODO comment' },
    { pattern: /\bFIXME\b/i, desc: 'FIXME marker' },
    { pattern: /\bthrow new Error\(['"]Not implemented['"]\)/i, desc: 'Stubbed exception' },
    { pattern: /^\+\s*pass\s*(#.*)?$/, desc: 'Python empty pass stub' }
  ];

  for (const line of addedLines) {
    for (const { pattern, desc } of placeholderPatterns) {
      if (pattern.test(line)) {
        violations.push(`Placeholder Detected (${desc}): "${line.trim().slice(0, 60)}"`);
        break;
      }
    }
  }

  // Check 4: Secret Leaks
  const secretPatterns = [
    { pattern: /AKIA[0-9A-Z]{16}/, desc: 'AWS Access Key ID' },
    { pattern: /ghp_[0-9a-zA-Z]{36}/, desc: 'GitHub Personal Access Token' },
    { pattern: /sk-[a-zA-Z0-9]{32,}/, desc: 'OpenAI Secret API Key' },
    { pattern: /-----BEGIN (RSA|EC|OPENSSH|DSA|PGP)? ?PRIVATE KEY-----/, desc: 'Private Encryption Key' }
  ];

  for (const line of addedLines) {
    for (const { pattern, desc } of secretPatterns) {
      if (pattern.test(line)) {
        violations.push(`SECRET LEAK PREVENTED (${desc}) in diff!`);
        break;
      }
    }
  }

  if (violations.length > 0) {
    console.error('\n❌ Diff Guard REJECTED the active changes with the following violations:\n');
    violations.forEach(v => console.error(`  - ❌ ${v}`));
    console.error('\nResolve these violations to satisfy the Agent Constitution.\n');
    process.exit(1);
  }

  console.log('  ✅ Zero placeholder tokens detected');
  console.log('  ✅ Zero leaked credentials or secrets detected');
  console.log('  ✅ Zero Do-Not-Touch boundary violations detected');
  console.log('\n🎉 Diff Guard Verdict: PASSED! Diff is 100% compliant with Minimal Viable Diff standards.\n');
}

function printHelp() {
  console.log(`
🧠 Agent Constitution CLI

Commands:
  npx agent-constitution init [dir]       Install Agent Constitution into a repository
  npx agent-constitution validate [dir]   Validate repository compliance
  npx agent-constitution benchmark [dir]  Run 100% empirical benchmark stress tests
  npx agent-constitution hooks [dir]      Activate pre-commit and pre-push git guardrails
  npx agent-constitution doctor [dir]     Diagnose repository health and AI readiness
  npx agent-constitution diff-guard [dir] Inspect git diff for placeholders, leaks, and blast radius
  npx agent-constitution mcp              Launch the Model Context Protocol (MCP) server
  npx agent-constitution help             Show this help menu
`);
}

switch (command) {
  case 'init':
    init();
    break;
  case 'validate':
    validate();
    break;
  case 'benchmark':
    benchmark();
    break;
  case 'hooks':
    hooks();
    break;
  case 'doctor':
    doctor();
    break;
  case 'diff-guard':
    diffGuard();
    break;
  case 'mcp':
    runMcp();
    break;
  case 'help':
  case '--help':
  case '-h':
  default:
    printHelp();
    break;
}
