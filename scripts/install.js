#!/usr/bin/env node
/**
 * KRACKED Skill - Auto Installer
 * Works on: Windows, macOS, Linux
 * Usage: npx kracked-skill
 */

const fs = require('fs');
const path = require('path');
const https = require('https');
const http = require('http');
const { execSync } = require('child_process');
const os = require('os');

// Plugin configuration
const PLUGIN_NAME = 'kracked-skill';
const PLUGIN_REPO = 'KrackedAI/kracked-skill';
const VERSION = '3.3.0';

// Colors for terminal output
const colors = {
  reset: '\x1b[0m',
  red: '\x1b[31m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  cyan: '\x1b[36m',
  white: '\x1b[37m'
};

function colorize(color, text) {
  return `${colors[color]}${text}${colors.reset}`;
}

function printHeader() {
  console.log('');
  console.log(colorize('cyan', '╔══════════════════════════════════════════════════════════════╗'));
  console.log(colorize('cyan', `║${colorize('green', ` KRACKED v${VERSION} - Claude Code Plugin Installer `)}║`));
  console.log(colorize('cyan', '╚══════════════════════════════════════════════════════════════╝'));
  console.log('');
}

function getPluginDir() {
  const platform = os.platform();
  const homeDir = os.homedir();

  // Detect Claude Code plugin directory
  if (platform === 'win32') {
    return path.join(homeDir, '.claude', 'plugins', PLUGIN_NAME);
  } else {
    // macOS and Linux
    return path.join(homeDir, '.claude', 'plugins', PLUGIN_NAME);
  }
}

function getClaudeDir() {
  const platform = os.platform();
  const homeDir = os.homedir();
  return path.join(homeDir, '.claude');
}

function downloadFile(url, dest) {
  return new Promise((resolve, reject) => {
    const protocol = url.startsWith('https') ? https : http;
    const file = fs.createWriteStream(dest);

    protocol.get(url, (response) => {
      if (response.statusCode === 302 || response.statusCode === 301) {
        // Follow redirect
        downloadFile(response.headers.location, dest).then(resolve).catch(reject);
        return;
      }

      if (response.statusCode !== 200) {
        reject(new Error(`Download failed: ${response.statusCode}`));
        return;
      }

      response.pipe(file);

      file.on('finish', () => {
        file.close();
        resolve();
      });
    }).on('error', (err) => {
      fs.unlink(dest, () => {});
      reject(err);
    });
  });
}

function extractZip(zipPath, destDir) {
  const platform = os.platform();

  if (platform === 'win32') {
    // Windows: Use PowerShell
    execSync(`powershell -Command "Expand-Archive -Path '${zipPath}' -DestinationPath '${destDir}' -Force"`, {
      stdio: 'inherit'
    });
  } else {
    // macOS/Linux: Try unzip, then tar
    try {
      execSync(`unzip -q "${zipPath}" -d "${destDir}"`, { stdio: 'inherit' });
    } catch (e) {
      // Fallback to python if unzip not available
      execSync(`python3 -m zipfile -e "${zipPath}" "${destDir}"`, { stdio: 'inherit' });
    }
  }
}

async function installPlugin() {
  printHeader();

  const claudeDir = getClaudeDir();
  const pluginDir = getPluginDir();
  const tempDir = path.join(os.tmpdir(), PLUGIN_NAME);
  const zipFile = path.join(tempDir, 'plugin.zip');

  console.log(colorize('blue', '[i] Installation Directory:'), pluginDir);
  console.log('');

  // Create Claude directories
  if (!fs.existsSync(claudeDir)) {
    console.log(colorize('yellow', '[!] Claude Code directory not found. Creating...'));
    fs.mkdirSync(claudeDir, { recursive: true });
  }

  const pluginsDir = path.join(claudeDir, 'plugins');
  if (!fs.existsSync(pluginsDir)) {
    fs.mkdirSync(pluginsDir, { recursive: true });
  }

  // Remove existing installation
  if (fs.existsSync(pluginDir)) {
    console.log(colorize('yellow', '[!] Plugin already installed. Updating...'));
    fs.rmSync(pluginDir, { recursive: true, force: true });
  }

  // Create temp directory
  fs.mkdirSync(tempDir, { recursive: true });

  try {
    // Try git clone first if available
    let hasGit = false;
    try {
      execSync('git --version', { stdio: 'ignore' });
      hasGit = true;
    } catch (e) {}

    if (hasGit) {
      console.log(colorize('blue', '[i] Cloning from GitHub...'));
      execSync(`git clone --depth 1 "https://github.com/${PLUGIN_REPO}.git" "${pluginDir}"`, {
        stdio: 'inherit'
      });
    } else {
      // Download zip file
      console.log(colorize('blue', '[i] Downloading plugin...'));
      const zipUrl = `https://github.com/${PLUGIN_REPO}/archive/refs/heads/main.zip`;

      await downloadFile(zipUrl, zipFile);

      console.log(colorize('blue', '[i] Extracting files...'));
      extractZip(zipFile, pluginsDir);

      // Move extracted directory to final location
      const extractedDir = path.join(pluginsDir, `${PLUGIN_NAME}-main`);
      if (fs.existsSync(extractedDir)) {
        fs.renameSync(extractedDir, pluginDir);
      }

      // Cleanup
      fs.unlinkSync(zipFile);
      fs.rmSync(tempDir, { recursive: true, force: true });
    }

    // Verify installation
    if (fs.existsSync(path.join(pluginDir, 'plugin.json'))) {
      console.log('');
      console.log(colorize('green', '[OK] Plugin installed successfully!'));
      console.log('');
      console.log(colorize('cyan', '══════════════════════════════════════════════════════════════'));
      console.log(colorize('green', 'Next Steps:'));
      console.log(`   1. ${colorize('yellow', 'Restart Claude Code')}`);
      console.log(`   2. Type ${colorize('cyan', '/kracked-help')} to see all commands`);
      console.log(`   3. Type ${colorize('cyan', '/analyze')} to start a new project`);
      console.log(`   4. Type ${colorize('cyan', '/language EN')} or ${colorize('cyan', '/language MS')} to select language`);
      console.log(colorize('cyan', '══════════════════════════════════════════════════════════════'));
      console.log('');
      console.log(colorize('blue', '[i] Documentation:'), `https://github.com/${PLUGIN_REPO}`;
      console.log('');
    } else {
      throw new Error('plugin.json not found after installation');
    }

  } catch (error) {
    console.log('');
    console.log(colorize('red', `[X] Installation failed: ${error.message}`));
    console.log('');
    console.log('Manual installation:');
    console.log(`  git clone https://github.com/${PLUGIN_REPO}.git "${pluginDir}"`);
    console.log('');
    process.exit(1);
  }
}

// Run installation
installPlugin().catch((error) => {
  console.error(colorize('red', `Error: ${error.message}`));
  process.exit(1);
});
