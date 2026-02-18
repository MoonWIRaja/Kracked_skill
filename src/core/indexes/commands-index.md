# Commands Index — KD v5.0.0 (Reorganized)

## Overview

Total: **80+ commands** organized by stage and purpose.

---

## Stage 1: Discovery (6 Commands)

| Command | Description | Priority |
|---------|-------------|----------|
| `/KD-kickoff` | Initialize project | Core |
| `/KD-analyze` | Risk assessment | Core |
| `/KD-domain-research` | Domain research | Optional |
| `/KD-market-research` | Market analysis | Optional |
| `/KD-tech-research` | Tech research | Optional |
| `/KD-project-context` | Context analysis | Optional |

---

## Stage 2: Ideation (5 Commands)

| Command | Description | Priority |
|---------|-------------|----------|
| `/KD-brainstorm` | Creative ideation | Core |
| `/KD-idea-design-thinking` | Design thinking | Optional |
| `/KD-idea-innovation` | Innovation workshop | Optional |
| `/KD-idea-problem-solving` | Problem solving | Optional |
| `/KD-idea-strategist` | Strategic planning | Optional |

---

## Stage 3: Requirements (3 Commands)

| Command | Description | Priority |
|---------|-------------|----------|
| `/KD-product-brief` | Product brief | Core |
| `/KD-prd` | Requirements doc | Core |
| `/KD-quick-spec` | Quick spec | Small projects |

---

## Stage 4: Architecture (6 Commands)

| Command | Description | Priority |
|---------|-------------|----------|
| `/KD-architecture` | System design | Core |
| `/KD-api-design` | API design | Backend |
| `/KD-ux-design` | UX/UI design | Frontend |
| `/KD-tool-selector` | Tech stack selection | Recommended |
| `/KD-version-check` | Version compatibility | Recommended |
| `/KD-scale-review` | Scalability review | Large projects |

---

## Stage 5: Planning (3 Commands)

| Command | Description | Priority |
|---------|-------------|----------|
| `/KD-epics-and-stories` | Backlog creation | Core |
| `/KD-sprint-planning` | Sprint planning | Agile |
| `/KD-build-workflow` | Build workflow | Advanced |

---

## Stage 6: Implementation (4 Commands)

| Command | Description | Priority |
|---------|-------------|----------|
| `/KD-dev-story` | Story implementation | Core |
| `/KD-quick-dev` | Quick development | Small tasks |
| `/KD-refactor` | Refactoring | Tech debt |
| `/KD-build-module` | Module building | Advanced |

---

## Stage 7: Testing (7 Commands)

| Command | Description | Priority |
|---------|-------------|----------|
| `/KD-test` | Test planning | Core |
| `/KD-test-arch` | Test architecture | Recommended |
| `/KD-test-design` | Test design | Recommended |
| `/KD-test-automate` | Automation | Recommended |
| `/KD-test-sprite` | Visual testing | UI projects |
| `/KD-test-ci` | CI testing | DevOps |
| `/KD-test-nfr` | Non-functional testing | Enterprise |

---

## Stage 8: Quality (3 Commands)

| Command | Description | Priority |
|---------|-------------|----------|
| `/KD-code-review` | Code review | Core |
| `/KD-validate` | Project validation | Core |
| `/KD-fix-course` | Course correction | When issues |

---

## Stage 9: Deployment (2 Commands)

| Command | Description | Priority |
|---------|-------------|----------|
| `/KD-deployment-plan` | Deployment strategy | Core |
| `/KD-validate-workflow` | Workflow validation | Recommended |

---

## Stage 10: Release (2 Commands)

| Command | Description | Priority |
|---------|-------------|----------|
| `/KD-scale-review` | Post-deploy review | Core |
| `/KD-retrospective` | Sprint retrospective | Agile |

---

## Cross-Cutting Commands

### Multi-Agent (2 Commands)
| Command | Description | Use When |
|---------|-------------|----------|
| `/KD-party-mode` | Parallel ideation | Complex decisions |
| `/KD-swarm` | Parallel execution | Multiple tasks |

