# KD Commands Reference

## Workflow Commands

### `/KD-analyze`
Start discovery. Activates the Analyst role.
- Gathers project context
- Identifies risks
- Assesses project scale (SMALL/STANDARD/DEEP)

### `/KD-product-brief`
Create a Product Brief. Activates PM role.
- Requires: Discovery complete
- Produces: `product-brief.md`
- ⏸️ Requires human approval

### `/KD-prd`
Create a PRD. Activates PM role.
- Requires: Product Brief approved
- Produces: `prd.md`
- ⏸️ Requires human approval

### `/KD-architecture [--depth=quick|standard|deep]`
Design system architecture. Activates Architect role.
- Requires: PRD approved
- Produces: `architecture.md`
- ⏸️ Requires human approval
- `--depth=quick` — Key decisions only
- `--depth=standard` — Full architecture (default)
- `--depth=deep` — Comprehensive with diagrams

### `/KD-epics-and-stories`
Create implementation backlog. Activates Tech Lead role.
- Requires: Architecture approved
- Produces: Story cards

### `/KD-dev-story [id] [--focus=backend|frontend|full]`
Implement a story. Activates Engineer role.
- Requires: Story backlog created
- `--focus=backend` — Backend only
- `--focus=frontend` — Frontend only
- `--focus=full` — Full-stack (default)

### `/KD-code-review [--scope=full|diff] [--severity=normal|strict]`
Code quality and security review. Activates QA + Security roles.
- Requires: Implementation complete
- `--scope=full` — Entire codebase (default)
- `--scope=diff` — Changed files only
- `--severity=normal` — Standard review (default)
- `--severity=strict` — Stricter standards

### `/KD-deployment-plan [--env=staging|production]`
Create deployment strategy. Activates DevOps role.
- Requires: Quality checks passed
- `--env=staging` — Staging deployment
- `--env=production` — Production (⏸️ requires approval)

### `/KD-scale-review`
Post-deployment assessment. Activates Release Manager role.
- Requires: Deployment successful
- Produces: `release-notes.md`

## Utility Commands

### `/KD-status`
Display summary of current `status.md`.

### `/KD-help`
Show all available commands.

## Multi-Agent Commands

### `/KD-party-mode --agents=N --topic="topic"`
Parallel ideation with multiple perspectives.
- `--agents=N` — Number of agents (2-5, default: 3)
- `--topic` — Focus topic

### `/KD-swarm --agents=N --tasks="task1,task2"`
Parallel task execution.
- `--agents=N` — Number of agents (2-8)
- `--tasks` — Comma-separated task list

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
