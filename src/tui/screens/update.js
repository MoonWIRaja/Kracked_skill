/**
 * Update Screen - v5.0.0
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

function ask(rl, question) {
  return new Promise((resolve) => {
    rl.question(question, (answer) => resolve(answer.trim()));
  });
}

async function downloadFile(url, dest) {
  try {
    const res = await axios.get(url, { timeout: 15000 });
    fs.writeFileSync(dest, res.data);
    return true;
  } catch { return false; }
}

export async function updateKD(options = {}) {
  console.log(chalk.cyan('  ───────────────────────────────────────────'));
  console.log(chalk.white('  🔄 UPDATE KD'));
  console.log(chalk.cyan('  ───────────────────────────────────────────'));
  console.log();

  const workDir = options.installDir || process.cwd();
  const kdPath = path.join(workDir, KD_DIR);
  
  if (!fs.existsSync(kdPath)) {
    console.log(chalk.red('  ❌ KD is not installed in this directory.'));
    console.log(chalk.gray(`  Directory: ${workDir}`));
    console.log(chalk.gray('  Run "kd install" to install KD first.'));
    process.exit(0);
    return;
  }

  const configPath = path.join(kdPath, 'config/settings.json');
  let currentConfig = {};
  if (fs.existsSync(configPath)) {
    try {
      currentConfig = JSON.parse(fs.readFileSync(configPath, 'utf-8'));
    } catch (e) {}
  }

  console.log(chalk.white('  Current Version:'), chalk.cyan(currentConfig.version || 'Unknown'));
  console.log(chalk.white('  Latest Version: '), chalk.green(VERSION));
  console.log();

  const rl = readline.createInterface({ input: process.stdin, output: process.stdout });

  if (currentConfig.version === VERSION && !options.force) {
    console.log(chalk.yellow('  You are already on the latest version.'));
    if (!options.nonInteractive) {
      const proceed = await ask(rl, chalk.white('  Reinstall anyway? [y/N]: '));
      if (proceed.toLowerCase() !== 'y') {
        console.log(chalk.gray('\n  Update cancelled.'));
        rl.close();
        process.exit(0);
        return;
      }
    } else {
      rl.close();
      process.exit(0);
      return;
    }
  }

  if (!options.nonInteractive && !options.force) {
    const proceed = await ask(rl, chalk.white('  Proceed with update? [Y/n]: '));
    if (proceed.toLowerCase() === 'n') {
      console.log(chalk.yellow('\n  Update cancelled.'));
      rl.close();
      process.exit(0);
      return;
    }
  }

  rl.close();
  console.log();
  const spinner = ora('Updating KD...').start();

  try {
    spinner.text = 'Downloading latest files...';
    await downloadAllFiles(workDir);

    spinner.text = 'Updating configuration...';
    currentConfig.version = VERSION;
    currentConfig.updated_date = new Date().toISOString();
    fs.writeFileSync(configPath, JSON.stringify(currentConfig, null, 2));

    spinner.succeed('Update complete!');
    console.log();
    console.log(chalk.green('  ✅ KD updated to v' + VERSION));
    console.log(chalk.cyan('  KD finishes what it starts.'));
    console.log();
    setTimeout(() => process.exit(0), 100);

  } catch (error) {
    spinner.fail('Update failed!');
    console.error(chalk.red(`  Error: ${error.message}`));
    process.exit(1);
  }
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

  // WORKFLOW STEPS - Discovery
  for (const s of ['workflow', 'step-01-orient', 'step-02-interview', 'step-03-research', 'step-04-synthesize', 'step-05-brief']) {
    files.push({ url: `${base}/workflows/discovery/analyze/${s}.md`, dest: `${KD_DIR}/workflows/discovery/analyze/${s}.md` });
  }
  for (const s of ['workflow', 'step-01-setup', 'step-02-ideation', 'step-03-evaluation', 'step-04-summary']) {
    files.push({ url: `${base}/workflows/discovery/brainstorm/${s}.md`, dest: `${KD_DIR}/workflows/discovery/brainstorm/${s}.md` });
  }
  for (const s of ['workflow', 'step-01-scope', 'step-02-research', 'step-03-report']) {
    files.push({ url: `${base}/workflows/discovery/domain-research/${s}.md`, dest: `${KD_DIR}/workflows/discovery/domain-research/${s}.md` });
  }

  // Planning
  for (const s of ['workflow', 'step-01-orient', 'step-02-personas', 'step-03-requirements', 'step-04-nfr', 'step-05-epics', 'step-06-mvp', 'step-07-metrics', 'step-08-validate']) {
    files.push({ url: `${base}/workflows/planning/prd-create/${s}.md`, dest: `${KD_DIR}/workflows/planning/prd-create/${s}.md` });
  }
  for (const s of ['workflow', 'step-01-check', 'step-02-score', 'step-03-report']) {
    files.push({ url: `${base}/workflows/planning/prd-validate/${s}.md`, dest: `${KD_DIR}/workflows/planning/prd-validate/${s}.md` });
  }
  for (const s of ['workflow', 'step-01-read-prd', 'step-02-define-epics', 'step-03-write-stories', 'step-04-sequence', 'step-05-validate']) {
    files.push({ url: `${base}/workflows/planning/epics-stories/${s}.md`, dest: `${KD_DIR}/workflows/planning/epics-stories/${s}.md` });
  }

  // Architecture
  for (const s of ['workflow', 'step-01-orient', 'step-02-tech-stack', 'step-03-database', 'step-04-api', 'step-05-security', 'step-06-validate']) {
    files.push({ url: `${base}/workflows/architecture/design/${s}.md`, dest: `${KD_DIR}/workflows/architecture/design/${s}.md` });
  }
  for (const s of ['workflow', 'step-01-identify', 'step-02-compare', 'step-03-recommend']) {
    files.push({ url: `${base}/workflows/architecture/tech-research/${s}.md`, dest: `${KD_DIR}/workflows/architecture/tech-research/${s}.md` });
  }
  for (const s of ['workflow', 'step-01-resources', 'step-02-endpoints', 'step-03-contracts', 'step-04-validate']) {
    files.push({ url: `${base}/workflows/architecture/api-design/${s}.md`, dest: `${KD_DIR}/workflows/architecture/api-design/${s}.md` });
  }

  // Implementation
  for (const s of ['workflow', 'step-01-read-prd', 'step-02-identify-stories', 'step-03-sequence', 'step-04-generate-files', 'step-05-validate']) {
    files.push({ url: `${base}/workflows/implementation/story-generate/${s}.md`, dest: `${KD_DIR}/workflows/implementation/story-generate/${s}.md` });
  }
  for (const s of ['workflow', 'step-01-orient', 'step-02-tdd-setup', 'step-03-implement', 'step-04-test', 'step-05-handoff']) {
    files.push({ url: `${base}/workflows/implementation/dev-story/${s}.md`, dest: `${KD_DIR}/workflows/implementation/dev-story/${s}.md` });
  }
  for (const s of ['workflow', 'step-01-read-story', 'step-02-review-code', 'step-03-security-check', 'step-04-report']) {
    files.push({ url: `${base}/workflows/implementation/code-review/${s}.md`, dest: `${KD_DIR}/workflows/implementation/code-review/${s}.md` });
  }
  for (const s of ['workflow', 'step-01-analyze', 'step-02-plan', 'step-03-execute']) {
    files.push({ url: `${base}/workflows/implementation/refactor/${s}.md`, dest: `${KD_DIR}/workflows/implementation/refactor/${s}.md` });
  }

  // Quality
  for (const s of ['workflow', 'step-01-strategy', 'step-02-unit', 'step-03-integration', 'step-04-e2e']) {
    files.push({ url: `${base}/workflows/quality/test-design/${s}.md`, dest: `${KD_DIR}/workflows/quality/test-design/${s}.md` });
  }
  for (const s of ['workflow', 'step-01-run', 'step-02-analyze', 'step-03-report']) {
    files.push({ url: `${base}/workflows/quality/test-execute/${s}.md`, dest: `${KD_DIR}/workflows/quality/test-execute/${s}.md` });
  }
  for (const s of ['workflow', 'step-01-surface', 'step-02-threats', 'step-03-test', 'step-04-report']) {
    files.push({ url: `${base}/workflows/quality/security-audit/${s}.md`, dest: `${KD_DIR}/workflows/quality/security-audit/${s}.md` });
  }

  // Deployment
  for (const s of ['workflow', 'step-01-env-setup', 'step-02-cicd', 'step-03-monitoring', 'step-04-rollback', 'step-05-validate']) {
    files.push({ url: `${base}/workflows/deployment/plan/${s}.md`, dest: `${KD_DIR}/workflows/deployment/plan/${s}.md` });
  }
  for (const s of ['workflow', 'step-01-pre-check', 'step-02-deploy', 'step-03-verify']) {
    files.push({ url: `${base}/workflows/deployment/execute/${s}.md`, dest: `${KD_DIR}/workflows/deployment/execute/${s}.md` });
  }

  // Release
  for (const s of ['workflow', 'step-01-gather', 'step-02-write', 'step-03-validate']) {
    files.push({ url: `${base}/workflows/release/notes/${s}.md`, dest: `${KD_DIR}/workflows/release/notes/${s}.md` });
  }
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