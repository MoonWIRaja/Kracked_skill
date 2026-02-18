/**
 * About Screen
 * KD TUI Application
 */

import chalk from 'chalk';

export async function showAbout() {
  console.log(chalk.cyan('  ───────────────────────────────────────────'));
  console.log(chalk.white('  ℹ️  ABOUT KD'));
  console.log(chalk.cyan('  ───────────────────────────────────────────'));
  console.log();
  
  console.log(chalk.cyan('  ╔═══════════════════════════════════════════════════════════════╗'));
  console.log(chalk.cyan('  ║') + chalk.white('                                                               ') + chalk.cyan('║'));
  console.log(chalk.cyan('  ║') + chalk.white('   ██╗  ██╗██████╗                                             ') + chalk.cyan('║'));
  console.log(chalk.cyan('  ║') + chalk.white('   ██║ ██╔╝██╔══██╗                                            ') + chalk.cyan('║'));
  console.log(chalk.cyan('  ║') + chalk.yellow('   █████╔╝ ██║  ██║    AI Skill by KRACKEDDEVS                  ') + chalk.cyan('║'));
  console.log(chalk.cyan('  ║') + chalk.blue('   ██╔═██╗ ██║  ██║    https://krackeddevs.com/                 ') + chalk.cyan('║'));
  console.log(chalk.cyan('  ║') + chalk.white('   ██║  ██╗██████╔╝                                            ') + chalk.cyan('║'));
  console.log(chalk.cyan('  ║') + chalk.white('   ╚═╝  ╚═╝╚═════╝                                             ') + chalk.cyan('║'));
  console.log(chalk.cyan('  ║') + chalk.white('                                                               ') + chalk.cyan('║'));
  console.log(chalk.cyan('  ╚═══════════════════════════════════════════════════════════════╝'));
  console.log();
  
  console.log(chalk.white('  Version:      ') + chalk.green('5.0.0'));
  console.log(chalk.white('  Name:         ') + chalk.cyan('Kracked_Skills (KD)'));
  console.log(chalk.white('  Author:       ') + chalk.yellow('KRACKEDDEVS'));
  console.log(chalk.white('  Website:      ') + chalk.blue('https://krackeddevs.com/'));
  console.log(chalk.white('  GitHub:       ') + chalk.gray('https://github.com/MoonWIRaja/Kracked_Skills'));
  console.log();
  
  console.log(chalk.white('  Description:'));
  console.log(chalk.gray('  Structured Multi-Role AI Product Execution System'));
  console.log();
  
  console.log(chalk.cyan('  ┌─────────────────────────────────────────┐'));
  console.log(chalk.cyan('  │') + chalk.bold.white('         FEATURES                          ') + chalk.cyan('│'));
  console.log(chalk.cyan('  └─────────────────────────────────────────┘'));
  console.log();
  console.log(chalk.gray('  • 9 Workflow Stages (discovery → release)'));
  console.log(chalk.gray('  • 92 Commands (analyze, prd, architecture...)'));
  console.log(chalk.gray('  • 14 AI Roles (architect, engineer, qa...)'));
  console.log(chalk.gray('  • 16 Technical Skills (react, devops...)'));
  console.log(chalk.gray('  • 9 Templates (prd, story-card...)'));
  console.log(chalk.gray('  • 6 Checklists (security, code-quality...)'));
  console.log(chalk.gray('  • 5 Multi-Agent Modes (party-mode, swarm...)'));
  console.log(chalk.gray('  • 6 AI Tool Adapters'));
  console.log(chalk.gray('  • Multi-Language Support (EN, MS, Custom)'));
  console.log();
  
  console.log(chalk.cyan('  ┌─────────────────────────────────────────┐'));
  console.log(chalk.cyan('  │') + chalk.bold.white('         AI TOOL ADAPTERS                  ') + chalk.cyan('│'));
  console.log(chalk.cyan('  └─────────────────────────────────────────┘'));
  console.log();
  console.log(chalk.cyan('  [1]') + chalk.white(' Claude Code') + chalk.gray('   → .claude/commands/'));
  console.log(chalk.cyan('  [2]') + chalk.white(' Cursor') + chalk.gray('       → .cursor/commands/'));
  console.log(chalk.cyan('  [3]') + chalk.white(' Cline') + chalk.gray('       → .clinerules/workflows/'));
  console.log(chalk.cyan('  [4]') + chalk.white(' Kilo Code') + chalk.gray('    → .kilocode/workflows/'));
  console.log(chalk.cyan('  [5]') + chalk.white(' Roo Code') + chalk.gray('     → .roo/commands/'));
  console.log(chalk.cyan('  [6]') + chalk.white(' Antigravity') + chalk.gray('  → .agent/workflows/'));
  console.log();
  
  console.log(chalk.cyan('  ┌─────────────────────────────────────────┐'));
  console.log(chalk.cyan('  │') + chalk.bold.white('         QUICK START                       ') + chalk.cyan('│'));
  console.log(chalk.cyan('  └─────────────────────────────────────────┘'));
  console.log();
  console.log(chalk.white('  1. Install KD in your project'));
  console.log(chalk.white('  2. Open your AI tool'));
  console.log(chalk.white('  3. Type ') + chalk.cyan('/KD') + chalk.white(' to see all commands'));
  console.log(chalk.white('  4. Run ') + chalk.cyan('/KD-analyze') + chalk.white(' to start your project'));
  console.log();
  
  console.log(chalk.green('  ┌─────────────────────────────────────────┐'));
  console.log(chalk.green('  │') + chalk.bold.white('  Motto: "KD finishes what it starts."    ') + chalk.green('│'));
  console.log(chalk.green('  │') + chalk.white('  License: MIT                            ') + chalk.green('│'));
  console.log(chalk.green('  └─────────────────────────────────────────┘'));
  console.log();
}