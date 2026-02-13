# KD System Architecture

## Overview
KD operates as a prompt-based system that guides AI tools through a structured product development workflow. It does not require a runtime — the system is entirely file-based.

## Architecture Diagram
```
┌─────────────────────────────────────────────┐
│                 AI TOOL                       │
│  (Claude Code / Cursor / Antigravity)        │
├─────────────────────────────────────────────┤
│                 ADAPTER                       │
│  (CLAUDE.md / .cursorrules / SKILL.md)       │
├─────────────────────────────────────────────┤
│              SYSTEM PROMPT                    │
│         (system-prompt.md)                    │
├──────────┬──────────┬──────────┬────────────┤
│  ROLES   │  STAGES  │  MULTI-  │  CONFIG    │
│  (9)     │  (7)     │  AGENT   │  + LANG    │
├──────────┴──────────┴──────────┴────────────┤
│  TEMPLATES (9) │ CHECKLISTS (6) │ WORKFLOWS │
├─────────────────────────────────────────────┤
│               status.md                      │
│         (Persistent State)                   │
└─────────────────────────────────────────────┘
```

## Components

### Adapter Layer
- Translates KD system prompt into tool-specific format
- Claude Code: `CLAUDE.md`
- Cursor: `.cursorrules`
- Antigravity: `.antigravity/SKILL.md`

### System Prompt
- Core instructions, rules, role/stage definitions
- `system-prompt.md` — single source of truth

### Roles
- 9 specialized roles with defined responsibilities
- Single role activation model
- Explicit transition protocol

### Stages
- 7 sequential stages with entry/exit criteria
- Human checkpoints at critical gates
- Scale-adaptive depth

### Multi-Agent
- Party Mode for ideation
- Agent Swarm for execution
- Confidence scoring and conflict resolution

### Templates & Checklists
- 9 document templates for consistent outputs
- 6 quality checklists for systematic verification

### Config & Language
- JSON-based configuration
- Dual language support (EN/MS)

### Status Tracking
- `status.md` — persistent project state
- Updated after every major action
- Read at every session start

## Data Flow
```
User Command → Adapter → System Prompt → Role Activation → Stage Execution → Template/Checklist → status.md Update
```

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
