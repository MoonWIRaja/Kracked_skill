/**
 * Install Screen
 * KD TUI Application
 */

import { select, checkbox, input, confirm } from '@inquirer/prompts';
import chalk from 'chalk';
import ora from 'ora';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import axios from 'axios';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const VERSION = '5.0.0';
const KD_REPO = 'MoonWIRaja/Kracked_Skills';
const KD_RAW_URL = `https://raw.githubusercontent.com/${KD_REPO}/main`;
const KD_DIR = '.kracked';

// AI Tools available
const AI_TOOLS = [
  { name: 'Claude Code', value: 'claude-code', description: "Anthropic's official CLI" },
  { name: 'Cursor', value: 'cursor', description: 'AI-powered IDE' },
  { name: 'Cline', value: 'cline', description: 'VS Code AI assistant' },
  { name: 'Kilo Code', value: 'kilocode', description: 'VS Code extension' },
  { name: 'Roo Code', value: 'roo', description: 'VS Code extension' },
  { name: 'Antigravity', value: 'antigravity', description: 'AI agent framework' },
];

// Common languages
const COMMON_LANGUAGES = [
  { name: 'English (Default)', value: 'en' },
  { name: 'Bahasa Melayu', value: 'ms' },
  { name: '日本語 (Japanese)', value: '日本語' },
  { name: '中文 (Chinese)', value: '中文' },
  { name: 'español (Spanish)', value: 'español' },
  { name: '✏️  Type custom language...', value: 'custom' },
];

export async function installKD(options = {}) {
  console.log(chalk.cyan('  ───────────────────────────────────────────'));
  console.log(chalk.white('  📦 INSTALL KD'));
  console.log(chalk.cyan('  ───────────────────────────────────────────'));
  console.log();

  // Check existing installation
  const kdPath = path.join(process.cwd(), KD_DIR);
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

  // Step 1: Select AI Tools
  let selectedTools = [];
  if (options.target) {
    selectedTools = options.target.split(',').map(t => t.trim());
  } else if (!options.nonInteractive) {
    console.log(chalk.white('  Step 1 of 3: Select AI Tool(s)'));
    console.log();
    
    selectedTools = await checkbox({
      message: 'Select target AI tool(s):',
      choices: AI_TOOLS,
      instructions: false,
    });

    if (selectedTools.length === 0) {
      console.log(chalk.yellow('  No tools selected. Using Claude Code as default.'));
      selectedTools = ['claude-code'];
    }
  } else {
    selectedTools = ['claude-code'];
  }

  // Step 2: Select Language
  let language = 'en';
  if (options.lang) {
    language = options.lang;
  } else if (!options.nonInteractive) {
    console.log();
    console.log(chalk.white('  Step 2 of 3: Select Language'));
    console.log();

    const langChoice = await select({
      message: 'Select preferred language:',
      choices: COMMON_LANGUAGES,
    });

    if (langChoice === 'custom') {
      language = await input({
        message: 'Enter your preferred language:',
        default: 'English',
      });
    } else {
      language = langChoice;
    }
  }

  // Step 3: Confirm
  if (!options.nonInteractive) {
    console.log();
    console.log(chalk.white('  Step 3 of 3: Confirm Installation'));
    console.log();
    
    console.log(chalk.cyan('  ╔═══════════════════════════════════════════════════════╗'));
    console.log(chalk.cyan('  ║') + chalk.white('           INSTALLATION SUMMARY                         ') + chalk.cyan('║'));
    console.log(chalk.cyan('  ╠═══════════════════════════════════════════════════════╣'));
    console.log(chalk.cyan('  ║') + chalk.white(`  Version:      ${VERSION}                                    `).padEnd(57) + chalk.cyan('║'));
    console.log(chalk.cyan('  ║') + chalk.white(`  Directory:    ${process.cwd()}\\${KD_DIR}`).padEnd(57) + chalk.cyan('║'));
    console.log(chalk.cyan('  ║') + chalk.white(`  Target(s):    ${selectedTools.join(', ')}`).padEnd(57) + chalk.cyan('║'));
    console.log(chalk.cyan('  ║') + chalk.white(`  Language:     ${language}`).padEnd(57) + chalk.cyan('║'));
    console.log(chalk.cyan('  ╚═══════════════════════════════════════════════════════╝'));
    console.log();

    const proceed = await confirm({
      message: 'Proceed with installation?',
      default: true,
    });

    if (!proceed) {
      console.log(chalk.yellow('\n  Installation cancelled.'));
      return;
    }
  }

  // Installation
  console.log();
  const spinner = ora('Installing KD...').start();

  try {
    // Create directories
    spinner.text = 'Creating directory structure...';
    await createDirectories();
    
    // Download files
    spinner.text = 'Downloading KD files...';
    await downloadFiles();
    
    // Create config
    spinner.text = 'Creating configuration...';
    await createConfig(selectedTools, language);
    
    // Setup adapters
    spinner.text = 'Setting up adapters...';
    for (const tool of selectedTools) {
      await setupAdapter(tool);
    }

    spinner.succeed('Installation complete!');
    
    // Success message
    showSuccess(selectedTools, language);

  } catch (error) {
    spinner.fail('Installation failed!');
    console.error(chalk.red(`  Error: ${error.message}`));
    throw error;
  }
}

