# KD Core v5.0.0
# AI Skill by KRACKEDDEVS | https://krackeddevs.com/

## Entry Point

```
1. Read status: .kracked/KD_output/status/status.md
2. Read indexes: .kracked/core/indexes/*.md
3. Load skills: On demand based on role/task
4. Execute: Follow workflow stage
```

## Quick Reference

| Resource | Location | Purpose |
|----------|----------|---------|
| Skills Index | `.kracked/core/indexes/skills-index.md` | 9 skills, load on demand |
| Commands Index | `.kracked/core/indexes/commands-index.md` | 88 commands, lazy load |
| Tools Index | `.kracked/core/indexes/tools-index.md` | Tool Selector, TestSprite, Multi-Agent |
| Roles Index | `.kracked/core/indexes/roles-index.md` | 16 roles, skill mapping |
| Stages Index | `.kracked/core/indexes/stages-index.md` | 8 stages workflow |

## Activation Flow

```
Start → Read Status → Identify Stage → Load Skills → Execute
```

## Commands

- `/KD` — Show menu
- `/KD-status` — Current state
- `/KD-help` — Full reference

## Rules

1. Single role at a time
2. Follow language setting
3. Update status after actions
4. Auto-debug before status update
5. Get approval at checkpoints

## 8 Stages

```
Discovery → Brainstorm → Requirements → Architecture → Implementation → Quality → Deployment → Release
```

---
*KD finishes what it starts.*