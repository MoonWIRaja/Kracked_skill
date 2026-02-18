# Stages Index — KD v5.0.0 (Expanded)

## Overview

KD workflow is organized into **10 sequential stages**. Each stage has specific commands and produces defined artifacts.

```
┌──────────┐   ┌──────────┐   ┌─────────────┐   ┌──────────────┐
│Discovery │──▶│ Ideation │──▶│Requirements │──▶│ Architecture │
│ Stage 1  │   │ Stage 2  │   │  Stage 3    │   │   Stage 4    │
└──────────┘   └──────────┘   └─────────────┘   └──────┬───────┘
                                                     │
┌──────────┐   ┌──────────┐   ┌─────────────┐   ┌────┴────────┐
│ Release  │◀──│Deployment│◀──│   Quality   │◀──│  Testing    │
│ Stage 10 │   │ Stage 9  │   │   Stage 8   │   │   Stage 7   │
└──────────┘   └──────────┘   └─────────────┘   └─────────────┘
                                                     │
                              ┌─────────────┐   ┌────┴────────┐
                              │   Release   │◀──│ Deployment  │
                              │  Stage 10   │   │   Stage 9   │
                              └─────────────┘   └─────────────┘
```

---

## Stage 1: Discovery

**Purpose:** Understand project context, assess risks, gather requirements.

### Commands
| Command | Description | Output |
|---------|-------------|--------|
| `/KD-kickoff` | Initialize project | Project context |
| `/KD-analyze` | Risk assessment | `status.md` |
| `/KD-domain-research` | Domain research | Research notes |
| `/KD-market-research` | Market analysis | Market report |
| `/KD-tech-research` | Tech research | Tech evaluation |
| `/KD-project-context` | Context analysis | Context doc |

### Entry Criteria
- Project folder exists

### Exit Criteria
- Project scope defined
- Risks identified
- Scale assessed (SMALL/STANDARD/DEEP)

### Active Role
- **Analyst** `[ANALYST]`

---

## Stage 2: Ideation

**Purpose:** Generate ideas, solve problems, plan strategy.

### Commands
| Command | Description | Output |
|---------|-------------|--------|
| `/KD-brainstorm` | Creative ideation | `brainstorm.md` |
| `/KD-idea-design-thinking` | Design thinking | Design concepts |
| `/KD-idea-innovation` | Innovation workshop | Innovation report |
| `/KD-idea-problem-solving` | Problem solving | Solutions doc |
| `/KD-idea-strategist` | Strategic planning | Strategy doc |

### Entry Criteria
- Discovery complete

### Exit Criteria
- Ideas documented
- Direction chosen

### Active Role
- **Analyst + PM** `[ANALYST]` `[PM]`

---

## Stage 3: Requirements

**Purpose:** Define what to build, create product documents.

### Commands
| Command | Description | Output |
|---------|-------------|--------|
| `/KD-product-brief` | Product brief | `product-brief.md` |
| `/KD-prd` | Requirements doc | `prd.md` |
| `/KD-quick-spec` | Quick spec | `spec.md` |

### Entry Criteria
- Ideation complete
- Direction approved

### Exit Criteria
- Product Brief approved ⏸️
- PRD approved ⏸️

### Active Role
- **Product Manager** `[PM]`

### Checkpoint
- ⏸️ Product Brief requires human approval
- ⏸️ PRD requires human approval

---

## Stage 4: Architecture

**Purpose:** Design system, select technologies, plan structure.

### Commands
| Command | Description | Output |
|---------|-------------|--------|
| `/KD-architecture` | System design | `architecture.md` |
| `/KD-api-design` | API design | API spec |
| `/KD-ux-design` | UX/UI design | Wireframes |
| `/KD-tool-selector` | Tech stack selection | Tech stack |
| `/KD-version-check` | Version compatibility | Compatibility report |
| `/KD-scale-review` | Scalability review | Scale plan |

### Entry Criteria
- PRD approved

### Exit Criteria
- Architecture approved ⏸️
- Tech stack selected

### Active Role
- **Architect** `[ARCH]`

### Checkpoint
- ⏸️ Architecture requires human approval

---

## Stage 5: Planning

**Purpose:** Create backlog, plan sprints, organize work.

### Commands
| Command | Description | Output |
|---------|-------------|--------|
| `/KD-epics-and-stories` | Backlog creation | Story cards |
| `/KD-sprint-planning` | Sprint planning | Sprint plan |
| `/KD-build-workflow` | Build workflow | Workflow doc |

### Entry Criteria
- Architecture approved

### Exit Criteria
- Backlog created
- Stories estimated

### Active Role
- **Tech Lead** `[TL]`

---

## Stage 6: Implementation

**Purpose:** Write code, implement features, build modules.

