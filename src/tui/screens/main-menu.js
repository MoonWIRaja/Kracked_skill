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

function askContinue() {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  return new Promise((resolve) => {
    rl.question(chalk.cyan('\n  Press [M] for Main Menu or [E] to Exit: '), (answer) => {
      rl.close();
      const choice = answer.trim().toUpperCase();
      resolve(choice === 'M' ? 'menu' : 'exit');
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

    const rl = readline.createInterface({
      input: process.stdin,
      output: process.stdout,
    });

    const choice = await new Promise((resolve) => {
      rl.question(chalk.white('  Enter your choice [1-5]: '), (answer) => {
        rl.close();
        resolve(answer.trim());
      });
    });

    const item = MENU_ITEMS.find(m => m.key === choice || m.value === choice.toLowerCase());

    if (!item) {
      console.log(chalk.red('\n  Invalid choice. Please try again.'));
      continue;
    }

    try {
      switch (item.value) {
        case 'install':
          await installKD(options);
          const installChoice = await askContinue();
          if (installChoice === 'exit') {
            console.log(chalk.gray('\n  👋 Goodbye!'));
            console.log(chalk.cyan('  KD finishes what it starts.'));
            process.exit(0);
          }
          break;

        case 'update':
          await updateKD(options);
          const updateChoice = await askContinue();
          if (updateChoice === 'exit') {
            console.log(chalk.gray('\n  👋 Goodbye!'));
            console.log(chalk.cyan('  KD finishes what it starts.'));
            process.exit(0);
          }
          break;

        case 'uninstall':
          await uninstallKD(options);
          const uninstallChoice = await askContinue();
          if (uninstallChoice === 'exit') {
            console.log(chalk.gray('\n  👋 Goodbye!'));
            console.log(chalk.cyan('  KD finishes what it starts.'));
            process.exit(0);
          }
          break;

        case 'about':
          await showAbout();
          const aboutChoice = await askContinue();
          if (aboutChoice === 'exit') {
            console.log(chalk.gray('\n  👋 Goodbye!'));
            console.log(chalk.cyan('  KD finishes what it starts.'));
            process.exit(0);
          }
          break;

        case 'exit':
          console.log(chalk.gray('\n  👋 Goodbye!'));
          console.log(chalk.cyan('  KD finishes what it starts.'));
          process.exit(0);
      }
    } catch (error) {
      console.error(chalk.red(`\n  Error: ${error.message}`));
      const errorChoice = await askContinue();
      if (errorChoice === 'exit') {
        process.exit(0);
      }
    }
  }
}