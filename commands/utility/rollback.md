---
name: rollback
description: Return to previous workflow stage
params:
  - name: stage
    description: Target stage to rollback to
    required: false
---

# Rollback Command

## Purpose

Return to a previous workflow stage when:
- Current stage needs revision
- Wrong direction taken
- Requirements changed
- User requested change

## Usage

`/rollback [stage]`

## Valid Stages

| Stage | Name | Command to Restart |
|-------|------|-------------------|
| 1 | Discovery | `/analyze` |
| 2 | Requirements | `/prd` |
| 3 | Architecture | `/architecture` |
| 4 | Implementation | `/dev-story [id]` |
| 5 | Quality | `/code-review` |
| 6 | Deployment | `/deployment-plan` |
| 7 | Release | `/scale-review` |

## Rollback Process

1. **Confirm Rollback**:
   ```
   ⚠️ ROLLBACK CONFIRMATION
   Target: [stage name]
   Impact: [what will be reverted]
   [CONFIRM] or [CANCEL]
   ```

2. **Update status.md**:
   - Update `Stage:` to target stage
   - Set `Active Role:` to appropriate role
   - Add change log entry

3. **Restore Context**:
   - Display key artifacts from target stage
   - Show decisions made at that stage
   - List risks identified

4. **Prompt Next Action**:
   - Suggest command to restart stage
   - Offer options to revise previous decisions

## Change Log Entry

```markdown
## Change Log
| Timestamp | Stage | Change | Role | Reason |
|-----------|-------|---------|------|--------|
| [now] | [current] | Rollback to [target] | System | User requested |
```

## Confirmation Message

```
┌────────────────────────────────────────────────────────────┐
│ ↩️ ROLLBACK COMPLETE                                   │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Previous Stage: [stage name]                            │
│ Current Stage: [target stage]                            │
│ Active Role: [role]                                      │
│                                                         │
│ To restart this stage: [command]                         │
│ To view artifacts: /show [artifact]                       │
│                                                         │
└────────────────────────────────────────────────────────────┘
```
