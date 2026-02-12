---
name: kracked-help
description: Display KRACKED command reference and quick start guide
---

# KRACKED v3.3 - Command Reference

## Primary Workflow Commands

| Command | Description | Stage |
|---------|-------------|--------|
| `/analyze` | Discovery & risk identification | 1 |
| `/prd` | Product Requirements Document | 2 |
| `/architecture --depth=[level]` | System architecture design | 3 |
| `/epics-and-stories` | Create backlog with epics and stories | 3 |
| `/dev-story [id] --focus=[scope]` | Implement single story | 4 |
| `/code-review --scope=[full\|diff]` | Quality & security review | 5 |
| `/deployment-plan --env=[staging\|production]` | Deployment strategy | 6 |
| `/scale-review` | Post-deployment review | 7 |

## Multi-Agent Commands

| Command | Description |
|---------|-------------|
| `/party-mode --stage=[stage] --agents=[n] --topic="[topic]"` | Parallel ideation |
| `/swarm --stage=[stage] --agents=[n] --tasks="[tasks]"` | Parallel execution |

## Utility Commands

| Command | Description |
|---------|-------------|
| `/language [EN\|MS]` | Display or change language |
| `/status` | Display project state |
| `/help` | This command reference |
| `/rollback [stage]` | Return to previous stage |
| `/retry` | Retry failed operation |
| `/compress-context` | Reduce context usage |
| `/show [artifact]` | Display specific artifact |

## Parameters

- `--depth=[quick\|standard\|deep]` - Architecture depth level
- `--focus=[backend\|frontend\|full]` - Implementation focus
- `--scope=[full\|diff]` - Code review scope
- `--severity=[strict\|normal]` - Code review severity
- `--env=[staging\|production]` - Deployment environment
- `--agents=[n]` - Number of multi-agents (2-8)

## Quick Start

1. **New Project**: `/analyze`
2. **Continue Project**: `/status`
3. **Change Language**: `/language EN` or `/language MS`

## Documentation

For complete guide, see: [docs/GUIDE.md](../docs/GUIDE.md)
