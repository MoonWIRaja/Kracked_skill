# Cursor Adapter — README

## Setup
KD integration with Cursor is automatic. The `install.sh` script creates `.cursorrules` in your project root, which Cursor reads as its system instructions.

## How It Works
1. `.cursorrules` contains the KD system instructions
2. It references `.kracked/prompts/system-prompt.md` for full details
3. All `/KD-*` commands are interpreted by Cursor's AI

## Files Created
- `.cursorrules` — System instructions (project root)
- `.kracked/` — KD system files
- `status.md` — Project state tracker

## Usage
Type commands directly in Cursor's chat:
```
/KD-analyze
/KD-status
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
