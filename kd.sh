#!/bin/bash

# ═══════════════════════════════════════════════════════════════
# KD v5.0.0 — Shell Wrapper for TUI
# AI Skill by KRACKEDDEVS - https://krackeddevs.com/
# ═══════════════════════════════════════════════════════════════

KD_VERSION="5.0.0"
KD_REPO="MoonWIRaja/Kracked_Skills"
KD_RAW_URL="https://raw.githubusercontent.com/$KD_REPO/main"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Save the original directory where user ran the command
ORIGINAL_DIR="$(pwd)"

# Banner
show_banner() {
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════════════════╗"
    echo "║                                                                       ║"
    echo "║   ██╗  ██╗██████╗                                                     ║"
    echo "║   ██║ ██╔╝██╔══██╗                                                    ║"
    echo "║   █████╔╝ ██║  ██║    AI Skill by KRACKEDDEVS                          ║"
    echo "║   ██╔═██╗ ██║  ██║    https://krackeddevs.com/                         ║"
    echo "║   ██║  ██╗██████╔╝                                                    ║"
    echo "║   ╚═╝  ╚═╝╚═════╝                                                     ║"
    echo "║                                                                       ║"
    echo "╚═══════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo "  KD v$KD_VERSION | Structured Multi-Role AI Product Execution System"
    echo ""
}

# Main
show_banner

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}Error: Node.js is not installed.${NC}"
    echo "Please install Node.js from https://nodejs.org/"
    exit 1
fi

# Download KD to a cache folder
KD_FOLDER="$HOME/.kd-tui"

# Always download/update files to cache
echo -e "${CYAN}Setting up KD TUI...${NC}"

# Create folder
mkdir -p "$KD_FOLDER/src/tui/screens"

# Download files
echo -e "${CYAN}Downloading files...${NC}"

curl -fsSL "$KD_RAW_URL/kd.js" -o "$KD_FOLDER/kd.js" 2>/dev/null
curl -fsSL "$KD_RAW_URL/package.json" -o "$KD_FOLDER/package.json" 2>/dev/null
curl -fsSL "$KD_RAW_URL/src/tui/banner.js" -o "$KD_FOLDER/src/tui/banner.js" 2>/dev/null
curl -fsSL "$KD_RAW_URL/src/tui/screens/main-menu.js" -o "$KD_FOLDER/src/tui/screens/main-menu.js" 2>/dev/null
curl -fsSL "$KD_RAW_URL/src/tui/screens/install.js" -o "$KD_FOLDER/src/tui/screens/install.js" 2>/dev/null
curl -fsSL "$KD_RAW_URL/src/tui/screens/update.js" -o "$KD_FOLDER/src/tui/screens/update.js" 2>/dev/null
curl -fsSL "$KD_RAW_URL/src/tui/screens/uninstall.js" -o "$KD_FOLDER/src/tui/screens/uninstall.js" 2>/dev/null
curl -fsSL "$KD_RAW_URL/src/tui/screens/about.js" -o "$KD_FOLDER/src/tui/screens/about.js" 2>/dev/null

# Check if files were downloaded
if [ ! -f "$KD_FOLDER/kd.js" ]; then
    echo -e "${RED}Error: Failed to download KD files.${NC}"
    exit 1
fi

# Install dependencies if needed
if [ ! -d "$KD_FOLDER/node_modules" ]; then
    if command -v npm &> /dev/null; then
        echo -e "${CYAN}Installing dependencies...${NC}"
        (cd "$KD_FOLDER" && npm install --silent 2>/dev/null)
    fi
fi

echo -e "${GREEN}Launching KD TUI...${NC}"
echo ""

# Redirect stdin to /dev/tty for interactive input
exec < /dev/tty

# Run from cache folder but ALWAYS pass original directory
# This is the key fix - always pass --install-dir
cd "$KD_FOLDER"
node kd.js --install-dir="$ORIGINAL_DIR" "$@" 2>&1
