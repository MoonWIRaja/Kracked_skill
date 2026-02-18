# PANDUAN LENGKAP KRAKCED_SKILLS (KD) v5.0.0

---

## 🎯 APA ITU KRACKED_SKILLS?

**Kracked_Skills (KD)** adalah sistem AI Skill untuk pembangunan produk perisian yang terstruktur. Sistem ini membantu developer dan AI bekerja bersama dengan workflow yang jelas dari idea hingga release.

---

## 🚀 CARA INSTALL

### Mac / Linux
```bash
# Pergi ke folder projek anda
cd /path/to/your/project

# Run installer
curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_Skills/main/kd.sh | bash
```

### Windows PowerShell
```powershell
# Pergi ke folder projek anda
cd C:\path\to\your\project

# Run installer
irm https://raw.githubusercontent.com/MoonWIRaja/Kracked_Skills/main/kd.ps1 | iex
```

### Non-Interactive Install
```bash
node kd.js install --target=cline --lang=ms --non-interactive
```

---

## 📊 KOMPONEN SISTEM

| Komponen | Jumlah | Keterangan |
|----------|--------|------------|
| Stages | 10 | Fasa pembangunan (discovery → release) |
| Commands | 75 | Slash commands untuk AI |
| Roles | 16 | Peranan AI (analyst, architect, engineer, dll) |
| Skills | 15 | Kemahiran khusus (React, API, DevOps, dll) |
| Tools | 8 | Alat bantuan |
| Adapters | 6 | Sokongan AI tools |
| Templates | 9 | Template dokumen |

---

## 📁 STRUKTUR FAIL

```
Kracked_skill/
├── kd.js                    # Entry point TUI
├── kd.sh                    # Wrapper Mac/Linux
├── kd.ps1                   # Wrapper Windows
├── package.json             # Node.js dependencies
│
├── src/
│   ├── tui/                 # TUI Application
│   │   ├── banner.js        # ASCII banner
│   │   └── screens/         # Menu screens
│   │       ├── main-menu.js
│   │       ├── install.js
│   │       ├── update.js
│   │       ├── uninstall.js
│   │       └── about.js
│   │
│   ├── skills/              # 15 Skills files
│   │   ├── 01-supabase-postgres.md
│   │   ├── 03-react-nextjs.md
│   │   ├── 11-api-design.md
│   │   └── ...
│   │
│   ├── prompts/             # AI Prompts
│   │   ├── system-prompt.md
│   │   ├── roles/           # 16 Role prompts
│   │   ├── stages/          # 10 Stage prompts
│   │   └── multi-agent/     # Multi-agent prompts
│   │
│   ├── adapters/            # 6 AI Tool Adapters
│   │   ├── claude-code/
│   │   ├── cursor/
│   │   ├── cline/
│   │   ├── kilocode/
│   │   ├── roo/
│   │   └── antigravity/
│   │
│   ├── templates/           # 9 Templates
│   │   ├── prd.md
│   │   ├── architecture.md
│   │   └── ...
│   │
│   └── config/              # Configuration
│       ├── defaults.json
│       └── language/        # Language files
│
└── docs/                    # Documentation
```

---

## 🔄 ALIRAN KERJA (WORKFLOW)

### 1. Discovery (Penemuan)
```
/KD-analyze → Analisa projek
/KD-brainstorm → Idea brainstorming
```

### 2. Requirements (Keperluan)
```
/KD-requirements → Tulis requirements
/KD-epics-and-stories → Break down ke stories
```

### 3. Architecture (Rekabentuk)
```
/KD-architecture → Design sistem
/KD-api-design → Design API
```

### 4. Implementation (Pelaksanaan)
```
/KD-dev-story → Implement story
/KD-code-review → Review code
```

### 5. Quality (Kualiti)
```
/KD-game-test-plan → Test planning
/KD-game-qa → QA testing
```

### 6. Deployment (Pengerahan)
```
/KD-deployment-plan → Plan deployment
/KD-release → Release preparation
```

---

## 🎭 ROLE YANG TERSEDIA

| Role | Fungsi |
|------|--------|
| analyst | Analisa keperluan bisnes |
| architect | Design sistem |
| engineer | Implementasi kod |
| qa | Quality assurance |
| devops | Deployment & infrastructure |
| product-manager | Product planning |
| ux-designer | User experience |
| tech-lead | Technical leadership |
| security | Security review |
| data-scientist | Data analysis |
| database-admin | Database management |
| mobile-developer | Mobile development |
| release-manager | Release coordination |
| game-dev | Game development |
| game-writer | Game narrative |
| game-designer | Game design |

---

## 🛠️ SKILLS YANG TERSEDIA

| Skill | Kegunaan |
|-------|----------|
| 01-supabase-postgres | Supabase & PostgreSQL |
| 02-insecure-defaults | Security defaults |
| 03-react-nextjs | React & Next.js |
| 04-premium-design-system | Design systems |
| 05-web-perf | Web performance |
| 06-code-review | Code review |
| 07-pwa-service-worker | PWA & Service Workers |
| 08-testing-qa | Testing & QA |
| 09-animations-components | Animations |
| 10-recursive-decomposition | Problem decomposition |
| 11-api-design | API design |
| 12-devops-deployment | DevOps & deployment |
| 13-game-development | Game development |
| 14-mobile-development | Mobile development |
| 15-documentation | Documentation |

---

## 🌍 SOKONGAN BAHASA

KD menyokong pelbagai bahasa:
- English (en)
- Bahasa Melayu (ms)
- 日本語 (Japanese)
- 中文 (Chinese)
- español (Spanish)
- Custom - taip bahasa sendiri

---

## 🔌 AI TOOLS YANG DISOKONG

| Tool | Adapter File |
|------|--------------|
| Claude Code | `.claude/CLAUDE.md` |
| Cursor | `.cursor/.cursorrules` |
| Cline | `.clinerules/.clinerules` |
| Kilo Code | `.kilocode/.kilocode` |
| Roo Code | `.roo/.roo` |
| Antigravity | Workflows |

---

## 📝 CARA PENGGUNAAN

### Step 1: Install
```bash
cd your-project
curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_Skills/main/kd.sh | bash
```

### Step 2: Pilih dari Menu
```
[1] 📦 Install KD
[2] 🔄 Update KD
[3] 🗑️  Uninstall KD
[4] ℹ️  About
[5] 🚪 Exit
```

### Step 3: Guna dalam AI Tool
```
/KD              # Show command menu
/KD-analyze      # Start discovery
/KD-help         # Show help
```

---

## 🔧 TROUBLESHOOTING

### Masalah: TUI tidak menunggu input
**Fix:** Telah dibaiki dengan `exec < /dev/tty`

### Masalah: Install ke folder salah
**Fix:** Telah dibaiki dengan pass `--install-dir`

### Masalah: Command tidak dikenali
**Solution:** Pastikan Node.js v18+ dipasang

---

## ✅ STATUS SISTEM

**SEMUA KOMPONEN: LENGKAP & BERFUNGSI**

| Aspek | Status |
|-------|--------|
| TUI | ✅ Fixed |
| Install Location | ✅ Fixed |
| stdin Handling | ✅ Fixed |
| Option Parsing | ✅ Fixed |

---

**KD finishes what it starts.** | KRACKEDDEVS | https://krackeddevs.com/