async function createDirectories() {
  const dirs = [
    KD_DIR,
    `${KD_DIR}/prompts`,
    `${KD_DIR}/prompts/roles`,
    `${KD_DIR}/prompts/stages`,
    `${KD_DIR}/prompts/multi-agent`,
    `${KD_DIR}/templates`,
    `${KD_DIR}/checklists`,
    `${KD_DIR}/workflows`,
    `${KD_DIR}/config`,
    `${KD_DIR}/config/language`,
    `${KD_DIR}/config/agents`,
    `${KD_DIR}/KD_output`,
    `${KD_DIR}/KD_output/status`,
  ];

  for (const dir of dirs) {
    const fullPath = path.join(process.cwd(), dir);
    if (!fs.existsSync(fullPath)) {
      fs.mkdirSync(fullPath, { recursive: true });
    }
  }
}

async function downloadFiles() {
  const files = [
    // Prompts
    { url: `${KD_RAW_URL}/src/prompts/system-prompt.md`, dest: `${KD_DIR}/prompts/system-prompt.md` },
    { url: `${KD_RAW_URL}/src/prompts/role-switcher.md`, dest: `${KD_DIR}/prompts/role-switcher.md` },
    
    // Roles
    { url: `${KD_RAW_URL}/src/prompts/roles/analyst.md`, dest: `${KD_DIR}/prompts/roles/analyst.md` },
    { url: `${KD_RAW_URL}/src/prompts/roles/architect.md`, dest: `${KD_DIR}/prompts/roles/architect.md` },
    { url: `${KD_RAW_URL}/src/prompts/roles/engineer.md`, dest: `${KD_DIR}/prompts/roles/engineer.md` },
    
    // Stages
    { url: `${KD_RAW_URL}/src/prompts/stages/discovery.md`, dest: `${KD_DIR}/prompts/stages/discovery.md` },
    { url: `${KD_RAW_URL}/src/prompts/stages/brainstorm.md`, dest: `${KD_DIR}/prompts/stages/brainstorm.md` },
    { url: `${KD_RAW_URL}/src/prompts/stages/requirements.md`, dest: `${KD_DIR}/prompts/stages/requirements.md` },
    { url: `${KD_RAW_URL}/src/prompts/stages/architecture.md`, dest: `${KD_DIR}/prompts/stages/architecture.md` },
    { url: `${KD_RAW_URL}/src/prompts/stages/planning.md`, dest: `${KD_DIR}/prompts/stages/planning.md` },
    { url: `${KD_RAW_URL}/src/prompts/stages/implementation.md`, dest: `${KD_DIR}/prompts/stages/implementation.md` },
    { url: `${KD_RAW_URL}/src/prompts/stages/testing.md`, dest: `${KD_DIR}/prompts/stages/testing.md` },
    { url: `${KD_RAW_URL}/src/prompts/stages/quality.md`, dest: `${KD_DIR}/prompts/stages/quality.md` },
    { url: `${KD_RAW_URL}/src/prompts/stages/deployment.md`, dest: `${KD_DIR}/prompts/stages/deployment.md` },
    { url: `${KD_RAW_URL}/src/prompts/stages/release.md`, dest: `${KD_DIR}/prompts/stages/release.md` },
    
    // Language files
    { url: `${KD_RAW_URL}/src/config/language/en.json`, dest: `${KD_DIR}/config/language/en.json` },
    { url: `${KD_RAW_URL}/src/config/language/ms.json`, dest: `${KD_DIR}/config/language/ms.json` },
    
    // Templates
    { url: `${KD_RAW_URL}/src/templates/status.md`, dest: `${KD_DIR}/templates/status.md` },
    { url: `${KD_RAW_URL}/src/templates/product-brief.md`, dest: `${KD_DIR}/templates/product-brief.md` },
    { url: `${KD_RAW_URL}/src/templates/prd.md`, dest: `${KD_DIR}/templates/prd.md` },
    { url: `${KD_RAW_URL}/src/templates/architecture.md`, dest: `${KD_DIR}/templates/architecture.md` },
  ];

  for (const file of files) {
    try {
      const response = await axios.get(file.url);
      const destPath = path.join(process.cwd(), file.dest);
      fs.writeFileSync(destPath, response.data);
    } catch (error) {
      // Skip if file not found
    }
  }
}

