# Workflow: Quick Start

> Accelerated workflow for SMALL scale projects

## Overview
The quick-start workflow condenses the KD lifecycle for small, focused projects. Combines stages where appropriate and reduces documentation overhead.

## Flow

```
Start
  │
  ├── 1. Quick Analysis (/KD-analyze)
  │     └── Abbreviated context gathering
  │     └── Auto-set scale: SMALL
  │     └── EXIT: Context understood
  │
  ├── 2. Combined Brief + Requirements
  │     └── Single document combining product brief + key requirements
  │     └── ⏸️ Quick approval
  │     └── EXIT: Requirements confirmed
  │
  ├── 3. Quick Architecture
  │     └── /KD-architecture --depth=quick
  │     └── Key decisions only, minimal documentation
  │     └── ⏸️ Quick approval
  │
  ├── 4. Direct Implementation
  │     └── Informal stories (no formal story cards)
  │     └── Implement features directly
  │     └── EXIT: Features working
  │
  ├── 5. Quick Review
  │     └── Combined code + security review
  │     └── EXIT: No critical issues
  │
  └── 6. Deploy + Release (Combined)
        └── Deploy to target environment
        └── Brief release notes
        └── EXIT: Deployed
```

## Differences from Main Workflow
- Stages 2-3 have simplified artifacts
- Stage 4 skips formal story cards
- Stages 5 combines QA + Security
- Stages 6-7 are merged
- Fewer checkpoints (only 2: requirements, architecture)

## When to Use
- Solo developer projects
- Timeline < 2 weeks
- Low technical risk
- ≤ 2 integration points
- Public data only

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
