<p align="center">
<h1 align="center">Kracked_Skills (KD)</h1>
<p align="center">
<strong>Structured Multi-Role AI Product Execution System</strong>
<br>
<img src="https://img.shields.io/badge/version-5.0.0-blue.svg" alt="Version">
</p>
<p align="center">
AI Skill by <a href="https://krackeddevs.com/">KRACKEDDEVS</a>
</p>
<p align="center">
<a href="#-quick-start">Quick Start</a> •
<a href="#-features">Features</a> •
<a href="#-commands">Commands</a> •
<a href="#-supported-tools">Supported Tools</a> •
<a href="docs/GETTING-STARTED.md">Documentation</a>
</p>
</p>

---

> **KD finishes what it starts.**

## 🚀 Quick Start

### 🎯 TUI Install (Recommended)

**All Platforms** (requires Node.js):
```bash
# macOS / Linux / Git Bash
curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_Skills/main/kd.sh | bash

# Windows PowerShell
irm https://raw.githubusercontent.com/MoonWIRaja/Kracked_Skills/main/kd.ps1 | iex
```

### 📦 Direct Commands

```bash
# Install (interactive)
node kd.js install

# Install (non-interactive)
node kd.js install --target=cline,cursor --lang=ms --non-interactive

# Update
node kd.js update

# Uninstall
node kd.js uninstall

# Show help
node kd.js help
```

### 🌍 Custom Language Support

KD now supports **any language**! During install, you can:
- Select from preset languages (English, Bahasa Melayu, etc.)
- **Type your own custom language**

```bash
# Example: Install with custom language
node kd.js install --lang="Bahasa Indonesia"
```

### Legacy Scripts (Still Available)

**macOS / Linux** (bash + curl):
```bash
curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_Skills/main/install.sh | bash
```

**Windows** (PowerShell):
```powershell
irm https://raw.githubusercontent.com/MoonWIRaja/Kracked_Skills/main/install.ps1 | iex
```

### After Installation

```
/KD                    # Show interactive command menu
/KD-analyze            # Start discovery
/KD-status             # Check project state
/KD-help               # View all commands
/KD-tool-selector      # Get tech stack recommendations
/KD-test-sprite        # Run automated testing
```

---

## ✨ Features

### 🎭 13 Specialized Roles

| Role | Prefix | Focus |
|------|--------|-------|
| Analyst | `[ANALYST]` | Discovery, risks, scale assessment |
| Product Manager | `[PM]` | Product brief, PRD, requirements |
| Architect | `[ARCH]` | System design, tech stack, decisions |
| Tech Lead | `[TL]` | Epics, stories, technical planning |
| Engineer | `[ENG]` | Code implementation, testing |
| QA | `[QA]` | Code review, test coverage |
| Security | `[SEC]` | Security audit, vulnerability assessment |
| DevOps | `[DEVOPS]` | Deployment, CI/CD, monitoring |
| Release Manager | `[RM]` | Release notes, versioning |
| **UX Designer** | `[UX]` | Wireframes, user flows, accessibility |
| **Data Scientist** | `[DATA]` | Data pipelines, ML models, analytics |
| **Mobile Developer** | `[MOBILE]` | iOS, Android, cross-platform development |
| **Database Admin** | `[DBA]` | Schema design, query optimization, migrations |

### 📊 8 Sequential Stages

```
Discovery → Brainstorm → Requirements → Architecture → Implementation → Quality → Deployment → Release
```

Each stage has defined entry/exit criteria, checkpoints, and artifact outputs.

## ✨ Features (v5.0.0)

- **Expanded Role Library**: 13 specialized roles including UX Designer, Data Scientist, Mobile Dev, and DBA.
- **Smart Role Switcher**: Auto-detects the best role for your request with regex triggers.
- **Multi-Agent Collaboration**: Handoff protocols, conflict resolution & personality profiles.
- **TestSprite Integration**: Automated visual regression testing (Puppeteer & Pixelmatch).
- **Intelligent Tool Selector**: Context-aware tool recommendations with scoring engine.
- **Git Integration**: Auto-commit scripts with conventional messages.
- **Analytics Dashboard**: Tracks agent performance and decision making.
- **Unified Exports**: Export project status, Jira CSVs, and PDFs.
- **Visual Output System**: ASCII wireframes, Mermaid diagrams, architecture visualizations.
- **6 AI Tool Adapters**: Claude Code, Cursor, Antigravity, Cline, Kilo Code, Roo Code.
- **120+ Commands**: Comprehensive command library for every development phase.
- Security advisory checks on dependencies

### 🌍 Dual Language Support

- **English (EN)** — Full interface in English
- **Bahasa Melayu (MS)** — Full interface in Bahasa Melayu
- Code always remains in English

### 📋 Decision Validation

Every significant decision runs through a structured validation block with impact assessment, confidence scoring, and risk analysis.

### 📂 Organized Output

All AI-generated files are organized into `.kracked/KD_output/` with category subdirectories:

```
.kracked/KD_output/
├── status/status.md
├── brainstorm/brainstorm.md
├── product-brief/product-brief.md
├── PRD/prd.md
├── architecture/architecture.md
├── epics-and-stories/
│   ├── epic-1/
│   │   ├── stories1-1.md
│   │   └── stories1-2.md
│   └── epic-2/
│       └── stories2-1.md
├── code-review/code-review.md
├── deployment/deployment-plan.md
└── release/release-notes.md
```

### 📎 Persistent State

