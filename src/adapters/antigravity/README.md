# Antigravity Adapter — README

## Setup
KD integration with Antigravity (Google Gemini/Deepmind) uses the `.antigravity/` skill directory. The `install.sh` script creates `SKILL.md` inside `.antigravity/` in your project root.

## How It Works
1. `.antigravity/SKILL.md` contains the KD skill definition with YAML frontmatter
2. Antigravity discovers and loads the skill automatically
3. All `/KD-*` commands are available through Antigravity chat

## Files Created
- `.antigravity/SKILL.md` — Skill definition (project root)
- `.kracked/` — KD system files
- `status.md` — Project state tracker

## Usage
Type commands directly in Antigravity chat:
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
