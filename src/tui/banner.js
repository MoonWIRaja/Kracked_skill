/**
 * KD Banner - Short KD Logo
 * AI Skill by KRACKEDDEVS
 */

import chalk from 'chalk';

export function showBanner() {
  console.log(chalk.cyan(`
╔═══════════════════════════════════════════════════════════════════════╗
║                                                                       ║
║   ${chalk.white('██╗  ██╗██████╗')}                                                     ║
║   ${chalk.white('██║ ██╔╝██╔══██╗')}                                                    ║
║   ${chalk.white('██████╔╝ ██║  ██║')}    ${chalk.yellow('AI Skill by KRACKEDDEVS')}                          ║
║   ${chalk.white('██╔═██╗ ██║  ██║')}    ${chalk.blue('https://krackeddevs.com/')}                         ║
║   ${chalk.white('██║  ██╗██████╔╝')}                                                    ║
║   ${chalk.white('╚═╝  ╚═╝╚═════╝')}                                                     ║
║                                                                       ║
╚═══════════════════════════════════════════════════════════════════════╝
`));
  console.log(chalk.gray(`  KD v5.0.0 | Structured Multi-Role AI Product Execution System`));
  console.log();
}

export function showSmallBanner() {
  console.log(chalk.cyan(`
  ╔═════════════════════════════════════════╗
  ║  ${chalk.white('KD')} v5.0.0 | ${chalk.yellow('KRACKEDDEVS')}        ║
  ╚═════════════════════════════════════════╝
`));
}