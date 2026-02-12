---
name: retry
description: Retry current failed operation
---

# Retry Command

## Purpose

Retry the last failed operation after fixes have been applied.

## When to Use

After fixing:
- Dependency issues
- Configuration errors
- Network failures
- Missing files
- Permission issues

## Process

1. **Identify Failure**:
   - Read status.md for blockers
   - Identify what failed and why

2. **Verify Fixes**:
   - Check if blocking issues resolved
   - Confirm dependencies available

3. **Retry Operation**:
   - Re-execute the failed command
   - Use same parameters as original attempt

4. **Update Status**:
   - If successful: Remove from blockers
   - If failed again: Update with new error

## Output Format

```
┌────────────────────────────────────────────────────────────┐
│ 🔄 RETRYING OPERATION                                  │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Operation: [failed operation]                            │
│ Original Error: [error message]                          │
│                                                         │
│ Retrying...                                             │
│                                                         │
├────────────────────────────────────────────────────────────┤
│ RESULT                                                 │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Status: [SUCCESS | FAILED]                              │
│ [If success: Continue to next stage]                   │
│ [If failed: New error + suggestion]                     │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

## Blocking Status

If blockers remain:

```
⚠️ Cannot Retry - Active Blockers:
  • [Blocker 1]
  • [Blocker 2]

Resolve blockers before retrying.
```
