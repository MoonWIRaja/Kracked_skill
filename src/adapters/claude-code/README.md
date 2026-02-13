# Claude Code Adapter — README

## Setup
KD integration with Claude Code is automatic. The `install.sh` script creates `CLAUDE.md` in your project root, which Claude Code reads as its system instructions.

## How It Works
1. `CLAUDE.md` references `.kracked/prompts/system-prompt.md`
2. Claude Code reads this at session start
3. All `/KD-*` commands are interpreted by Claude

## Files Created
- `CLAUDE.md` — System instructions (project root)
- `.kracked/` — KD system files
- `status.md` — Project state tracker

## Usage
```
# Start a new project
/KD-analyze

# View current status
/KD-status

# Get help
/KD-help
```

## Updating
```bash
bash update.sh
```

## Uninstalling
```bash
bash uninstall.sh
```

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