async function createConfig(tools, language) {
  const projName = path.basename(process.cwd());
  const now = new Date().toISOString();

  const config = {
    version: VERSION,
    project_name: projName,
    language: language,
    target_tools: tools,
    scale: 'auto',
    installed_date: now,
    site: 'https://krackeddevs.com/',
    branding: 'KRACKEDDEVS',
  };

  const configPath = path.join(process.cwd(), `${KD_DIR}/config/settings.json`);
  fs.writeFileSync(configPath, JSON.stringify(config, null, 2));

  // Create status.md
  const statusContent = `# PROJECT STATUS

## Meta
- Project: ${projName}
- Language: ${language}
- Scale: [to be determined]
- Created: ${now.split('T')[0]}

## Current State
- Stage: Ready to begin
- Active Role: None

## Next Actions
1. Run /KD-analyze to begin discovery phase
`;

  const statusPath = path.join(process.cwd(), `${KD_DIR}/KD_output/status/status.md`);
  fs.writeFileSync(statusPath, statusContent);
}

async function setupAdapter(tool) {
  const adapterConfigs = {
    'claude-code': {
      dir: '.claude',
      file: 'CLAUDE.md',
      content: `# KD - AI Skill by KRACKEDDEVS
Read .kracked/prompts/system-prompt.md for full instructions.
Type /KD for command menu. Status: .kracked/KD_output/status/status.md`
    },
    'cursor': {
      dir: '.cursor',
      file: '.cursorrules',
      content: `# KD - AI Skill by KRACKEDDEVS
Read .kracked/prompts/system-prompt.md for full instructions.
Type /KD for command menu. Status: .kracked/KD_output/status/status.md`
    },
    'cline': {
      dir: '.clinerules',
      file: '.clinerules',
      content: `# KD - AI Skill by KRACKEDDEVS
Read .kracked/prompts/system-prompt.md for full instructions.
Type /KD for command menu. Status: .kracked/KD_output/status/status.md`
    },
    'kilocode': {
      dir: '.kilocode',
      file: '.kilocode',
      content: `# KD - AI Skill by KRACKEDDEVS
Read .kracked/prompts/system-prompt.md for full instructions.
Type /KD for command menu. Status: .kracked/KD_output/status/status.md`
    },
    'roo': {
      dir: '.roo',
      file: '.roo',
      content: `# KD - AI Skill by KRACKEDDEVS
Read .kracked/prompts/system-prompt.md for full instructions.
Type /KD for command menu. Status: .kracked/KD_output/status/status.md`
    },
  };

  const config = adapterConfigs[tool];
  if (config) {
    const dirPath = path.join(process.cwd(), config.dir);
    if (!fs.existsSync(dirPath)) {
      fs.mkdirSync(dirPath, { recursive: true });
    }
    const filePath = path.join(dirPath, config.file);
    fs.writeFileSync(filePath, config.content);
  }
}

function showSuccess(tools, language) {
  console.log();
  console.log(chalk.green('  ╔═══════════════════════════════════════════════════════════════╗'));
  console.log(chalk.green('  ║') + chalk.white('                                                               ') + chalk.green('║'));
  console.log(chalk.green('  ║') + chalk.bold.white('              ✅ INSTALLATION COMPLETE!                        ') + chalk.green('║'));
  console.log(chalk.green('  ║') + chalk.white('                                                               ') + chalk.green('║'));
  console.log(chalk.green('  ║') + chalk.white(`              KD v${VERSION} installed successfully!            `) + chalk.green('║'));
  console.log(chalk.green('  ║') + chalk.white('              AI Skill by KRACKEDDEVS                          ') + chalk.green('║'));
  console.log(chalk.green('  ║') + chalk.white('              https://krackeddevs.com/                         ') + chalk.green('║'));
  console.log(chalk.green('  ║') + chalk.white('                                                               ') + chalk.green('║'));
  console.log(chalk.green('  ╚═══════════════════════════════════════════════════════════════╝'));
  console.log();
  console.log(chalk.cyan('  📋 Installed:'));
  console.log(chalk.white(`     Adapters:  ${tools.join(', ')}`));
  console.log(chalk.white(`     Language:  ${language}`));
  console.log(chalk.white(`     Directory: ${process.cwd()}\\${KD_DIR}`));
  console.log();
  console.log(chalk.cyan('  📝 Next Steps:'));
  console.log(chalk.white('     1. Open your AI tool'));
  console.log(chalk.white('     2. Type /KD to see command menu'));
  console.log(chalk.white('     3. Run /KD-analyze to start your project'));
  console.log();
  console.log(chalk.cyan('  KD finishes what it starts.'));
  console.log();
}