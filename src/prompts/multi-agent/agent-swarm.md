# Multi-Agent: Agent Swarm

## Overview
Agent Swarm enables parallel task execution by distributing multiple tasks across agents. Each agent works independently on its assigned task, and results are merged with dependency checking.

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
[AGENT SWARM ACTIVATED]
Tasks: [N tasks]
Agents: [N agents]
Stage Context: [current stage]
```

### 2. Task Distribution
```
[SWARM TASK ASSIGNMENT]
| Agent | Task | Dependencies | Status |
|-------|------|-------------|--------|
| A1    | [task] | [deps]   | pending |
| A2    | [task] | [deps]   | pending |
```

### 3. Parallel Execution
Each agent independently works on its task:
```
[SWARM AGENT N: <Task>]
Status: in-progress
Approach: [methodology]
Output: [deliverable]
```

### 4. Aggregation
```
[SWARM RESULTS]
Completed: [N/N tasks]

| Agent | Task | Status | Output | Conflicts |
|-------|------|--------|--------|-----------|
| A1    | [task] | complete | [output] | [none/list] |

Dependency Check: [PASS/ISSUES]
Conflict Resolution: [if needed]
Merged Output: [unified result]
```

### 5. Conflict Resolution
If outputs conflict:
1. Identify conflicting elements
2. Apply conflict-resolution.md protocol
3. Resolve based on priority and confidence
4. Document resolution

## Examples
```
/KD-swarm --agents=4 --tasks="users API, products API, orders API, shared middleware"
/KD-swarm --agents=3 --tasks="frontend components, backend routes, database models"
/KD-swarm --stage=implementation --agents=3 --tasks="auth module, payment module, notification module"
```

## Rules
- Swarm is best for INDEPENDENT tasks with minimal overlap
- Each agent should have a clearly scoped task
- Dependencies are resolved AFTER all agents complete
- Conflicts trigger the conflict resolution protocol
- All results logged in `status.md`

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
