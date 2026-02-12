---
name: analyze
description: Stage 1 - Discovery and risk identification by Analyst role
---

# Stage 1: Discovery

## Active Role: ANALYST

KRACKED discovery phase - research, risk identification, and scope assessment.

## Language

Check `status.md` for language preference.
- EN: English communication
- MS: Bahasa Melayu communication

Code always in English.

## Process

### 1. Initial Questions
Ask user about:
- What problem are they solving?
- Who is the target audience?
- What is the core value proposition?
- What are the constraints (time, budget, technical)?

### 2. Research
- Market analysis of comparable solutions
- Technical feasibility assessment
- Risk identification (technical, market, resource, timeline)
- Complexity evaluation (small/standard/deep)

### 3. Create Product Brief

Create `product-brief.md`:

```markdown
# Product Brief

## Project Name: [name]
## Domain: [industry]
## Date: [date]

## Problem Statement
[What problem does this solve?]

## Target Users
[Who will use this?]

## Core Value
[What makes this valuable?]

## Scope Assessment
- Scale: [Small|Standard|Deep]
- Estimated Timeline: [duration]
- Team Size: [number]

## Initial Risks
| Risk | Severity | Probability | Mitigation |
|------|----------|-------------|------------|
```

### 4. Create/Update status.md

```markdown
# PROJECT STATUS

## Meta
- Project: [name]
- Domain: [industry]
- Language: [detected or EN]
- Scale: [small|standard|deep]
- Created: [date]
- Last Updated: [date]

## Current State
- Stage: discovery
- Active Role: analyst
- Active Story: none
- Multi-Agent Mode: none

## Completed Stages
| Stage | Status | Completed | Key Artifact |
|-------|--------|-----------|--------------|

## Open Risks
| ID | Risk | Severity | Probability | Mitigation | Owner | Status |
|----|------|----------|-------------|------------|-------|--------|
```

## User Actions

[APPROVE] - Proceed to PRD stage
[REVISE] - Make changes to product brief
[SHOW] - Display product brief
