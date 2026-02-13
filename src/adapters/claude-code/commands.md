# Claude Code Adapter — Command Reference

## Slash Commands

All KD commands are implemented as natural language directives that Claude Code interprets from the CLAUDE.md system file.

### Workflow Commands
- `/KD-analyze` — Activate Analyst role, start Discovery stage
- `/KD-product-brief` — Activate PM role, create product brief
- `/KD-prd` — Activate PM role, create PRD
- `/KD-architecture [--depth=quick|standard|deep]` — Activate Architect, design system
- `/KD-epics-and-stories` — Activate Tech Lead, create backlog
- `/KD-dev-story [id] [--focus=backend|frontend|full]` — Activate Engineer, implement story
- `/KD-code-review [--scope=full|diff] [--severity=normal|strict]` — Activate QA + Security
- `/KD-deployment-plan [--env=staging|production]` — Activate DevOps
- `/KD-scale-review` — Activate Release Manager

### Utility Commands
- `/KD-status` — Display current `status.md` summary
- `/KD-help` — Show available commands

### Multi-Agent Commands
- `/KD-party-mode --agents=N --topic="topic"` — Parallel ideation (2-5 agents)
- `/KD-swarm --agents=N --tasks="task1,task2"` — Parallel execution (2-8 agents)

## Usage in Claude Code
Simply type any command in the Claude Code chat. Claude reads `CLAUDE.md` automatically and will follow the KD system prompt.

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
