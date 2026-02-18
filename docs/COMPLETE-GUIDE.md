# KRAKCED_SKILLS v5.0.0 - PANDUAN LENGKAP

---

## 🎯 APA ITU KRAKCED_SKILLS?

**Kracked_Skills (KD)** adalah sistem AI Skill untuk pembangunan produk perisian yang terstruktur. Ia membantu developer dan AI bekerja bersama dengan workflow yang jelas.

### Konsep Utama
- **10 Stages** - Tahap pembangunan berperingkat
- **75 Commands** - Arahan untuk setiap tugasan
- **16 Roles** - Peranan AI yang berbeza
- **15 Skills** - Kemahiran teknikal
- **8 Tools** - Alat bantuan

---

## 📁 STRUKTUR FOLDER LENGKAP

```
Kracked_skill/
│
├── src/                          ← Teras Sistem
│   │
│   ├── adapters/                 ← Adapter untuk AI Tools
│   │   ├── antigravity/          ← Untuk Antigravity AI
│   │   │   ├── README.md         ← Panduan adapter
│   │   │   ├── SKILL.md          ← Skill definition
│   │   │   └── workflows/        ← 50+ command files
│   │   │
│   │   ├── claude-code/          ← Untuk Claude Code
│   │   │   ├── CLAUDE.md         ← Claude config
│   │   │   ├── commands.md       ← Senarai commands
│   │   │   └── commands/         ← Command files
│   │   │
│   │   ├── cline/                ← Untuk Cline (Anda)
│   │   │   ├── .clinerules       ← Cline configuration
│   │   │   ├── README.md         ← Panduan
│   │   │   └── workflows/        ← 82 command files
│   │   │
│   │   ├── cursor/               ← Untuk Cursor IDE
│   │   │   ├── .cursorrules      ← Cursor config
│   │   │   └── commands/         ← Command files
│   │   │
│   │   ├── kilocode/             ← Untuk Kilocode
│   │   │   ├── .kilocode         ← Kilocode config
│   │   │   └── workflows/        ← Command files
│   │   │
│   │   ├── roo/                  ← Untuk Roo Code
│   │   │   ├── .roo              ← Roo config
│   │   │   └── commands/         ← Command files
│   │   │
│   │   └── generic/              ← Untuk AI lain
│   │       ├── instructions.md   ← Arahan umum
│   │       └── README.md         ← Panduan
│   │
│   ├── core/                     ← Teras Sistem
│   │   ├── core.md               ← Dokumentasi teras
│   │   ├── kracked.sh            ← Script utama
│   │   ├── language.sh           ← Sokongan bahasa
│   │   ├── status.sh             ← Tracking status
│   │   ├── utils.sh              ← Utiliti shell
│   │   ├── validation.sh         ← Pengesahan
│   │   │
│   │   └── indexes/              ← Index Rujukan
│   │       ├── stages-index.md   ← 10 stages
│   │       ├── commands-index.md ← 75 commands
│   │       ├── skills-index.md   ← 15 skills
│   │       ├── roles-index.md    ← 16 roles
│   │       └── tools-index.md    ← 8 tools
│   │
│   ├── prompts/                  ← Prompts Sistem
│   │   ├── system-prompt.md      ← Prompt utama AI
│   │   ├── conflict-resolution.md← Penyelesaian konflik
│   │   ├── handoff-protocol.md   ← Protokol serah terima
│   │   ├── role-switcher.md      ← Pertukaran role
│   │   │
│   │   ├── stages/               ← Definisi Stage
│   │   │   ├── _stage-template.md← Template
│   │   │   ├── discovery.md      ← Stage 1
│   │   │   ├── brainstorm.md     ← Stage 2 (Ideation)
│   │   │   ├── requirements.md   ← Stage 3
│   │   │   ├── architecture.md   ← Stage 4
│   │   │   ├── planning.md       ← Stage 5
│   │   │   ├── implementation.md ← Stage 6
│   │   │   ├── testing.md        ← Stage 7
│   │   │   ├── quality.md        ← Stage 8
│   │   │   ├── deployment.md     ← Stage 9
│   │   │   └── release.md        ← Stage 10
│   │   │
│   │   ├── roles/                ← Definisi Role
│   │   │   ├── _role-template.md ← Template
│   │   │   ├── analyst.md        ← Analyst
│   │   │   ├── architect.md      ← Architect
│   │   │   ├── data-scientist.md ← Data Scientist
│   │   │   ├── database-admin.md ← DBA
│   │   │   ├── devops.md         ← DevOps
│   │   │   ├── engineer.md       ← Engineer
│   │   │   ├── mobile-developer.md← Mobile Dev
│   │   │   ├── product-manager.md← PM
│   │   │   ├── qa.md             ← QA
│   │   │   ├── release-manager.md← Release Manager
│   │   │   ├── security.md       ← Security
│   │   │   ├── tech-lead.md      ← Tech Lead
│   │   │   └── ux-designer.md    ← UX Designer
│   │   │
│   │   └── multi-agent/          ← Multi-Agent System
│   │       ├── agent-swarm.md    ← Swarm protocol
│   │       ├── aggregation.md    ← Aggregation
│   │       ├── confidence-scoring.md← Confidence
│   │       ├── conflict-resolution.md← Conflict
│   │       └── party-mode.md     ← Party Mode
│   │
│   ├── skills/                   ← Skills Library
│   │   ├── SKILLS.md             ← Index skills
│   │   ├── 01-supabase-postgres.md   ← Backend/DB
│   │   ├── 02-insecure-defaults.md   ← Security
│   │   ├── 03-react-nextjs.md        ← Frontend
│   │   ├── 04-premium-design-system.md← UI/UX
│   │   ├── 05-web-perf.md            ← Performance
│   │   ├── 06-code-review.md          ← Quality
│   │   ├── 07-pwa-service-worker.md   ← PWA
│   │   ├── 08-testing-qa.md           ← Testing
│   │   ├── 09-animations-components.md← Animations
│   │   ├── 10-recursive-decomposition.md← Optimization
│   │   ├── 11-api-design.md           ← APIs
│   │   ├── 12-devops-deployment.md    ← DevOps
│   │   ├── 13-game-development.md     ← Games
│   │   ├── 14-mobile-development.md   ← Mobile
│   │   └── 15-documentation.md        ← Docs
│   │
│   ├── templates/                ← Template Dokumen
│   │   ├── architecture.md       ← Architecture Doc
│   │   ├── decision-log.md       ← Decision Log
│   │   ├── deployment-plan.md    ← Deployment Plan
│   │   ├── prd.md                ← PRD Template
│   │   ├── product-brief.md      ← Product Brief
│   │   ├── release-notes.md      ← Release Notes
│   │   ├── risk-register.md      ← Risk Register
│   │   ├── status.md             ← Status Template
│   │   └── story-card.md         ← User Story
│   │
│   ├── workflows/                ← Workflow Utama
│   │   ├── main.md               ← Workflow 10 stages
│   │   ├── quick-start.md        ← Ringkas
│   │   ├── full-product.md       ← Lengkap
│   │   └── maintenance.md        ← Penyelenggaraan
│   │
│   ├── tools/                    ← Alat Bantuan
│   │   ├── tool-selector/        ← Pilih Tech Stack
│   │   │   ├── tool-selector.js  ← Main script
│   │   │   └── knowledge-base.json← Data
│   │   │
│   │   ├── version-checker/      ← Semak Versi
│   │   │   ├── version-checker.js← Main script
│   │   │   ├── registry.json     ← Cache
│   │   │   ├── compatibility-rules.json← Rules
│   │   │   └── README.md         ← Panduan
│   │   │
│   │   ├── testsprite/           ← Visual Testing
│   │   │   └── testsprite-core.js← Main script
│   │   │
│   │   ├── exporters/            ← Export
│   │   │   ├── export-consolidated.sh
│   │   │   ├── export-jira.js
│   │   │   └── export-pdf.sh
│   │   │
│   │   ├── analytics/            ← Analytics
│   │   │   └── agent-performance.json
│   │   │
│   │   ├── git-integration/      ← Git
│   │   │   ├── auto-commit.sh
│   │   │   └── config.yaml
│   │   │
│   │   ├── commands/             ← Command Tools
│   │   │   └── testsprite.js
│   │   │
│   │   ├── checklists/           ← Checklists
│   │   │   ├── checkpoint-approval.md
│   │   │   ├── code-quality.md
│   │   │   ├── decision-validation.md
│   │   │   ├── pre-deployment.md
│   │   │   ├── security-audit.md
│   │   │   └── stage-completion.md
│   │   │
│   │   ├── artifacts/            ← Artifacts
│   │   │   └── manifest.yaml
│   │   │
│   │   └── config/               ← Konfigurasi
│   │       ├── defaults.json     ← Defaults
│   │       ├── settings-schema.json← Schema
│   │       ├── agents/
│   │       │   └── personalities.json
│   │       └── language/
│   │           ├── en.json       ← English
│   │           └── ms.json       ← Bahasa Melayu
│   │
│   └── tests/                    ← Tests
│       ├── test-install.sh
│       └── test-validate.sh
│
├── docs/                         ← Dokumentasi
│   ├── ADAPTERS.md               ← Panduan adapters
│   ├── ARCHITECTURE.md           ← Architecture doc
│   ├── COMMANDS.md               ← Panduan commands
│   ├── CONTRIBUTING.md           ← Cara contribute
│   ├── GETTING-STARTED.md        ← Mula menggunakan
│   ├── LANGUAGE.md               ← Sokongan bahasa
│   ├── MULTI-AGENT.md            ← Multi-agent guide
│   └── ROLES.md                  ← Panduan roles
│
├── install.sh                    ← Install script (Linux/Mac)
├── install.ps1                   ← Install script (Windows)
├── uninstall.sh                  ← Uninstall (Linux/Mac)
├── uninstall.ps1                 ← Uninstall (Windows)
├── update.sh                     ← Update (Linux/Mac)
├── update.ps1                    ← Update (Windows)
├── validate.sh                   ← Validation script
├── VERSION                       ← Version file
├── CHANGELOG.md                  ← Changelog
├── LICENSE                       ← License
├── README.md                     ← README utama
└── Planing.md                    ← Planning notes
```

