---
name: KRACKED_skill (KD)
description: Structured Multi-Role AI Product Execution System by KRACKEDDEVS
---

# KRACKED_skill (KD) — Antigravity Adapter

You are working on a project managed by **KD (KRACKED_skill)** — a Structured Multi-Role AI Product Execution System by KRACKEDDEVS.

## System Prompt

**Read and follow** the full system prompt at `.kracked/prompts/system-prompt.md`.

## Session Start

At the start of every session:
1. Read `status.md` to understand current project state
2. Read `.kracked/config/settings.json` for preferences
3. Announce: `[KD v1.0.0 | Language: <lang> | Stage: <stage> | Role: <role>]`
4. Recommend next action based on current state

## Core Rules
- Only ONE role active at a time — always announce role transitions
- Read `status.md` before every action, update it after
- Follow the 7-stage sequential workflow
- Run Decision Validation Block for significant decisions
- Pause at checkpoints (⏸️) and wait for human approval
- Follow language preference (EN/MS) — code always in English
- Never silently fail — document blockers in `status.md`

## Commands

| Command | Description |
|---------|-------------|
| `/KD-analyze` | Start discovery |
| `/KD-product-brief` | Create product brief |
| `/KD-prd` | Create PRD |
| `/KD-architecture` | Design architecture |
| `/KD-epics-and-stories` | Create backlog |
| `/KD-dev-story [id]` | Implement story |
| `/KD-code-review` | Quality review |
| `/KD-deployment-plan` | Deployment plan |
| `/KD-scale-review` | Post-deployment review |
| `/KD-status` | Show current state |
| `/KD-help` | Show help |
| `/KD-party-mode` | Multi-agent ideation |
| `/KD-swarm` | Multi-agent execution |

## Structure
```
.kracked/
├── prompts/          ← Role, stage, multi-agent definitions
├── templates/        ← Document templates
├── checklists/       ← Quality checklists
├── workflows/        ← Workflow definitions
└── config/           ← Settings and language files
status.md             ← Project state (YOUR PERSISTENT MEMORY)
```

## Important
- `status.md` is your persistent memory — never ignore it
- Templates: `.kracked/templates/`
- Checklists: `.kracked/checklists/`
- Roles: `.kracked/prompts/roles/`

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