### Utility (4 Commands)
| Command | Description | Use When |
|---------|-------------|----------|
| `/KD-status` | Project status | Any time |
| `/KD-help` | Command help | Need info |
| `/KD-build-agent` | Build custom agent | Advanced |
| `/KD-build-module` | Build module | Advanced |

---

## Role Commands (11 Commands)

| Command | Role | Use When |
|---------|------|----------|
| `/KD-role-analyst` | Analyst | Discovery |
| `/KD-role-pm` | Product Manager | Requirements |
| `/KD-role-architect` | Architect | Architecture |
| `/KD-role-dev` | Engineer | Implementation |
| `/KD-role-qa` | QA | Testing |
| `/KD-role-security` | Security | Security audit |
| `/KD-role-devops` | DevOps | Deployment |
| `/KD-role-ux` | UX Designer | UI/UX work |
| `/KD-role-data` | Data Scientist | Data/ML |
| `/KD-role-mobile` | Mobile Developer | Mobile apps |
| `/KD-role-dba` | Database Admin | Database |

> **Note:** Roles auto-activate by stage. Manual override only when needed.

---

## Game Development (17 Commands)

Domain-specific for game projects only.

| Command | Description |
|---------|-------------|
| `/KD-game-gdd` | Game Design Document |
| `/KD-game-arch` | Game Architecture |
| `/KD-game-architect` | Game Architect role |
| `/KD-game-brainstorm` | Game brainstorming |
| `/KD-game-brief` | Game brief |
| `/KD-game-designer` | Game Designer role |
| `/KD-game-dev` | Game development |
| `/KD-game-dev-story` | Game story implementation |
| `/KD-game-narrative` | Game narrative |
| `/KD-game-qa` | Game testing |
| `/KD-game-scrum-master` | Game Scrum |
| `/KD-game-solo` | Solo game dev |
| `/KD-game-story` | Game story design |
| `/KD-game-test-auto` | Game test automation |
| `/KD-game-test-design` | Game test design |
| `/KD-game-test-perf` | Game performance |
| `/KD-game-test-plan` | Game test plan |
| `/KD-game-writer` | Game writer role |

---

## Removed Commands (Duplicates)

These commands were removed due to redundancy:

| Removed | Reason | Use Instead |
|---------|--------|-------------|
| `/KD-idea-solver` | Duplicate | `/KD-idea-problem-solving` |
| `/KD-idea-storyteller` | Duplicate | `/KD-idea-storytelling` |
| `/KD-idea-presenter` | Subset | `/KD-idea-storytelling` |
| `/KD-idea-coach` | Subset | `/KD-idea-design-thinking` |
| `/KD-qa-automate` | Duplicate | `/KD-test-automate` |
| `/KD-test-teach` | Documentation | Read docs |
| `/KD-test-trace` | Subset | `/KD-test-design` |
| `/KD-test-atdd` | Subset | `/KD-test-design` |
| `/KD-validate-agent` | Rarely used | `/KD-validate` |
| `/KD-idea-storytelling` | Merged | `/KD-idea-strategist` |

---

## Quick Start (10 Core Commands)

For most projects, these 10 commands are sufficient:

```
1.  /KD-analyze          → Discovery
2.  /KD-brainstorm       → Ideation
3.  /KD-product-brief    → Define product
4.  /KD-prd              → Requirements
5.  /KD-architecture     → Design system
6.  /KD-epics-and-stories → Plan work
7.  /KD-dev-story        → Implement
8.  /KD-test             → Testing
9.  /KD-code-review      → Quality
10. /KD-deployment-plan  → Deploy
```

---

## Command Count Summary

| Category | Count |
|----------|-------|
| Core Workflow | 41 |
| Multi-Agent | 2 |
| Utility | 4 |
| Roles | 11 |
| Game Dev | 17 |
| **Total** | **75** |

---

*Load detail from workflows/ on demand*

*KD finishes what it starts.* | KRACKEDDEVS | https://krackeddevs.com/