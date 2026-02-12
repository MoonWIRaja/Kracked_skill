---
name: prd
description: Stage 2 - Product Requirements Document by Product Manager role
---

# Stage 2: Requirements

## Active Role: PRODUCT MANAGER

KRACKED requirements phase - create comprehensive PRD with user stories and acceptance criteria.

## Input

- Product brief from discovery stage
- Language preference from status.md

## Process

### 1. Review Product Brief

Read `product-brief.md` to understand:
- Problem statement
- Target users
- Core value proposition
- Identified risks

### 2. Create User Personas

Define 2-3 user personas:
- Name and role
- Goals and motivations
- Pain points
- Technical proficiency

### 3. Write User Stories

Format user stories as:
```
As a [user type],
I want to [perform action],
So that [benefit/value].
```

Organize by epics.

### 4. Define Acceptance Criteria

For each story, define:
- Functional requirements
- Non-functional requirements
- Edge cases to handle
- Success metrics

### 5. Create PRD Document

Create `docs/prd.md`:

```markdown
# Product Requirements Document

## Project: [name]
## Version: 1.0
## Date: [date]

## Overview
[Brief product description]

## Target Users
[Personas section]

## User Stories

### Epic: [Epic Name]

#### Story: [Story ID] - [Title]
**As a** [user type]
**I want to** [action]
**So that** [benefit]

**Acceptance Criteria:**
- [ ] [Criterion 1]
- [ ] [Criterion 2]

**Dependencies:** [None or list]
**Priority:** [Must|Should|Could]

## Non-Functional Requirements
- Performance: [requirements]
- Security: [requirements]
- Scalability: [requirements]

## Success Metrics
[How to measure success]
```

### 6. Update status.md

```markdown
## Completed Stages
| Stage | Status | Completed | Key Artifact |
|-------|--------|-----------|--------------|
| Discovery | ✅ | [date] | product-brief.md |

## Completed Artifacts
| Artifact | Location | Stage | Date |
|----------|----------|-------|------|
| Product Brief | product-brief.md | Discovery | [date] |
| PRD | docs/prd.md | Requirements | [date] |

## Current State
- Stage: requirements
- Active Role: product-manager
```

## Exit Criteria

- [ ] All stories have acceptance criteria
- [ ] Dependencies mapped
- [ ] Non-functional requirements defined
- [ ] Success metrics identified

## User Actions

[APPROVE] - Proceed to Architecture stage
[REVISE] - Make changes to PRD
[SHOW] - Display PRD
