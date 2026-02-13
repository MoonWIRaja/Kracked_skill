# Multi-Agent: Confidence Scoring

## Overview
Confidence scoring provides a standardized way for agents (both in Party Mode and Swarm) to communicate certainty levels about their recommendations.

## Scoring Scale

| Level  | Score | Criteria |
|--------|-------|----------|
| HIGH   | 3     | Fully aligns with all existing artifacts; minimal risk; well-established pattern; strong evidence |
| MEDIUM | 2     | Mostly aligns with artifacts; some unknowns; reasonable assumptions; moderate evidence |
| LOW    | 1     | Partial alignment; significant unknowns; novel approach; limited evidence |

## When to Score
Apply confidence scoring to:
- Architecture decisions
- Technology selections
- Design pattern choices
- Risk assessments
- Multi-agent recommendations
- Non-obvious implementation choices

## Scoring Format
```
Confidence: [HIGH/MEDIUM/LOW] ([3/2/1])
Justification: [why this score]
Factors:
  + [supporting factor]
  + [supporting factor]
  - [undermining factor]
  - [undermining factor]
```

## Aggregation in Party Mode
1. Collect scores from all agents
2. Calculate average: `sum(scores) / num_agents`
3. Calculate consensus: `% of agents with matching recommendation`
4. Apply threshold rules:

| Avg Score | Consensus | Action |
|-----------|-----------|--------|
| ≥ 2.5     | > 70%     | Strong recommendation — proceed |
| ≥ 2.0     | 50-70%    | Moderate — recommend with caveats |
| < 2.0     | < 50%     | Weak — escalate to user |

## Documentation
All confidence scores are recorded in `status.md` under Architecture Decisions or Multi-Agent Sessions.

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
