/**
 * Install Screen - Full Installation v5.0.0
 * Complete with all workflow step files
 */

import * as readline from 'readline';
import chalk from 'chalk';
import ora from 'ora';
import fs from 'fs';
import path from 'path';
import axios from 'axios';

const VERSION = '5.0.0';
const KD_REPO = 'MoonWIRaja/Kracked_Skills';
const KD_RAW_URL = `https://raw.githubusercontent.com/${KD_REPO}/main`;
const KD_DIR = '.kracked';

const AI_TOOLS = [
  { key: '1', name: 'Claude Code', value: 'claude-code' },
  { key: '2', name: 'Cursor', value: 'cursor' },
  { key: '3', name: 'Cline', value: 'cline' },
  { key: '4', name: 'Kilo Code', value: 'kilocode' },
  { key: '5', name: 'Roo Code', value: 'roo-code' },
  { key: '6', name: 'Antigravity', value: 'antigravity' },
  { key: 'A', name: 'All', value: 'all' },
];

const LANGUAGES = [
  { key: '1', name: 'English (Default)', value: 'EN' },
  { key: '2', name: 'Bahasa Melayu', value: 'MS' },
  { key: 'C', name: 'Custom (type your own)', value: 'custom' },
];

// Full command list
const COMMANDS = [
  'KD', 'KD-analyze', 'KD-api-design', 'KD-architecture', 'KD-brainstorm',
  'KD-github-read', 'KD-build-agent', 'KD-build-module', 'KD-build-workflow',
  'KD-code-review', 'KD-deployment-plan', 'KD-dev-story', 'KD-doc-project',
  'KD-domain-research', 'KD-epics-and-stories', 'KD-fix-course', 'KD-game-arch',
  'KD-game-architect', 'KD-game-brainstorm', 'KD-game-brief', 'KD-game-designer',
  'KD-game-dev', 'KD-game-dev-story', 'KD-game-gdd', 'KD-game-narrative',
  'KD-game-qa', 'KD-game-scrum-master', 'KD-game-solo', 'KD-game-story',
  'KD-game-test-auto', 'KD-game-test-design', 'KD-game-test-perf',
  'KD-game-test-plan', 'KD-game-writer', 'KD-help', 'KD-idea-coach',
  'KD-idea-design-thinking', 'KD-idea-innovation', 'KD-idea-presenter',
  'KD-idea-problem-solving', 'KD-idea-solver', 'KD-idea-storyteller',
  'KD-idea-storytelling', 'KD-idea-strategist', 'KD-kickoff', 'KD-market-research',
  'KD-party-mode', 'KD-prd', 'KD-product-brief', 'KD-project-context',
  'KD-qa-automate', 'KD-quick-dev', 'KD-quick-spec', 'KD-refactor',
  'KD-retrospective', 'KD-role-analyst', 'KD-role-architect', 'KD-role-bmad-master',
  'KD-role-data-scientist', 'KD-role-dba', 'KD-role-dev', 'KD-role-devops',
  'KD-role-mobile-dev', 'KD-role-pm', 'KD-role-qa', 'KD-role-release-manager',
  'KD-role-scrum-master', 'KD-role-security', 'KD-role-solo-dev', 'KD-role-tech-writer',
  'KD-role-ux', 'KD-scale-review', 'KD-sprint-planning', 'KD-sprint-status',
  'KD-status', 'KD-swarm', 'KD-tech-research', 'KD-test', 'KD-test-arch',
  'KD-test-atdd', 'KD-test-automate', 'KD-test-ci', 'KD-test-design',
  'KD-test-frame', 'KD-test-nfr', 'KD-test-sprite', 'KD-test-teach',
  'KD-test-trace', 'KD-tool-selector', 'KD-ux-design', 'KD-validate',
  'KD-validate-agent', 'KD-validate-workflow', 'KD-version-check'
];

function ask(rl, question) {
  return new Promise((resolve) => {
    rl.question(question, (answer) => resolve(answer.trim()));
  });
}

