/**
 * Main Menu Screen
 * KD TUI Application
 */

import { select } from '@inquirer/prompts';
import chalk from 'chalk';
import { installKD } from './install.js';
import { updateKD } from './update.js';
import { uninstallKD } from './uninstall.js';
import { showAbout } from './about.js';

export async function mainMenu() {
  console.log(chalk.white('  🚀 MAIN MENU'));
  console.log();

  const choice = await select({
    message: 'Select an action:',
    choices: [
      { 
        name: '📦 Install KD    - Install KD in current directory', 
        value: 'install',
        description: 'Install Kracked_Skills system'
      },
      { 
        name: '🔄 Update KD     - Update to latest version', 
        value: 'update',
        description: 'Update existing installation'
      },
      { 
        name: '🗑️  Uninstall KD  - Remove KD from directory', 
        value: 'uninstall',
        description: 'Remove Kracked_Skills'
      },
      { 
        name: 'ℹ️  About         - Information about KD', 
        value: 'about',
        description: 'Show version and info'
      },
      { 
        name: '🚪 Exit          - Exit the application', 
        value: 'exit',
        description: 'Quit'
      },
    ],
  });

  switch (choice) {
    case 'install':
      await installKD({});
      break;
    case 'update':
      await updateKD({});
      break;
    case 'uninstall':
      await uninstallKD({});
      break;
    case 'about':
      await showAbout();
      break;
    case 'exit':
      console.log(chalk.gray('\n  👋 Goodbye!'));
      console.log(chalk.cyan('  KD finishes what it starts.'));
      process.exit(0);
  }
}