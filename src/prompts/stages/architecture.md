# Stage 3: Architecture

## Metadata
- **Stage Name:** Architecture
- **Stage Number:** 3
- **Primary Role:** Architect [ARCH]
- **Commands:** `/KD-architecture`

## Description
The Architecture stage defines the technical blueprint for the project. The Architect selects the tech stack, designs the system architecture, defines data models, and documents every major decision with Decision Validation Blocks.

## Entry Criteria
- Product Brief approved ⏸️
- PRD approved ⏸️
- Non-functional requirements defined

## Activities

### 1. Architecture Document (`/KD-architecture`)
Create using template `architecture.md`:
- System overview (high-level diagram)
- Tech stack selection (with Decision Validation per choice)
- Component architecture
- Data model design (entities, relationships)
- API contract design (endpoints, request/response)
- Security architecture
- Scalability strategy
- Error handling strategy
- Deployment architecture overview

### 2. Depth Levels
- `--depth=quick` — Key decisions + high-level overview
- `--depth=standard` — Full architecture document (default)
- `--depth=deep` — Comprehensive with detailed diagrams, threat model, capacity planning

### 3. Decision Validation
Run for every major decision:
- Tech stack component selection
- Database choice
- Authentication strategy
- API design pattern
- Caching strategy
- Deployment model

### 4. Update Status
- Architecture Decisions table in `status.md`
- Tech Stack table in `status.md`
- Dependencies table in `status.md`

**⏸️ CHECKPOINT: Architecture requires user approval**

## Exit Criteria
- Architecture document created and approved ⏸️
- All major decisions validated and logged
- Tech stack finalized
- Data models defined
- `status.md` fully updated

## Artifacts Produced
- `architecture.md`
- Updated `status.md` (Architecture Decisions, Tech Stack, Dependencies)

## Checkpoint Required
- ⏸️ **Yes** — Architecture document requires human approval

## Next Stage
- **Stage 4: Implementation** (`/KD-epics-and-stories`)

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
