# Kracked_Skills (KD)

<p align="center">
<strong>Structured Multi-Role AI Product Execution System</strong>
<br>
<img src="https://img.shields.io/badge/version-5.0.0-blue.svg" alt="Version">
<img src="https://img.shields.io/badge/license-MIT-green.svg" alt="License">
</p>

<p align="center">
AI Skill by <a href="https://krackeddevs.com/">KRACKEDDEVS</a>
</p>

<p align="center">
<a href="#-quick-start">Quick Start</a> •
<a href="#-v50-features">v5.0 Features</a> •
<a href="#-commands">Commands</a> •
<a href="#-supported-tools">Supported Tools</a> •
<a href="docs/GETTING-STARTED.md">Documentation</a>
</p>

---

> **KD finishes what it starts.**

## 🚀 Quick Start

### Install (All Platforms)

```bash
# macOS / Linux / Git Bash
curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_Skills/main/kd.sh | bash

# Windows PowerShell
irm https://raw.githubusercontent.com/MoonWIRaja/Kracked_Skills/main/kd.ps1 | iex

# Or directly with Node.js
node kd.js install
```

### After Installation

```
/KD                    # Show command menu
/KD-analyze            # Start discovery phase
/KD-status             # Check project state
```

---

## ✨ v5.0.0 Features

### 🎭 15 Agent YAML Definitions

Structured agent files with skills mapping, persona names, and constraints:

| Role | Prefix | Stage | Skills |
|------|--------|-------|--------|
| Analyst | `[ANA]` | Discovery | 6, 10 |
| PM | `[PM]` | Requirements | 6, 10 |
| Architect | `[ARCH]` | Architecture | 1, 3, 4, 5, 6, 7, 10 |
| Tech Lead | `[TL]` | Implementation | 1, 3, 4, 5, 6, 10 |
| Engineer | `[ENG]` | Implementation | 1-11 |
| QA | `[QA]` | Quality | 1, 2, 3, 4, 5, 6, 10 |
| Scrum Master | `[SM]` | Implementation | 6, 10 |
| Security | `[SEC]` | Quality | 2, 6, 10 |
| DevOps | `[DEVOPS]` | Deployment | 5, 6, 7, 10 |
| Release Manager | `[RM]` | Release | 6, 10 |
| UX Designer | `[UX]` | Architecture | 4, 6, 10 |
| Data Scientist | `[DATA]` | Implementation | 6, 10 |
| Mobile Developer | `[MOBILE]` | Implementation | 3, 4, 6, 9, 10 |
| Database Admin | `[DBA]` | Architecture | 1, 6, 10 |
| Solo Developer | `[SOLO]` | All | 1-11 |

### 🚪 Phase-Gate Architecture

Validation checkpoints between each phase:

```
Discovery → [Gate] → Requirements → [Gate] → Architecture → [Gate] → 
Implementation → [Gate] → Quality → [Gate] → Deployment → [Gate] → Release
```

Each gate validates:
- ✅ Required artifacts produced
- ✅ Quality criteria met
- ✅ No critical blockers

### 📋 Workflow Sharding

~95 step-by-step workflow files organized by phase:

- **Discovery**: analyze, brainstorm, domain-research
- **Planning**: prd-create, prd-validate, epics-stories
- **Architecture**: design, tech-research, api-design
- **Implementation**: story-generate, dev-story, code-review, refactor
- **Quality**: test-design, test-execute, security-audit
- **Deployment**: plan, execute
- **Release**: notes, retrospective

### 📚 Knowledge Base

Patterns and standards for consistent development:

- `patterns/auth-patterns.md` — Authentication patterns
- `patterns/api-patterns.md` — API design patterns
- `patterns/database-patterns.md` — Database patterns
- `patterns/security-patterns.md` — Security patterns
- `standards/code-style.md` — Code style guidelines
- `standards/naming-conventions.md` — Naming conventions
- `standards/documentation-standards.md` — Documentation standards

### 📊 Scale-Aware Workflows

KD adapts workflow depth based on project scale:

| Scale | Team | Timeline | Depth |
|-------|------|----------|-------|
| SMALL | Solo | < 2 weeks | Lightweight |
| STANDARD | 2-5 | 2-8 weeks | Balanced |
| DEEP | 6+ | > 8 weeks | Comprehensive |

### 🌍 Multi-Language Support

- **English (EN)** — Full interface
- **Bahasa Melayu (MS)** — Full interface
- **Custom** — Type your own language during install

---

## 📋 Commands

| Category | Commands | Description |
|----------|----------|-------------|
| **Core** | `/KD`, `/KD-analyze`, `/KD-brainstorm`, `/KD-prd` | Product lifecycle |
| **Planning** | `/KD-epics-and-stories`, `/KD-sprint-planning` | Sprint planning |
| **Dev** | `/KD-dev-story`, `/KD-refactor`, `/KD-code-review` | Implementation |
| **Testing** | `/KD-test`, `/KD-test-sprite`, `/KD-test-automate` | QA |
| **Deploy** | `/KD-deployment-plan`, `/KD-validate` | Deployment |
| **Roles** | `/KD-role-analyst`, `/KD-role-architect`, etc. | 15 roles |

*Total 120+ commands available.*

---

## 🔧 Supported Tools

| Tool | Adapter | Auto-Setup |
|------|---------|------------|
| Claude Code | `.claude/` | ✅ |
| Cursor | `.cursor/` | ✅ |
| Cline | `.clinerules/` | ✅ |
| Kilo Code | `.kilocode/` | ✅ |
| Roo Code | `.roo/` | ✅ |
| Antigravity | `.agent/` | ✅ |

---

## 📁 Project Structure

```
.kracked/
├── agents/              # 15 YAML agent definitions
├── gates/               # 7 phase gate checklists
├── workflows/           # ~95 step-by-step files
├── knowledge/           # Patterns & standards
├── prompts/             # System prompts
├── templates/           # 11 document templates
├── skills/              # 17 technical skills
├── config/              # Settings & language
└── KD_output/           # Generated output
    └── status/status.md # Project state
```

---

## 🔄 Maintenance

```bash
node kd.js update      # Update to latest
node kd.js uninstall   # Remove KD
node kd.js help        # Show help
```

---

## 📄 License

MIT License — see [LICENSE](LICENSE).

---

## 🏢 About

**KRACKEDDEVS** builds AI-powered developer tools.

- 🌐 **Website:** [krackeddevs.com](https://krackeddevs.com/)
- 📦 **GitHub:** [github.com/MoonWIRaja/Kracked_Skills](https://github.com/MoonWIRaja/Kracked_Skills)

---

<p align="center">
<strong>KD finishes what it starts.</strong><br>
<em>AI Skill by KRACKEDDEVS</em>
</p>