export async function installKD(options = {}) {
  console.log(chalk.cyan('  ───────────────────────────────────────────'));
  console.log(chalk.white('  📦 INSTALL KD v' + VERSION));
  console.log(chalk.cyan('  ───────────────────────────────────────────'));
  console.log();

  const workDir = options.installDir || process.cwd();
  const kdPath = path.join(workDir, KD_DIR);
  
  if (fs.existsSync(kdPath)) {
    if (options.force) {
      console.log(chalk.yellow('  ⚠️  Existing installation found. Overwriting...'));
      fs.rmSync(kdPath, { recursive: true, force: true });
    } else {
      console.log(chalk.red('  ❌ KD is already installed.'));
      console.log(chalk.gray('  Use --force to overwrite.'));
      return;
    }
  }

  const rl = readline.createInterface({ input: process.stdin, output: process.stdout });

  try {
    let selectedTools = options.target ? options.target.split(',').map(t => t.trim()) : [];
    
    if (!options.target && !options.nonInteractive) {
      console.log(chalk.white('  Step 1 of 3: Select AI Tool(s)'));
      for (const tool of AI_TOOLS) console.log(chalk.cyan(`  [${tool.key}]`) + ` ${tool.name}`);
      console.log();
      const answer = await ask(rl, chalk.white('  Select AI tool(s): '));
      if (answer.toUpperCase() === 'A') {
        selectedTools = AI_TOOLS.filter(t => t.value !== 'all').map(t => t.value);
      } else {
        for (const key of answer.split(',').map(k => k.trim().toUpperCase())) {
          const tool = AI_TOOLS.find(t => t.key.toUpperCase() === key);
          if (tool && tool.value !== 'all') selectedTools.push(tool.value);
        }
      }
      if (!selectedTools.length) selectedTools = ['claude-code'];
    } else if (!selectedTools.length) {
      selectedTools = ['claude-code'];
    }

    let language = options.lang ? options.lang.toUpperCase() : 'EN';
    if (!options.lang && !options.nonInteractive) {
      console.log();
      console.log(chalk.white('  Step 2 of 3: Select Language'));
      for (const lang of LANGUAGES) console.log(chalk.cyan(`  [${lang.key}]`) + ` ${lang.name}`);
      const answer = await ask(rl, chalk.white('  Select language: '));
      const lang = LANGUAGES.find(l => l.key.toUpperCase() === answer.toUpperCase());
      if (lang) language = lang.value === 'custom' ? await ask(rl, '  Enter language: ') : lang.value;
    }

    if (!options.nonInteractive) {
      console.log();
      console.log(chalk.white('  Step 3 of 3: Confirm'));
      console.log(chalk.cyan(`  Directory: ${workDir}/${KD_DIR}`));
      console.log(chalk.cyan(`  Target(s): ${selectedTools.join(', ')}`));
      console.log(chalk.cyan(`  Language:  ${language}`));
      const confirm = await ask(rl, chalk.white('\n  Proceed? [Y/n]: '));
      if (confirm.toLowerCase() === 'n') { console.log(chalk.yellow('  Cancelled.')); rl.close(); return; }
    }

    rl.close();
    console.log();
    const spinner = ora('Installing...').start();

    spinner.text = 'Creating directories...';
    createDirectories(workDir);

    spinner.text = 'Downloading KD files...';
    await downloadAllFiles(workDir);

    spinner.text = 'Creating config...';
    createConfig(workDir, selectedTools, language);

    spinner.text = 'Initializing status...';
    initStatus(workDir, language);

    for (const tool of selectedTools) {
      spinner.text = `Setting up ${tool}...`;
      await setupAdapter(workDir, tool);
    }

    spinner.succeed('Installation complete!');
    showSuccess(workDir, selectedTools, language);

  } catch (error) {
    rl.close();
    throw error;
  }
}

