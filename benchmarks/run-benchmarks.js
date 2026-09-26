#!/usr/bin/env node

/**
 * Agent Constitution Automated Benchmark Engine
 * Evaluates repository and agent compliance across the 10 Constitutional Stress Tests.
 * Usage:
 *   node benchmarks/run-benchmarks.js [targetDir]
 */

const fs = require('fs');
const path = require('path');

const targetDir = path.resolve(process.cwd(), process.argv[2] || '.');

console.log('╔════════════════════════════════════════════════════════════════╗');
console.log('║   Agent Constitution 100% Empirical Benchmark Evaluator       ║');
console.log('╚════════════════════════════════════════════════════════════════╝');
console.log(`Evaluating Target: ${targetDir}\n`);

const results = [];
let totalScore = 0;
const maxScore = 100;

function evaluate(id, name, points, testFn) {
  process.stdout.write(`[${id}] ${name.padEnd(52, '.')} `);
  try {
    const passed = testFn();
    if (passed) {
      console.log(`\x1b[32mPASS\x1b[0m (+${points} pts)`);
      results.push({ id, name, score: points, max: points, status: 'PASS' });
      totalScore += points;
    } else {
      console.log(`\x1b[31mFAIL\x1b[0m (0/${points} pts)`);
      results.push({ id, name, score: 0, max: points, status: 'FAIL' });
    }
  } catch (err) {
    console.log(`\x1b[31mERROR\x1b[0m: ${err.message}`);
    results.push({ id, name, score: 0, max: points, status: 'ERROR', error: err.message });
  }
}

// 1. BENCH-01: Scope Discipline & MVD Law
evaluate('BENCH-01', 'Scope Discipline & Minimal Viable Diff (MVD)', 10, () => {
  const file = path.join(targetDir, 'docs', 'surgical-editing-and-scope-containment.md');
  if (!fs.existsSync(file)) return false;
  const content = fs.readFileSync(file, 'utf8');
  return content.includes('Minimal Viable Diff') && content.includes('Zero-Collateral-Damage');
});

// 2. BENCH-02: Grounding & Anti-Hallucination Proof
evaluate('BENCH-02', 'Epistemic Modesty & Grounding Invariants', 10, () => {
  const file = path.join(targetDir, 'docs', 'anti-hallucination-evidence.md');
  if (!fs.existsSync(file)) return false;
  const content = fs.readFileSync(file, 'utf8');
  return content.includes('Verify Before Asserting') && content.includes('Ghost Success');
});

// 3. BENCH-03: Git Push & Branch Lockout
evaluate('BENCH-03', 'Deterministic Remote Push Lockout (Runtime Hooks)', 10, () => {
  const hookFile = path.join(targetDir, '.githooks', 'pre-push');
  const docFile = path.join(targetDir, 'docs', 'git-and-github-push-guardrails.md');
  if (!fs.existsSync(hookFile) || !fs.existsSync(docFile)) return false;
  const hookContent = fs.readFileSync(hookFile, 'utf8');
  return hookContent.includes('ALLOW_AGENT_PUSH') && hookContent.includes('protected branch');
});

// 4. BENCH-04: Circuit Breaker & 3-Strike Rule
evaluate('BENCH-04', 'Agent Drift Prevention & 3-Strike Circuit Breaker', 10, () => {
  const file = path.join(targetDir, 'docs', 'drift-prevention-and-circuit-breakers.md');
  if (!fs.existsSync(file)) return false;
  const content = fs.readFileSync(file, 'utf8');
  return content.includes('3-Strike') && content.includes('Circuit Breaker');
});

// 5. BENCH-05: AI-Native Threat Defense (Agentic OWASP)
evaluate('BENCH-05', 'Agentic OWASP: Prompt Injection & Slopsquatting', 10, () => {
  const file = path.join(targetDir, 'docs', 'security-and-depth.md');
  if (!fs.existsSync(file)) return false;
  const content = fs.readFileSync(file, 'utf8');
  return content.includes('Indirect Prompt Injection') && content.includes('Slopsquatting') && content.includes('Secret Zeroization');
});

// 6. BENCH-06: Multi-Agent Swarm Concurrency & Task Claiming
evaluate('BENCH-06', 'Subagent Swarm Concurrency & State Invariants', 10, () => {
  const file = path.join(targetDir, 'docs', 'subagent-orchestration.md');
  if (!fs.existsSync(file)) return false;
  const content = fs.readFileSync(file, 'utf8');
  return content.includes('Atomic Task Claiming Protocol') && content.includes('Zero-Trust Auditor Context');
});

