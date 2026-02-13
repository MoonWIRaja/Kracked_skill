# Workflow: Main (Standard Flow)

> Default workflow — follows all 7 stages sequentially

## Overview
The main workflow follows the full KD lifecycle from Discovery to Release. Suitable for STANDARD and DEEP scale projects.

## Flow

```
Start
  │
  ├── 1. Discovery (/KD-analyze)
  │     └── Analyst gathers context, identifies risks, assesses scale
  │     └── EXIT: Scale confirmed by user
  │
  ├── 2. Requirements (/KD-product-brief → /KD-prd)
  │     └── PM creates Product Brief → ⏸️ Approval
  │     └── PM creates PRD → ⏸️ Approval
  │     └── EXIT: Both documents approved
  │
  ├── 3. Architecture (/KD-architecture)
  │     └── Architect designs system, validates decisions
  │     └── EXIT: Architecture approved → ⏸️ Approval
  │
  ├── 4. Implementation (/KD-epics-and-stories → /KD-dev-story)
  │     └── Tech Lead creates backlog
  │     └── Engineer implements stories
  │     └── EXIT: All stories complete, tests passing
  │
  ├── 5. Quality (/KD-code-review)
  │     └── QA reviews code quality
  │     └── Security performs audit
  │     └── EXIT: Both verdicts PASS
  │
  ├── 6. Deployment (/KD-deployment-plan)
  │     └── DevOps creates deployment plan
  │     └── Production → ⏸️ Approval
  │     └── EXIT: Deployed and healthy
  │
  └── 7. Release (/KD-scale-review)
        └── Release Manager creates release notes
        └── Post-deployment assessment
        └── EXIT: Cycle closed
```

## Checkpoints (⏸️)
1. Product Brief approval
2. PRD approval
3. Architecture approval
4. Production deployment approval

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
