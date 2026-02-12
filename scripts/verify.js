#!/usr/bin/env node
/**
 * KRACKED Skill - Installation Verifier
 * Runs after npm install to verify plugin is correctly installed
 */

const fs = require('fs');
const path = require('path');
const os = require('os');

const PLUGIN_NAME = 'kracked-skill';

function getPluginDir() {
  const homeDir = os.homedir();
  return path.join(homeDir, '.claude', 'plugins', PLUGIN_NAME);
}

function verify() {
  const pluginDir = getPluginDir();
  const requiredFiles = [
    'plugin.json',
    'README.md',
    'commands/skills/analyze.md',
    'commands/utility/help.md',
    'skills/kracked-workflow.md',
    'agents/analyst.md'
  ];

  console.log(`[KRACKED] Verifying installation...`);

  let allExists = true;
  for (const file of requiredFiles) {
    const filePath = path.join(pluginDir, file);
    if (!fs.existsSync(filePath)) {
      console.log(`  [MISSING] ${file}`);
      allExists = false;
    }
  }

  if (allExists) {
    console.log('[KRACKED] Installation verified successfully!');
    return 0;
  } else {
    console.log('[KRACKED] Installation incomplete. Please reinstall.');
    return 1;
  }
}

process.exit(verify());
