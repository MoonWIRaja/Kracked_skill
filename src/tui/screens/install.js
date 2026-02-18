/**
 * Install Screen
 * KD TUI Application - Full Installation
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

// AI Tools available
const AI_TOOLS = [
  { key: '1', name: 'Claude Code', value: 'claude-code' },
  { key: '2', name: 'Cursor', value: 'cursor' },
  { key: '3', name: 'Cline', value: 'cline' },
  { key: '4', name: 'Kilo Code', value: 'kilocode' },
  { key: '5', name: 'Roo Code', value: 'roo-code' },
  { key: '6', name: 'Antigravity', value: 'antigravity' },
  { key: 'A', name: 'All', value: 'all' },
];

// Common languages
const LANGUAGES = [
  { key: '1', name: 'English (Default)', value: 'EN' },
  { key: '2', name: 'Bahasa Melayu', value: 'MS' },
  { key: 'C', name: 'Custom (type your own)', value: 'custom' },
];

// Full command list for adapters
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
  'KD-validate-agent', 'KD-validate-workflow'
];

function ask(rl, question) {
  return new Promise((resolve) => {
    rl.question(question, (answer) => {
      resolve(answer.trim());
    });
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
      console.log(chalk.red('  ❌ KD is already installed in this directory.'));
      console.log(chalk.gray('  Use --force to overwrite.'));
      return;
    }
  }

  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  try {
    let selectedTools = [];
    if (options.target) {
      selectedTools = options.target.split(',').map(t => t.trim());
    } else if (!options.nonInteractive) {
      console.log(chalk.white('  Step 1 of 3: Select AI Tool(s)'));
      console.log();
      
      for (const tool of AI_TOOLS) {
        console.log(chalk.cyan(`  [${tool.key}]`) + ` ${tool.name}`);
      }
      console.log();
      console.log(chalk.gray('  Enter multiple numbers separated by commas (e.g., 1,3,4) or A for all'));
      console.log();

      const answer = await ask(rl, chalk.white('  Select AI tool(s): '));
      
      if (answer.toUpperCase() === 'A') {
        selectedTools = AI_TOOLS.filter(t => t.value !== 'all').map(t => t.value);
      } else {
        const keys = answer.split(',').map(k => k.trim().toUpperCase());
        for (const key of keys) {
          const tool = AI_TOOLS.find(t => t.key.toUpperCase() === key);
          if (tool && tool.value !== 'all') {
            selectedTools.push(tool.value);
          }
        }
      }

      if (selectedTools.length === 0) {
        console.log(chalk.yellow('  No tools selected. Using Claude Code as default.'));
        selectedTools = ['claude-code'];
      }
    } else {
      selectedTools = ['claude-code'];
    }

    let language = 'EN';
    if (options.lang) {
      language = options.lang.toUpperCase();
    } else if (!options.nonInteractive) {
      console.log();
      console.log(chalk.white('  Step 2 of 3: Select Language'));
      console.log();
      
      for (const lang of LANGUAGES) {
        console.log(chalk.cyan(`  [${lang.key}]`) + ` ${lang.name}`);
      }
      console.log();

      const answer = await ask(rl, chalk.white('  Select language: '));
      
      const lang = LANGUAGES.find(l => l.key.toUpperCase() === answer.toUpperCase());
      if (lang) {
        if (lang.value === 'custom') {
          language = await ask(rl, chalk.white('  Enter your language: '));
        } else {
          language = lang.value;
        }
      }
    }

    if (!options.nonInteractive) {
      console.log();
      console.log(chalk.white('  Step 3 of 3: Confirm Installation'));
      console.log();
      
      console.log(chalk.cyan('  ┌─────────────────────────────────────────┐'));
      console.log(chalk.cyan('  │') + chalk.white('       INSTALLATION SUMMARY              ') + chalk.cyan('│'));
      console.log(chalk.cyan('  ├─────────────────────────────────────────┤'));
      console.log(chalk.cyan('  │') + chalk.white(`  Version:      ${VERSION}              `) + chalk.cyan('│'));
      console.log(chalk.cyan('  │') + chalk.white(`  Directory:    ${workDir}/${KD_DIR}`) + chalk.cyan('│'));
      console.log(chalk.cyan('  │') + chalk.white(`  Target(s):    ${selectedTools.join(', ')}`) + chalk.cyan('│'));
      console.log(chalk.cyan('  │') + chalk.white(`  Language:     ${language}`) + chalk.cyan('│'));
      console.log(chalk.cyan('  └─────────────────────────────────────────┘'));
      console.log();

      const confirm = await ask(rl, chalk.white('  Proceed with installation? [Y/n]: '));
      
      if (confirm && confirm.toLowerCase() === 'n') {
        console.log(chalk.yellow('\n  Installation cancelled.'));
        rl.close();
        return;
      }
    }

    rl.close();

    console.log();
    const spinner = ora('Installing KD...').start();

    try {
      spinner.text = 'Creating directory structure...';
      await createDirectories(workDir);
      
      spinner.text = 'Downloading KD files...';
      await downloadFiles(workDir);
      
      spinner.text = 'Creating configuration...';
      await createConfig(workDir, selectedTools, language);
      
      spinner.text = 'Initializing status...';
      await initStatus(workDir, language);

      spinner.text = 'Setting up adapters...';
      for (const tool of selectedTools) {
        spinner.text = `Setting up ${tool}...`;
        await setupAdapter(workDir, tool);
      }

      spinner.succeed('Installation complete!');
      showSuccess(workDir, selectedTools, language);

    } catch (error) {
      spinner.fail('Installation failed!');
      console.error(chalk.red(`  Error: ${error.message}`));
    }

  } catch (error) {
    rl.close();
    throw error;
  }
}

async function createDirectories(workDir) {
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
    const fullPath = path.join(workDir, dir);
    if (!fs.existsSync(fullPath)) {
      fs.mkdirSync(fullPath, { recursive: true });
    }
  }
}

async function downloadFile(url, dest) {
  try {
    const response = await axios.get(url, { timeout: 10000 });
    fs.writeFileSync(dest, response.data);
    return true;
  } catch (error) {
    return false;
  }
}

async function downloadFiles(workDir) {
  const base = `${KD_RAW_URL}/src`;
  const files = [
    { url: `${base}/prompts/system-prompt.md`, dest: `${KD_DIR}/prompts/system-prompt.md` },
    { url: `${base}/prompts/role-switcher.md`, dest: `${KD_DIR}/prompts/role-switcher.md` },
    { url: `${base}/prompts/roles/analyst.md`, dest: `${KD_DIR}/prompts/roles/analyst.md` },
    { url: `${base}/prompts/roles/architect.md`, dest: `${KD_DIR}/prompts/roles/architect.md` },
    { url: `${base}/prompts/roles/engineer.md`, dest: `${KD_DIR}/prompts/roles/engineer.md` },
    { url: `${base}/prompts/stages/discovery.md`, dest: `${KD_DIR}/prompts/stages/discovery.md` },
    { url: `${base}/prompts/stages/brainstorm.md`, dest: `${KD_DIR}/prompts/stages/brainstorm.md` },
    { url: `${base}/prompts/stages/requirements.md`, dest: `${KD_DIR}/prompts/stages/requirements.md` },
    { url: `${base}/prompts/stages/architecture.md`, dest: `${KD_DIR}/prompts/stages/architecture.md` },
    { url: `${base}/config/language/en.json`, dest: `${KD_DIR}/config/language/en.json` },
    { url: `${base}/config/language/ms.json`, dest: `${KD_DIR}/config/language/ms.json` },
    { url: `${base}/templates/status.md`, dest: `${KD_DIR}/templates/status.md` },
    { url: `${base}/templates/prd.md`, dest: `${KD_DIR}/templates/prd.md` },
    { url: `${base}/skills/SKILLS.md`, dest: `${KD_DIR}/skills/SKILLS.md` },
    { url: `${base}/core/core.md`, dest: `${KD_DIR}/core/core.md` },
  ];

  for (const file of files) {
    const destPath = path.join(workDir, file.dest);
    await downloadFile(file.url, destPath);
  }
}

async function createConfig(workDir, tools, language) {
  const projName = path.basename(workDir);
  const config = {
    version: VERSION,
    project_name: projName,
    language: language,
    target_tools: tools.join(','),
    installed_date: new Date().toISOString(),
    site: 'https://krackeddevs.com/',
    branding: 'KRACKEDDEVS',
  };
  fs.writeFileSync(path.join(workDir, `${KD_DIR}/config/settings.json`), JSON.stringify(config, null, 2));
}

async function initStatus(workDir, language) {
  const projName = path.basename(workDir);
  const now = new Date().toISOString().split('T')[0];
  const content = `# PROJECT STATUS\n\n## Meta\n- Project: ${projName}\n- Language: ${language}\n- Created: ${now}\n\n## Current State\n- Stage: Ready to begin\n\n## Next Actions\n1. Run /KD-analyze to begin discovery phase\n`;
  fs.writeFileSync(path.join(workDir, `${KD_DIR}/KD_output/status/status.md`), content);
}

async function setupAdapter(workDir, tool) {
  const configs = {
    'claude-code': { dir: '.claude', file: 'CLAUDE.md', cmdDir: '.claude/commands', cmdSource: 'commands' },
    'cursor': { dir: '.cursor', file: '.cursorrules', cmdDir: '.cursor/commands', cmdSource: 'commands' },
    'cline': { dir: '.clinerules', file: '.clinerules', cmdDir: '.clinerules/workflows', cmdSource: 'workflows' },
    'kilocode': { dir: '.kilocode', file: '.kilocode', cmdDir: '.kilocode/workflows', cmdSource: 'workflows' },
    'roo-code': { dir: '.roo', file: '.roo', cmdDir: '.roo/commands', cmdSource: 'commands' },
    'antigravity': { dir: '.agent', file: 'SKILL.md', cmdDir: '.agent/workflows', cmdSource: 'workflows' },
  };

  const config = configs[tool];
  if (!config) return;

  const dirPath = path.join(workDir, config.dir);
  if (!fs.existsSync(dirPath)) fs.mkdirSync(dirPath, { recursive: true });

  const adapterUrl = tool === 'antigravity' 
    ? `${KD_RAW_URL}/src/adapters/${tool}/SKILL.md`
    : `${KD_RAW_URL}/src/adapters/${tool}/${config.file}`;
  
  const adapterDest = path.join(dirPath, config.file);
  const downloaded = await downloadFile(adapterUrl, adapterDest);
  
  if (!downloaded) {
    fs.writeFileSync(adapterDest, `# KD - AI Skill by KRACKEDDEVS\nRead .kracked/prompts/system-prompt.md for full instructions.`);
  }

  const cmdDirPath = path.join(workDir, config.cmdDir);
  if (!fs.existsSync(cmdDirPath)) fs.mkdirSync(cmdDirPath, { recursive: true });

  for (const cmd of COMMANDS) {
    const cmdUrl = `${KD_RAW_URL}/src/adapters/${tool}/${config.cmdSource}/${cmd}.md`;
    const cmdDest = path.join(cmdDirPath, `${cmd}.md`);
    await downloadFile(cmdUrl, cmdDest);
  }
}

function showSuccess(workDir, tools, language) {
  console.log();
  console.log(chalk.green('  ╔═══════════════════════════════════════════════════════════════╗'));
  console.log(chalk.green('  ║') + chalk.bold.white('              ✅ INSTALLATION COMPLETE!                        ') + chalk.green('║'));
  console.log(chalk.green('  ║') + chalk.white(`              KD v${VERSION} installed successfully!            `) + chalk.green('║'));
  console.log(chalk.green('  ╚═══════════════════════════════════════════════════════════════╝'));
  console.log();
  console.log(chalk.cyan('  📋 Installed:'));
  console.log(chalk.white(`     Adapters:  ${tools.join(', ')}`));
  console.log(chalk.white(`     Language:  ${language}`));
  console.log(chalk.white(`     Directory: ${workDir}/${KD_DIR}`));
  console.log();
}