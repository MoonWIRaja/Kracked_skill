/**
 * Update Screen
 * KD TUI Application
 */

import { confirm } from '@inquirer/prompts';
import chalk from 'chalk';
import ora from 'ora';
import fs from 'fs';
import path from 'path';
import axios from 'axios';

const VERSION = '5.0.0';
const KD_REPO = 'MoonWIRaja/Kracked_Skills';
const KD_RAW_URL = `https://raw.githubusercontent.com/${KD_REPO}/main`;
const KD_DIR = '.kracked';

export async function updateKD(options = {}) {
  console.log(chalk.cyan('  ───────────────────────────────────────────'));
  console.log(chalk.white('  🔄 UPDATE KD'));
  console.log(chalk.cyan('  ───────────────────────────────────────────'));
  console.log();

  const kdPath = path.join(process.cwd(), KD_DIR);
  if (!fs.existsSync(kdPath)) {
    console.log(chalk.red('  ❌ KD is not installed in this directory.'));
    console.log(chalk.gray('  Run "node kd.js install" to install KD first.'));
    return;
  }

  const configPath = path.join(kdPath, 'config/settings.json');
  let currentConfig = {};
  if (fs.existsSync(configPath)) {
    currentConfig = JSON.parse(fs.readFileSync(configPath, 'utf-8'));
  }

  console.log(chalk.white('  Current Version:'), chalk.cyan(currentConfig.version || VERSION));
  console.log(chalk.white('  Latest Version: '), chalk.green(VERSION));
  console.log();

  if (currentConfig.version === VERSION && !options.force) {
    console.log(chalk.yellow('  You are already on the latest version.'));
    const proceed = await confirm({ message: 'Reinstall anyway?', default: false });
    if (!proceed) {
      console.log(chalk.gray('\n  Update cancelled.'));
      return;
    }
  }

  if (!options.nonInteractive && !options.force) {
    const proceed = await confirm({ message: 'Proceed with update?', default: true });
    if (!proceed) {
      console.log(chalk.yellow('\n  Update cancelled.'));
      return;
    }
  }

  console.log();
  const spinner = ora('Updating KD...').start();

  try {
    spinner.text = 'Updating configuration...';
    currentConfig.version = VERSION;
    currentConfig.updated_date = new Date().toISOString();
    fs.writeFileSync(configPath, JSON.stringify(currentConfig, null, 2));

    spinner.succeed('Update complete!');
    
    console.log();
    console.log(chalk.green('  ✅ KD updated to v' + VERSION));
    console.log(chalk.cyan('  KD finishes what it starts.'));
    console.log();

  } catch (error) {
    spinner.fail('Update failed!');
    console.error(chalk.red(`  Error: ${error.message}`));
    throw error;
  }
}