---

## 🚀 CARA PENGGUNAAN

### Langkah 1: Install

**Windows:**
```powershell
.\install.ps1
```

**Linux/Mac:**
```bash
chmod +x install.sh
./install.sh
```

### Langkah 2: Mulakan Projek

```
/KD-analyze
```

AI akan:
1. Tanya soalan tentang projek
2. Kumpul konteks
3. Nilai risiko
4. Tetapkan skala (SMALL/STANDARD/DEEP)

### Langkah 3: Ikuti Workflow

```
/KD-brainstorm      → Idea
/KD-product-brief   → Product Brief
/KD-prd             → Requirements
/KD-architecture    → Design
/KD-epics-and-stories → Stories
/KD-dev-story       → Code
/KD-test            → Test
/KD-code-review     → Review
/KD-deployment-plan → Deploy
```

---

## 📊 10 STAGES LENGKAP

### Stage 1: Discovery
**Tujuan:** Faham projek, kumpul konteks

**Commands:**
- `/KD-kickoff` - Mulakan projek
- `/KD-analyze` - Analisis risiko
- `/KD-domain-research` - Riset domain
- `/KD-market-research` - Riset pasaran

**Output:** `status.md`

---

### Stage 2: Ideation
**Tujuan:** Generate idea, solve problems

