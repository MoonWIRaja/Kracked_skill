# Multi-Agent: Conflict Resolution

## Overview
When multiple agents produce conflicting outputs (in Party Mode or Swarm), this protocol resolves disagreements systematically.

## Conflict Types

| Type | Description | Resolution Method |
|------|-------------|-------------------|
| Direct | Agents recommend opposite approaches | Weighted scoring |
| Partial | Agents agree on approach but differ on details | Merge best elements |
| Dependency | Agent outputs have incompatible dependencies | Dependency analysis |
| Priority | Agents disagree on what matters most | Refer to PRD priorities |

## Resolution Protocol

### Step 1: Identify Conflict
```
[CONFLICT DETECTED]
Type: [Direct/Partial/Dependency/Priority]
Agents: [list of conflicting agents]
Element: [what they disagree on]
```

### Step 2: Score Each Position
For each conflicting position:
- Alignment with PRD requirements: [1-5]
- Alignment with architecture decisions: [1-5]
- Risk level: [1-5, lower is better]
- Implementation complexity: [1-5, lower is better]
- Confidence score: [1-3]

Total = weighted sum

### Step 3: Apply Resolution
```
[CONFLICT RESOLUTION]
Winner: [Agent N's position]
Score: [total]
Rationale: [why this was selected]
Compromise: [any elements merged from losing position]
Dissent logged: [for future reference]
```

### Step 4: Document
Record in `status.md`:
- What was conflicting
- How it was resolved
- What was potentially lost
- When to revisit if needed

## Escalation
If no clear winner (scores within 10%):
- Present both options to user
- Provide pros/cons summary
- Let user decide
- Document the human decision

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
