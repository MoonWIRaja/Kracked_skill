# Multi-Agent: Output Aggregation

## Overview
This protocol defines how outputs from multiple agents are combined into a unified deliverable, whether from Party Mode ideation or Agent Swarm execution.

## Aggregation Types

### Party Mode Aggregation
Input: Multiple opinions on the same topic
Output: Unified recommendation with consensus score

```
1. Collect all agent positions
2. Group by recommendation similarity
3. Calculate consensus percentage
4. Identify majority position
5. Incorporate valuable minority insights
6. Generate unified recommendation
```

### Swarm Aggregation
Input: Multiple task outputs (potentially interdependent)
Output: Merged deliverable with dependency resolution

```
1. Collect all agent outputs
2. Build dependency graph
3. Check for conflicts (→ conflict-resolution.md)
4. Merge non-conflicting outputs
5. Resolve conflicts
6. Validate merged output coherence
7. Generate unified deliverable
```

## Aggregation Format

```
[AGGREGATION REPORT]
Mode: [party/swarm]
Agents: [N]
Status: [complete/partial]

Inputs Received: [N/N]
Conflicts Found: [N]
Conflicts Resolved: [N]

Merged Output:
[unified result]

Quality Check:
- Coherence: [pass/fail]
- Completeness: [pass/fail]
- Consistency: [pass/fail]

Notes:
- [any caveats or observations]
```

## Quality Checks
Before finalizing aggregation:
1. **Coherence:** Does the merged output make sense as a whole?
2. **Completeness:** Are all required elements present?
3. **Consistency:** No contradictions in the merged output?
4. **Traceability:** Can each element be traced to a source agent?

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
