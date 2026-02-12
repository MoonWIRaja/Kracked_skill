---
name: compress-context
description: Reduce context usage by archiving completed stages
---

# Compress Context Command

## Purpose

Reduce token usage by archiving completed stages and artifacts.

## Triggers

- Context usage at 70% capacity
- After 5+ completed stories
- User manually triggers

## Process

1. **Identify What to Compress**:
   - Completed stages (not current stage)
   - Old artifacts with summaries
   - Detailed decision logs

2. **Create Archive**:
   - Move detailed files to `docs/archive/`
   - Keep summaries in `status.md`

3. **Update References**:
   - Add archive location to status.md
   - Maintain decision log summaries

4. **Report Compression**:

```
┌────────────────────────────────────────────────────────────┐
│ 🗜️ CONTEXT COMPRESSION                                │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Trigger: [manual | auto]                               │
│ Archived: [list of files]                               │
│ Context Reduced: [X]%                                    │
│                                                         │
│ Full History: docs/archive/ and status.md                │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

## Archive Structure

```
docs/archive/
├── stage-1-discovery/
│   └── research-notes.md
├── stage-2-requirements/
│   ├── user-stories-detailed.md
│   └── acceptance-criteria.md
└── stage-3-architecture/
    └── system-diagrams.md
```

## Status.md Update

```markdown
## Archive
| Stage | Archive Location | Date |
|-------|------------------|------|
| Discovery | docs/archive/stage-1-discovery/ | [date] |
| Requirements | docs/archive/stage-2-requirements/ | [date] |
```
