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
1. Read `.kracked/KD_output/status/status.md` to understand current project state
2. Read `.kracked/config/settings.json` for preferences
3. Announce: `[KD v2.0.0-beta | Language: <lang> | Stage: <stage> | Role: <role>]`
4. Recommend next action based on current state

## Core Rules
- Only ONE role active at a time — always announce role transitions
- Each role has a **unique name and personality** (see system-prompt.md)
- Read `status.md` before every action, update it after
- **Auto-debug** all files before updating status — check for errors, verify goals
- Follow the 8-stage sequential workflow
- Run Decision Validation Block for significant decisions
- Pause at checkpoints (⏸️) and wait for human approval
- Follow language preference (EN/MS) — code always in English
- Never silently fail — document blockers in `status.md`
- ALL output files go to `.kracked/KD_output/<category>/`
- **Search the web** for research, validation, and best practices

## `/KD` — Interactive Command Menu

When user types `/KD` alone, display the command menu showing current state and all available commands with descriptions. Show the recommended next command based on current project state.

## Slash Commands

The following slash commands are available. When the user types `/`, these should appear as suggestions:

### `/KD` — Command Menu
Show the interactive command menu with current project state and all available commands.

### `/KD-analyze` — Discovery Phase
Start discovery and risk assessment. Gathers context, identifies risks, assesses project scale.

### `/KD-brainstorm` — Ideation & Goals
Creative ideation, goal setting, market research, competitor analysis.

### `/KD-product-brief` — Product Brief
Create the product brief: vision, target users, MVP scope. Requires human approval.

### `/KD-prd` — Product Requirements
Create the full PRD with requirements, personas, and success metrics. Requires human approval.

### `/KD-architecture` — System Architecture
Design system architecture, tech stack selection, data models, API contracts. Requires human approval.

### `/KD-epics-and-stories` — Create Backlog
Create epics and stories for implementation. Organizes into epic folders with story files.

### `/KD-dev-story` — Implement Story
Implement a specific story. Usage: `/KD-dev-story [epic-id] [story-id]`. Tracks all code file locations.

### `/KD-code-review` — Quality Review
Code quality and security review. Checks coverage, style, performance, vulnerabilities.

### `/KD-deployment-plan` — Deployment Strategy
Create deployment plan with staging/production strategy, rollback, and monitoring.

### `/KD-scale-review` — Post-Deployment Review
Post-deployment assessment, release notes, version tagging, monitoring.

### `/KD-status` — Project State
Display current project state from status.md.

### `/KD-help` — Command Reference
Show detailed help for all commands and their parameters.

### `/KD-party-mode` — Multi-Agent Ideation
Parallel brainstorming with named personas. Usage: `/KD-party-mode --agents=N --topic=TOPIC`

### `/KD-swarm` — Multi-Agent Execution
Parallel execution with named agents. Usage: `/KD-swarm --agents=N --tasks=TASKS`

## Output Structure
```
.kracked/KD_output/
├── status/status.md
├── brainstorm/brainstorm.md
├── product-brief/product-brief.md
├── PRD/prd.md
├── architecture/architecture.md
├── epics-and-stories/
│   ├── epic-1/
│   │   ├── stories1-1.md
│   │   └── stories1-2.md
│   └── epic-2/
│       ├── stories2-1.md
│       └── stories2-2.md
├── code-review/code-review.md
├── deployment/deployment-plan.md
├── release/release-notes.md
├── decisions/decision-log.md
└── risks/risk-register.md
```

## Structure
```
.kracked/
├── prompts/          ← Role, stage, multi-agent definitions
├── templates/        ← Document templates
├── checklists/       ← Quality checklists
├── workflows/        ← Workflow definitions
├── config/           ← Settings and language files
└── KD_output/        ← ALL AI-generated output
```

## Important
- `.kracked/KD_output/status/status.md` is your persistent memory — never ignore it
- Templates: `.kracked/templates/`
- Checklists: `.kracked/checklists/`
- Roles: `.kracked/prompts/roles/`

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
