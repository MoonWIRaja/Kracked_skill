---
name: show
description: Display specific artifact
params:
  - name: artifact
    description: Name of artifact to display
    required: true
---

# Show Command

## Purpose

Display a specific artifact created during the project workflow.

## Usage

`/show [artifact]`

## Available Artifacts

| Artifact | Location | Stage |
|----------|-----------|--------|
| product-brief | product-brief.md | Discovery |
| prd | docs/prd.md | Requirements |
| architecture | docs/architecture.md | Architecture |
| data-model | docs/data-model.md | Architecture |
| api-design | docs/api-design.md | Architecture |
| stories | docs/stories.md | Requirements |
| deployment-plan | docs/deployment.md | Deployment |
| security-audit | docs/security-audit.md | Quality |
| release-notes | docs/release-notes.md | Release |
| status | status.md | All |

## Display Format

```
┌────────────────────────────────────────────────────────────┐
│ 📄 [ARTIFACT NAME]                                    │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ [Full content of artifact file]                          │
│                                                         │
├────────────────────────────────────────────────────────────┤
│ META                                                   │
├────────────────────────────────────────────────────────────┤
│ Stage: [stage]                                          │
│ Created: [date]                                         │
│ Last Modified: [date]                                     │
│ Location: [file path]                                   │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

## If Not Found

```
⚠️ Artifact not found: [name]

Available artifacts:
  • /show product-brief
  • /show prd
  • /show architecture
  ...

Use /status to see all created artifacts.
```
