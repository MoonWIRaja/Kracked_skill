# Stage 2: Ideation (`/KD-brainstorm`)

## Overview
The Ideation stage focuses on idea generation, goal-setting, and creative exploration **before** formal requirements are written. This ensures the Product Brief and PRD are grounded in validated ideas rather than assumptions.

## Commands Available
| Command | Description |
|---------|-------------|
| `/KD-brainstorm` | Core ideation (default) |
| `/KD-idea-design-thinking` | Design thinking approach |
| `/KD-idea-innovation` | Innovation workshop |
| `/KD-idea-problem-solving` | Problem-solving focus |
| `/KD-idea-strategist` | Strategic planning |

## Command
```
/KD-brainstorm [--mode=solo|party] [--depth=quick|deep]
```

## Parameters
- `--mode=solo` — Single agent brainstorming (default)
- `--mode=party` — Auto-triggers Party Mode with 3 agents for creative ideation
- `--depth=quick` — Lightweight exploration (30 min)
- `--depth=deep` — Comprehensive research and analysis (2+ hours)

## Entry Criteria
- Discovery (`/KD-analyze`) must be complete
- `status.md` has scale assessment and risk profile

## Roles
- **Primary:** Analyst (research lead)
- **Supporting:** Product Manager (user perspective)
- Both roles may collaborate during this stage

## Activities

### 1. Goal Definition
- Define the core problem being solved
- Identify target users and their pain points
- Set measurable success metrics
- Validate assumptions against web research

### 2. Market & Competitor Research
- **Search the web** for similar products and services
- Analyze competitor strengths and weaknesses
- Identify market gaps and opportunities
- Document findings with source URLs

### 3. Feature Ideation
- Generate a comprehensive list of possible features
- Group features by category (core, nice-to-have, future)
- Prioritize using impact vs effort matrix
- Consider technical feasibility at high level

### 4. User Journey Mapping
- Map the primary user flow
- Identify key touchpoints and decision points
- Note potential friction points and solutions
- Research UX patterns from successful products

### 5. Technical Feasibility
- High-level assessment of technical approach
- Identify major technical risks or unknowns
- Research available tools, frameworks, and services
- Note any integration challenges

### 6. Validation
- Cross-reference ideas against discovery findings
- Validate against market research
- Check alignment with project scale and timeline
- Confirm direction with user before proceeding

## Output Template

Save to: `.kracked/KD_output/brainstorm/brainstorm.md`

```markdown
# BRAINSTORM DOCUMENT

## Meta
- Project: [name]
- Date: [date]
- Participants: [roles involved]
- Mode: [solo/party]

## Problem Statement
[Clear definition of the problem]

## Target Users
[Who are we building for and why]

## Goals & Success Metrics
| Goal | Metric | Target |
|------|--------|--------|
| [goal] | [metric] | [target] |

## Market Research
### Competitors
| Competitor | Strengths | Weaknesses | Gap We Fill |
|-----------|-----------|------------|-------------|

### Sources
- [source 1 with URL]
- [source 2 with URL]

## Feature Ideas
### Core (Must-Have)
- [ ] [feature 1]
- [ ] [feature 2]

### Nice-to-Have
- [ ] [feature]

### Future
- [ ] [feature]

## User Journey
[Primary user flow description]

## Technical Notes
[High-level technical considerations]

## Risks & Unknowns
| Risk | Severity | Mitigation |
|------|----------|------------|

## Recommendation
[Clear direction based on brainstorming]

## Next Step
→ Proceed to `/KD-product-brief`
```

## Exit Criteria
- Goals defined and validated
- Market research completed
- Feature list prioritized
- User confirms direction
- Document saved to `.kracked/KD_output/brainstorm/brainstorm.md`

## Rules
- Always include web research — never brainstorm in a vacuum
- Cite sources with URLs
- Present findings as actionable insights, not raw data
- If `/KD-brainstorm --mode=party` is used, run Party Mode first then synthesize
- Update `status.md` when brainstorm is complete

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
