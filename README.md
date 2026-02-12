# KRACKED Skill - Claude Code Plugin

[![Version](https://img.shields.io/badge/version-3.3.0-blue.svg)](https://github.com/KrackedAI/kracked-skill)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Compatible-orange.svg)]()

<div align="center">

**KRACKED** - Structured Multi-Role AI Product Execution System

*Multi-Language Support | Production-Ready | Conflict-Resistant*

[English](#english) | [Bahasa Melayu](#bahasa-melayu)

</div>

---

<a name="english"></a>
## English

### Overview

KRACKED is a structured, role-based product delivery system designed to take a product from **idea → architecture → build → deploy → monitor**.

### Features

- **9 Specialized Roles**: Analyst → Product Manager → Architect → Tech Lead → Engineer → QA → Security → DevOps → Release Manager
- **Multi-Agent Modes**: Party Mode for ideation, Agent Swarm for parallel execution
- **Multi-Language Support**: English (EN) & Bahasa Melayu (MS)
- **Artifact-Driven**: Every stage produces traceable artifacts
- **State-Aware**: Continuous status tracking via `status.md`
- **Production-Ready**: Security, deployment, and monitoring built-in

### Quick Install

#### Method 1: Git Clone (Recommended - No NPM Required)

**Linux/macOS:**
```bash
git clone https://github.com/moonwiraja/kracked-skill.git ~/.claude/plugins/kracked-skill
```

**Windows (Command Prompt/PowerShell):**
```cmd
git clone https://github.com/moonwiraja/kracked-skill.git %USERPROFILE%\.claude\plugins\kracked-skill
```

**Windows (Git Bash):**
```bash
git clone https://github.com/moonwiraja/kracked-skill.git ~/.claude/plugins/kracked-skill
```

#### Method 2: Download ZIP

1. Go to: https://github.com/moonwiraja/kracked-skill
2. Click **Code → Download ZIP**
3. Extract to:
   - Windows: `%USERPROFILE%\.claude\plugins\kracked-skill\`
   - Linux/macOS: `~/.claude/plugins/kracked-skill/`

#### Method 3: Installer Script

**Windows (PowerShell):**
```powershell
curl -L https://raw.githubusercontent.com/moonwiraja/kracked-skill/main/install.bat -o install.bat; .\install.bat
```

**Windows (CMD):**
```cmd
curl -L https://raw.githubusercontent.com/moonwiraja/kracked-skill/main/install.bat -o install.bat && install.bat
```

**Linux/macOS:**
```bash
curl -fsSL https://raw.githubusercontent.com/moonwiraja/kracked-skill/main/install.sh | sh
```

### Usage

After installation, restart Claude Code and use:

```
/kracked-help           # Show all commands
/analyze                # Start discovery stage
/language [EN|MS]       # Change language
/status                 # Show project state
```

### Commands

| Stage | Command | Description |
|-------|---------|-------------|
| 1 | `/analyze` | Discovery & risk identification |
| 2 | `/prd` | Product Requirements Document |
| 3 | `/architecture --depth=[level]` | System architecture design |
| 4 | `/dev-story [id]` | Implement single story |
| 5 | `/code-review` | Quality & security review |
| 6 | `/deployment-plan` | Deployment strategy |
| 7 | `/scale-review` | Post-deployment review |

**Multi-Agent Commands:**
- `/party-mode` - Parallel ideation with multiple perspectives
- `/swarm` - Parallel task execution

**Utility Commands:**
- `/language` - Display/change language
- `/status` - Project state
- `/rollback [stage]` - Return to previous stage

### Documentation

Full documentation: [docs/GUIDE.md](docs/GUIDE.md)

### License

MIT License - see [LICENSE](LICENSE)

---

<a name="bahasa-melayu"></a>
## Bahasa Melayu

### Gambaran Ringkas

KRACKED ialah sistem penghantaran produk berbasis-peranan berstruktur yang direka untuk mengambil produk dari **idea → seni bina → bina → pasang → pantau**.

### Ciri-ciri

- **9 Peranan Khusus**: Analisis → Pengurus Produk → Arkitek → Ketua Teknikal → Jurutera → QA → Keselamatan → DevOps → Pengurus Pelepasan
- **Mod Multi-Ejen**: Party Mode untuk ideasi, Agent Swarm untuk pelaksanaan selari
- **Sokongan Bahasa**: English (EN) & Bahasa Melayu (MS)
- **Berbasis-Artifak**: Setiap peringkat menghasilkan artifak yang boleh dijejaki
- **Sedar-Keadaan**: Penjejakan status berterusan melalui `status.md`
- **Sedia-Produksi**: Keselamatan, pemasangan, dan pemantauan terbina-dalam

### Pasang Pantas

#### Cara 1: Git Clone (Disyorkan - Tanpa NPM)

**Linux/macOS:**
```bash
git clone https://github.com/moonwiraja/kracked-skill.git ~/.claude/plugins/kracked-skill
```

**Windows (Command Prompt/PowerShell):**
```cmd
git clone https://github.com/moonwiraja/kracked-skill.git %USERPROFILE%\.claude\plugins\kracked-skill
```

**Windows (Git Bash):**
```bash
git clone https://github.com/moonwiraja/kracked-skill.git ~/.claude/plugins/kracked-skill
```

#### Cara 2: Muat Turus ZIP

1. Pergi ke: https://github.com/moonwiraja/kracked-skill
2. Klik **Code → Download ZIP**
3. Ekstrak ke:
   - Windows: `%USERPROFILE%\.claude\plugins\kracked-skill\`
   - Linux/macOS: `~/.claude/plugins/kracked-skill/`

#### Cara 3: Skrip Pemasang

**Windows (PowerShell):**
```powershell
curl -L https://raw.githubusercontent.com/moonwiraja/kracked-skill/main/install.bat -o install.bat; .\install.bat
```

**Windows (CMD):**
```cmd
curl -L https://raw.githubusercontent.com/moonwiraja/kracked-skill/main/install.bat -o install.bat && install.bat
```

**Linux/macOS:**
```bash
curl -fsSL https://raw.githubusercontent.com/moonwiraja/kracked-skill/main/install.sh | sh
```

### Penggunaan

Selepas pemasangan, mulakan semula Claude Code dan guna:

```
/kracked-help           # Tunjuk semua arahan
/analyze                # Mulakan peringkat penemuan
/language [EN|MS]       # Tukar bahasa
/status                 # Tunjuk keadaan projek
```

### Arahan

| Peringkat | Arahan | Keterangan |
|-----------|---------|-------------|
| 1 | `/analyze` | Penemuan & pengenalpastian risiko |
| 2 | `/prd` | Dokumen Keperluan Produk |
| 3 | `/architecture --depth=[level]` | Reka bentuk seni bina sistem |
| 4 | `/dev-story [id]` | Laksanakan cerita tunggal |
| 5 | `/code-review` | Semakan kualiti & keselamatan |
| 6 | `/deployment-plan` | Strategi pemasangan |
| 7 | `/scale-review` | Semakan pasca-pemasangan |

### Dokumentasi

Dokumentasi penuh: [docs/GUIDE.md](docs/GUIDE.md)

### Lesen

Lesen MIT - lihat [LICENSE](LICENSE)

---

<div align="center">

**Built with ❤️ for Claude Code**

[Homepage](https://github.com/KrackedAI/kracked-skill) • [Documentation](docs/) • [Issues](https://github.com/KrackedAI/kracked-skill/issues)

</div>
