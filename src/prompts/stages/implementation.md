# Stage 6: Implementation

## Metadata
- **Stage Name:** Implementation
- **Stage Number:** 6 of 10
- **Primary Role:** Engineer [ENG]
- **Commands:** Multiple (see below)

## Commands Available
| Command | Description | Priority |
|---------|-------------|----------|
| `/KD-dev-story` | Story implementation | Core |
| `/KD-quick-dev` | Quick development | Small tasks |
| `/KD-refactor` | Refactoring | Tech debt |
| `/KD-build-module` | Module building | Advanced |

## Description
The Implementation stage is where code is written. The Engineer implements stories according to the backlog, writes tests, and ensures code quality.

## Entry Criteria
- Stories defined
- Architecture clear
- Tech stack selected

## Activities

### 1. Story Implementation
For each story:
1. Read story card
2. Understand acceptance criteria
3. Implement solution
4. Write tests
5. Self-review code
6. Mark story complete

### 2. Focus Modes
- `--focus=backend` — Backend/API only
- `--focus=frontend` — Frontend/UI only
- `--focus=full` — Full-stack (default)

### 3. Code Standards
- Follow language-specific best practices
- Use consistent naming conventions
- Handle errors gracefully
- Write meaningful comments
- Keep functions focused

### 4. Test Writing
- Write unit tests for each component
- Integration tests for APIs
- Update test coverage

## Exit Criteria
- All stories implemented
- Unit tests passing
- Code follows architecture decisions
- Stories marked complete

## Artifacts Produced
- Source code
- Unit tests
- Updated story cards

## Next Stage
- **Stage 7: Testing** (`/KD-test`)

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*