#!/bin/bash
# KRACKED Skill - Installer for Claude Code Plugin
# Supports: Linux, macOS, Windows (Git Bash/WSL)

set -e

# Plugin info
PLUGIN_NAME="kracked-skill"
PLUGIN_REPO="moonwiraja/kracked-skill"
VERSION="3.3.0"

echo ""
echo "============================================================"
echo " KRACKED v${VERSION} - Claude Code Plugin Installer"
echo "============================================================"
echo ""

# Detect OS and set plugin directory
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows (Git Bash)
    CLAUDE_DIR="$USERPROFILE/.claude"
else
    # Linux/macOS
    CLAUDE_DIR="$HOME/.claude"
fi

PLUGIN_DIR="$CLAUDE_DIR/plugins/$PLUGIN_NAME"

echo "Installation Directory: $PLUGIN_DIR"
echo ""

# Check if Claude Code directory exists
if [ ! -d "$CLAUDE_DIR" ]; then
    echo "Claude Code directory not found. Creating..."
    mkdir -p "$CLAUDE_DIR"
fi

# Create plugins directory
mkdir -p "$CLAUDE_DIR/plugins"

# Check if plugin already exists
if [ -d "$PLUGIN_DIR" ]; then
    echo "Plugin already installed. Updating..."
    rm -rf "$PLUGIN_DIR"
fi

# Download and install
echo "Downloading $PLUGIN_NAME..."
echo ""

# Try git clone first if available
if command -v git &> /dev/null; then
    git clone --depth 1 "https://github.com/${PLUGIN_REPO}.git" "$PLUGIN_DIR" || {
        echo "Git clone failed. Trying curl..."
        if command -v curl &> /dev/null; then
            curl -L "https://github.com/${PLUGIN_REPO}/archive/refs/heads/main.zip" -o /tmp/kracked-skill.zip
            unzip -q /tmp/kracked-skill.zip -d "$CLAUDE_DIR/plugins"
            mv "$CLAUDE_DIR/plugins/kracked-skill-main" "$PLUGIN_DIR"
            rm /tmp/kracked-skill.zip
        else
            echo "ERROR: Neither git nor curl available. Please install git."
            exit 1
        fi
    }
elif command -v curl &> /dev/null; then
    curl -L "https://github.com/${PLUGIN_REPO}/archive/refs/heads/main.zip" -o /tmp/kracked-skill.zip
    unzip -q /tmp/kracked-skill.zip -d "$CLAUDE_DIR/plugins"
    mv "$CLAUDE_DIR/plugins/kracked-skill-main" "$PLUGIN_DIR"
    rm /tmp/kracked-skill.zip
else
    echo "ERROR: Please install git or curl to download the plugin."
    exit 1
fi

# Verify installation
if [ -f "$PLUGIN_DIR/plugin.json" ]; then
    echo ""
    echo "============================================================"
    echo " Plugin installed successfully!"
    echo "============================================================"
    echo ""
    echo "Next Steps:"
    echo "  1. Restart Claude Code"
    echo "  2. Type /kracked-help to see all commands"
    echo "  3. Type /analyze to start a new project"
    echo "  4. Type /language EN or /language MS to select language"
    echo ""
    echo "Documentation: https://github.com/${PLUGIN_REPO}"
    echo ""
else
    echo "ERROR: Installation verification failed. Please check manually."
    exit 1
fi
