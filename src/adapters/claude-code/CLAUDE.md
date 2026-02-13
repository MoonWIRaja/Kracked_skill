# KD - AI Skill by KRACKEDDEVS
# Official Site: https://krackeddevs.com/

## Activation

KD is active in this project. Read the system prompt:

```
Read the file at .kracked/prompts/system-prompt.md
```

## `/KD` — Interactive Command Menu

When user types `/KD` alone (without any suffix), display the command menu showing:
- Current project state (stage, role, scale, language)
- All available commands with descriptions
- Recommended next command based on current state

## Slash Commands

The following slash commands are available. When the user types `/`, these should appear as suggestions:

### `/KD` — Command Menu
Show the interactive command menu with current project state and all available commands.

### `/KD-analyze` — Discovery Phase
Start discovery and risk assessment. Gathers context, identifies risks, assesses project scale.

### `/KD-brainstorm` — Ideation & Goals
Creative ideation, goal setting, market research, competitor analysis. Runs before requirements.

### `/KD-product-brief` — Product Brief
Create the product brief: vision, target users, MVP scope. Requires human approval.

### `/KD-prd` — Product Requirements
Create the full PRD with requirements, personas, and success metrics. Requires human approval.

### `/KD-architecture` — System Architecture
Design system architecture, tech stack selection, data models, API contracts. Requires human approval.

### `/KD-epics-and-stories` — Create Backlog
Create epics and stories for implementation. Organizes work into epic folders with story files.

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
Parallel brainstorming with named agent personas. Usage: `/KD-party-mode --agents=N --topic=TOPIC`

### `/KD-swarm` — Multi-Agent Execution
Parallel task execution with named agents. Usage: `/KD-swarm --agents=N --tasks=TASKS`

## Key Features
- **Named Agent Personas** — Each role has a unique name and personality
- **Web Research** — AI searches the web for market data, best practices
- **Auto-Debug** — System auto-checks for errors before updating status
- **Output Organization** — All output in `.kracked/KD_output/<category>/`

## Workflow

1. Read `.kracked/prompts/system-prompt.md` for full instructions
2. Read `.kracked/KD_output/status/status.md` for current project state
3. Execute commands following workflow stages
4. Auto-debug and verify before updating status

## Files Reference

- System Prompt: `.kracked/prompts/system-prompt.md`
- Status: `.kracked/KD_output/status/status.md`
- Templates: `.kracked/templates/`
- Checklists: `.kracked/checklists/`
- Output: `.kracked/KD_output/`

## Official Site

https://krackeddevs.com/
