# Stage 5: Planning

## Metadata
- **Stage Name:** Planning
- **Stage Number:** 5 of 10
- **Primary Role:** Tech Lead [TL]
- **Commands:** Multiple (see below)

## Commands Available
| Command | Description | Priority |
|---------|-------------|----------|
| `/KD-epics-and-stories` | Create backlog | Core |
| `/KD-sprint-planning` | Plan sprint | Agile |
| `/KD-build-workflow` | Build workflow | Advanced |

## Description
The Planning stage transforms architecture into actionable work items. The Tech Lead creates epics, user stories, and organizes the backlog for implementation.

## Entry Criteria
- Architecture approved
- Tech stack selected
- `architecture.md` complete

## Activities

### 1. Epic Creation
- Break down product into major epics
- Define epic scope and boundaries
- Prioritize epics by business value
- Estimate epic complexity

### 2. Story Decomposition
- Create user stories for each epic
- Write acceptance criteria
- Estimate story points
- Identify dependencies

### 3. Backlog Organization
- Prioritize stories
- Identify MVP scope
- Plan releases
- Create sprint backlog (if Agile)

### 4. Technical Planning
- Identify technical risks
- Plan spike stories
- Set up development environment
- Define coding standards

## Output Template

Save to: `.kracked/KD_output/epics-and-stories/`

```
epic-1/
  ├── epic-1.md
  ├── story-1-1.md
  ├── story-1-2.md
epic-2/
  ├── epic-2.md
  └── ...
```

## Exit Criteria
- All epics defined
- Stories estimated
- Backlog prioritized
- MVP scope identified

## Artifacts Produced
- Epic files
- Story cards
- Sprint plan (if Agile)

## Next Stage
- **Stage 6: Implementation** (`/KD-dev-story`)

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*