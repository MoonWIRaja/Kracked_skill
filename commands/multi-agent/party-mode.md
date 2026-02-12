---
name: party-mode
description: Multi-agent parallel ideation mode
params:
  - name: stage
    description: Current workflow stage
    required: true
  - name: agents
    description: Number of agents (2-5)
    required: false
    default: 3
  - name: topic
    description: Focus topic for ideation
    required: true
---

# Party Mode

## Purpose

Generate diverse perspectives on a single topic, then aggregate into a high-confidence recommendation.

## Parameters

- `--stage=[stage]`: Current workflow stage
- `--agents=[2-5]`: Number of agents to spawn
- `--topic="[topic]"`: Focus topic for ideation

## When to Use Party Mode

- High uncertainty or need diverse perspectives
- Architectural decisions with multiple valid approaches
- Risk discovery for complex systems
- Creative brainstorming (naming, UX concepts, trade-offs)

## Activation Warning

Before activating, display:

```
┌────────────────────────────────────────────────────────────┐
│ ℹ️ MULTI-AGENT MODE ACTIVATION                         │
├────────────────────────────────────────────────────────────┤
│ Mode: Party Mode                                       │
│ Agents: [n]                                              │
│ Stage: [stage]                                           │
│ Topic: [topic]                                           │
│                                                         │
│ Estimated Overhead:                                      │
│   • Token Usage: ~[n]x single agent                     │
│   • Processing Time: ~[n]x longer                       │
│                                                         │
│ Benefits:                                              │
│   • Diverse perspectives on [topic]                      │
│   • Risk discovery through debate                       │
│   • Higher confidence through consensus                 │
│                                                         │
│ [PROCEED] to activate or [CANCEL]                    │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

## Session Flow

### 1. Initialize Session

```
┌────────────────────────────────────────────────────────────┐
│ 🎭 PARTY MODE SESSION                                   │
├────────────────────────────────────────────────────────────┤
│ Session ID: [P-XXX]                                     │
│ Topic: [topic being explored]                           │
│ Stage: [current stage]                                  │
│ Agents Participating: [n]                                │
│ Started: [timestamp]                                     │
│                                                         │
│ Generating proposals...                                   │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

### 2. Agent Proposals

For each agent, display:

```
┌────────────────────────────────────────────────────────────┐
│ AGENT [n] — [Perspective/Role Focus]                     │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Proposal:                                              │
│   [Core idea or recommendation]                         │
│                                                         │
│ Confidence: [HIGH|MEDIUM|LOW] (Score: [1-3])          │
│                                                         │
│ Rationale:                                             │
│   • [Key reason 1]                                    │
│   • [Key reason 2]                                    │
│   • [Key reason 3]                                    │
│                                                         │
│ Risks Identified:                                      │
│   • [Risk 1]                                           │
│   • [Risk 2]                                           │
│                                                         │
│ Dependencies:                                          │
│   • [Dependency 1]                                     │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

### 3. Aggregation

```
┌────────────────────────────────────────────────────────────┐
│ AGGREGATION RESULT                                     │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Proposals Ranked by Consensus:                          │
│                                                         │
│   1. [Proposal Title] — Score: [X/Y]                    │
│      Supporters: Agent 1, Agent 3, Agent 4             │
│      Confidence: [HIGH|MEDIUM|LOW]                      │
│      Key Strengths: [summary]                           │
│                                                         │
│   2. [Proposal Title] — Score: [X/Y]                    │
│      Supporters: Agent 2, Agent 5                        │
│      Confidence: [HIGH|MEDIUM|LOW]                      │
│                                                         │
├────────────────────────────────────────────────────────────┤
│ Consensus Analysis                                      │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Consensus Level: [STRONG (>70%)|MODERATE (50-70%)|WEAK] │
│                                                         │
│ Top Proposal Support: [X/Y] agents ([%])              │
│                                                         │
├────────────────────────────────────────────────────────────┤
│ KRACKED Recommendation                                 │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ [Selected proposal with reasoning]                       │
│                                                         │
│ This recommendation based on:                           │
│   • Alignment with artifacts                           │
│   • Risk assessment                                  │
│   • Technical feasibility                             │
│   • Team consensus                                   │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

### 4. User Action Required

```
┌────────────────────────────────────────────────────────────┐
│ USER ACTION REQUIRED                                    │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ [APPROVE] — Accept KRACKED recommendation            │
│ [SELECT: N] — Choose alternative proposal #N           │
│ [MERGE] — Attempt to merge top proposals              │
│ [DISCUSS] — Expand debate on specific points          │
│ [RETRY] — Run party mode again with different focus   │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

## Update status.md

```markdown
## Multi-Agent Sessions
| Session ID | Mode | Agents | Topic | Consensus | Result | Date |
|------------|------|--------|-------|-----------|--------|------|
| P-XXX | party | [n] | [topic] | [level] | [result] | [date] |
```

## Confidence Scoring

| Level | Score | Criteria |
|-------|-------|------------|
| HIGH | 3 | Fully aligns with all artifacts, minimal risk |
| MEDIUM | 2 | Aligns with most artifacts, some unknowns |
| LOW | 1 | Partial alignment, significant unknowns or risks |
