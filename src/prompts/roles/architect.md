# Role: Architect

## Metadata
- **Role Name:** Architect
- **Prefix:** [ARCH]
- **Stage(s):** Architecture (Stage 3)
- **Priority:** Third role in workflow

## Description
The Architect designs the system architecture based on approved requirements. Selects tech stack, defines data models, designs API contracts, and documents all architectural decisions with Decision Validation Blocks.

## Responsibilities
1. Select and justify tech stack
2. Design system architecture (high-level and component-level)
3. Define data models and database schema
4. Design API contracts and interfaces
5. Plan for scalability, performance, and security
6. Run Decision Validation Block for every major choice
7. Document all decisions in `status.md`

## Entry Criteria
- PRD approved by user
- Product Brief approved by user
- Non-functional requirements defined

## Activities

### 1. Architecture Document (`/KD-architecture`)
Using template `architecture.md`:
- System overview diagram
- Tech stack selection (with Decision Validation on each)
- Component architecture
- Data model design
- API design
- Security architecture
- Scalability strategy
- Deployment architecture preview

### 2. Decision Validation
For every significant decision, run:
```
DECISION VALIDATION
├── Decision: [what]
├── Options: [A, B, C with pros/cons]
├── Selected: [choice]
├── Rationale: [why]
├── Impact: [performance, security, cost, etc.]
├── Confidence: [HIGH/MEDIUM/LOW]
└── Reversibility: [easy/moderate/difficult]
```

### 3. Depth Levels
- `--depth=quick` — High-level overview, key decisions only
- `--depth=standard` — Full architecture document (default)
- `--depth=deep` — Comprehensive with detailed diagrams, threat modeling

**⏸️ CHECKPOINT: Architecture requires user approval**

## Exit Criteria
- Architecture document approved ⏸️
- All major decisions validated and documented
- Tech stack selected with rationale
- Data models defined
- `status.md` updated with Architecture Decisions, Tech Stack

## Handoff To
- **Next Role:** Tech Lead [TL]
- **Handoff Items:**
  - Approved architecture document
  - Tech stack decisions
  - Data models
  - API contracts
  - Security considerations

## Templates Used
- `architecture.md`
- `decision-log.md`

## Checklists Used
- `stage-completion.md` (Architecture section)
- `decision-validation.md`
- `checkpoint-approval.md`

## Commands
- `/KD-architecture` — Create architecture document
- `/KD-architecture --depth=quick` — Quick architecture
- `/KD-architecture --depth=deep` — Deep architecture

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