`.kracked/KD_output/status/status.md` tracks project state across sessions — never lose context.

---

## 📋 Commands

| Category | Commands (Examples) | Description |
|----------|---------------------|-------------|
| **Setup** | `/KD-kickoff`, `/KD-help` | Project init and context loading |
| **Core Process** | `/KD`, `/KD-analyze`, `/KD-brainstorm`, `/KD-prd` | Manage the full product lifecycle from idea to launch |
| **Agile/Exec** | `/KD-sprint-planning`, `/KD-dev-story`, `/KD-refactor` | Execute sprints, implement stories (TDD), refactor code |
| **Backend** | `/KD-api-design` | Design robust, secure API endpoints & models |
| **Roles** | `/KD-role-analyst`, `/KD-role-architect`, `/KD-role-dev`, `/KD-role-ux`, `/KD-role-data`, `/KD-role-mobile`, `/KD-role-dba` | Specialized personas for every aspect of development |
| **Game Dev** | `/KD-game-gdd`, `/KD-game-mechanics`, `/KD-game-qa` | Specialized suite for Game Design & Development |
| **Innovation** | `/KD-idea-design-thinking`, `/KD-idea-storyteller` | Tools for creative ideation and strategy |
| **Testing** | `/KD-test`, `/KD-test-arch`, `/KD-test-automate`, `/KD-test-sprite` | Rigorous QA and test engineering tools |
| **Tool Selection** | `/KD-tool-selector` | **NEW** Intelligent tech stack recommendations |
| **Validation** | `/KD-validate`, `/KD-fix-course`, `/KD-retrospective` | Safety checks and course correction tools |

*Total 120+ commands available across all categories.*

---

## 🔧 Supported Tools

| Tool | Adapter | Auto-Setup |
|------|---------|------------|
| **Claude Code** | `CLAUDE.md` | ✅ |
| **Cursor** | `.cursorrules` | ✅ |
| **Antigravity** | `.antigravity/SKILL.md` | ✅ |
| **Cline** | `.clinerules` | ✅ |
| **Kilo Code** | `.kilocode` | ✅ |
| **Roo Code** | `.roo` | ✅ |
| **Generic** | Manual instructions | 📋 |

---

## 📁 Project Structure

```
.kracked/
├── prompts/
│   ├── system-prompt.md      # Core system prompt
│   ├── roles/                # 13 role definitions
│   ├── stages/               # 8 stage definitions
│   └── multi-agent/          # Multi-agent protocols
├── templates/                # 9 document templates
├── checklists/               # 6 quality checklists
├── workflows/                # 4 workflow definitions
├── testsprite/               # TestSprite automated testing
├── tool-selector/            # Intelligent tool selection
├── analytics/                # Agent performance tracking
├── git-integration/          # Auto-commit scripts
├── exporters/                # Export utilities
└── config/
    ├── settings.json         # Project configuration
    └── language/             # EN + MS strings

KD_output/                    # All AI-generated output
├── status/status.md          # Project state tracker
├── epics-and-stories/        # Epic folders with stories
└── ...                       # Other output categories
```

---

## 📚 Documentation

| Document | Description |
|----------|-------------|
| [Getting Started](docs/GETTING-STARTED.md) | Installation and first steps |
| [Architecture](docs/ARCHITECTURE.md) | System architecture overview |
| [Roles Guide](docs/ROLES.md) | Detailed role reference |
| [Commands Reference](docs/COMMANDS.md) | Full command documentation |
| [Multi-Agent Guide](docs/MULTI-AGENT.md) | Party Mode and Swarm guide |
| [Language Support](docs/LANGUAGE.md) | EN/MS configuration |
| [Adapters Guide](docs/ADAPTERS.md) | Tool-specific setup |
| [Contributing](docs/CONTRIBUTING.md) | How to contribute |

---

## 🔄 Maintenance

### Update to Latest Version

**macOS / Linux / Git Bash:**
```bash
curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_Skills/main/update.sh | bash
```

**Windows PowerShell:**
```powershell
irm https://raw.githubusercontent.com/MoonWIRaja/Kracked_Skills/main/update.ps1 | iex
```

### Validation

Check if your installation is healthy and all required files are present:

```bash
curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_Skills/main/validate.sh | bash
```

### Uninstallation

**macOS / Linux / Git Bash:**
```bash
curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_Skills/main/uninstall.sh | bash
```

**Windows PowerShell:**
```powershell
irm https://raw.githubusercontent.com/MoonWIRaja/Kracked_Skills/main/uninstall.ps1 | iex
```

---

## 📊 Scale Assessment

KD adapts its workflow depth based on project scale:

| Factor | Small | Standard | Deep |
|--------|-------|----------|------|
| Team Size | Solo | 2-5 | 6+ |
| Timeline | < 2 weeks | 2-8 weeks | > 8 weeks |
| Risk | Low | Medium | High |
| Integration | 0-2 | 3-5 | 6+ |
| Data | Public | Internal | PII/Financial |

---

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.

---

## 🏢 About KRACKEDDEVS

**KRACKEDDEVS** builds AI-powered developer tools that bring structure and consistency to software development.

- 🌐 **Website:** [krackeddevs.com](https://krackeddevs.com/)
- 📦 **GitHub:** [github.com/MoonWIRaja/Kracked_skill](https://github.com/MoonWIRaja/Kracked_Skills)

---

<p align="center">
<strong>KD finishes what it starts.</strong><br>
<em>AI Skill by KRACKEDDEVS</em>
</p>