**Commands:**
- `/KD-brainstorm` - Brainstorming
- `/KD-idea-design-thinking` - Design thinking
- `/KD-idea-innovation` - Innovation
- `/KD-idea-problem-solving` - Problem solving

**Output:** `brainstorm.md`

---

### Stage 3: Requirements
**Tujuan:** Definikan apa yang perlu dibina

**Commands:**
- `/KD-product-brief` - Product Brief
- `/KD-prd` - PRD Document
- `/KD-quick-spec` - Quick Spec

**Output:** `product-brief.md`, `prd.md`

**Checkpoint:** ⏸️ Perlu approval

---

### Stage 4: Architecture
**Tujuan:** Design sistem

**Commands:**
- `/KD-architecture` - Architecture Doc
- `/KD-api-design` - API Design
- `/KD-tool-selector` - Tech Stack
- `/KD-version-check` - Version Check

**Output:** `architecture.md`

**Checkpoint:** ⏸️ Perlu approval

---

### Stage 5: Planning
**Tujuan:** Plan kerja

**Commands:**
- `/KD-epics-and-stories` - Create backlog
- `/KD-sprint-planning` - Sprint plan

**Output:** Story cards

---

### Stage 6: Implementation
**Tujuan:** Tulis kod

**Commands:**
- `/KD-dev-story` - Implement story
- `/KD-quick-dev` - Quick development
- `/KD-refactor` - Refactor code

**Output:** Source code

---

### Stage 7: Testing
**Tujuan:** Test aplikasi

**Commands:**
- `/KD-test` - Test plan
- `/KD-test-automate` - Automate tests
- `/KD-test-sprite` - Visual testing

**Output:** Test reports

---

### Stage 8: Quality
**Tujuan:** Review kualiti

**Commands:**
- `/KD-code-review` - Code review
- `/KD-validate` - Validation
- `/KD-fix-course` - Fix issues

