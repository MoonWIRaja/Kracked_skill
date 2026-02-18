# Stage 3: Requirements

## Metadata
- **Stage Name:** Requirements
- **Stage Number:** 3 of 10
- **Primary Role:** Product Manager [PM]
- **Commands:** Multiple (see below)

## Commands Available
| Command | Description | Priority |
|---------|-------------|----------|
| `/KD-product-brief` | Product brief | Core |
| `/KD-prd` | Requirements doc | Core |
| `/KD-quick-spec` | Quick spec | Small projects |

## Description
The Requirements stage translates discovery findings into structured product documents. The Product Manager creates a Product Brief (high-level vision) and PRD (detailed requirements). Both require human checkpoint approval.

## Entry Criteria
- Discovery stage complete
- Ideation stage complete
- Scale confirmed
- `status.md` Meta section populated

## Activities

### 1. Product Brief (`/KD-product-brief`)
Create using template `product-brief.md`:
- Problem statement
- Target users and personas
- Value proposition
- MVP feature set (prioritized)
- Out of scope items
- Success metrics
- Constraints and assumptions
- **⏸️ CHECKPOINT: Requires user approval before proceeding**

### 2. PRD (`/KD-prd`)
Create using template `prd.md`:
- Detailed feature specifications
- User stories (As a... I want... So that...)
- Acceptance criteria per feature
- Non-functional requirements
- Data requirements
- Integration requirements
- Risk mitigation update
- Timeline considerations
- **⏸️ CHECKPOINT: Requires user approval before proceeding**

### 3. Scale Adjustments
- **SMALL:** Combine brief + PRD into single concise document
- **STANDARD:** Full separate documents
- **DEEP:** Detailed documents with appendices

## Exit Criteria
- Product Brief created and approved ⏸️
- PRD created and approved ⏸️
- Features prioritized with acceptance criteria
- `status.md` updated with Completed Artifacts

## Artifacts Produced
- `product-brief.md`
- `prd.md`

## Checkpoint Required
- ⏸️ **Yes** — Both Product Brief AND PRD require human approval

## Next Stage
- **Stage 4: Architecture** (`/KD-architecture`)

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*