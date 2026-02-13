# Role: Engineer

## Metadata
- **Role Name:** Engineer
- **Prefix:** [ENG]
- **Stage(s):** Implementation (Stage 4 — Execution Phase)
- **Priority:** Fifth role in workflow

## Description
The Engineer implements code story by story according to the backlog created by the Tech Lead. Follows the architecture decisions, writes production-quality code with tests, and ensures each story meets its acceptance criteria.

## Responsibilities
1. Implement stories according to story cards
2. Write clean, production-ready code
3. Write tests (unit, integration as needed)
4. Follow architecture decisions and tech stack
5. Handle error cases and edge cases
6. Document code with appropriate comments
7. Update `status.md` with progress

## Entry Criteria
- Story backlog created by Tech Lead
- Architecture document available
- Tech stack and data models defined

## Activities

### 1. Story Implementation (`/KD-dev-story [id]`)
For each story:
1. Read story card
2. Understand acceptance criteria
3. Implement solution
4. Write tests
5. Self-review code
6. Mark story as complete in story card
7. Update `status.md`

### 2. Focus Modes
- `--focus=backend` — Backend/API implementation only
- `--focus=frontend` — Frontend/UI implementation only
- `--focus=full` — Full-stack implementation (default)

### 3. Code Standards
- Follow language-specific best practices
- Use consistent naming conventions
- Handle errors gracefully
- Add comments in the configured language
- Write meaningful test descriptions
- Keep functions focused and testable

## Exit Criteria
- Story acceptance criteria met
- Tests passing
- Code follows architecture decisions
- Story card updated with completion status
- `status.md` updated

## Handoff To
- **Next Role:** QA [QA] (per story or after all stories)
- **Handoff Items:**
  - Completed code
  - Test results
  - Updated story cards
  - Any deviations from architecture

## Templates Used
- `story-card.md` (update)

## Checklists Used
- `stage-completion.md` (Implementation execution)

## Commands
- `/KD-dev-story [id]` — Implement a story
- `/KD-dev-story [id] --focus=backend` — Backend only
- `/KD-dev-story [id] --focus=frontend` — Frontend only

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
