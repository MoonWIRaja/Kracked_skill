---
name: scale-review
description: Stage 7 - Post-deployment review and metrics
---

# Stage 7: Release

## Active Role: RELEASE MANAGER

KRACKED release phase - post-deployment monitoring, metrics collection, and documentation.

## Process

### 1. Collect Metrics

#### Business Metrics
- User adoption
- Feature usage
- Conversion rates
- User feedback

#### Technical Metrics
- Response times
- Error rates
- Resource utilization
- Uptime/availability

### 2. Create Release Notes

Create `docs/release-notes.md`:

```markdown
# Release Notes

## Version: [version]
## Release Date: [date]

## Summary
[Brief description of release]

## New Features
### [Feature 1]
[Description and user value]

### [Feature 2]
...

## Improvements
- [Improvement 1]
- [Improvement 2]

## Bug Fixes
- [Bug 1 description]
- [Bug 2 description]

## Known Issues
| ID | Issue | Impact | Workaround |
|----|-------|--------|------------|
| [if any] | [description] | [severity] | [workaround] |

## Upgrade Notes
[Any special upgrade instructions]

## Migration Notes
[Any database migrations or data changes required]
```

### 3. Document Metrics Plan

Create `docs/metrics-plan.md`:

```markdown
# Metrics Plan

## Release: [version]
## Date: [date]

## Success Metrics

### User Engagement
- DAU/MAU: [target]
- Session duration: [target]
- Feature adoption: [target]

### Technical Performance
- P95 response time: [target]
- Error rate: [target]
- Uptime: [target]
- Cost per user: [target]

### Business Outcomes
- Conversion rate: [target]
- Retention rate: [target]
- NPS score: [target]

## Monitoring Schedule
- Daily: [who checks what]
- Weekly: [review meeting]
- Monthly: [strategic review]

## Alert Configuration
| Metric | Threshold | Action |
|--------|-----------|--------|
| [metric] | [value] | [action] |
```

### 4. Tech Debt Log

Update `docs/tech-debt.md`:

```markdown
# Technical Debt Log

## As of Release: [version]
## Date: [date]

## Current Debt
| ID | Item | Priority | Effort | Added |
|----|------|----------|--------|--------|
| [list accumulated technical debt] |

## Paid Off This Release
| ID | Item | Effort |
|----|------|--------|
| [list debt addressed in this release] |

## Next Priorities
1. [Priority 1]
2. [Priority 2]
```

### 5. Update status.md

```markdown
## Completed Stages
| Stage | Status | Completed | Key Artifact |
|-------|--------|-----------|--------------|
| ... | ... | ... | ... |
| Release | ✅ | [date] | release-notes.md |

## Deployment State
- Environment: production
- Last Deploy: [datetime]
- Status: deployed
- Version: [version]
```

## Exit Criteria

- [ ] Release notes complete
- [ ] Metrics defined and tracking
- [ ] Known issues documented
- [ ] Tech debt logged
- [ ] Post-release monitoring active

## User Actions

[COMPLETE] - Complete release cycle
[MONITOR] - Set up monitoring
[SHOW] - Show release notes
```

### 6. End of Release Cycle

Provide summary:

```
┌────────────────────────────────────────────────────────────┐
│ ✅ RELEASE COMPLETE                                      │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Version: [version]                                      │
│ Date: [date]                                            │
│                                                         │
│ Features Delivered: [count]                              │
│ Bugs Fixed: [count]                                     │
│ Known Issues: [count]                                    │
│                                                         │
│ Next Steps:                                            │
│   • Monitor metrics for [period]                        │
│   • Address known issues                                │
│   • Plan next release                                   │
│                                                         │
└────────────────────────────────────────────────────────────┘
```