### Commands
| Command | Description | Output |
|---------|-------------|--------|
| `/KD-dev-story` | Story implementation | Code |
| `/KD-quick-dev` | Quick development | Code |
| `/KD-refactor` | Refactoring | Refactored code |
| `/KD-build-module` | Module building | Module |

### Entry Criteria
- Stories defined
- Architecture clear

### Exit Criteria
- Features implemented
- Unit tests passing

### Active Role
- **Engineer** `[ENG]`

---

## Stage 7: Testing

**Purpose:** Test functionality, automate tests, ensure quality.

### Commands
| Command | Description | Output |
|---------|-------------|--------|
| `/KD-test` | Test planning | Test plan |
| `/KD-test-arch` | Test architecture | Test strategy |
| `/KD-test-design` | Test design | Test cases |
| `/KD-test-automate` | Automation | Automated tests |
| `/KD-test-sprite` | Visual testing | Test report |
| `/KD-test-ci` | CI testing | CI config |
| `/KD-test-nfr` | Non-functional testing | NFR report |

### Entry Criteria
- Code implemented

### Exit Criteria
- All tests passing
- Coverage acceptable

### Active Role
- **QA** `[QA]`

---

## Stage 8: Quality

**Purpose:** Review code, validate project, fix issues.

### Commands
| Command | Description | Output |
|---------|-------------|--------|
| `/KD-code-review` | Code review | `code-review.md` |
| `/KD-validate` | Project validation | Validation report |
| `/KD-fix-course` | Course correction | Fix log |

### Entry Criteria
- Tests passing

### Exit Criteria
- Code review passed
- No critical issues

### Active Role
- **QA + Security** `[QA]` `[SEC]`

---

## Stage 9: Deployment

**Purpose:** Deploy to production, configure infrastructure.

### Commands
| Command | Description | Output |
|---------|-------------|--------|
| `/KD-deployment-plan` | Deployment strategy | `deployment-plan.md` |
| `/KD-validate-workflow` | Workflow validation | Validation report |

### Entry Criteria
- Quality checks passed

### Exit Criteria
- Deployed to staging
- Production approved ⏸️

### Active Role
- **DevOps** `[DEVOPS]`

### Checkpoint
- ⏸️ Production deployment requires human approval

---

## Stage 10: Release

**Purpose:** Document release, review performance, close cycle.

### Commands
| Command | Description | Output |
|---------|-------------|--------|
| `/KD-scale-review` | Post-deploy review | Review report |
| `/KD-retrospective` | Sprint retrospective | Retro notes |

### Entry Criteria
- Deployment successful

### Exit Criteria
- Release notes created
- Lessons learned documented

### Active Role
- **Release Manager** `[RM]`

---

## Cross-Cutting Commands

### Multi-Agent (Any Stage)
| Command | Description |
|---------|-------------|
| `/KD-party-mode` | Parallel ideation |
| `/KD-swarm` | Parallel execution |

### Utility (Any Stage)
| Command | Description |
|---------|-------------|
| `/KD-status` | Project status |
| `/KD-help` | Command help |
| `/KD-tool-selector` | Tech selection |
| `/KD-version-check` | Version check |

### Roles (Manual Override)
| Command | Role |
|---------|------|
| `/KD-role-analyst` | Analyst |
| `/KD-role-pm` | Product Manager |
| `/KD-role-architect` | Architect |
| `/KD-role-dev` | Engineer |
| `/KD-role-qa` | QA |
| `/KD-role-security` | Security |
| `/KD-role-devops` | DevOps |
| `/KD-role-ux` | UX Designer |
| `/KD-role-data` | Data Scientist |
| `/KD-role-mobile` | Mobile Developer |
| `/KD-role-dba` | Database Admin |

---

## Domain-Specific Workflows

### Game Development
Use `/KD-game-*` commands for game projects. See Game Dev Index.

### API Development
Use `/KD-api-design` in Architecture stage.

### Mobile Development
Use `/KD-role-mobile` for mobile-specific tasks.

---

## Quick Reference

| Stage | Key Command | Must Have |
|-------|-------------|-----------|
| 1. Discovery | `/KD-analyze` | ✅ Required |
| 2. Ideation | `/KD-brainstorm` | ✅ Required |
| 3. Requirements | `/KD-prd` | ✅ Required |
| 4. Architecture | `/KD-architecture` | ✅ Required |
| 5. Planning | `/KD-epics-and-stories` | ✅ Required |
| 6. Implementation | `/KD-dev-story` | ✅ Required |
| 7. Testing | `/KD-test` | ✅ Required |
| 8. Quality | `/KD-code-review` | ✅ Required |
| 9. Deployment | `/KD-deployment-plan` | ✅ Required |
| 10. Release | `/KD-scale-review` | ✅ Required |

---

*KD finishes what it starts.* | KRACKEDDEVS | https://krackeddevs.com/