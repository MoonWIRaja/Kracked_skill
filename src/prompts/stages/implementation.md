# Stage 4: Implementation

## Metadata
- **Stage Name:** Implementation
- **Stage Number:** 4
- **Primary Roles:** Tech Lead [TL] → Engineer [ENG]
- **Commands:** `/KD-epics-and-stories`, `/KD-dev-story [id]`

## Description
The Implementation stage has two phases. First, the Tech Lead creates the backlog (epics and stories). Then, the Engineer implements each story. This is typically the longest stage.

## Entry Criteria
- Architecture document approved ⏸️
- Tech stack finalized
- Data models defined

## Activities

### Phase 1: Planning (Tech Lead)
**Command:** `/KD-epics-and-stories`
- Break architecture into epics (major feature areas)
- Create user stories per epic
- Each story follows `story-card.md` template
- Define implementation order
- Identify dependencies between stories
- Flag stories for Agent Swarm consideration

### Phase 2: Execution (Engineer)
**Command:** `/KD-dev-story [story-id]`
- Implement stories one by one (or via swarm)
- For each story:
  1. Read story card and acceptance criteria
  2. Implement solution
  3. Write tests
  4. Self-review
  5. Mark complete
  6. Update `status.md`

### Focus Modes
- `--focus=backend` — API/server implementation only
- `--focus=frontend` — UI/client implementation only
- `--focus=full` — Full-stack (default)

### Scale Adjustments
- **SMALL:** Combine planning + execution, informal stories
- **STANDARD:** Full story cards, ordered execution
- **DEEP:** Detailed cards, formal code reviews per story

## Exit Criteria
- All stories implemented
- All tests passing
- Story cards updated with completion status
- `status.md` updated with progress

## Artifacts Produced
- Story card files (per story)
- Implementation code
- Test files
- Updated `status.md`

## Checkpoint Required
- No formal checkpoint (quality checks in next stage)

## Next Stage
- **Stage 5: Quality** (`/KD-code-review`)

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
