---
name: dev-story
description: Stage 4 - Implement single story with focus selection
params:
  - name: storyId
    description: Story ID to implement
    required: true
  - name: focus
    description: Implementation focus (backend|frontend|full)
    required: false
    default: full
---

# Stage 4: Implementation

## Active Role: TECH LEAD → ENGINEER

KRACKED implementation phase - write code and tests for a specific user story.

## Parameters

- `storyId`: Story ID from PRD
- `--focus=backend`: Backend only
- `--focus=frontend`: Frontend only
- `--focus=full`: Full stack (default)

## Input

- Architecture document
- PRD with user stories
- Story ID to implement

## Process

### 1. Tech Lead: Task Breakdown

Read the story from PRD and break down:

```markdown
# Implementation Plan: [Story ID] - [Title]

## Story Summary
[User story text]

## Acceptance Criteria
[From PRD]

## Tasks

### [Task 1]
- Description: [what to do]
- Files: [list of files]
- Dependencies: [what depends on this]
- Estimate: [complexity]

### [Task 2]
...
```

### 2. Engineer: Implementation

For each task:

a. **Read existing code** in target files
b. **Implement changes** following project patterns
c. **Write tests** for new functionality
d. **Update dependencies** if needed

### 3. Code Structure

Follow project conventions:
- Use existing patterns and abstractions
- Don't add premature abstractions
- Keep solutions simple and focused
- Add comments only where logic isn't self-evident

### 4. Testing

Write tests covering:
- Happy path
- Edge cases
- Error conditions

### 5. Update status.md

```markdown
## Current State
- Stage: implementation
- Active Role: engineer
- Active Story: [story-id]

## Completed Artifacts
| Artifact | Location | Stage | Date |
|----------|----------|-------|------|
| [Story Impl] | [file paths] | Implementation | [date] |
```

## Exit Criteria

- [ ] All acceptance criteria met
- [ ] Tests pass
- [ ] Code follows project patterns
- [ ] No blocking bugs
- [ ] Dependencies updated

## Multi-Agent Option

For complex stories with parallel tasks:
```
/swarm --stage=implementation --agents=3 --tasks="API, models, tests"
```

## User Actions

[COMPLETE] - Mark story complete, proceed to next
[TEST] - Run tests
[SHOW] - Show implemented code