function createDirectories(workDir) {
  const dirs = [
    KD_DIR, `${KD_DIR}/prompts`, `${KD_DIR}/prompts/roles`, `${KD_DIR}/prompts/stages`,
    `${KD_DIR}/prompts/multi-agent`, `${KD_DIR}/templates`, `${KD_DIR}/checklists`,
    `${KD_DIR}/workflows`, `${KD_DIR}/config`, `${KD_DIR}/config/language`,
    `${KD_DIR}/config/agents`, `${KD_DIR}/testsprite`, `${KD_DIR}/tool-selector`,
    `${KD_DIR}/git-integration`, `${KD_DIR}/analytics`, `${KD_DIR}/exporters`,
    `${KD_DIR}/artifacts`, `${KD_DIR}/version-checker`, `${KD_DIR}/core`,
    `${KD_DIR}/core/indexes`, `${KD_DIR}/skills`, `${KD_DIR}/github-reader`,
    `${KD_DIR}/KD_output`, `${KD_DIR}/KD_output/status`, `${KD_DIR}/KD_output/brainstorm`,
    `${KD_DIR}/KD_output/product-brief`, `${KD_DIR}/KD_output/PRD`,
    `${KD_DIR}/KD_output/architecture`, `${KD_DIR}/KD_output/epics-and-stories`,
    `${KD_DIR}/KD_output/code-review`, `${KD_DIR}/KD_output/deployment`,
    `${KD_DIR}/KD_output/release`, `${KD_DIR}/KD_output/decisions`, `${KD_DIR}/KD_output/risks`,
    `${KD_DIR}/KD_output/testsprite`, `${KD_DIR}/KD_output/testsprite/screenshots`,
    `${KD_DIR}/KD_output/testsprite/videos`, `${KD_DIR}/KD_output/github-reader`,
    `${KD_DIR}/agents`, `${KD_DIR}/gates`, `${KD_DIR}/knowledge`,
    `${KD_DIR}/knowledge/patterns`, `${KD_DIR}/knowledge/standards`,
    `${KD_DIR}/workflows/discovery/analyze`, `${KD_DIR}/workflows/discovery/brainstorm`,
    `${KD_DIR}/workflows/discovery/domain-research`,
    `${KD_DIR}/workflows/planning/prd-create`, `${KD_DIR}/workflows/planning/prd-validate`,
    `${KD_DIR}/workflows/planning/epics-stories`,
    `${KD_DIR}/workflows/architecture/design`, `${KD_DIR}/workflows/architecture/tech-research`,
    `${KD_DIR}/workflows/architecture/api-design`,
    `${KD_DIR}/workflows/implementation/story-generate`, `${KD_DIR}/workflows/implementation/dev-story`,
    `${KD_DIR}/workflows/implementation/code-review`, `${KD_DIR}/workflows/implementation/refactor`,
    `${KD_DIR}/workflows/quality/test-design`, `${KD_DIR}/workflows/quality/test-execute`,
    `${KD_DIR}/workflows/quality/security-audit`,
    `${KD_DIR}/workflows/deployment/plan`, `${KD_DIR}/workflows/deployment/execute`,
    `${KD_DIR}/workflows/release/notes`, `${KD_DIR}/workflows/release/retrospective`,
  ];
  for (const dir of dirs) {
    const p = path.join(workDir, dir);
    if (!fs.existsSync(p)) fs.mkdirSync(p, { recursive: true });
  }
}

async function downloadFile(url, dest) {
  try {
    const res = await axios.get(url, { timeout: 15000 });
    fs.writeFileSync(dest, res.data);
    return true;
  } catch { return false; }
}