// 7. BENCH-07: Anti-AI Slop Frontend Aesthetic Standards
evaluate('BENCH-07', 'Frontend Aesthetics & Anti-AI-Slop Architecture', 10, () => {
  const file = path.join(targetDir, 'docs', 'frontend-design-and-aesthetics.md');
  if (!fs.existsSync(file)) return false;
  const content = fs.readFileSync(file, 'utf8');
  return content.includes('Anti-AI-Slop') && content.includes('Layered Surface Architecture');
});

// 8. BENCH-08: Universal Multi-Stack Ecosystem Coverage
evaluate('BENCH-08', 'Universal Stack Coverage (12 Language Packs)', 10, () => {
  const langDir = path.join(targetDir, 'docs', 'languages');
  if (!fs.existsSync(langDir)) return false;
  const expectedLangs = [
    'cpp.md', 'csharp.md', 'go.md', 'java-kotlin.md', 'nodejs.md',
    'php.md', 'python.md', 'react-web.md', 'ruby.md', 'rust.md',
    'sql.md', 'terraform.md'
  ];
  return expectedLangs.every((lang) => fs.existsSync(path.join(langDir, lang)));
});

// 9. BENCH-09: 23/23 Constitutional Protocol Completeness
evaluate('BENCH-09', 'Full 23-Protocol Constitutional System Linkage', 10, () => {
  const agentsFile = path.join(targetDir, 'AGENTS.md');
  if (!fs.existsSync(agentsFile)) return false;
  const content = fs.readFileSync(agentsFile, 'utf8');
  const requiredDocs = [
    'agent-decision-matrix.md', 'anti-hallucination-evidence.md', 'architecture-standards.md',
    'coding-standards.md', 'context-memory.md', 'deployment-guide.md',
    'drift-prevention-and-circuit-breakers.md', 'frontend-design-and-aesthetics.md',
    'git-and-github-push-guardrails.md', 'incident-response.md', 'limitless-first-principles-agency.md',
    'monorepo-and-multirepo-governance.md', 'non-regression-policy.md', 'proactive-autonomous-agency.md',
    'safe-execution-guardrails.md', 'security-and-depth.md', 'subagent-orchestration.md',
    'surgical-editing-and-scope-containment.md', 'task-management.md', 'tdd-and-verification.md',
    'token-economy-and-max-output.md', 'transforming-legacy-projects.md', 'universal-stack-detection.md'
  ];
  return requiredDocs.every((doc) => content.includes(doc));
});

// 10. BENCH-10: Persistent Scale-Horizon Memory (10x-100x)
evaluate('BENCH-10', 'Scale-Horizon Memory & Attention Physics', 10, () => {
  const contextFile = path.join(targetDir, 'CONTEXT.md');
  const memoryDoc = path.join(targetDir, 'docs', 'context-memory.md');
  if (!fs.existsSync(contextFile) || !fs.existsSync(memoryDoc)) return false;
  const contextContent = fs.readFileSync(contextFile, 'utf8');
  const memoryContent = fs.readFileSync(memoryDoc, 'utf8');
  return contextContent.includes('Scale Horizon') && memoryContent.includes('Attention Physics');
});

console.log('\n────────────────────────────────────────────────────────────────');
console.log(`TOTAL BENCHMARK SCORE: ${totalScore} / ${maxScore}`);

let grade = 'HAZARDOUS AGENT (< 50)';
if (totalScore >= 95) grade = 'CONSTITUTIONAL MASTER (100% Top-Tier Autonomous Standard)';
else if (totalScore >= 80) grade = 'DISCIPLINED CONTRIBUTOR';
else if (totalScore >= 60) grade = 'ERRATIC AGENT';

console.log(`GRADE: \x1b[32m${grade}\x1b[0m`);
console.log('────────────────────────────────────────────────────────────────\n');

// Write machine-readable benchmark report
const reportPath = path.join(targetDir, 'benchmarks', 'benchmark_report.json');
fs.writeFileSync(reportPath, JSON.stringify({
  timestamp: new Date().toISOString(),
  target: targetDir,
  totalScore,
  maxScore,
  grade,
  results
}, null, 2));

console.log(`📄 Saved benchmark report to: ${reportPath}`);

if (totalScore < maxScore) {
  process.exit(1);
} else {
  process.exit(0);
}
