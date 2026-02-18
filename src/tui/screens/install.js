/**
 * Install Screen - Full Installation
 * Matches install.sh completely
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
  'KD-build-agent', 'KD-build-module', 'KD-build-workflow', 'KD-code-review',
  'KD-deployment-plan', 'KD-dev-story', 'KD-doc-project', 'KD-domain-research',
  'KD-epics-and-stories', 'KD-fix-course', 'KD-game-arch', 'KD-game-architect',
  'KD-game-brainstorm', 'KD-game-brief', 'KD-game-designer', 'KD-game-dev',
  'KD-game-dev-story', 'KD-game-gdd', 'KD-game-narrative', 'KD-game-qa',
  'KD-game-scrum-master', 'KD-game-solo', 'KD-game-story', 'KD-game-test-auto',
  'KD-game-test-design', 'KD-game-test-perf', 'KD-game-test-plan', 'KD-game-writer',
  'KD-help', 'KD-idea-coach', 'KD-idea-design-thinking', 'KD-idea-innovation',
  'KD-idea-presenter', 'KD-idea-problem-solving', 'KD-idea-solver', 'KD-idea-storyteller',
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
  console.log(chalk.white('  📦 INSTALL KD'));
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
    `${KD_DIR}/core/indexes`, `${KD_DIR}/skills`, `${KD_DIR}/KD_output`,
    `${KD_DIR}/KD_output/status`, `${KD_DIR}/KD_output/brainstorm`,
    `${KD_DIR}/KD_output/product-brief`, `${KD_DIR}/KD_output/PRD`,
    `${KD_DIR}/KD_output/architecture`, `${KD_DIR}/KD_output/epics-and-stories`,
    `${KD_DIR}/KD_output/code-review`, `${KD_DIR}/KD_output/deployment`,
    `${KD_DIR}/KD_output/release`, `${KD_DIR}/KD_output/decisions`, `${KD_DIR}/KD_output/risks`,
  ];
  for (const dir of dirs) {
    const p = path.join(workDir, dir);
    if (!fs.existsSync(p)) fs.mkdirSync(p, { recursive: true });
  }
}

async function downloadFile(url, dest) {
  try {
    const res = await axios.get(url, { timeout: 10000 });
    fs.writeFileSync(dest, res.data);
    return true;
  } catch { return false; }
}

async function downloadAllFiles(workDir) {
  const base = `${KD_RAW_URL}/src`;
  
  // All files from install.sh
  const files = [
    // Prompts
    { url: `${base}/prompts/system-prompt.md`, dest: `${KD_DIR}/prompts/system-prompt.md` },
    { url: `${base}/prompts/role-switcher.md`, dest: `${KD_DIR}/prompts/role-switcher.md` },
    { url: `${base}/prompts/handoff-protocol.md`, dest: `${KD_DIR}/prompts/handoff-protocol.md` },
    { url: `${base}/prompts/conflict-resolution.md`, dest: `${KD_DIR}/prompts/conflict-resolution.md` },
    
    // Roles
    { url: `${base}/prompts/roles/_role-template.md`, dest: `${KD_DIR}/prompts/roles/_role-template.md` },
    { url: `${base}/prompts/roles/analyst.md`, dest: `${KD_DIR}/prompts/roles/analyst.md` },
    { url: `${base}/prompts/roles/product-manager.md`, dest: `${KD_DIR}/prompts/roles/product-manager.md` },
    { url: `${base}/prompts/roles/architect.md`, dest: `${KD_DIR}/prompts/roles/architect.md` },
    { url: `${base}/prompts/roles/tech-lead.md`, dest: `${KD_DIR}/prompts/roles/tech-lead.md` },
    { url: `${base}/prompts/roles/engineer.md`, dest: `${KD_DIR}/prompts/roles/engineer.md` },
    { url: `${base}/prompts/roles/qa.md`, dest: `${KD_DIR}/prompts/roles/qa.md` },
    { url: `${base}/prompts/roles/security.md`, dest: `${KD_DIR}/prompts/roles/security.md` },
    { url: `${base}/prompts/roles/devops.md`, dest: `${KD_DIR}/prompts/roles/devops.md` },
    { url: `${base}/prompts/roles/release-manager.md`, dest: `${KD_DIR}/prompts/roles/release-manager.md` },
    { url: `${base}/prompts/roles/ux-designer.md`, dest: `${KD_DIR}/prompts/roles/ux-designer.md` },
    { url: `${base}/prompts/roles/data-scientist.md`, dest: `${KD_DIR}/prompts/roles/data-scientist.md` },
    { url: `${base}/prompts/roles/mobile-developer.md`, dest: `${KD_DIR}/prompts/roles/mobile-developer.md` },
    { url: `${base}/prompts/roles/database-admin.md`, dest: `${KD_DIR}/prompts/roles/database-admin.md` },
    
    // Stages
    { url: `${base}/prompts/stages/_stage-template.md`, dest: `${KD_DIR}/prompts/stages/_stage-template.md` },
    { url: `${base}/prompts/stages/discovery.md`, dest: `${KD_DIR}/prompts/stages/discovery.md` },
    { url: `${base}/prompts/stages/brainstorm.md`, dest: `${KD_DIR}/prompts/stages/brainstorm.md` },
    { url: `${base}/prompts/stages/requirements.md`, dest: `${KD_DIR}/prompts/stages/requirements.md` },
    { url: `${base}/prompts/stages/architecture.md`, dest: `${KD_DIR}/prompts/stages/architecture.md` },
    { url: `${base}/prompts/stages/implementation.md`, dest: `${KD_DIR}/prompts/stages/implementation.md` },
    { url: `${base}/prompts/stages/quality.md`, dest: `${KD_DIR}/prompts/stages/quality.md` },
    { url: `${base}/prompts/stages/deployment.md`, dest: `${KD_DIR}/prompts/stages/deployment.md` },
    { url: `${base}/prompts/stages/release.md`, dest: `${KD_DIR}/prompts/stages/release.md` },
    
    // Multi-Agent
    { url: `${base}/prompts/multi-agent/party-mode.md`, dest: `${KD_DIR}/prompts/multi-agent/party-mode.md` },
    { url: `${base}/prompts/multi-agent/agent-swarm.md`, dest: `${KD_DIR}/prompts/multi-agent/agent-swarm.md` },
    { url: `${base}/prompts/multi-agent/confidence-scoring.md`, dest: `${KD_DIR}/prompts/multi-agent/confidence-scoring.md` },
    { url: `${base}/prompts/multi-agent/conflict-resolution.md`, dest: `${KD_DIR}/prompts/multi-agent/conflict-resolution.md` },
    { url: `${base}/prompts/multi-agent/aggregation.md`, dest: `${KD_DIR}/prompts/multi-agent/aggregation.md` },
    
    // Templates
    { url: `${base}/templates/status.md`, dest: `${KD_DIR}/templates/status.md` },
    { url: `${base}/templates/product-brief.md`, dest: `${KD_DIR}/templates/product-brief.md` },
    { url: `${base}/templates/prd.md`, dest: `${KD_DIR}/templates/prd.md` },
    { url: `${base}/templates/architecture.md`, dest: `${KD_DIR}/templates/architecture.md` },
    { url: `${base}/templates/story-card.md`, dest: `${KD_DIR}/templates/story-card.md` },
    { url: `${base}/templates/deployment-plan.md`, dest: `${KD_DIR}/templates/deployment-plan.md` },
    { url: `${base}/templates/release-notes.md`, dest: `${KD_DIR}/templates/release-notes.md` },
    { url: `${base}/templates/decision-log.md`, dest: `${KD_DIR}/templates/decision-log.md` },
    { url: `${base}/templates/risk-register.md`, dest: `${KD_DIR}/templates/risk-register.md` },
    
    // Checklists
    { url: `${base}/checklists/stage-completion.md`, dest: `${KD_DIR}/checklists/stage-completion.md` },
    { url: `${base}/checklists/decision-validation.md`, dest: `${KD_DIR}/checklists/decision-validation.md` },
    { url: `${base}/checklists/checkpoint-approval.md`, dest: `${KD_DIR}/checklists/checkpoint-approval.md` },
    { url: `${base}/checklists/security-audit.md`, dest: `${KD_DIR}/checklists/security-audit.md` },
    { url: `${base}/checklists/pre-deployment.md`, dest: `${KD_DIR}/checklists/pre-deployment.md` },
    { url: `${base}/checklists/code-quality.md`, dest: `${KD_DIR}/checklists/code-quality.md` },
    
    // Workflows
    { url: `${base}/workflows/main.md`, dest: `${KD_DIR}/workflows/main.md` },
    { url: `${base}/workflows/quick-start.md`, dest: `${KD_DIR}/workflows/quick-start.md` },
    { url: `${base}/workflows/full-product.md`, dest: `${KD_DIR}/workflows/full-product.md` },
    { url: `${base}/workflows/maintenance.md`, dest: `${KD_DIR}/workflows/maintenance.md` },
    
    // Config
    { url: `${base}/config/settings-schema.json`, dest: `${KD_DIR}/config/settings-schema.json` },
    { url: `${base}/config/defaults.json`, dest: `${KD_DIR}/config/defaults.json` },
    { url: `${base}/config/language/en.json`, dest: `${KD_DIR}/config/language/en.json` },
    { url: `${base}/config/language/ms.json`, dest: `${KD_DIR}/config/language/ms.json` },
    { url: `${base}/config/agents/personalities.json`, dest: `${KD_DIR}/config/agents/personalities.json` },
    
    // TestSprite
    { url: `${base}/testsprite/testsprite-core.js`, dest: `${KD_DIR}/testsprite/testsprite-core.js` },
    { url: `${base}/commands/testsprite.js`, dest: `${KD_DIR}/testsprite/run.js` },
    
    // Tool Selector
    { url: `${base}/tool-selector/tool-selector.js`, dest: `${KD_DIR}/tool-selector/tool-selector.js` },
    { url: `${base}/tool-selector/knowledge-base.json`, dest: `${KD_DIR}/tool-selector/knowledge-base.json` },
    
    // Git Integration
    { url: `${base}/git-integration/auto-commit.sh`, dest: `${KD_DIR}/git-integration/auto-commit.sh` },
    { url: `${base}/git-integration/config.yaml`, dest: `${KD_DIR}/git-integration/config.yaml` },
    
    // Analytics
    { url: `${base}/analytics/agent-performance.json`, dest: `${KD_DIR}/analytics/agent-performance.json` },
    
    // Version Checker
    { url: `${base}/version-checker/version-checker.js`, dest: `${KD_DIR}/version-checker/version-checker.js` },
    { url: `${base}/version-checker/registry.json`, dest: `${KD_DIR}/version-checker/registry.json` },
    { url: `${base}/version-checker/compatibility-rules.json`, dest: `${KD_DIR}/version-checker/compatibility-rules.json` },
    { url: `${base}/version-checker/README.md`, dest: `${KD_DIR}/version-checker/README.md` },
    
    // Exporters
    { url: `${base}/exporters/export-consolidated.sh`, dest: `${KD_DIR}/exporters/export-consolidated.sh` },
    { url: `${base}/exporters/export-jira.js`, dest: `${KD_DIR}/exporters/export-jira.js` },
    { url: `${base}/exporters/export-pdf.sh`, dest: `${KD_DIR}/exporters/export-pdf.sh` },
    
    // Artifacts
    { url: `${base}/artifacts/manifest.yaml`, dest: `${KD_DIR}/artifacts/manifest.yaml` },
    
    // Core
    { url: `${base}/core/core.md`, dest: `${KD_DIR}/core/core.md` },
    { url: `${base}/core/indexes/skills-index.md`, dest: `${KD_DIR}/core/indexes/skills-index.md` },
    { url: `${base}/core/indexes/commands-index.md`, dest: `${KD_DIR}/core/indexes/commands-index.md` },
    { url: `${base}/core/indexes/tools-index.md`, dest: `${KD_DIR}/core/indexes/tools-index.md` },
    { url: `${base}/core/indexes/roles-index.md`, dest: `${KD_DIR}/core/indexes/roles-index.md` },
    { url: `${base}/core/indexes/stages-index.md`, dest: `${KD_DIR}/core/indexes/stages-index.md` },
    
    // Skills
    { url: `${base}/skills/SKILLS.md`, dest: `${KD_DIR}/skills/SKILLS.md` },
    { url: `${base}/skills/01-supabase-postgres.md`, dest: `${KD_DIR}/skills/01-supabase-postgres.md` },
    { url: `${base}/skills/02-insecure-defaults.md`, dest: `${KD_DIR}/skills/02-insecure-defaults.md` },
    { url: `${base}/skills/03-react-nextjs.md`, dest: `${KD_DIR}/skills/03-react-nextjs.md` },
    { url: `${base}/skills/04-premium-design-system.md`, dest: `${KD_DIR}/skills/04-premium-design-system.md` },
    { url: `${base}/skills/05-web-perf.md`, dest: `${KD_DIR}/skills/05-web-perf.md` },
    { url: `${base}/skills/06-code-review.md`, dest: `${KD_DIR}/skills/06-code-review.md` },
    { url: `${base}/skills/07-pwa-service-worker.md`, dest: `${KD_DIR}/skills/07-pwa-service-worker.md` },
    { url: `${base}/skills/08-testing-qa.md`, dest: `${KD_DIR}/skills/08-testing-qa.md` },
    { url: `${base}/skills/09-animations-components.md`, dest: `${KD_DIR}/skills/09-animations-components.md` },
    { url: `${base}/skills/10-recursive-decomposition.md`, dest: `${KD_DIR}/skills/10-recursive-decomposition.md` },
    { url: `${base}/skills/11-api-design.md`, dest: `${KD_DIR}/skills/11-api-design.md` },
    { url: `${base}/skills/12-devops-deployment.md`, dest: `${KD_DIR}/skills/12-devops-deployment.md` },
    { url: `${base}/skills/13-game-development.md`, dest: `${KD_DIR}/skills/13-game-development.md` },
    { url: `${base}/skills/14-mobile-development.md`, dest: `${KD_DIR}/skills/14-mobile-development.md` },
    { url: `${base}/skills/15-documentation.md`, dest: `${KD_DIR}/skills/15-documentation.md` },
  ];

  for (const f of files) {
    await downloadFile(f.url, path.join(workDir, f.dest));
  }
}

function createConfig(workDir, tools, lang) {
  const proj = path.basename(workDir);
  const cfg = {
    version: VERSION,
    project_name: proj,
    language: lang,
    target_tools: tools.join(','),
    scale: 'auto',
    installed_date: new Date().toISOString(),
    site: 'https://krackeddevs.com/',
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
}