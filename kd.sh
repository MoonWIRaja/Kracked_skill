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

# Download and run TUI
run_tui() {
    show_banner
    
    # Check if Node.js is installed
    if ! command -v node &> /dev/null; then
        echo -e "${RED}Error: Node.js is not installed.${NC}"
        echo "Please install Node.js from https://nodejs.org/"
        exit 1
    fi
    
    # Check if we're in a KD repo directory
    if [ -f "kd.js" ]; then
        # Run local TUI
        node kd.js "$@"
    else
        # Download and run remote TUI
        echo -e "${CYAN}Downloading KD TUI...${NC}"
        
        # Create temp directory
        TEMP_DIR=$(mktemp -d)
        
        # Download kd.js and package.json
        curl -fsSL "$KD_RAW_URL/kd.js" -o "$TEMP_DIR/kd.js" 2>/dev/null
        curl -fsSL "$KD_RAW_URL/package.json" -o "$TEMP_DIR/package.json" 2>/dev/null
        
        # Download TUI modules
        mkdir -p "$TEMP_DIR/src/tui/screens"
        curl -fsSL "$KD_RAW_URL/src/tui/banner.js" -o "$TEMP_DIR/src/tui/banner.js" 2>/dev/null
        curl -fsSL "$KD_RAW_URL/src/tui/screens/main-menu.js" -o "$TEMP_DIR/src/tui/screens/main-menu.js" 2>/dev/null
        curl -fsSL "$KD_RAW_URL/src/tui/screens/install.js" -o "$TEMP_DIR/src/tui/screens/install.js" 2>/dev/null
        curl -fsSL "$KD_RAW_URL/src/tui/screens/update.js" -o "$TEMP_DIR/src/tui/screens/update.js" 2>/dev/null
        curl -fsSL "$KD_RAW_URL/src/tui/screens/uninstall.js" -o "$TEMP_DIR/src/tui/screens/uninstall.js" 2>/dev/null
        curl -fsSL "$KD_RAW_URL/src/tui/screens/about.js" -o "$TEMP_DIR/src/tui/screens/about.js" 2>/dev/null
        
        # Install dependencies and run
        cd "$TEMP_DIR"
        
        if command -v npm &> /dev/null; then
            echo -e "${CYAN}Installing dependencies...${NC}"
            npm install --silent 2>/dev/null
        fi
        
        echo -e "${GREEN}Launching KD TUI...${NC}"
        echo ""
        
        node kd.js "$@"
        
        # Cleanup
        cd - > /dev/null
        rm -rf "$TEMP_DIR"
    fi
}

# Main
run_tui "$@"