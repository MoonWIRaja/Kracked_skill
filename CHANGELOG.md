# KD Changelog

All notable changes to the Kracked_Skills (KD) project will be documented in this file.

## [5.0.0] - 2026-02-19

### Major Upgrade — Phase-Gate Architecture & Workflow Sharding

#### Added

**Agent YAML Files** (15 files):
- `src/agents/*.agent.yaml`
- analyst, pm, architect, tech-lead, engineer, qa, scrum-master, security, devops, release-manager, ux-designer, data-scientist, mobile-developer, database-admin, solo-dev
- Each with skills mapping, persona names, constraints, and workflows

**Phase Gates** (7 files):
- `src/gates/discovery-exit.md`
- `src/gates/requirements-exit.md`
- `src/gates/architecture-exit.md`
- `src/gates/implementation-exit.md`
- `src/gates/quality-exit.md`
- `src/gates/deployment-exit.md`
- `src/gates/release-exit.md`

**Workflows** (~95 files):
- Discovery: analyze (6), brainstorm (5), domain-research (4)
- Planning: prd-create (9), prd-validate (4), epics-stories (6)
- Architecture: design (7), tech-research (4), api-design (5)
- Implementation: story-generate (6), dev-story (6), code-review (5), refactor (4)
- Quality: test-design (5), test-execute (4), security-audit (5)
- Deployment: plan (6), execute (4)
- Release: notes (4), retrospective (4)

**Knowledge Base** (8 files):
- Patterns: auth, api, database, security
- Standards: code-style, naming-conventions, documentation

**Config** (2 files):
- `src/config/scale-taxonomy.yaml` — SMALL/STANDARD/DEEP scales
- `src/config/agents/names.json` — Agent name pools

**Templates** (2 new files):
- `src/templates/tech-stack.md`
- `src/templates/phase-gate-report.md`

**Core Indexes** (1 new file):
- `src/core/indexes/workflows-index.md`

#### Changed

- Updated `src/prompts/system-prompt.md` with Agent Loading Protocol
- Updated `src/prompts/handoff-protocol.md` with gate checking
- Updated `src/templates/status.md` with phase gates section
- Updated `src/templates/story-card.md` with technical context
- Updated `src/core/indexes/roles-index.md` to reference YAML files
- Updated `src/tui/screens/install.js` with all v5.0.0 files
- Updated `src/tui/screens/update.js` with all v5.0.0 files
- Updated `src/tui/screens/about.js` with v5.0.0 features
- Updated `README.md` with v5.0.0 features

#### Removed

- `src/prompts/roles/*.md` (14 files) — Replaced by YAML agents
- `install.sh`, `install.ps1` — Replaced by kd.js
- `update.sh`, `update.ps1` — Replaced by kd.js
- `uninstall.sh`, `uninstall.ps1` — Replaced by kd.js
- `validate.sh` — Integrated into kd.js

#### Architecture

- Phase-gate model with validation checkpoints
- Agent-first approach with YAML definitions
- Scale-aware workflows (SMALL/STANDARD/DEEP)
- Knowledge-driven development
- Workflow sharding for step-by-step execution

---

### Previous Versions

## [4.x] - 2025
- Initial modular structure
- TUI installer (kd.js)
- 6 AI tool adapters

## [3.x] - 2025
- Multi-agent support
- Party mode and swarm

## [2.x] - 2025
- Role-based system
- 8 workflow stages

## [1.x] - 2024
- Basic project structure
- Initial commands