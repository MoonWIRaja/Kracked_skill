---
name: swarm
description: Multi-agent parallel task execution mode
params:
  - name: stage
    description: Current workflow stage
    required: true
  - name: agents
    description: Number of micro-agents (2-8)
    required: false
    default: 3
  - name: tasks
    description: Comma-separated list of sub-tasks
    required: true
---

# Agent Swarm

## Purpose

Execute independent sub-tasks in parallel, then aggregate outputs into a cohesive final artifact.

## Parameters

- `--stage=[stage]`: Current workflow stage
- `--agents=[2-8]`: Number of micro-agents to deploy
- `--tasks="[tasks]"`: Comma-separated sub-task descriptions

## When to Use Swarm

- Task can be cleanly decomposed into 3+ independent sub-tasks
- Parallel execution saves significant time
- Multiple files need simultaneous modification
- Large documentation task with distinct sections
- Multiple test suites to write in parallel

## Activation Warning

```
┌────────────────────────────────────────────────────────────┐
│ ℹ️ MULTI-AGENT MODE ACTIVATION                         │
├────────────────────────────────────────────────────────────┤
│ Mode: Agent Swarm                                      │
│ Agents: [n]                                              │
│ Stage: [stage]                                           │
│ Sub-tasks: [count]                                       │
│                                                         │
│ Estimated Overhead:                                      │
│   • Token Usage: ~[n]x single agent                     │
│   • Processing Time: ~[n]x longer                       │
│   • Complexity: Increased aggregation step              │
│                                                         │
│ Benefits:                                              │
│   • Parallel execution of [count] tasks                 │
│   • Faster completion on decomposable work               │
│                                                         │
│ [PROCEED] to activate or [CANCEL]                    │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

## Session Flow

### 1. Initialize Session

```
┌────────────────────────────────────────────────────────────┐
│ 🐝 AGENT SWARM EXECUTION                                │
├────────────────────────────────────────────────────────────┤
│ Session ID: [S-XXX]                                     │
│ Parent Task: [main task description]                      │
│ Stage: [current stage]                                  │
│ Agents Deployed: [n]                                     │
│ Started: [timestamp]                                     │
│                                                         │
│ Executing sub-tasks in parallel...                       │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

### 2. Swarm Agent Reports

For each agent, display:

```
┌────────────────────────────────────────────────────────────┐
│ SWARM AGENT [α/β/γ/δ/ε/ζ/η/θ]                         │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Sub-task: [specific task assigned]                       │
│ Status: [✓ COMPLETE | ✗ FAILED | ⏸ BLOCKED]            │
│                                                         │
│ Output:                                                │
│   [Brief description of artifact produced]              │
│                                                         │
│ Location: [file path or "inline below"]                  │
│                                                         │
│ Dependencies Resolved: [list or "none"]                 │
│ Issues Encountered: [list or "none"]                    │
│                                                         │
│ [If failed:]                                          │
│ Error: [error message]                                  │
│ Recovery: [suggested fix]                             │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

### 3. Aggregation Summary

```
┌────────────────────────────────────────────────────────────┤
│ SWARM AGGREGATION SUMMARY                              │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Total Sub-tasks: [n]                                    │
│ Completed: [n]                                           │
│ Failed: [n]                                              │
│ Blocked: [n]                                             │
│                                                         │
│ Success Rate: [X]%                                      │
│                                                         │
│ Final Artifact: [location]                              │
│                                                         │
├────────────────────────────────────────────────────────────┤
│ CONFLICTS REQUIRING RESOLUTION                         │
├────────────────────────────────────────────────────────────┤
│ [If conflicts detected between agent outputs:]            │
│                                                         │
│ Conflict: [description]                                │
│ Agent A Output: [description]                           │
│ Agent B Output: [description]                           │
│ Resolution: [suggested approach]                        │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

### 4. User Action Required

```
┌────────────────────────────────────────────────────────────┐
│ USER ACTION REQUIRED                                    │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ [PROCEED] — Accept aggregated output                    │
│ [REVIEW] — Review individual agent outputs              │
│         before accepting                                 │
│ [RETRY-FAILED] — Redeploy failed agents only          │
│ [MANUAL-MERGE] — Flag for human merge of conflicts    │
│ [ABORT] — Discard swarm output, return to single agent  │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

## Example Usage

```
/swarm --stage=implementation --agents=3 --tasks="API routes, database models, unit tests"
```

## Update status.md

```markdown
## Multi-Agent Sessions
| Session ID | Mode | Agents | Topic | Consensus | Result | Date |
|------------|------|--------|-------|-----------|--------|------|
| S-XXX | swarm | [n] | [main task] | N/A | [result] | [date] |
```

## Conflict Resolution

When agents produce conflicting outputs:

1. **Pause** and document the conflict
2. **Present options** from each agent
3. **Recommend resolution** based on:
   - Alignment with artifacts
   - Technical merit
   - Least disruptive approach
4. **User decides** final approach
