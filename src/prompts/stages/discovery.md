# Stage 1: Discovery

## Metadata
- **Stage Name:** Discovery
- **Stage Number:** 1 of 10
- **Primary Role:** Analyst [ANALYST]
- **Commands:** Multiple (see below)

## Commands Available
| Command | Description | Priority |
|---------|-------------|----------|
| `/KD-kickoff` | Initialize project | Core |
| `/KD-analyze` | Risk assessment | Core |
| `/KD-domain-research` | Domain research | Optional |
| `/KD-market-research` | Market analysis | Optional |
| `/KD-tech-research` | Tech research | Optional |
| `/KD-project-context` | Context analysis | Optional |

## Description
The Discovery stage is the starting point of every KD project. The Analyst gathers context, identifies risks, and assesses the appropriate project scale. This stage ensures that all subsequent work is informed by a thorough understanding of the project.

## Entry Criteria
- KD installed in the project (`status.md` exists)
- User has initiated `/KD-analyze`
- `status.md` shows Stage: "Ready to begin"

## Activities

### 1. Context Gathering
Ask the user structured questions:
- **Problem:** What problem does this project solve?
- **Users:** Who are the target users?
- **Domain:** What industry/domain?
- **Timeline:** What is the expected timeline?
- **Team:** How many people will work on this?
- **Existing:** Is there an existing codebase?
- **Budget:** Budget constraints?
- **Compliance:** Any regulatory requirements?

### 2. Risk Assessment
Identify and categorize risks:
- **Technical:** Complexity, unknowns, dependencies
- **Business:** Market, competition, timeline pressure
- **Security:** Data sensitivity, compliance needs
- **Operational:** Deployment, scaling, maintenance

### 3. Scale Assessment
Evaluate factors and recommend SMALL / STANDARD / DEEP:
- Present scoring table to user
- Calculate weighted score
- Recommend scale with rationale
- Get user confirmation

### 4. Update Status
Update `status.md`:
- Meta section (project name, domain, language, scale, deadline)
- Open Risks section
- Security Notes section
- Change Log

## Exit Criteria
- All context questions answered
- Risks documented in `status.md`
- Scale assessed and confirmed by user
- `status.md` Meta section fully populated

## Artifacts Produced
- Updated `status.md` (Meta, Risks, Security Notes)
- Risk register (if scale is DEEP)

## Checkpoint Required
- No formal checkpoint — scale confirmation only

## Next Stage
- **Stage 2: Ideation** (`/KD-brainstorm`)

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
