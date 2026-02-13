# Multi-Agent: Agent Swarm

## Overview
Agent Swarm enables parallel task execution by distributing multiple tasks across **named agent personas**. Each agent has a unique name and personality, works independently on its assigned task, reports progress in their own voice, and results are merged with dependency checking.

## Command
```
/KD-swarm --agents=N --tasks="task1,task2,task3"
```

## Parameters
- `--agents=N` — Number of agents (2-8, default: matches task count)
- `--stage=[stage]` — Context stage (optional)
- `--tasks="list"` — Comma-separated task descriptions

## Protocol

### 1. Initialization
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ⚡ AGENT SWARM ACTIVATED
  Tasks: [N tasks]
  Agents: [N agents]
  Stage Context: [current stage]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 2. Agent Assignment
Each agent gets a **name** from the personality pool and is assigned a task:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ⚡ SWARM TASK ASSIGNMENT
  | Agent | Name | Task | Dependencies | Status |
  |-------|------|------|-------------|--------|
  | A1    | [name] | [task] | [deps] | ready |
  | A2    | [name] | [task] | [deps] | ready |
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 3. Agent Introduction
Each agent introduces themselves briefly:
```
🎭 [Name] — Agent [N]
"Hey, I'm [Name]. I'll handle [task]. Let me get to work."
```

### 4. Parallel Execution
Each agent works independently and reports in character:
```
🎭 [Name] — Working on: [Task]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Status: in-progress
Approach: [methodology in their voice]
Progress: [updates]
Output: [deliverable]
💬 "[Brief comment in character about approach or findings]"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 5. Aggregation
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  📊 SWARM RESULTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Completed: [N/N tasks]

| Agent | Name | Task | Status | Output | Conflicts |
|-------|------|------|--------|--------|-----------|
| A1    | [name] | [task] | complete | [output] | [none/list] |

Dependency Check: [PASS/ISSUES]
Conflict Resolution: [if needed]
Merged Output: [unified result]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 6. Conflict Resolution
If outputs conflict:
1. Identify conflicting elements
2. Agents discuss the conflict by name
3. Apply conflict-resolution.md protocol
4. Resolve based on priority and confidence
5. Document resolution

## Examples
```
/KD-swarm --agents=4 --tasks="users API, products API, orders API, shared middleware"
/KD-swarm --agents=3 --tasks="frontend components, backend routes, database models"
/KD-swarm --stage=implementation --agents=3 --tasks="auth module, payment module, notification module"
```

## Rules
- Swarm is best for INDEPENDENT tasks with minimal overlap
- Each agent has a unique name and speaks in character
- Each agent should have a clearly scoped task
- Dependencies are resolved AFTER all agents complete
- Conflicts trigger the conflict resolution protocol
- All results logged in `status.md`
- Agents persist their names if called again in the same session

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
