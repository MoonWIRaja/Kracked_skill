<p align="center">
  <h1 align="center">KRACKED_skill (KD)</h1>
  <p align="center">
    <strong>Structured Multi-Role AI Product Execution System</strong>
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

### One-Line Install

**macOS / Linux / Windows** (curl built-in):
```bash
curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_skill/main/install.sh | bash
```

**Windows** (PowerShell):
```powershell
irm https://raw.githubusercontent.com/MoonWIRaja/Kracked_skill/main/install.sh | bash
```

**Windows** (Git Bash / WSL):
```bash
curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_skill/main/install.sh | bash
```

> **Note:** `install.sh` is a bash script. Windows users need **Git Bash**, **WSL**, or **MSYS2** to run it.

### Non-Interactive Install

```bash
curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_skill/main/install.sh | bash -s -- --target=claude-code --language=EN --non-interactive
```

### After Installation

```
/KD-analyze          # Start discovery
/KD-status           # Check project state
/KD-help             # View all commands
```

---

## ✨ Features

### 🎭 9 Structured Roles
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

### 📊 7 Sequential Stages
```
Discovery → Requirements → Architecture → Implementation → Quality → Deployment → Release
```
Each stage has defined entry/exit criteria, checkpoints, and artifact outputs.

### 🤖 Multi-Agent System
- **Party Mode** — Spawn 2-5 agents for parallel ideation with consensus scoring
- **Agent Swarm** — Distribute tasks across 2-8 agents for parallel execution
- **Confidence Scoring** — HIGH/MEDIUM/LOW scoring on all recommendations
- **Conflict Resolution** — Systematic protocol for resolving agent disagreements

### 🌐 Dual Language Support
- **English (EN)** — Full interface in English
- **Bahasa Melayu (MS)** — Full interface in Bahasa Melayu
- Code always remains in English

### 📋 Decision Validation
Every significant decision runs through a structured validation block with impact assessment, confidence scoring, and risk analysis.

### 📎 Persistent State
`status.md` tracks project state across sessions — never lose context.

---

## 📋 Commands

| Command | Description |
|---------|-------------|
| `/KD-analyze` | Start discovery and risk assessment |
| `/KD-product-brief` | Create product brief |
| `/KD-prd` | Create PRD |
| `/KD-architecture [--depth=level]` | Design system architecture |
| `/KD-epics-and-stories` | Create implementation backlog |
| `/KD-dev-story [id] [--focus=scope]` | Implement a specific story |
| `/KD-code-review [--scope=s] [--severity=s]` | Code quality + security review |
| `/KD-deployment-plan [--env=env]` | Create deployment strategy |
| `/KD-scale-review` | Post-deployment assessment |
| `/KD-status` | Display current project state |
| `/KD-help` | Show command reference |
| `/KD-party-mode [--agents=N] [--topic=t]` | Multi-agent ideation |
| `/KD-swarm [--agents=N] [--tasks=t]` | Multi-agent execution |

---

## 🔧 Supported Tools

| Tool | Adapter | Auto-Setup |
|------|---------|------------|
| **Claude Code** | `CLAUDE.md` | ✅ |
| **Cursor** | `.cursorrules` | ✅ |
| **Antigravity** | `.antigravity/SKILL.md` | ✅ |
| **Generic** | Manual instructions | 📋 |

---

## 📁 Project Structure

```
.kracked/
├── prompts/
│   ├── system-prompt.md        # Core system prompt
│   ├── roles/                  # 9 role definitions
│   ├── stages/                 # 7 stage definitions
│   └── multi-agent/            # Multi-agent protocols
├── templates/                  # 9 document templates
├── checklists/                 # 6 quality checklists
├── workflows/                  # 4 workflow definitions
└── config/
    ├── settings.json           # Project configuration
    └── language/               # EN + MS strings
status.md                       # Project state tracker
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

## 🔄 Updates

```bash
bash update.sh          # Check for and apply updates
bash validate.sh        # Validate installation integrity
bash uninstall.sh       # Remove KD from project
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
- 📦 **GitHub:** [github.com/MoonWIRaja/Kracked_skill](https://github.com/MoonWIRaja/Kracked_skill)

---

<p align="center">
  <strong>KD finishes what it starts.</strong><br>
  <em>AI Skill by KRACKEDDEVS</em>
</p>