async function downloadAllFiles(workDir) {
  const base = `${KD_RAW_URL}/src`;
  const files = [];

  // Prompts
  files.push(
    { url: `${base}/prompts/system-prompt.md`, dest: `${KD_DIR}/prompts/system-prompt.md` },
    { url: `${base}/prompts/role-switcher.md`, dest: `${KD_DIR}/prompts/role-switcher.md` },
    { url: `${base}/prompts/handoff-protocol.md`, dest: `${KD_DIR}/prompts/handoff-protocol.md` },
    { url: `${base}/prompts/conflict-resolution.md`, dest: `${KD_DIR}/prompts/conflict-resolution.md` },
  );

  // Roles - SKIPPED (replaced by agents/*.agent.yaml in v5.0.0)

  // Stages (11 files)
  for (const s of ['_stage-template', 'discovery', 'brainstorm', 'planning', 'requirements', 'architecture', 'implementation', 'quality', 'testing', 'deployment', 'release']) {
    files.push({ url: `${base}/prompts/stages/${s}.md`, dest: `${KD_DIR}/prompts/stages/${s}.md` });
  }

  // Multi-Agent
  for (const m of ['party-mode', 'agent-swarm', 'confidence-scoring', 'conflict-resolution', 'aggregation']) {
    files.push({ url: `${base}/prompts/multi-agent/${m}.md`, dest: `${KD_DIR}/prompts/multi-agent/${m}.md` });
  }

  // Templates
  for (const t of ['status', 'product-brief', 'prd', 'architecture', 'story-card', 'deployment-plan', 'release-notes', 'decision-log', 'risk-register', 'tech-stack', 'phase-gate-report']) {
    files.push({ url: `${base}/templates/${t}.md`, dest: `${KD_DIR}/templates/${t}.md` });
  }

  // Checklists
  for (const c of ['stage-completion', 'decision-validation', 'checkpoint-approval', 'security-audit', 'pre-deployment', 'code-quality']) {
    files.push({ url: `${base}/checklists/${c}.md`, dest: `${KD_DIR}/checklists/${c}.md` });
  }

  // Workflows main
  files.push(
    { url: `${base}/workflows/main.md`, dest: `${KD_DIR}/workflows/main.md` },
    { url: `${base}/workflows/quick-start.md`, dest: `${KD_DIR}/workflows/quick-start.md` },
    { url: `${base}/workflows/full-product.md`, dest: `${KD_DIR}/workflows/full-product.md` },
    { url: `${base}/workflows/maintenance.md`, dest: `${KD_DIR}/workflows/maintenance.md` },
  );

  // WORKFLOW STEPS - Discovery/analyze
  for (const s of ['workflow', 'step-01-orient', 'step-02-interview', 'step-03-research', 'step-04-synthesize', 'step-05-brief']) {
    files.push({ url: `${base}/workflows/discovery/analyze/${s}.md`, dest: `${KD_DIR}/workflows/discovery/analyze/${s}.md` });
  }
  // Discovery/brainstorm
  for (const s of ['workflow', 'step-01-setup', 'step-02-ideation', 'step-03-evaluation', 'step-04-summary']) {
    files.push({ url: `${base}/workflows/discovery/brainstorm/${s}.md`, dest: `${KD_DIR}/workflows/discovery/brainstorm/${s}.md` });
  }
  // Discovery/domain-research
  for (const s of ['workflow', 'step-01-scope', 'step-02-research', 'step-03-report']) {
    files.push({ url: `${base}/workflows/discovery/domain-research/${s}.md`, dest: `${KD_DIR}/workflows/discovery/domain-research/${s}.md` });
  }
  // Planning/prd-create
  for (const s of ['workflow', 'step-01-orient', 'step-02-personas', 'step-03-requirements', 'step-04-nfr', 'step-05-epics', 'step-06-mvp', 'step-07-metrics', 'step-08-validate']) {
    files.push({ url: `${base}/workflows/planning/prd-create/${s}.md`, dest: `${KD_DIR}/workflows/planning/prd-create/${s}.md` });
  }
  // Planning/prd-validate
  for (const s of ['workflow', 'step-01-check', 'step-02-score', 'step-03-report']) {
    files.push({ url: `${base}/workflows/planning/prd-validate/${s}.md`, dest: `${KD_DIR}/workflows/planning/prd-validate/${s}.md` });
  }
  // Planning/epics-stories
  for (const s of ['workflow', 'step-01-read-prd', 'step-02-define-epics', 'step-03-write-stories', 'step-04-sequence', 'step-05-validate']) {
    files.push({ url: `${base}/workflows/planning/epics-stories/${s}.md`, dest: `${KD_DIR}/workflows/planning/epics-stories/${s}.md` });
  }
  // Architecture/design
  for (const s of ['workflow', 'step-01-orient', 'step-02-tech-stack', 'step-03-database', 'step-04-api', 'step-05-security', 'step-06-validate']) {
    files.push({ url: `${base}/workflows/architecture/design/${s}.md`, dest: `${KD_DIR}/workflows/architecture/design/${s}.md` });
  }
  // Architecture/tech-research
  for (const s of ['workflow', 'step-01-identify', 'step-02-compare', 'step-03-recommend']) {
    files.push({ url: `${base}/workflows/architecture/tech-research/${s}.md`, dest: `${KD_DIR}/workflows/architecture/tech-research/${s}.md` });
  }
  // Architecture/api-design
  for (const s of ['workflow', 'step-01-resources', 'step-02-endpoints', 'step-03-contracts', 'step-04-validate']) {
    files.push({ url: `${base}/workflows/architecture/api-design/${s}.md`, dest: `${KD_DIR}/workflows/architecture/api-design/${s}.md` });
  }
  // Implementation/story-generate
  for (const s of ['workflow', 'step-01-read-prd', 'step-02-identify-stories', 'step-03-sequence', 'step-04-generate-files', 'step-05-validate']) {
    files.push({ url: `${base}/workflows/implementation/story-generate/${s}.md`, dest: `${KD_DIR}/workflows/implementation/story-generate/${s}.md` });
  }
  // Implementation/dev-story
  for (const s of ['workflow', 'step-01-orient', 'step-02-tdd-setup', 'step-03-implement', 'step-04-test', 'step-05-handoff']) {
    files.push({ url: `${base}/workflows/implementation/dev-story/${s}.md`, dest: `${KD_DIR}/workflows/implementation/dev-story/${s}.md` });
  }
  // Implementation/code-review
  for (const s of ['workflow', 'step-01-read-story', 'step-02-review-code', 'step-03-security-check', 'step-04-report']) {
    files.push({ url: `${base}/workflows/implementation/code-review/${s}.md`, dest: `${KD_DIR}/workflows/implementation/code-review/${s}.md` });
  }
  // Implementation/refactor
  for (const s of ['workflow', 'step-01-analyze', 'step-02-plan', 'step-03-execute']) {
    files.push({ url: `${base}/workflows/implementation/refactor/${s}.md`, dest: `${KD_DIR}/workflows/implementation/refactor/${s}.md` });
  }
  // Quality/test-design
  for (const s of ['workflow', 'step-01-strategy', 'step-02-unit', 'step-03-integration', 'step-04-e2e']) {
    files.push({ url: `${base}/workflows/quality/test-design/${s}.md`, dest: `${KD_DIR}/workflows/quality/test-design/${s}.md` });
  }
  // Quality/test-execute
  for (const s of ['workflow', 'step-01-run', 'step-02-analyze', 'step-03-report']) {
    files.push({ url: `${base}/workflows/quality/test-execute/${s}.md`, dest: `${KD_DIR}/workflows/quality/test-execute/${s}.md` });
  }
  // Quality/security-audit
  for (const s of ['workflow', 'step-01-surface', 'step-02-threats', 'step-03-test', 'step-04-report']) {
    files.push({ url: `${base}/workflows/quality/security-audit/${s}.md`, dest: `${KD_DIR}/workflows/quality/security-audit/${s}.md` });
  }
  // Deployment/plan
  for (const s of ['workflow', 'step-01-env-setup', 'step-02-cicd', 'step-03-monitoring', 'step-04-rollback', 'step-05-validate']) {
    files.push({ url: `${base}/workflows/deployment/plan/${s}.md`, dest: `${KD_DIR}/workflows/deployment/plan/${s}.md` });
  }
  // Deployment/execute
  for (const s of ['workflow', 'step-01-pre-check', 'step-02-deploy', 'step-03-verify']) {
    files.push({ url: `${base}/workflows/deployment/execute/${s}.md`, dest: `${KD_DIR}/workflows/deployment/execute/${s}.md` });
  }
  // Release/notes
  for (const s of ['workflow', 'step-01-gather', 'step-02-write', 'step-03-validate']) {
    files.push({ url: `${base}/workflows/release/notes/${s}.md`, dest: `${KD_DIR}/workflows/release/notes/${s}.md` });
  }
  // Release/retrospective
  for (const s of ['workflow', 'step-01-collect', 'step-02-analyze', 'step-03-action-items']) {
    files.push({ url: `${base}/workflows/release/retrospective/${s}.md`, dest: `${KD_DIR}/workflows/release/retrospective/${s}.md` });
  }

  // Config
  files.push(
    { url: `${base}/config/settings-schema.json`, dest: `${KD_DIR}/config/settings-schema.json` },
    { url: `${base}/config/defaults.json`, dest: `${KD_DIR}/config/defaults.json` },
    { url: `${base}/config/language/en.json`, dest: `${KD_DIR}/config/language/en.json` },
    { url: `${base}/config/language/ms.json`, dest: `${KD_DIR}/config/language/ms.json` },
    { url: `${base}/config/agents/personalities.json`, dest: `${KD_DIR}/config/agents/personalities.json` },
    { url: `${base}/config/agents/names.json`, dest: `${KD_DIR}/config/agents/names.json` },
    { url: `${base}/config/scale-taxonomy.yaml`, dest: `${KD_DIR}/config/scale-taxonomy.yaml` },
  );

  // Core
  files.push(
    { url: `${base}/core/core.md`, dest: `${KD_DIR}/core/core.md` },
    { url: `${base}/core/indexes/skills-index.md`, dest: `${KD_DIR}/core/indexes/skills-index.md` },
    { url: `${base}/core/indexes/commands-index.md`, dest: `${KD_DIR}/core/indexes/commands-index.md` },
    { url: `${base}/core/indexes/tools-index.md`, dest: `${KD_DIR}/core/indexes/tools-index.md` },
    { url: `${base}/core/indexes/roles-index.md`, dest: `${KD_DIR}/core/indexes/roles-index.md` },
    { url: `${base}/core/indexes/stages-index.md`, dest: `${KD_DIR}/core/indexes/stages-index.md` },
    { url: `${base}/core/indexes/workflows-index.md`, dest: `${KD_DIR}/core/indexes/workflows-index.md` },
  );

  // Skills
  for (const sk of ['SKILLS', '01-supabase-postgres', '02-insecure-defaults', '03-react-nextjs', '04-premium-design-system', '05-web-perf', '06-code-review', '07-pwa-service-worker', '08-testing-qa', '09-animations-components', '10-recursive-decomposition', '11-api-design', '12-devops-deployment', '13-game-development', '14-mobile-development', '15-documentation']) {
    files.push({ url: `${base}/skills/${sk}.md`, dest: `${KD_DIR}/skills/${sk}.md` });
  }

  // Agents
  for (const a of ['analyst', 'pm', 'architect', 'tech-lead', 'engineer', 'qa', 'scrum-master', 'security', 'devops', 'release-manager', 'ux-designer', 'data-scientist', 'mobile-developer', 'database-admin', 'solo-dev']) {
    files.push({ url: `${base}/agents/${a}.agent.yaml`, dest: `${KD_DIR}/agents/${a}.agent.yaml` });
  }

  // Gates
  for (const g of ['discovery-exit', 'requirements-exit', 'architecture-exit', 'implementation-exit', 'quality-exit', 'deployment-exit', 'release-exit']) {
    files.push({ url: `${base}/gates/${g}.md`, dest: `${KD_DIR}/gates/${g}.md` });
  }

  // Knowledge
  files.push(
    { url: `${base}/knowledge/kd-index.md`, dest: `${KD_DIR}/knowledge/kd-index.md` },
    { url: `${base}/knowledge/patterns/auth-patterns.md`, dest: `${KD_DIR}/knowledge/patterns/auth-patterns.md` },
    { url: `${base}/knowledge/patterns/api-patterns.md`, dest: `${KD_DIR}/knowledge/patterns/api-patterns.md` },
    { url: `${base}/knowledge/patterns/database-patterns.md`, dest: `${KD_DIR}/knowledge/patterns/database-patterns.md` },
    { url: `${base}/knowledge/patterns/security-patterns.md`, dest: `${KD_DIR}/knowledge/patterns/security-patterns.md` },
    { url: `${base}/knowledge/standards/code-style.md`, dest: `${KD_DIR}/knowledge/standards/code-style.md` },
    { url: `${base}/knowledge/standards/naming-conventions.md`, dest: `${KD_DIR}/knowledge/standards/naming-conventions.md` },
    { url: `${base}/knowledge/standards/documentation-standards.md`, dest: `${KD_DIR}/knowledge/standards/documentation-standards.md` },
  );

  // Tools
  files.push(
    { url: `${base}/testsprite/testsprite-core.js`, dest: `${KD_DIR}/testsprite/testsprite-core.js` },
    { url: `${base}/testsprite/browser-setup.js`, dest: `${KD_DIR}/testsprite/browser-setup.js` },
    { url: `${base}/commands/testsprite.js`, dest: `${KD_DIR}/testsprite/run.js` },
    { url: `${base}/github-reader/github-reader.js`, dest: `${KD_DIR}/github-reader/github-reader.js` },
    { url: `${base}/github-reader/kd-github-read.js`, dest: `${KD_DIR}/github-reader/kd-github-read.js` },
    { url: `${base}/tool-selector/tool-selector.js`, dest: `${KD_DIR}/tool-selector/tool-selector.js` },
    { url: `${base}/tool-selector/knowledge-base.json`, dest: `${KD_DIR}/tool-selector/knowledge-base.json` },
    { url: `${base}/git-integration/auto-commit.sh`, dest: `${KD_DIR}/git-integration/auto-commit.sh` },
    { url: `${base}/git-integration/config.yaml`, dest: `${KD_DIR}/git-integration/config.yaml` },
    { url: `${base}/analytics/agent-performance.json`, dest: `${KD_DIR}/analytics/agent-performance.json` },
    { url: `${base}/version-checker/version-checker.js`, dest: `${KD_DIR}/version-checker/version-checker.js` },
    { url: `${base}/version-checker/registry.json`, dest: `${KD_DIR}/version-checker/registry.json` },
    { url: `${base}/version-checker/compatibility-rules.json`, dest: `${KD_DIR}/version-checker/compatibility-rules.json` },
    { url: `${base}/version-checker/README.md`, dest: `${KD_DIR}/version-checker/README.md` },
    { url: `${base}/exporters/export-consolidated.sh`, dest: `${KD_DIR}/exporters/export-consolidated.sh` },
    { url: `${base}/exporters/export-jira.js`, dest: `${KD_DIR}/exporters/export-jira.js` },
    { url: `${base}/exporters/export-pdf.sh`, dest: `${KD_DIR}/exporters/export-pdf.sh` },
    { url: `${base}/artifacts/manifest.yaml`, dest: `${KD_DIR}/artifacts/manifest.yaml` },
  );

  // Download all
  for (const f of files) {
    await downloadFile(f.url, path.join(workDir, f.dest));
  }
}