**Output:** `code-review.md`

---

### Stage 9: Deployment
**Tujuan:** Deploy ke production

**Commands:**
- `/KD-deployment-plan` - Deployment strategy

**Output:** `deployment-plan.md`

**Checkpoint:** ⏸️ Production approval

---

### Stage 10: Release
**Tujuan:** Close cycle

**Commands:**
- `/KD-scale-review` - Post-deploy review
- `/KD-retrospective` - Retrospective

**Output:** `release-notes.md`

---

## 👥 16 ROLES

| Role | Prefix | Fokus |
|------|--------|-------|
| Analyst | [ANALYST] | Discovery, Research |
| Product Manager | [PM] | Requirements |
| Architect | [ARCH] | System Design |
| Tech Lead | [TL] | Technical Planning |
| Engineer | [ENG] | Implementation |
| QA | [QA] | Testing |
| Security | [SEC] | Security |
| DevOps | [DEVOPS] | Deployment |
| Release Manager | [RM] | Releases |
| UX Designer | [UX] | User Experience |
| Data Scientist | [DATA] | Data/ML |
| Mobile Developer | [MOBILE] | Mobile Apps |
| Database Admin | [DBA] | Database |
| Scrum Master | [SM] | Agile |
| Solo Developer | [SOLO] | Full Stack |
| Tech Writer | [TW] | Documentation |

**Aktifkan Role:**
```
/KD-role-analyst
/KD-role-architect
/KD-role-dev
...etc
```

---

## 📚 15 SKILLS

| # | Skill | Domain | Bilang |
|---|-------|--------|--------|
| 1 | Supabase Postgres | Backend/DB | Database, SQL |
| 2 | Insecure Defaults | Security | Security audit |
| 3 | React & Next.js | Frontend | Components |
| 4 | Premium Design System | UI/UX | Design |
| 5 | Web Performance | Performance | Optimization |
| 6 | Code Review | Quality | Review |
| 7 | PWA & Service Workers | PWA | Offline |
| 8 | Testing & QA | Testing | Tests |
| 9 | Animations & Components | UI | Animations |
| 10 | Recursive Decomposition | Optimization | Token opt |
| 11 | API Design | APIs | REST/GraphQL |
| 12 | DevOps & Deployment | DevOps | CI/CD |
| 13 | Game Development | Games | Game dev |
| 14 | Mobile Development | Mobile | iOS/Android |
| 15 | Documentation | Docs | Writing |

---

## 🛠️ 8 TOOLS

| Tool | Fungsi | Command |
|------|--------|---------|
| Tool Selector | Pilih tech stack | `/KD-tool-selector` |
| Version Checker | Semak versi | `/KD-version-check` |
| TestSprite | Visual testing | `/KD-test-sprite` |
| Multi-Agent | Party mode/Swarm | `/KD-party-mode` |
| Exporters | Export Jira/PDF | Auto |
| Analytics | Performance | Auto |
| Git Integration | Auto commit | Auto |
| Core Scripts | Utilities | Auto |

---

## 🔧 VERSION CHECKER

Semak compatibility framework:

```bash
node src/version-checker/version-checker.js next.js,react,node
```

Output:
```
📦 VERSION COMPATIBILITY CHECK
✓ next.js: 16.1.6
✓ react: 19.2.4
✓ node: 25.6.1
✅ No compatibility issues!
```

---

## 🌐 MULTI-AGENT SYSTEM

### Party Mode
Multiple agents brainstorm together:
```
/KD-party-mode --agents=3 --topic="architecture"
```

### Swarm
Multiple agents execute tasks:
```
/KD-swarm --agents=3 --tasks="task1,task2,task3"
```

---

## 🌍 SOKONGAN BAHASA

Tetapkan bahasa dalam `config/settings.json`:
```json
{
  "language": "ms"  // "en" untuk English
}
```

---

## ✅ STATUS SISTEM

| Komponen | Jumlah | Status |
|----------|--------|--------|
| Stages | 10 | ✅ Complete |
| Commands | 75 | ✅ Optimized |
| Roles | 16 | ✅ Complete |
| Skills | 15 | ✅ Complete |
| Tools | 8 | ✅ Complete |
| Adapters | 6 | ✅ Complete |
| Templates | 9 | ✅ Complete |
| Checklists | 6 | ✅ Complete |

**SISTEM: SEMPURNA - TIADA ISU**

---

*KD finishes what it starts.* | KRACKEDDEVS | https://krackeddevs.com/