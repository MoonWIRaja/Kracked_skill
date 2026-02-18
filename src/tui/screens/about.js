/**
 * About Screen
 * KD TUI Application
 */

import chalk from 'chalk';

const VERSION = '5.0.0';

export async function showAbout() {
  console.log(chalk.cyan('  ───────────────────────────────────────────'));
  console.log(chalk.white('  ℹ️  ABOUT KD'));
  console.log(chalk.cyan('  ───────────────────────────────────────────'));
  console.log();
  
  console.log(chalk.cyan(`
  ╔═══════════════════════════════════════════════════════════════╗
  ║                                                               ║
  ║   ██╗  ██╗██████╗                                             ║
  ║   ██║ ██╔╝██╔══██╗                                            ║
  ║   █████╔╝ ██║  ██║    AI Skill by KRACKEDDEVS                  ║
  ║   ██╔═██╗ ██║  ██║    https://krackeddevs.com/                 ║
  ║   ██║  ██╗██████╔╝                                            ║
  ║   ╚═╝  ╚═╝╚═════╝                                             ║
  ║                                                               ║
  ╚═══════════════════════════════════════════════════════════════╝
`));
  
  console.log(chalk.white('  Version:        '), chalk.cyan(VERSION));
  console.log(chalk.white('  Name:           '), chalk.cyan('Kracked_Skills (KD)'));
  console.log(chalk.white('  Author:         '), chalk.cyan('KRACKEDDEVS'));
  console.log(chalk.white('  Website:        '), chalk.blue('https://krackeddevs.com/'));
  console.log(chalk.white('  GitHub:         '), chalk.blue('https://github.com/MoonWIRaja/Kracked_Skills'));
  console.log();
  
  console.log(chalk.white('  Description:'));
  console.log(chalk.gray('  Structured Multi-Role AI Product Execution System'));
  console.log();
  
  console.log(chalk.white('  Features:'));
  console.log(chalk.gray('  • 10 Workflow Stages'));
  console.log(chalk.gray('  • 75 Commands'));
  console.log(chalk.gray('  • 16 AI Roles'));
  console.log(chalk.gray('  • 15 Technical Skills'));
  console.log(chalk.gray('  • 8 Tools'));
  console.log(chalk.gray('  • 6 AI Tool Adapters'));
  console.log(chalk.gray('  • Multi-Language Support (EN, MS, Custom)'));
  console.log();
  
  console.log(chalk.white('  Adapters:'));
  console.log(chalk.gray('  • Claude Code'));
  console.log(chalk.gray('  • Cursor'));
  console.log(chalk.gray('  • Cline'));
  console.log(chalk.gray('  • Kilo Code'));
  console.log(chalk.gray('  • Roo Code'));
  console.log(chalk.gray('  • Antigravity'));
  console.log();
  
  console.log(chalk.cyan('  Motto: '), chalk.white('"KD finishes what it starts."'));
  console.log();
  
  console.log(chalk.gray('  License: MIT'));
  console.log();
}