function createConfig(workDir, tools, lang) {
  const proj = path.basename(workDir);
  const cfg = {
    version: VERSION, project_name: proj, language: lang, target_tools: tools.join(','),
    scale: 'auto', installed_date: new Date().toISOString(), site: 'https://krackeddevs.com/',
    branding: 'KRACKEDDEVS',
    features: { multi_agent: true, status_tracking: true, decision_validation: true, checkpoints: true, web_research: true, agent_personalities: true }
  };
  fs.writeFileSync(path.join(workDir, `${KD_DIR}/config/settings.json`), JSON.stringify(cfg, null, 2));
}

function initStatus(workDir, lang) {
  const proj = path.basename(workDir);
  const date = new Date().toISOString().split('T')[0];
  const content = `# PROJECT STATUS

## Meta
- Project: ${proj}
- Language: ${lang}
- Created: ${date}

## Current State
- Stage: Ready to begin
- Active Role: None

## Completed Stages
| Stage | Status | Date |
|-------|--------|------|
| Discovery | pending | - |
| Brainstorm | pending | - |
| Requirements | pending | - |
| Architecture | pending | - |
| Implementation | pending | - |
| Quality | pending | - |
| Deployment | pending | - |
| Release | pending | - |

## Next Actions
1. Run /KD-analyze to begin discovery phase

## Change Log
| Date | Change | By |
|------|--------|-----|
| ${date} | KD installed v${VERSION} | System |
`;
  fs.writeFileSync(path.join(workDir, `${KD_DIR}/KD_output/status/status.md`), content);
}

