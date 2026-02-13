# Workflow: Maintenance

> Workflow for ongoing maintenance after initial release

## Overview
The maintenance workflow handles bug fixes, feature additions, and ongoing improvements after the initial product release.

## Flow

```
Maintenance Trigger
  │
  ├── Is it a Bug Fix?
  │     ├── YES → Bug Fix Flow
  │     │     ├── 1. Identify and reproduce
  │     │     ├── 2. Implement fix (Engineer)
  │     │     ├── 3. Quick review (QA)
  │     │     ├── 4. Deploy patch (DevOps)
  │     │     └── 5. Release patch notes (RM)
  │     │
  │     └── NO → Continue ↓
  │
  ├── Is it a Small Feature?
  │     ├── YES → Small Feature Flow
  │     │     ├── 1. Quick requirements (PM)
  │     │     ├── 2. Impact assessment (Architect)
  │     │     ├── 3. Implement (Engineer)
  │     │     ├── 4. Review (QA)
  │     │     ├── 5. Deploy (DevOps)
  │     │     └── 6. Update release notes (RM)
  │     │
  │     └── NO → Continue ↓
  │
  └── Is it a Major Feature?
        └── YES → Use Quick Start or Main Workflow
              └── Start from /KD-analyze with existing context
```

## Maintenance Tasks

### Regular Checks
- [ ] Dependency updates
- [ ] Security patches
- [ ] Performance monitoring review
- [ ] Error rate review
- [ ] User feedback collection

### Periodic Reviews
- Monthly: Security dependency scan
- Quarterly: Architecture review
- Semi-annually: Full scale review

## Status Tracking
During maintenance, `status.md` continues to be the source of truth:
- New features get story cards
- Bug fixes documented in Change Log
- Decisions still use Decision Validation

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
