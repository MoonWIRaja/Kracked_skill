# Workflow: Main (Standard Flow)

> Default workflow — follows all 10 stages sequentially

## Overview
The main workflow follows the full KD lifecycle from Discovery to Release. Suitable for STANDARD and DEEP scale projects.

## Flow

```
Start
  │
  ├── 1. Discovery (/KD-analyze, /KD-kickoff)
  │     └── Analyst gathers context, identifies risks, assesses scale
  │     └── EXIT: Scale confirmed by user
  │
  ├── 2. Ideation (/KD-brainstorm, /KD-idea-*)
  │     └── Analyst + PM ideate, set goals, market research
  │     └── EXIT: Brainstorm.md created, direction confirmed
  │
  ├── 3. Requirements (/KD-product-brief → /KD-prd)
  │     └── PM creates Product Brief → ⏸️ Approval
  │     └── PM creates PRD → ⏸️ Approval
  │     └── EXIT: Both documents approved
  │
  ├── 4. Architecture (/KD-architecture, /KD-api-design, /KD-tool-selector)
  │     └── Architect designs system, validates decisions
  │     └── Tool selection, version compatibility check
  │     └── EXIT: Architecture approved → ⏸️ Approval
  │
  ├── 5. Planning (/KD-epics-and-stories, /KD-sprint-planning)
  │     └── Tech Lead creates backlog
  │     └── Sprint planning if Agile
  │     └── EXIT: Stories defined and estimated
  │
  ├── 6. Implementation (/KD-dev-story, /KD-refactor)
  │     └── Engineer implements stories
  │     └── Refactor as needed
  │     └── EXIT: All stories complete, unit tests passing
  │
  ├── 7. Testing (/KD-test, /KD-test-automate, /KD-test-sprite)
  │     └── QA designs test strategy
  │     └── Automated tests created
  │     └── Visual regression if UI
  │     └── EXIT: All tests passing
  │
  ├── 8. Quality (/KD-code-review, /KD-validate)
  │     └── QA reviews code quality
  │     └── Security performs audit
  │     └── Validation check
  │     └── EXIT: Both verdicts PASS
  │
  ├── 9. Deployment (/KD-deployment-plan)
  │     └── DevOps creates deployment plan
  │     └── Staging deployment
  │     └── Production → ⏸️ Approval
  │     └── EXIT: Deployed and healthy
  │
  └── 10. Release (/KD-scale-review, /KD-retrospective)
        └── Release Manager creates release notes
        └── Post-deployment assessment
        └── Sprint retrospective
        └── EXIT: Cycle closed
```

## Checkpoints (⏸️)
1. Product Brief approval (Stage 3)
2. PRD approval (Stage 3)
3. Architecture approval (Stage 4)
4. Production deployment approval (Stage 9)

## Stage Summary

| Stage | Key Command | Duration | Checkpoint |
|-------|-------------|----------|------------|
| 1. Discovery | `/KD-analyze` | 1-2 hours | Scale confirmation |
| 2. Ideation | `/KD-brainstorm` | 2-4 hours | Direction confirmed |
| 3. Requirements | `/KD-prd` | 4-8 hours | ⏸️ PRD approval |
| 4. Architecture | `/KD-architecture` | 4-8 hours | ⏸️ Architecture approval |
| 5. Planning | `/KD-epics-and-stories` | 2-4 hours | Backlog ready |
| 6. Implementation | `/KD-dev-story` | Variable | Code complete |
| 7. Testing | `/KD-test` | 2-4 hours | Tests passing |
| 8. Quality | `/KD-code-review` | 1-2 hours | Review passed |
| 9. Deployment | `/KD-deployment-plan` | 1-2 hours | ⏸️ Production approval |
| 10. Release | `/KD-scale-review` | 1 hour | Cycle closed |

---

*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
