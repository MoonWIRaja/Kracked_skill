#!/usr/bin/env node

/**
 * Kracked_Skills (KD) v5.0.0
 * TUI Application - Install, Update, Uninstall
 * AI Skill by KRACKEDDEVS - https://krackeddevs.com/
 */

import { mainMenu } from './src/tui/screens/main-menu.js';
import { installKD } from './src/tui/screens/install.js';
import { updateKD } from './src/tui/screens/update.js';
import { uninstallKD } from './src/tui/screens/uninstall.js';
import { showAbout } from './src/tui/screens/about.js';
import { showBanner } from './src/tui/banner.js';

const VERSION = '5.0.0';

// Parse command line arguments
const args = process.argv.slice(2);
const command = args[0];

// Non-interactive flags
const nonInteractive = args.includes('--non-interactive') || args.includes('-ni');
const force = args.includes('--force') || args.includes('-f');

// Parse options
function getOption(name, shortName) {
  const idx = args.findIndex(a => a === `--${name}` || a === `-${shortName}`);
  if (idx !== -1 && args[idx + 1]) {
    return args[idx + 1];
  }
  return null;
}

const targetOption = getOption('target', 't');
const langOption = getOption('lang', 'l');

// Main function
async function main() {
  try {
    // Direct command mode
    if (command) {
      switch (command.toLowerCase()) {
        case 'install':
        case 'i':
          showBanner();
          await installKD({ 
            target: targetOption, 
            lang: langOption, 
            nonInteractive, 
            force 
          });
          return;
        
        case 'update':
        case 'u':
          showBanner();
          await updateKD({ nonInteractive, force });
          return;
        
        case 'uninstall':
        case 'x':
        case 'remove':
          showBanner();
          await uninstallKD({ nonInteractive, force });
          return;
        
        case 'about':
        case 'info':
          showBanner();
          await showAbout();
          return;
        
        case 'version':
        case 'v':
        case '-v':
        case '--version':
          console.log(`KD v${VERSION}`);
          return;
        
        case 'help':
        case 'h':
        case '-h':
        case '--help':
          showHelp();
          return;
        
        default:
          // Unknown command, show menu
          break;
      }
    }
    
    // Interactive TUI mode
    showBanner();
    await mainMenu();
    
  } catch (error) {
    console.error('\n❌ Error:', error.message);
    process.exit(1);
  }
}

function showHelp() {
  console.log(`
╔═══════════════════════════════════════════════════════════════╗
║                    KD v${VERSION} - Help                         ║
╠═══════════════════════════════════════════════════════════════╣
║                                                               ║
║  Usage: node kd.js [command] [options]                        ║
║                                                               ║
║  Commands:                                                    ║
║    install, i     Install KD in current directory             ║
║    update, u      Update KD to latest version                 ║
║    uninstall, x   Remove KD from current directory            ║
║    about          Show information about KD                   ║
║    version        Show version number                         ║
║    help           Show this help message                      ║
║                                                               ║
║  Options:                                                     ║
║    --target, -t   Target AI tool(s)                           ║
║                    (claude-code,cursor,cline,kilocode,roo)    ║
║    --lang, -l     Language (en, ms, or custom)                ║
║    --non-interactive, -ni  Skip prompts, use defaults         ║
║    --force, -f    Force overwrite existing installation       ║
║                                                               ║
║  Examples:                                                    ║
║    node kd.js                                    # TUI mode   ║
║    node kd.js install                            # Install    ║
║    node kd.js i -t cline -l ms                   # Quick      ║
║    node kd.js update                             # Update     ║
║    node kd.js uninstall                          # Remove     ║
║                                                               ║
║  Remote Install:                                              ║
║    curl -fsSL .../kd.sh | bash       # Linux/Mac              ║
║    irm .../kd.ps1 | iex              # Windows                ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
`);
}

// Run main
main();