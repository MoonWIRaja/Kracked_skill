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

export async function mainMenu(options = {}) {
  console.log(chalk.white('  🚀 MAIN MENU'));
  console.log();
  
  // Show menu options
  for (const item of MENU_ITEMS) {
    console.log(chalk.cyan(`  [${item.key}]`) + ` ${item.name} - ${chalk.gray(item.description)}`);
  }
  console.log();

  // Use readline for input - works in all environments
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  return new Promise((resolve, reject) => {
    rl.question(chalk.white('  Enter your choice [1-5]: '), async (answer) => {
      rl.close();
      
      const choice = answer.trim();
      const item = MENU_ITEMS.find(m => m.key === choice || m.value === choice.toLowerCase());
      
      if (!item) {
        console.log(chalk.red('\n  Invalid choice. Please try again.'));
        console.log();
        resolve(await mainMenu(options));
        return;
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
          case 'exit':
            console.log(chalk.gray('\n  👋 Goodbye!'));
            console.log(chalk.cyan('  KD finishes what it starts.'));
            process.exit(0);
        }
        resolve();
      } catch (error) {
        reject(error);
      }
    });
  });
}
