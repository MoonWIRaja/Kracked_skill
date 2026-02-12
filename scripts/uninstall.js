#!/usr/bin/env node
/**
 * KRACKED Skill - Uninstaller
 */

const fs = require('fs');
const path = require('path');
const os = require('os');

const PLUGIN_NAME = 'kracked-skill';

function getPluginDir() {
  const homeDir = os.homedir();
  return path.join(homeDir, '.claude', 'plugins', PLUGIN_NAME);
}

function uninstall() {
  const pluginDir = getPluginDir();

  if (fs.existsSync(pluginDir)) {
    console.log(`[KRACKED] Uninstalling from ${pluginDir}`);
    fs.rmSync(pluginDir, { recursive: true, force: true });
    console.log('[KRACKED] Uninstalled successfully!');
    console.log('Please restart Claude Code.');
  } else {
    console.log('[KRACKED] Plugin not found. Already uninstalled?');
  }
}

uninstall();
