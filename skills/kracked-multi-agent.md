---
name: kracked-multi-agent
description: |
  Multi-Agent System for KRACKED with Party Mode and Agent Swarm.

  Party Mode: Multiple agents brainstorm in parallel with different perspectives.
  Agent Swarm: Multiple micro-agents handle sub-tasks simultaneously.

  Both modes require explicit user activation.
---

# KRACKED Multi-Agent System

## Overview

KRACKED supports two multi-agent modes for enhanced exploration and parallel execution:

| Mode        | Purpose                    | Best For                          |
|-------------|----------------------------|-----------------------------------|
| Party Mode  | Parallel ideation          | Exploration, risk discovery       |
| Agent Swarm | Parallel task execution    | Decomposable tasks, large outputs |

## Activation

### Party Mode
```
/party-mode --stage=[stage] --agents=[2-5] --topic="[focus topic]"
```

Use when:
- High uncertainty or need diverse perspectives
- Architectural decisions with multiple valid approaches
- Risk discovery for complex systems
- Creative brainstorming

### Agent Swarm
```
/swarm --stage=[stage] --agents=[2-8] --tasks="[sub-task list]"
```

Use when:
- Task can be cleanly decomposed into 3+ independent sub-tasks
- Parallel execution saves significant time
- Multiple files need simultaneous modification

## Before Activation

Always display overhead warning:

```
┌────────────────────────────────────────────────────────────┐
│ ℹ️ MULTI-AGENT MODE ACTIVATION                         │
├────────────────────────────────────────────────────────────┤
│ Mode: [Party Mode | Agent Swarm]                        │
│ Agents: [n]                                              │
│                                                          │
│ Estimated Overhead:                                      │
│   • Token Usage: ~[n]x single agent                     │
│   • Processing Time: ~[n]x longer                       │
│                                                          │
│ [PROCEED] to activate or [CANCEL]                    │
└────────────────────────────────────────────────────────────┘
```

## Party Mode Output Format

```
┌────────────────────────────────────────────────────────────┐
│ 🎭 PARTY MODE SESSION                                   │
├────────────────────────────────────────────────────────────┤
│ Session ID: [P-XXX]                                     │
│ Topic: [topic being explored]                           │
│ Agents Participating: [n]                                │
├────────────────────────────────────────────────────────────┤
│                                                          │
│ AGENT 1 — [Perspective/Role Focus]                     │
│ Proposal: [Core idea]                                  │
│ Confidence: [HIGH|MEDIUM|LOW] (Score: [1-3])          │
│ Rationale: [Key reasons]                               │
│ Risks Identified: [List]                                │
│                                                          │
│ [...]                                                   │
├────────────────────────────────────────────────────────────┤
│ AGGREGATION RESULT                                     │
├────────────────────────────────────────────────────────────┤
│                                                          │
│ Proposals Ranked by Consensus:                          │
│ 1. [Proposal] — Score: [X/Y] | Confidence: [HIGH]   │
│                                                          │
│ Consensus Level: [STRONG|MODERATE|WEAK]               │
│ KRACKED Recommendation: [selected proposal]            │
│                                                          │
├────────────────────────────────────────────────────────────┤
│ USER ACTION REQUIRED                                    │
├────────────────────────────────────────────────────────────┤
│ [APPROVE] — Accept recommendation                      │
│ [SELECT: N] — Choose alternative #N                   │
│ [MERGE] — Merge top proposals                         │
└────────────────────────────────────────────────────────────┘
```

## Agent Swarm Output Format

```
┌────────────────────────────────────────────────────────────┐
│ 🐝 AGENT SWARM EXECUTION                                │
├────────────────────────────────────────────────────────────┤
│ Session ID: [S-XXX]                                     │
│ Parent Task: [main task]                                │
│ Agents Deployed: [n]                                     │
├────────────────────────────────────────────────────────────┤
│                                                          │
│ SWARM AGENT α                                           │
│ Sub-task: [specific task]                               │
│ Status: [✓ COMPLETE | ✗ FAILED]                       │
│ Output: [description]                                   │
│                                                          │
│ [...]                                                   │
├────────────────────────────────────────────────────────────┤
│ SWARM AGGREGATION SUMMARY                              │
├────────────────────────────────────────────────────────────┤
│                                                          │
│ Total: [n] | Completed: [n] | Failed: [n]                │
│ Success Rate: [X%]                                      │
│                                                          │
└────────────────────────────────────────────────────────────┘
```

## Confidence Scoring

| Level   | Score | Criteria                                    |
|---------|-------|-----------------------------------------------|
| HIGH    | 3     | Fully aligns, minimal risk               |
| MEDIUM  | 2     | Aligns mostly, some unknowns              |
| LOW     | 1     | Partial alignment, significant risks   |

## Consensus Thresholds

| Consensus    | Action                                  |
|--------------|---------------------------------------------|
| > 70%        | Auto-recommend, single checkpoint        |
| 50-70%       | Recommend with caveats                   |
| < 50%        | Escalate to user, present all options  |

## Conflict Resolution

When agents disagree:

1. Pause → Document → Present options
2. Show each option with:
   - Supporting agents
   - Confidence level
   - Key arguments FOR and AGAINST
3. KRACKED recommendation based on:
   - Alignment with artifacts
   - Risk assessment
   - Technical feasibility
4. User makes final decision
