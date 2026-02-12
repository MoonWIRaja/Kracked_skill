---
name: epics-and-stories
description: Create backlog with epics and user stories
---

# Epics and Stories

## Purpose

Create structured backlog with epics and user stories after architecture is complete.

## Input

- PRD with initial stories
- Architecture with components

## Process

### 1. Organize Stories by Epic

Group related stories into epics based on:
- User journey flow
- Technical component
- Business value

### 2. Story Details

For each story, ensure:
- Unique ID (Epic-Number format)
- Clear acceptance criteria
- Dependencies noted
- Priority assigned
- Story points estimated

### 3. Create Backlog Document

Create `docs/stories.md`:

```markdown
# User Story Backlog

## Epic: [Epic Name]
**ID:** EP-[number]
**Priority:** [Must|Should|Could]

### Story: EP-[number]-1 - [Title]
**ID:** [story-id]
**As a** [user type]
**I want to** [action]
**So that** [benefit]

**Acceptance Criteria:**
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

**Priority:** P[0-3]
**Story Points:** [estimate]
**Dependencies:** [None or list]
**Component:** [from architecture]

---

## Epic: [Another Epic]
...

## Unscheduled Stories
[Stories not yet assigned to epic]
```

### 4. Update status.md

```markdown
## Completed Artifacts
| Artifact | Location | Stage | Date |
|----------|----------|-------|------|
| ... | ... | ... | ... |
| Story Backlog | docs/stories.md | Requirements | [date] |
```

## Output Format

```
┌────────────────────────────────────────────────────────────┐
│ 📋 BACKLOG CREATED                                    │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Epics: [count]                                          │
│ Stories: [total count]                                   │
│                                                         │
│ Distribution:                                          │
│   EP-[1]: [story count] stories                        │
│   EP-[2]: [story count] stories                        │
│   ...                                                   │
│                                                         │
│ Total Story Points: [sum]                              │
│                                                         │
│ Next: /dev-story [id] to implement                      │
│                                                         │
└────────────────────────────────────────────────────────────┘
```
