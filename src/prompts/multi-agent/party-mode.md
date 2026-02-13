# Multi-Agent: Party Mode

## Overview
Party Mode enables parallel ideation by spawning multiple agent perspectives to analyze a topic collaboratively. Each agent provides independent recommendations with confidence scores, and results are aggregated into a consensus.

## Command
```
/KD-party-mode --agents=N --topic="topic"
```

## Parameters
- `--agents=N` — Number of agents (2-5, default: 3)
- `--stage=[stage]` — Context stage (optional, auto-detected from status.md)
- `--topic="topic"` — Focus topic for discussion

## Protocol

### 1. Initialization
```
[PARTY MODE ACTIVATED]
Topic: [topic]
Agents: [N]
Stage Context: [current stage]
```

### 2. Agent Spawning
Each agent receives a unique perspective bias:
- **Agent 1:** Conservative / Risk-focused
- **Agent 2:** Innovative / Opportunity-focused
- **Agent 3:** Pragmatic / Balance-focused
- **Agent 4:** User-centric / UX-focused (if N >= 4)
- **Agent 5:** Scalability / Performance-focused (if N >= 5)

### 3. Independent Analysis
Each agent independently provides:
```
[AGENT N: <Perspective>]
Position: [recommendation]
Rationale: [reasoning]
Pros: [list]
Cons: [list]
Confidence: [HIGH/MEDIUM/LOW] ([3/2/1])
Risks: [identified risks]
```

### 4. Aggregation
After all agents report:
```
[PARTY MODE RESULTS]
Topic: [topic]
Agents: [N]

Individual Positions:
| Agent | Position | Confidence | Key Argument |
|-------|----------|------------|--------------|
| 1     | [pos]    | [H/M/L]   | [argument]   |

Consensus: [X%]
Recommendation: [unified recommendation]
Dissenting Views: [if any]
Action: [based on consensus threshold]
```

### 5. Consensus Thresholds
| Consensus | Action |
|-----------|--------|
| > 70%     | Auto-recommend, proceed with single checkpoint |
| 50-70%    | Recommend with caveats, mandatory user review |
| < 50%     | Escalate to user, present all options |

### 6. Documentation
Log session in `status.md` → Multi-Agent Sessions:
```
| Session ID | Mode  | Agents | Topic   | Consensus | Result    | Date  |
|------------|-------|--------|---------|-----------|-----------|-------|
| P001       | party | 3      | [topic] | [X%]     | [approved] | [date]|
```

## Examples
```
/KD-party-mode --agents=3 --topic="database selection: PostgreSQL vs MongoDB vs CockroachDB"
/KD-party-mode --agents=4 --topic="authentication: JWT vs session-based vs OAuth2"
/KD-party-mode --stage=architecture --agents=3 --topic="monolith vs microservices"
```

## Rules
- Party Mode can be activated at ANY stage
- All agents have access to the same project context
- Each agent must provide a confidence score
- Results are logged in `status.md`
- Party Mode does NOT make final decisions — it informs them

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
