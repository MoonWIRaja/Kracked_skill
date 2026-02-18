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
  
  console.log(chalk.white('  KD (Kracked_Skills) v5.0.0'));
  console.log(chalk.gray('  Structured Multi-Role AI Product Execution System'));
  console.log();
  
  console.log(chalk.cyan('  ┌─────────────────────────────────────────┐'));
  console.log(chalk.cyan('  │') + chalk.white('         WHAT IS KD?                       ') + chalk.cyan('│'));
  console.log(chalk.cyan('  └─────────────────────────────────────────┘'));
  console.log();
  console.log(chalk.white('  KD is an AI-powered development assistant'));
  console.log(chalk.white('  that provides structured workflows for:'));
  console.log();
  console.log(chalk.gray('  • Project Discovery & Analysis'));
  console.log(chalk.gray('  • Requirements & PRD Generation'));
  console.log(chalk.gray('  • Architecture Design'));
  console.log(chalk.gray('  • Implementation & Testing'));
  console.log(chalk.gray('  • Deployment & Release'));
  console.log();
  
  console.log(chalk.cyan('  ┌─────────────────────────────────────────┐'));
  console.log(chalk.cyan('  │') + chalk.white('         AI TOOLS SUPPORTED                ') + chalk.cyan('│'));
  console.log(chalk.cyan('  └─────────────────────────────────────────┘'));
  console.log();
  console.log(chalk.cyan('  [1]') + chalk.white(' Claude Code') + chalk.gray(' - .claude/commands/'));
  console.log(chalk.cyan('  [2]') + chalk.white(' Cursor') + chalk.gray('      - .cursor/commands/'));
  console.log(chalk.cyan('  [3]') + chalk.white(' Cline') + chalk.gray('      - .clinerules/workflows/'));
  console.log(chalk.cyan('  [4]') + chalk.white(' Kilo Code') + chalk.gray('  - .kilocode/workflows/'));
  console.log(chalk.cyan('  [5]') + chalk.white(' Roo Code') + chalk.gray('   - .roo/commands/'));
  console.log(chalk.cyan('  [6]') + chalk.white(' Antigravity') + chalk.gray(' - .agent/workflows/'));
  console.log();
  
  console.log(chalk.cyan('  ┌─────────────────────────────────────────┐'));
  console.log(chalk.cyan('  │') + chalk.white('         QUICK START                       ') + chalk.cyan('│'));
  console.log(chalk.cyan('  └─────────────────────────────────────────┘'));
  console.log();
  console.log(chalk.white('  1. Install KD in your project'));
  console.log(chalk.white('  2. Open your AI tool'));
  console.log(chalk.white('  3. Type ') + chalk.cyan('/KD') + chalk.white(' to see commands'));
  console.log(chalk.white('  4. Run ') + chalk.cyan('/KD-analyze') + chalk.white(' to start'));
  console.log();
  
  console.log(chalk.cyan('  ┌─────────────────────────────────────────┐'));
  console.log(chalk.cyan('  │') + chalk.white('         AVAILABLE COMMANDS                ') + chalk.cyan('│'));
  console.log(chalk.cyan('  └─────────────────────────────────────────┘'));
  console.log();
  console.log(chalk.gray('  /KD              - Show command menu'));
  console.log(chalk.gray('  /KD-analyze      - Analyze project'));
  console.log(chalk.gray('  /KD-brainstorm   - Brainstorm ideas'));
  console.log(chalk.gray('  /KD-prd          - Generate PRD'));
  console.log(chalk.gray('  /KD-architecture - Design architecture'));
  console.log(chalk.gray('  /KD-status       - Show project status'));
  console.log(chalk.gray('  /KD-help         - Full command list'));
  console.log();
  
  console.log(chalk.green('  ┌─────────────────────────────────────────┐'));
  console.log(chalk.green('  │') + chalk.bold.white('  KRACKEDDEVS                              ') + chalk.green('│'));
  console.log(chalk.green('  │') + chalk.white('  https://krackeddevs.com/                 ') + chalk.green('│'));
  console.log(chalk.green('  │') + chalk.cyan('  KD finishes what it starts.              ') + chalk.green('│'));
  console.log(chalk.green('  └─────────────────────────────────────────┘'));
  console.log();
}