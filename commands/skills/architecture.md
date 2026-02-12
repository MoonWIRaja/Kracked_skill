---
name: architecture
description: Stage 3 - System architecture design with depth selection
params:
  - name: depth
    description: Architecture detail level (quick|standard|deep)
    required: false
    default: standard
---

# Stage 3: Architecture

## Active Role: ARCHITECT

KRACKED architecture phase - design system structure, select tech stack, define data model.

## Parameters

- `--depth=quick`: Minimal architecture for simple projects
- `--depth=standard`: Full architecture (default)
- `--depth=deep`: Enterprise architecture with detailed analysis

## Input

- PRD from requirements stage
- Product brief for context
- Language preference from status.md

## Process

### 1. Review Requirements

Read `docs/prd.md` to understand:
- Functional requirements
- Non-functional requirements
- User stories and epics
- Success metrics

### 2. Decision Validation (Required)

Before finalizing architecture, run:

```
┌────────────────────────────────────────────────────────────┐
│ DECISION VALIDATION                                    │
├────────────────────────────────────────────────────────────┤
│ Decision: [What is being decided]                       │
│                                                         │
│ Alignment:                                             │
│   Product Goals: [How it aligns]                        │
│   PRD Requirements: [What it addresses]               │
│                                                         │
│ Impact Analysis:                                        │
│   Scope: [Components affected]                          │
│   Breaking Changes: [Yes/No]                            │
│   User Impact: [None/Low/Medium/High]                   │
│                                                         │
│ Recommendation: [Proceed/Proceed with Caution]           │
└────────────────────────────────────────────────────────────┘
```

### 3. Design System Architecture

Create `docs/architecture.md`:

```markdown
# System Architecture

## Project: [name]
## Version: 1.0
## Date: [date]

## Architecture Overview
[System description and diagram references]

## Technology Stack

### Frontend
- Framework: [choice]
- State Management: [choice]
- UI Library: [choice]

### Backend
- Runtime: [choice]
- Framework: [choice]
- API Layer: [REST/GraphQL]

### Database
- Primary: [choice + rationale]
- Caching: [choice]
- Search: [choice if needed]

### Infrastructure
- Hosting: [choice]
- CI/CD: [choice]
- Monitoring: [choice]

## System Components

### [Component 1]
- Purpose: [description]
- Technologies: [list]
- Interfaces: [API endpoints]

### [Component 2]
...

## Data Model

### [Entity 1]
```yaml
fields:
  id: type
  name: type
  ...
relationships:
  - type: one-to-many
    target: [Entity 2]
```

## API Design

### [Endpoint]
- Method: [GET/POST/PUT/DELETE]
- Path: [path]
- Auth: [required/optional]
- Request: [schema]
- Response: [schema]

## Security Design
- Authentication: [method]
- Authorization: [model]
- Data Protection: [measures]

## Deployment Architecture
[Environment setup, scaling strategy]

## Architecture Decisions Log
| ID | Decision | Rationale | Impact | Date |
|----|----------|-----------|--------|------|
```

### 4. Update status.md

Add architecture decisions to status.md:

```markdown
## Architecture Decisions
| ID | Decision | Rationale | Impact | Date | Status |
|----|----------|-----------|--------|------|--------|
| A001 | [tech choice] | [reason] | [impact] | [date] | Active |

## Tech Stack
| Layer | Technology | Version | Reason |
|-------|------------|---------|--------|
| Frontend | [choice] | [ver] | [rationale] |
...
```

## Exit Criteria

- [ ] No unresolved architectural risks
- [ ] Deployment path defined
- [ ] Tech stack justified
- [ ] Data model complete
- [ ] API design documented

## Multi-Agent Option

For complex systems, suggest Party Mode:
```
Consider: /party-mode --stage=architecture --agents=3 --topic="architecture alternatives"
```

## User Actions

[APPROVE] - Proceed to Implementation stage
[REVISE] - Make changes to architecture
[SHOW] - Display architecture document
