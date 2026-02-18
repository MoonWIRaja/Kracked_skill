/**
 * Main Menu Screen
 * KD TUI Application
 */

import * as readline from 'readline';
import chalk from 'chalk';
import { installKD } from './install.js';
import { updateKD } from './update.js';
import { uninstallKD } from './uninstall.js';
import { showAbout } from './about.js';

const MENU_ITEMS = [
  { key: '1', name: '📦 Install KD', value: 'install', description: 'Install KD in current directory' },
  { key: '2', name: '🔄 Update KD', value: 'update', description: 'Update to latest version' },
  { key: '3', name: '🗑️  Uninstall KD', value: 'uninstall', description: 'Remove KD from directory' },
  { key: '4', name: 'ℹ️  About', value: 'about', description: 'Information about KD' },
  { key: '5', name: '🚪 Exit', value: 'exit', description: 'Exit the application' },
];

function waitForInput(prompt) {
  return new Promise((resolve) => {
    const rl = readline.createInterface({
      input: process.stdin,
      output: process.stdout,
    });
    
    rl.question(prompt, (answer) => {
      rl.close();
      resolve(answer.trim().toUpperCase());
    });
  });
}

export async function mainMenu(options = {}) {
  while (true) {
    console.log();
    console.log(chalk.white('  🚀 MAIN MENU'));
    console.log();
    
    for (const item of MENU_ITEMS) {
      console.log(chalk.cyan(`  [${item.key}]`) + ` ${item.name} - ${chalk.gray(item.description)}`);
    }
    console.log();

    const choice = await waitForInput(chalk.white('  Enter your choice [1-5]: '));
    const item = MENU_ITEMS.find(m => m.key === choice || m.value === choice.toLowerCase());

    if (!item) {
      console.log(chalk.red('\n  Invalid choice. Please try again.'));
      continue;
    }

    if (item.value === 'exit') {
      console.log(chalk.gray('\n  👋 Goodbye!'));
      console.log(chalk.cyan('  KD finishes what it starts.'));
      process.exit(0);
    }

    try {
      switch (item.value) {
        case 'install':
          await installKD(options);
          break;
        case 'update':
          await updateKD(options);
          break;
        case 'uninstall':
          await uninstallKD(options);
          break;
        case 'about':
          await showAbout();
          break;
      }

      // After operation, ask to continue
      console.log();
      const cont = await waitForInput(chalk.cyan('  Press [M] for Main Menu, any other key to Exit: '));
      
      if (cont !== 'M') {
        console.log(chalk.gray('\n  👋 Goodbye!'));
        console.log(chalk.cyan('  KD finishes what it starts.'));
        process.exit(0);
      }

    } catch (error) {
      console.error(chalk.red(`\n  Error: ${error.message}`));
      const cont = await waitForInput(chalk.cyan('\n  Press [M] for Main Menu, any other key to Exit: '));
      if (cont !== 'M') {
        process.exit(0);
      }
    }
  }
}