async function setupAdapter(workDir, tool) {
  const configs = {
    'claude-code': { dir: '.claude', file: 'CLAUDE.md', cmdDir: '.claude/commands', src: 'commands' },
    'cursor': { dir: '.cursor', file: '.cursorrules', cmdDir: '.cursor/commands', src: 'commands' },
    'cline': { dir: '.clinerules', file: '.clinerules', cmdDir: '.clinerules/workflows', src: 'workflows' },
    'kilocode': { dir: '.kilocode', file: '.kilocode', cmdDir: '.kilocode/workflows', src: 'workflows' },
    'roo-code': { dir: '.roo', file: '.roo', cmdDir: '.roo/commands', src: 'commands' },
    'antigravity': { dir: '.agent', file: 'SKILL.md', cmdDir: '.agent/workflows', src: 'workflows' },
  };
  const cfg = configs[tool];
  if (!cfg) return;

  const dir = path.join(workDir, cfg.dir);
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });

  const url = tool === 'antigravity' ? `${KD_RAW_URL}/src/adapters/${tool}/SKILL.md` : `${KD_RAW_URL}/src/adapters/${tool}/${cfg.file}`;
  const dest = path.join(dir, cfg.file);
  const ok = await downloadFile(url, dest);
  if (!ok) fs.writeFileSync(dest, `# KD - AI Skill by KRACKEDDEVS\nRead .kracked/prompts/system-prompt.md for instructions.`);

  const cmdDir = path.join(workDir, cfg.cmdDir);
  if (!fs.existsSync(cmdDir)) fs.mkdirSync(cmdDir, { recursive: true });

  for (const cmd of COMMANDS) {
    await downloadFile(`${KD_RAW_URL}/src/adapters/${tool}/${cfg.src}/${cmd}.md`, path.join(cmdDir, `${cmd}.md`));
  }
}

function showSuccess(workDir, tools, lang) {
  console.log();
  console.log(chalk.green('  ╔═══════════════════════════════════════════════════════════════╗'));
  console.log(chalk.green('  ║') + chalk.bold.white('              ✅ INSTALLATION COMPLETE!                        ') + chalk.green('║'));
  console.log(chalk.green('  ║') + chalk.white(`              KD v${VERSION} installed successfully!            `) + chalk.green('║'));
  console.log(chalk.green('  ╚═══════════════════════════════════════════════════════════════╝'));
  console.log();
  console.log(chalk.cyan('  📋 Installed:'));
  console.log(chalk.white(`     Adapters:  ${tools.join(', ')}`));
  console.log(chalk.white(`     Language:  ${lang}`));
  console.log(chalk.white(`     Directory: ${workDir}/${KD_DIR}`));
  console.log();
  console.log(chalk.green('  KD finishes what it starts.'));
  console.log();
}