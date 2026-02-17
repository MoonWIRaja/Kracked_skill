# PLANNING.md - Kracked_Skills

```
# Kracked_Skills - Project Planning Document
# Version: 1.0.0
# Created: 2026
# Status: Planning Phase

================================================================================
TABLE OF CONTENTS
================================================================================

1. PROJECT OVERVIEW
2. PROBLEM STATEMENT
3. GOALS AND OBJECTIVES
4. TARGET USERS
5. TECHNICAL ARCHITECTURE
6. FILE STRUCTURE
7. CORE COMPONENTS
8. INSTALLATION SYSTEM
9. ADAPTER IMPLEMENTATIONS
10. TEMPLATE SYSTEM
11. MULTI-AGENT SYSTEM
12. LANGUAGE SYSTEM
13. DOCUMENTATION PLAN
14. TESTING STRATEGY
15. RELEASE ROADMAP
16. SUCCESS METRICS
17. RISK ASSESSMENT
18. MAINTENANCE PLAN
19. APPENDICES

================================================================================
1. PROJECT OVERVIEW
================================================================================

1.1 Project Name
----------------
Kracked_Skills

1.2 Project Description
-----------------------
Kracked_Skills adalah sistem eksekusi produk AI berbilang peranan yang berstruktur.
Sistem ini direka untuk membantu pembangunan produk dari peringkat idea sehingga
deployment dan monitoring, dengan pendekatan yang terkawal dan boleh diaudit.

1.3 Project Version
-------------------
Current: 1.0.0
Initial Release Target: v1.0.0

1.4 Repository
--------------
GitHub: https://github.com/MoonWIRaja/Kracked_skill
Official Site: https://krackeddevs.com/

1.5 License
-----------
MIT License

1.6 Inspiration
---------------
- BMAD Method (https://github.com/bmad-code-org/BMAD-METHOD)
- KRACKED System Prompt v3.3 (Custom development)

1.7 Key Differentiators from BMAD
---------------------------------
| Aspect              | BMAD                    | Kracked_Skills           |
|---------------------|-------------------------|-------------------------|
| Distribution        | NPM/npx                 | Bash script + curl/wget |
| Multi-Agent         | None                    | Party Mode & Swarm      |
| Language Support    | English only            | English & Bahasa Melayu |
| Roles               | Implicit                | Explicit 9 roles        |
| Status Tracking     | None                    | status.md persistent    |
| Decision Validation | Basic                   | Structured blocks       |
| Human Checkpoints   | None                    | Explicit approval gates |
| Target Platforms    | Node.js developers      | Universal (any AI tool) |
| Commands            | /command                | /KD-command prefix      |
| Branding            | BMAD                    | KRACKEDDEVS             |

1.8 Installation Model
----------------------
Kracked_Skills dipasang untuk SETIAP PROJEK secara individu. Ini membolehkan:
- Konfigurasi berasingan untuk setiap projek
- Bahasa yang berbeza untuk projek berbeza
- Status tracking yang unik per projek
- Artifacts yang terasing antara projek

================================================================================
2. PROBLEM STATEMENT
================================================================================

2.1 Problems Identified
-----------------------

Problem 1: Inconsistent AI-Assisted Development
- AI assistants lack structured methodology
- No clear role separation during development
- Decisions are not tracked or validated
- Context is lost over long conversations

Problem 2: BMAD Limitations
- Requires npm/npx installation
- Targeted only at Node.js developers
- No multi-agent capabilities
- No language localization
- No persistent state tracking

Problem 3: Production Readiness Gap
- AI-generated code often lacks production considerations
- Security implications not systematically addressed
- Deployment planning is afterthought
- No rollback strategy documentation

Problem 4: Collaboration Challenges
- No audit trail of decisions made
- Handoffs between different development phases unclear
- Conflicting decisions not resolved systematically
- No confidence scoring on recommendations

2.2 Target Problems to Solve
----------------------------
1. Provide structured workflow for AI-assisted development
2. Eliminate npm dependency for universal accessibility
3. Enable multi-agent collaboration with confidence scoring
4. Support multiple languages (EN, MS)
5. Maintain persistent project state
6. Ensure production-ready outputs
7. Create audit-friendly decision trails

================================================================================
3. GOALS AND OBJECTIVES
================================================================================

3.1 Primary Goals
-----------------

Goal 1: Universal Accessibility
- Install without npm/npx
- Work on any platform (Linux, macOS, Windows via WSL/Git Bash)
- Compatible with supported AI tools (Claude Code, Cursor, Antigravity)

Goal 2: Structured Development
- 9 distinct roles with clear responsibilities
- 7 sequential workflow stages
- Clear entry/exit criteria for each stage
- Decision validation at critical points

Goal 3: Multi-Agent Capabilities
- Party Mode for parallel ideation
- Agent Swarm for parallel task execution
- Confidence scoring and consensus building
- Conflict resolution mechanisms

Goal 4: Production Readiness
- Security awareness in every decision
- Deployment planning built-in
- Rollback strategies documented
- Monitoring and observability considered

Goal 5: Localization
- Full support for English and Bahasa Melayu
- Code remains in English (industry standard)
- Documentation in selected language
- Comments in selected language

3.2 Success Criteria
--------------------

| Criterion                         | Metric                    | Target       |
|-----------------------------------|---------------------------|--------------|
| Installation success rate         | % successful installs     | > 95%        |
| Time to first /KD-analyze        | Minutes                   | < 5 minutes  |
| User satisfaction                 | Feedback rating           | > 4.0/5.0    |
| Documentation completeness        | Coverage %                | 100%         |
| Multi-platform compatibility      | Platforms supported       | 3+           |
| AI tool compatibility             | Tools supported           | 3            |
| Language support                  | Languages supported       | 2            |

3.3 Non-Goals
-------------

- Not building a standalone application
- Not creating a web interface
- Not building proprietary AI models
- Not replacing existing project management tools
- Not creating a hosted service

================================================================================
4. TARGET USERS
================================================================================

4.1 Primary Users
-----------------

Persona 1: Solo Developer
- Profile: Individual developer using AI assistants
- Needs: Structure, consistency, production-ready output
- Pain Points: Context loss, inconsistent AI responses
- Value from KRACKED: Structured workflow, persistent state

Persona 2: Small Team (2-5 people)
- Profile: Startup or small product team
- Needs: Coordination, decision tracking, audit trail
- Pain Points: Knowledge transfer, decision inconsistency
- Value from KRACKED: Role separation, status tracking

Persona 3: AI-First Developer
- Profile: Developer who heavily uses AI coding assistants
- Needs: Control over AI workflow, quality assurance
- Pain Points: AI hallucination, unvalidated decisions
- Value from KRACKED: Decision validation, checkpoints

4.2 Secondary Users
-------------------

Persona 4: Project Manager
- Profile: Non-technical project overseer
- Needs: Visibility into development progress
- Pain Points: Black box AI development
- Value from KRACKED: status.md transparency, checkpoints

Persona 5: Technical Lead
- Profile: Senior developer reviewing AI output
- Needs: Quality control, architecture oversight
- Pain Points: Unstructured AI contributions
- Value from KRACKED: Role-based handoffs, validation blocks

4.3 User Journeys
-----------------

Journey 1: New Project (Solo Developer)
1. Run install script in project folder
2. Select language preference
3. Start with /KD-analyze
4. Follow guided workflow
5. Complete deployment

Journey 2: Existing Project (Team)
1. Run install script in existing repo
2. Analyze current state
3. Pick up from appropriate stage
4. Continue with multi-agent for complex decisions
5. Document and deploy

================================================================================
5. TECHNICAL ARCHITECTURE
================================================================================

5.1 High-Level Architecture
---------------------------

┌─────────────────────────────────────────────────────────────────────────────┐
│                              USER ENVIRONMENT                               │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                         │
│  │ Claude Code │  │   Cursor    │  │ Antigravity │                         │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘                         │
│         │                │                │                                 │
│         └────────────────┴────────────────┘                                 │
│                                   │                                         │
│                          ADAPTER LAYER                                       │
│         ┌─────────────────────────┼─────────────────────────┐              │
│         │                         │                         │               │
│         ▼                         ▼                         ▼               │
│  ┌─────────────┐          ┌─────────────┐          ┌─────────────┐         │
│  │ CLAUDE.md   │          │ .cursorrules│          │ .antigravity│         │
│  │ commands.md │          │ prompts/    │          │ kracked.json│         │
│  └─────────────┘          └─────────────┘          └─────────────┘         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                            KRACKEDDEVS CORE                                  │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                         PROMPTS LAYER                                │   │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐               │   │
│  │  │ system-prompt│  │    roles/    │  │   stages/    │               │   │
│  │  │     .md      │  │  (9 files)   │  │  (7 files)   │               │   │
│  │  └──────────────┘  └──────────────┘  └──────────────┘               │   │
│  │                                                                      │   │
│  │  ┌────────────────────────────────────────────────────────────────┐ │   │
│  │  │                    multi-agent/                                 │ │   │
│  │  │  party-mode.md | agent-swarm.md | confidence-scoring.md        │ │   │
│  │  └────────────────────────────────────────────────────────────────┘ │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                        TEMPLATES LAYER                               │   │
│  │  status.md | product-brief.md | prd.md | architecture.md            │   │
│  │  story-card.md | deployment-plan.md | release-notes.md              │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                       CHECKLISTS LAYER                               │   │
│  │  stage-completion.md | decision-validation.md | checkpoint.md       │   │
│  │  security-audit.md | error-recovery.md                               │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                         CONFIG LAYER                                 │   │
│  │  settings.json | language.json                                       │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                           INSTALLATION SYSTEM                               │
│                                                                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐   │
│  │  install.sh  │  │ uninstall.sh │  │  update.sh   │  │  validate.sh │   │
│  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘   │
│                                                                             │
│  Delivery Methods:                                                          │
│  • curl | bash                                                              │
│  • wget -qO- | bash                                                         │
│  • git clone + local install                                                │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

================================================================================
6. FILE STRUCTURE
================================================================================

6.1 Complete Directory Tree
---------------------------

Kracked_Skills/
│
├── install.sh                         # Main installation script
├── uninstall.sh                       # Uninstallation script
├── update.sh                          # Update script
├── validate.sh                        # Validation script
├── VERSION                            # Current version number
├── LICENSE                            # MIT License
├── README.md                          # Main documentation
├── PLANNING.md                        # This planning document
├── CHANGELOG.md                       # Version history
│
├── src/
│   │
│   ├── core/
│   │   ├── kracked.sh                 # Core initialization functions
│   │   ├── language.sh                # Language handling functions
│   │   ├── status.sh                  # Status management functions
│   │   ├── validation.sh              # Validation functions
│   │   └── utils.sh                   # Utility functions
│   │
│   ├── prompts/
│   │   │
│   │   ├── system-prompt.md           # FULL KRACKED v3.3 system prompt
│   │   │
│   │   ├── roles/
│   │   │   ├── _role-template.md      # Template for creating new roles
│   │   │   ├── analyst.md             # Analyst role definition
│   │   │   ├── product-manager.md     # PM role definition
│   │   │   ├── architect.md           # Architect role definition
│   │   │   ├── tech-lead.md           # Tech Lead role definition
│   │   │   ├── engineer.md            # Engineer role definition
│   │   │   ├── qa.md                  # QA role definition
│   │   │   ├── security.md            # Security role definition
│   │   │   ├── devops.md              # DevOps role definition
│   │   │   └── release-manager.md     # Release Manager role definition
│   │   │
│   │   ├── stages/
│   │   │   ├── _stage-template.md     # Template for creating new stages
│   │   │   ├── discovery.md           # Discovery stage prompt
│   │   │   ├── requirements.md        # Requirements stage prompt
│   │   │   ├── architecture.md        # Architecture stage prompt
│   │   │   ├── implementation.md      # Implementation stage prompt
│   │   │   ├── quality.md             # Quality stage prompt
│   │   │   ├── deployment.md          # Deployment stage prompt
│   │   │   └── release.md             # Release stage prompt
│   │   │
│   │   └── multi-agent/
│   │       ├── party-mode.md          # Party mode detailed prompt
│   │       ├── agent-swarm.md         # Agent swarm detailed prompt
│   │       ├── confidence-scoring.md  # Confidence scoring methodology
│   │       ├── conflict-resolution.md # Conflict resolution protocol
│   │       └── aggregation.md         # Output aggregation protocol
│   │
│   ├── templates/
│   │   ├── status.md                  # Status file template
│   │   ├── product-brief.md           # Product brief template
│   │   ├── prd.md                     # PRD template
│   │   ├── architecture.md            # Architecture document template
│   │   ├── story-card.md              # User story card template
│   │   ├── deployment-plan.md         # Deployment plan template
│   │   ├── release-notes.md           # Release notes template
│   │   ├── decision-log.md            # Decision log template
│   │   └── risk-register.md           # Risk register template
│   │
│   ├── checklists/
│   │   ├── stage-completion.md        # Stage completion checklist
│   │   ├── decision-validation.md     # Decision validation checklist
│   │   ├── checkpoint-approval.md     # Human checkpoint checklist
│   │   ├── security-audit.md          # Security audit checklist
│   │   ├── error-recovery.md          # Error recovery checklist
│   │   └── pre-deployment.md          # Pre-deployment checklist
│   │
│   ├── workflows/
│   │   ├── main.flow.md               # Main workflow definition
│   │   ├── quick-start.flow.md        # Quick start workflow
│   │   ├── full-product.flow.md       # Full product workflow
│   │   └── maintenance.flow.md        # Maintenance workflow
│   │
│   ├── adapters/
│   │   │
│   │   ├── claude-code/
│   │   │   ├── CLAUDE.md              # Claude Code skill file
│   │   │   ├── commands.md            # Command definitions
│   │   │   └── README.md              # Claude Code specific docs
│   │   │
│   │   ├── cursor/
│   │   │   ├── .cursorrules           # Cursor rules file
│   │   │   ├── prompts/
│   │   │   │   └── kracked.md         # KRACKED prompt for Cursor
│   │   │   └── README.md              # Cursor specific docs
│   │   │
│   │   ├── antigravity/
│   │   │   ├── skill.md               # Skill definition
│   │   │   ├── config.json            # Configuration
│   │   │   └── README.md              # Antigravity specific docs
│   │   │
│   │   └── generic/
│   │       ├── instructions.md        # Generic instructions
│   │       └── README.md              # Generic adapter docs
│   │
│   └── config/
│       ├── settings.schema.json       # Settings JSON schema
│       ├── default-settings.json      # Default settings
│       └── language/
│           ├── en.json                # English strings
│           └── ms.json                # Bahasa Melayu strings
│
├── docs/
│   ├── README.md                      # Documentation index
│   ├── GETTING-STARTED.md             # Getting started guide
│   ├── COMMANDS.md                    # Command reference
│   ├── WORKFLOWS.md                   # Workflow documentation
│   ├── MULTI-AGENT.md                 # Multi-agent documentation
│   ├── ROLES.md                       # Role documentation
│   ├── TEMPLATES.md                   # Template documentation
│   ├── BEST-PRACTICES.md              # Best practices guide
│   ├── TROUBLESHOOTING.md             # Troubleshooting guide
│   ├── FAQ.md                         # Frequently asked questions
│   └── CONTRIBUTING.md                # Contribution guidelines
│
├── examples/
│   │
│   ├── marketplace-mvp/
│   │   ├── README.md                  # Example description
│   │   ├── status.md                  # Example status file
│   │   ├── product-brief.md           # Example product brief
│   │   ├── prd.md                     # Example PRD
│   │   └── architecture.md            # Example architecture
│   │
│   ├── quick-project/
│   │   ├── README.md
│   │   └── status.md
│   │
│   └── multi-agent-session/
│       ├── README.md
│       ├── party-mode-example.md      # Example party mode output
│       └── swarm-example.md           # Example swarm output
│
├── tests/
│   ├── install.test.sh                # Installation tests
│   ├── validation.test.sh             # Validation tests
│   ├── language.test.sh               # Language tests
│   └── fixtures/
│       └── test-project/              # Test fixture project
│
└── scripts/
    ├── release.sh                     # Release script
    ├── test-all.sh                    # Run all tests
    └── generate-docs.sh               # Documentation generator

================================================================================
7. CORE COMPONENTS
================================================================================

7.1 Installation Scripts
------------------------

7.1.1 install.sh
----------------
Purpose: Main installation entry point

Functions:
- print_banner()           # Display KRACKEDDEVS ASCII art
- check_dependencies()     # Verify curl/wget, git available
- detect_platform()        # Linux, macOS, Windows (WSL)
- ask_target()             # Prompt for AI tool target (Claude Code, Cursor, Antigravity)
- ask_language()           # Prompt for language preference
- download_kracked()       # Download all KRACKED files
- init_status()            # Initialize status.md
- setup_[adapter]()        # Setup specific adapter
- main()                   # Orchestrate installation

Flow:
1. Print banner
2. Check dependencies
3. Detect platform
4. Ask user preferences (target AI tool, language)
5. Confirm installation
6. Download files
7. Initialize project
8. Setup adapter
9. Print success message

Error Handling:
- Missing dependencies → Exit with instructions
- Download failure → Retry with fallback URL
- Write permission denied → Exit with fix instructions
- Existing installation → Prompt for overwrite

7.1.2 uninstall.sh
------------------
Purpose: Remove KRACKED from project

Functions:
- check_kracked_exists()   # Verify .kracked exists
- backup_status()          # Backup status.md
- remove_files()           # Remove .kracked directory
- remove_adapters()        # Remove adapter files
- confirm()                # Confirm uninstallation

Preserved Files:
- status.md (backed up)
- All project source files
- Any custom templates user created

7.1.3 update.sh
---------------
Purpose: Update KRACKED to latest version

Functions:
- check_current_version()  # Read current version
- fetch_latest_version()   # Check GitHub for latest
- compare_versions()       # Determine if update needed
- backup_config()          # Backup user settings
- download_update()        # Download new files
- restore_config()         # Restore user settings
- migrate_if_needed()      # Run migrations

7.1.4 validate.sh
-----------------
Purpose: Validate KRACKED installation

Functions:
- check_file_integrity()   # Verify all files exist
- check_config_valid()     # Validate settings.json
- check_status_valid()     # Validate status.md format
- check_adapter_valid()    # Validate adapter setup

7.2 Command System (All commands start with /KD)
------------------------------------------------

7.2.1 Command List
------------------

| Command                    | Description                    |
|---------------------------|--------------------------------|
| /KD-analyze               | Discovery and risk identification |
| /KD-product-brief         | Create product brief           |
| /KD-prd                   | Product requirements document  |
| /KD-architecture          | System architecture design     |
| /KD-epics-and-stories     | Backlog creation               |
| /KD-dev-story [id]        | Single story implementation    |
| /KD-code-review           | Quality and security review    |
| /KD-deployment-plan       | Deployment strategy            |
| /KD-scale-review          | Post-deployment assessment     |
| /KD-status                | Display current project state  |
| /KD-help                  | Display command reference      |
| /KD-party-mode            | Activate party mode            |
| /KD-swarm                 | Activate agent swarm           |

7.2.2 Command Parameters
------------------------

/KD-architecture --depth=[quick|standard|deep]
/KD-dev-story [story-id] --focus=[backend|frontend|full]
/KD-code-review --scope=[full|diff] --severity=[strict|normal]
/KD-deployment-plan --env=[staging|production]
/KD-party-mode --agents=[n] --topic="[topic]"
/KD-swarm --agents=[n] --tasks="[task list]"

7.3 Scale Assessment (AI-Driven)
--------------------------------

Scale (SMALL/STANDARD/DEEP) tidak dipilih semasa installation.
Sebaliknya, AI akan menilai scale berdasarkan:

1. Semasa /KD-analyze - AI mengumpul maklumat projek
2. AI menilai faktor-faktor:
   - Saiz pasukan
   - Timeline
   - Risiko teknikal
   - Integrasi yang diperlukan
   - Sensitiviti data
   - Jangkaan scale pengguna

3. AI mencadangkan scale dan meminta pengesahan pengguna

Assessment Criteria:

| Factor              | Small (1)    | Standard (2-3)    | Deep (4-5)        |
|---------------------|--------------|-------------------|-------------------|
| Team Size           | Solo         | 2-5 people        | 6+ people         |
| Timeline            | <2 weeks     | 2-8 weeks         | >8 weeks          |
| Technical Risk      | Low          | Medium            | High              |
| Integration Points  | 0-2          | 3-5               | 6+                |
| Data Sensitivity    | Public       | Internal          | PII/Financial     |
| Scale Expectation   | <100 users   | <10,000 users     | >10,000 users     |

================================================================================
8. INSTALLATION SYSTEM
================================================================================

8.1 Installation Methods
------------------------

Method 1: curl (Primary)
------------------------
curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_skill/main/install.sh | bash

Method 2: wget
--------------
wget -qO- https://raw.githubusercontent.com/MoonWIRaja/Kracked_skill/main/install.sh | bash

Method 3: git clone + local
---------------------------
git clone https://github.com/MoonWIRaja/Kracked_skill.git
cd Kracked_Skills
bash install.sh /path/to/project

8.2 Installation Parameters
---------------------------

Positional Arguments:
- $1: Target directory (default: current directory)

Flags:
- --target=[claude-code|cursor|antigravity]
- --language=[EN|MS]
- --non-interactive (skip prompts, use defaults)
- --force (overwrite existing installation)
- --verbose (detailed output)
- --help (show usage)

8.3 Installation Flow Diagram
-----------------------------

```
START
  │
  ▼
┌─────────────────────────┐
│   Check Dependencies    │
│  - curl or wget         │
│  - bash                 │
│  - write permission     │
└───────────┬─────────────┘
            │
            ▼
      ┌─────┴─────┐
      │   OK?     │──── NO ───▶ Exit with error
      └─────┬─────┘
            │ YES
            ▼
┌─────────────────────────┐
│   Detect Platform       │
│  - Linux                │
│  - macOS                │
│  - Windows (WSL/Git)    │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│   Interactive Prompts   │──── --non-interactive ───▶ Use defaults
│  - Target AI tool       │
│    (Claude Code,        │
│     Cursor, Antigravity)│
│  - Language             │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│   Confirm Installation  │──── Decline ───▶ Exit
└───────────┬─────────────┘
            │ Confirm
            ▼
┌─────────────────────────┐
│   Create .kracked/      │
│   directory structure   │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│   Download Files        │
│  - Prompts              │
│  - Templates            │
│  - Checklists           │
│  - Adapters             │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│   Create Config         │
│  - settings.json        │
│  - language pref        │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│   Initialize status.md  │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│   Setup Adapter         │
│  - Claude Code          │
│  - Cursor               │
│  - Antigravity          │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│   Print Success         │
│   Next steps guide      │
└───────────┬─────────────┘
            │
            ▼
          END
```

8.4 Banner Display (KRACKEDDEVS)
--------------------------------

Option 1 - Full KRACKEDDEVS:
```
╔═══════════════════════════════════════════════════════════════════════════════╗
║                                                                               ║
║   ██╗  ██╗██████╗ ██╗  ██╗ █████╗ ██╗     ███╗   ███╗ █████╗ ██████╗         ║
║   ██║ ██╔╝██╔══██╗██║ ██╔╝██╔══██╗██║     ████╗ ████║██╔══██╗██╔══██╗        ║
║   █████╔╝ ██║  ██║█████╔╝ ███████║██║     ██╔████╔██║███████║██████╔╝        ║
║   ██╔═██╗ ██║  ██║██╔═██╗ ██╔══██║██║     ██║╚██╔╝██║██╔══██║██╔══██╗        ║
║   ██║  ██╗██████╔╝██║  ██╗██║  ██║███████╗██║ ╚═╝ ██║██║  ██║██║  ██║        ║
║   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝        ║
║                                                                               ║
║               ██╗███╗   ██╗     █████╗ ███████╗ ██████╗██╗██╗                ║
║               ██║████╗  ██║    ██╔══██╗██╔════╝██╔════╝██║██║                ║
║               ██║██╔██╗ ██║    ███████║███████╗██║     ██║██║                ║
║               ██║██║╚██╗██║    ██╔══██║╚════██║██║     ██║██║                ║
║               ██║██║ ╚████║    ██║  ██║███████║╚██████╗██║██║                ║
║               ╚═╝╚═╝  ╚═══╝    ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝╚═╝                ║
║                                                                               ║
║                  AI Skill by KRACKEDDEVS                                      ║
║                  https://krackeddevs.com/                                     ║
║                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════╝
```

Option 2 - Short KD:
```
╔═══════════════════════════════════════════════════════════════════════╗
║                                                                       ║
║   ██╗  ██╗██████╗                                                     ║
║   ██║ ██╔╝██╔══██╗                                                    ║
║   █████╔╝ ██║  ██║    AI Skill by KRACKEDDEVS                          ║
║   ██╔═██╗ ██║  ██║    https://krackeddevs.com/                         ║
║   ██║  ██╗██████╔╝                                                    ║
║   ╚═╝  ╚═╝╚═════╝                                                     ║
║                                                                       ║
╚═══════════════════════════════════════════════════════════════════════╝
```

Option 3 - Simple with Branding (RECOMMENDED):
```
╔═══════════════════════════════════════════════════════════════════════╗
║                                                                       ║
║     ██╗  ██╗██████╗ ██╗  ██╗ █████╗ ██╗     ██╗  ██╗███████╗██████╗   ║
║     ██║ ██╔╝██╔══██╗██║ ██╔╝██╔══██╗██║     ██║ ██╔╝██╔════╝██╔══██╗  ║
║     █████╔╝ ██║  ██║█████╔╝ ███████║██║     █████╔╝ █████╗  ██████╔╝   ║
║     ██╔═██╗ ██║  ██║██╔═██╗ ██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗  ║
║     ██║  ██╗██████╔╝██║  ██╗██║  ██║███████╗██║  ██╗███████╗██║  ██║  ║
║     ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝  ║
║                                                                       ║
║                   AI Skill by KRACKEDDEVS                              ║
║                   https://krackeddevs.com/                             ║
║                                                                       ║
╚═══════════════════════════════════════════════════════════════════════╝
```

================================================================================
9. ADAPTER IMPLEMENTATIONS
================================================================================

9.1 Supported AI Tools (3 Only)
-------------------------------

| Tool         | Adapter File      | Description                        |
|--------------|-------------------|------------------------------------|
| Claude Code  | CLAUDE.md         | Anthropic's Claude Code IDE        |
| Cursor       | .cursorrules      | Cursor AI code editor              |
| Antigravity  | skill.md + config | Antigravity AI platform            |

9.2 Claude Code Adapter
-----------------------

File: src/adapters/claude-code/CLAUDE.md

Content:
```markdown
# KD - AI Skill by KRACKEDDEVS

Official Site: https://krackeddevs.com/

## Activation

KD is active in this project. Read the system prompt:

```bash
Read the file at .kracked/prompts/system-prompt.md
```

## Quick Start Commands

| Command                    | Description                    |
|---------------------------|--------------------------------|
| /KD-analyze               | Start discovery phase          |
| /KD-product-brief         | Create product brief           |
| /KD-prd                   | Product requirements document  |
| /KD-architecture          | System architecture design     |
| /KD-dev-story [id]        | Implement a story              |
| /KD-code-review           | Quality and security review    |
| /KD-deployment-plan       | Deployment strategy            |
| /KD-status                | Show current project state     |
| /KD-help                  | Display command reference      |

## Multi-Agent Commands

| Command                                         | Description              |
|------------------------------------------------|--------------------------|
| /KD-party-mode --agents=N --topic="topic"      | Parallel brainstorming   |
| /KD-swarm --agents=N --tasks="task1,task2"     | Parallel execution       |

## Workflow

1. Read `.kracked/prompts/system-prompt.md` for full instructions
2. Read `status.md` for current project state
3. Execute commands following workflow stages
4. Update `status.md` after each major action

## Language

Current language: {LANGUAGE}
Change in: `.kracked/config/settings.json`

## Files Reference

- System Prompt: `.kracked/prompts/system-prompt.md`
- Status: `status.md`
- Templates: `.kracked/templates/`
- Checklists: `.kracked/checklists/`

## Official Site

https://krackeddevs.com/
```

9.3 Cursor Adapter
------------------

File: src/adapters/cursor/.cursorrules

Content:
```
# KD - AI Skill by KRACKEDDEVS
# Official Site: https://krackeddevs.com/

You are operating with KD - Structured Multi-Role AI Product Execution System.

## Initialization

Before starting any work:
1. Read `.kracked/prompts/system-prompt.md` for full system instructions
2. Read `status.md` for current project state
3. Follow the workflow stage indicated in status.md

## Core Rules

1. SINGLE ROLE ACTIVATION
   Only one role active at a time.
   Always state: [ACTIVE ROLE: <Role Name>]

2. LANGUAGE CONSISTENCY
   Follow language preference in `.kracked/config/settings.json`
   - EN: English for all interactions
   - MS: Bahasa Melayu for all interactions
   - Code always in English

3. STATUS TRACKING
   Update `status.md` after every major decision or action.

4. DECISION VALIDATION
   For architecture, schema, deployment decisions:
   Run the decision validation block (see system-prompt.md)

5. CHECKPOINTS
   Stages require human approval:
   - /KD-product-brief
   - /KD-prd
   - /KD-architecture
   - /KD-deployment-plan (production)

## Commands

All commands start with /KD prefix:
- /KD-analyze - Discovery phase
- /KD-product-brief - Product brief
- /KD-prd - Requirements
- /KD-architecture - System design
- /KD-dev-story [id] - Implementation
- /KD-code-review - Quality check
- /KD-deployment-plan - Deploy strategy
- /KD-status - Current state
- /KD-help - Command reference

## Multi-Agent

- /KD-party-mode --agents=N --topic="topic"
- /KD-swarm --agents=N --tasks="tasks"

## File Structure

Reference these files:
- System prompt: `.kracked/prompts/system-prompt.md`
- Templates: `.kracked/templates/`
- Checklists: `.kracked/checklists/`
- Status: `status.md`

## Error Handling

On errors, follow error recovery protocol in system-prompt.md.
Always document in status.md under Blockers section.
```

9.4 Antigravity Adapter
-----------------------

File: src/adapters/antigravity/skill.md

Content:
```markdown
# KD Skill

## Metadata
- Name: KD
- Version: 1.0.0
- Author: KRACKEDDEVS
- Site: https://krackeddevs.com/
- Description: Structured Multi-Role AI Product Execution System

## Capabilities
- Workflow orchestration
- Multi-agent collaboration
- Status tracking
- Decision validation
- Human checkpoints

## Activation
Read `.kracked/prompts/system-prompt.md` to activate KD.

## Commands
All commands use /KD prefix:
- /KD-analyze
- /KD-product-brief
- /KD-prd
- /KD-architecture
- /KD-dev-story
- /KD-code-review
- /KD-deployment-plan
- /KD-status
- /KD-party-mode
- /KD-swarm
- /KD-help

## Configuration
- Language: Set in `.kracked/config/settings.json`
```

File: src/adapters/antigravity/config.json

Content:
```json
{
    "skill_name": "KD",
    "version": "1.0.0",
    "author": "KRACKEDDEVS",
    "site": "https://krackeddevs.com/",
    "system_prompt_path": ".kracked/prompts/system-prompt.md",
    "status_file": "status.md",
    "config_path": ".kracked/config/settings.json",
    "commands": [
        "KD-analyze",
        "KD-product-brief",
        "KD-prd",
        "KD-architecture",
        "KD-dev-story",
        "KD-code-review",
        "KD-deployment-plan",
        "KD-status",
        "KD-party-mode",
        "KD-swarm",
        "KD-help"
    ],
    "language_support": ["EN", "MS"],
    "supported_targets": ["claude-code", "cursor", "antigravity"]
}
```

================================================================================
10. TEMPLATE SYSTEM
================================================================================

10.1 Template Files
-------------------

| Template               | Purpose                          |
|------------------------|----------------------------------|
| status.md              | Track project state              |
| product-brief.md       | Define product vision            |
| prd.md                 | Product requirements document    |
| architecture.md        | System architecture document     |
| story-card.md          | Individual user story tracking   |
| deployment-plan.md     | Deployment strategy document     |
| release-notes.md       | Document release contents        |
| decision-log.md        | Log architectural decisions      |
| risk-register.md       | Track project risks              |

10.2 status.md Template
-----------------------

```markdown
# PROJECT STATUS

## Meta
- Project: [name]
- Domain: [industry]
- Language: [EN|MS]
- Scale: [to be determined by AI during /KD-analyze]
- Deadline: [date or "not defined"]
- Created: [date]
- Last Updated: [date]

## Current State
- Stage: [Ready to begin | Discovery | Requirements | Architecture | Implementation | Quality | Deployment | Release]
- Active Role: [None | Analyst | PM | Architect | Tech Lead | Engineer | QA | Security | DevOps | Release Manager]
- Active Story: [story-id or "none"]
- Multi-Agent Mode: [none | party | swarm]

## Completed Stages
| Stage | Status | Completed Date | Key Artifact |
|-------|--------|----------------|--------------|
| Discovery | [pending|complete|blocked] | [date] | [artifact path] |

## Completed Artifacts
| Artifact | Location | Stage | Date |
|----------|----------|-------|------|
| [name] | [path] | [stage] | [date] |

## Architecture Decisions
| ID | Decision | Rationale | Impact | Date | Status |
|----|----------|-----------|--------|------|--------|
| A001 | [decision] | [why] | [scope] | [date] | [active|superseded] |

## Tech Stack
| Layer | Technology | Version | Reason |
|-------|------------|---------|--------|
| Frontend | [tech] | [version] | [why] |
| Backend | [tech] | [version] | [why] |
| Database | [tech] | [version] | [why] |

## Dependencies
| Name | Type | Version | Status | Risk |
|------|------|---------|--------|------|
| [name] | [npm|pip|etc] | [version] | [active|deprecated] | [low|med|high] |

## Open Risks
| ID | Risk | Severity | Probability | Mitigation | Owner | Status |
|----|------|----------|-------------|------------|-------|--------|
| R001 | [risk] | [low|med|high|critical] | [low|med|high] | [action] | [role] | [open|mitigated|closed] |

## Security Notes
| Component | Classification | Protection | Audit Date |
|-----------|----------------|------------|------------|
| [name] | [public|internal|confidential|restricted] | [encryption|access control] | [date] |

## Deployment State
- Environment: [development|staging|production]
- Last Deploy: [datetime or "N/A"]
- Status: [pending|deployed|failed|rolledback]
- Version: [version or "N/A"]

## Monitoring State
- Health Check: [url or "N/A"]
- Logs: [url or "N/A"]
- Alerts: [configured alerts or "none"]
- Dashboard: [url or "N/A"]

## Known Issues
| ID | Issue | Severity | Workaround | Status |
|----|-------|----------|------------|--------|
| I001 | [issue] | [low|med|high] | [workaround] | [open|resolved] |

## Multi-Agent Sessions
| Session ID | Mode | Agents | Topic | Consensus | Result | Date |
|------------|------|--------|-------|-----------|--------|------|
| P001 | party | 3 | [topic] | [80%] | [approved] | [date] |

## Next Actions
1. [Action 1]
2. [Action 2]

## Blockers
| ID | Blocker | Since | Impact | Resolution Plan |
|----|---------|-------|--------|-----------------|
| B001 | [blocker] | [date] | [scope] | [plan] |

## Change Log
| Timestamp | Stage | Change | Role | Reason |
|-----------|-------|--------|------|--------|
| [datetime] | [stage] | [what changed] | [role] | [why] |
```

================================================================================
11. MULTI-AGENT SYSTEM
================================================================================

11.1 Party Mode Commands
------------------------

Command: /KD-party-mode --stage=[stage] --agents=[2-5] --topic="[topic]"

Examples:
- /KD-party-mode --stage=architecture --agents=3 --topic="database selection"
- /KD-party-mode --agents=4 --topic="authentication approach"

11.2 Agent Swarm Commands
-------------------------

Command: /KD-swarm --stage=[stage] --agents=[2-8] --tasks="[task list]"

Examples:
- /KD-swarm --stage=implementation --agents=4 --tasks="users API, products API, orders API, tests"
- /KD-swarm --agents=3 --tasks="frontend components, backend routes, database models"

11.3 Confidence Scoring
-----------------------

| Level   | Score | Criteria                                           |
|---------|-------|----------------------------------------------------|
| HIGH    | 3     | Fully aligns with all artifacts, minimal risk      |
| MEDIUM  | 2     | Aligns with most artifacts, some unknowns          |
| LOW     | 1     | Partial alignment, significant unknowns or risks   |

Decision Thresholds:

| Consensus    | Action                                         |
|--------------|------------------------------------------------|
| > 70%        | Auto-recommend, single checkpoint              |
| 50-70%       | Recommend with caveats, mandatory review       |
| < 50%        | Escalate to user, present all options          |

================================================================================
12. LANGUAGE SYSTEM
================================================================================

12.1 Supported Languages
------------------------

| Code | Language      | Native Name    |
|------|---------------|----------------|
| EN   | English       | English        |
| MS   | Bahasa Melayu | بهاس ملايو     |

12.2 Language Rules
-------------------

1. CONVERSATION LANGUAGE
   - All prompts, responses, discussions use selected language
   - Role transitions and handoffs use selected language
   - Error messages in selected language

2. CODE LANGUAGE (ALWAYS ENGLISH)
   - Variable names: English
   - Function names: English
   - Class names: English
   - API endpoints: English
   - Database tables/columns: English
   - File names: English

3. CODE COMMENTS
   - Follow selected language preference

4. TECHNICAL TERMS
   - Keep in English when no common translation exists
   - Example: "database", "API", "endpoint", "deployment", "cache"

================================================================================
13. DOCUMENTATION PLAN
================================================================================

13.1 Documentation Files
------------------------

| File                | Purpose               | Length   |
|---------------------|-----------------------|----------|
| README.md           | Project overview      | 2-3 pages|
| GETTING-STARTED.md  | Quick start guide     | 3-4 pages|
| COMMANDS.md         | Command reference     | 4-5 pages|
| WORKFLOWS.md        | Workflow documentation| 5-6 pages|
| MULTI-AGENT.md      | Multi-agent guide     | 4-5 pages|
| ROLES.md            | Role documentation    | 6-8 pages|
| TEMPLATES.md        | Template guide        | 3-4 pages|
| BEST-PRACTICES.md   | Best practices        | 4-5 pages|
| TROUBLESHOOTING.md  | Common issues         | 3-4 pages|
| FAQ.md              | Questions & answers   | 2-3 pages|
| CONTRIBUTING.md     | Contribution guide    | 2-3 pages|

13.2 README.md Structure
------------------------

```markdown
# Kracked_Skills

[ASCII Logo - KD/KRACKEDDEVS]

## What is KD?

AI Skill by KRACKEDDEVS - Structured Multi-Role AI Product Execution System

Official Site: https://krackeddevs.com/

## Quick Start

### Installation
curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_skill/main/install.sh | bash

### First Use
/KD-analyze

## Features

- 9 Structured Roles
- 7 Workflow Stages
- Multi-Agent Support (Party Mode & Swarm)
- Dual Language (English & Bahasa Melayu)
- Persistent Status Tracking
- Decision Validation
- Human Checkpoints

## Supported AI Tools

- Claude Code
- Cursor
- Antigravity

## Documentation

[Links to docs]

## Examples

[Example projects]

## License

MIT License

## Official Site

https://krackeddevs.com/
```

================================================================================
14. TESTING STRATEGY
================================================================================

14.1 Test Categories
--------------------

| Category         | Purpose                    | Location                  |
|------------------|----------------------------|---------------------------|
| Installation     | Verify install.sh works    | tests/install.test.sh     |
| Validation       | Verify validation logic    | tests/validation.test.sh  |
| Language         | Verify language handling   | tests/language.test.sh    |
| Integration      | End-to-end workflows       | tests/integration/        |

14.2 Test Cases
---------------

### Installation Tests

| Test ID  | Description                        | Expected Result          |
|----------|------------------------------------|--------------------------|
| INST-001 | Fresh install with curl            | .kracked/ created        |
| INST-002 | Fresh install with wget            | .kracked/ created        |
| INST-003 | Install to custom directory        | Files in correct location|
| INST-004 | Install with --non-interactive     | No prompts shown         |
| INST-005 | Re-install with --force            | Overwrites existing      |
| INST-006 | Uninstall removes .kracked         | Directory removed        |
| INST-007 | Update preserves config            | settings.json intact     |

### Validation Tests

| Test ID | Description                      | Expected Result    |
|---------|----------------------------------|--------------------|
| VAL-001 | Valid settings.json              | Pass               |
| VAL-002 | Invalid JSON in settings         | Error reported     |
| VAL-003 | Missing required file            | Error reported     |
| VAL-004 | Missing section in status.md     | Error reported     |
| VAL-005 | All files present                | Pass               |

### Language Tests

| Test ID  | Description              | Expected Result   |
|----------|--------------------------|-------------------|
| LANG-001 | Set language to EN       | English strings   |
| LANG-002 | Set language to MS       | Malay strings     |
| LANG-003 | Language persists        | Saved in config   |

================================================================================
15. RELEASE ROADMAP
================================================================================

15.1 Version Milestones
-----------------------

### v0.1.0 - Foundation (Week 1-2)
- [ ] Repository setup
- [ ] install.sh basic functionality
- [ ] uninstall.sh
- [ ] update.sh
- [ ] Basic directory structure
- [ ] system-prompt.md
- [ ] Banner with KRACKEDDEVS branding

### v0.2.0 - Core Prompts (Week 3-4)
- [ ] All 9 role prompts
- [ ] All 7 stage prompts
- [ ] Multi-agent prompts
- [ ] Confidence scoring documentation
- [ ] All commands with /KD prefix

### v0.3.0 - Templates (Week 5-6)
- [ ] status.md template
- [ ] product-brief.md template
- [ ] prd.md template
- [ ] architecture.md template
- [ ] story-card.md template
- [ ] deployment-plan.md template
- [ ] release-notes.md template

### v0.4.0 - Adapters (Week 7-8)
- [ ] Claude Code adapter
- [ ] Cursor adapter
- [ ] Antigravity adapter

### v0.5.0 - Documentation (Week 9-10)
- [ ] All documentation files
- [ ] Example projects
- [ ] FAQ

### v0.6.0 - Testing (Week 11-12)
- [ ] Installation tests
- [ ] Validation tests
- [ ] Language tests
- [ ] Integration tests

### v0.7.0 - Beta Release (Week 13-14)
- [ ] Bug fixes from testing
- [ ] Documentation polish
- [ ] Beta testing with users

### v0.8.0 - Release Candidate (Week 15-16)
- [ ] Address beta feedback
- [ ] Performance optimization
- [ ] Final documentation review

### v1.0.0 - Production Release (Week 17-18)
- [ ] Final testing
- [ ] Release announcement
- [ ] Publish to GitHub
- [ ] Update krackeddevs.com

================================================================================
16. SUCCESS METRICS
================================================================================

16.1 Technical Metrics
----------------------

| Metric                  | Target  | Measurement Method       |
|-------------------------|---------|--------------------------|
| Installation success    | > 95%   | GitHub Issues, feedback  |
| Download size           | < 500 KB| File size check          |
| Installation time       | < 2 min | Timed tests              |
| Script error rate       | < 1%    | Error logging            |

16.2 User Metrics
-----------------

| Metric              | Target          | Measurement Method |
|---------------------|-----------------|--------------------|
| GitHub Stars        | > 100 in 3 months| GitHub stats      |
| User satisfaction   | > 4.0/5.0       | Feedback form      |
| Return users        | > 50%           | Analytics          |
| Feature requests    | < 20/month      | GitHub Issues      |

================================================================================
17. RISK ASSESSMENT
================================================================================

17.1 Technical Risks
--------------------

| Risk ID | Risk                      | Prob | Impact | Mitigation                    |
|---------|---------------------------|------|--------|-------------------------------|
| TR-001  | curl/wget unavailable     | Low  | High   | Provide git clone alternative |
| TR-002  | GitHub raw URL blocked    | Low  | High   | Provide mirror URLs           |
| TR-003  | Platform-specific issues  | Med  | Medium | Extensive testing             |
| TR-004  | Large system prompt       | Med  | Low    | Context compression           |
| TR-005  | AI tool compatibility     | Med  | Medium | Adapter pattern               |

17.2 Project Risks
------------------

| Risk ID | Risk                    | Prob | Impact | Mitigation            |
|---------|-------------------------|------|--------|-----------------------|
| PR-001  | Scope creep             | High | Medium | Strict v1.0 scope     |
| PR-002  | Insufficient testing    | Med  | High   | Dedicated test phase  |
| PR-003  | Documentation lag       | Med  | Medium | Doc sprints           |
| PR-004  | User adoption low       | Med  | High   | Marketing, examples   |
| PR-005  | Breaking changes        | Low  | High   | Semantic versioning   |

================================================================================
18. MAINTENANCE PLAN
================================================================================

18.1 Regular Maintenance Tasks
------------------------------

| Task                | Frequency | Responsible |
|---------------------|-----------|-------------|
| Dependency updates  | Monthly   | Maintainer  |
| Security audit      | Quarterly | Maintainer  |
| Documentation review| Quarterly | Maintainer  |
| Test suite run      | Per commit| CI/CD       |
| Version bump        | Per release| Maintainer |

18.2 Support Channels
---------------------

| Channel            | Purpose              | Response Time |
|--------------------|----------------------|---------------|
| GitHub Issues      | Bug reports, features| 48 hours      |
| GitHub Discussions | Questions, help      | 72 hours      |
| Email              | Security issues      | 24 hours      |
| krackeddevs.com    | General info         | -             |

================================================================================
19. APPENDICES
================================================================================

Appendix A: Complete Command Reference
--------------------------------------

```
KD Command Reference
====================

All commands start with /KD prefix.

PRIMARY WORKFLOW COMMANDS
-------------------------

/KD-analyze                         Discovery and risk identification
/KD-product-brief                   Product brief creation
/KD-prd                             Product requirements document
/KD-architecture --depth=[level]    System architecture design
/KD-epics-and-stories               Backlog creation
/KD-dev-story [id] --focus=[scope]  Single story implementation
/KD-code-review --scope=[scope]     Quality and security review
/KD-deployment-plan --env=[env]     Deployment strategy
/KD-scale-review                    Post-deployment assessment

MULTI-AGENT COMMANDS
--------------------

/KD-party-mode --agents=[n] --topic="[topic]"
/KD-swarm --agents=[n] --tasks="[task list]"

UTILITY COMMANDS
----------------

/KD-status                          Display current project state
/KD-help                            Display command reference

PARAMETERS
----------

--depth=[quick|standard|deep]       Architecture depth level
--focus=[backend|frontend|full]     Implementation focus area
--scope=[full|diff]                 Code review scope
--severity=[strict|normal]          Code review severity
--env=[staging|production]          Deployment environment
--agents=[n]                        Number of multi-agents (2-8)
--topic="[topic]"                   Party mode focus topic
--tasks="[list]"                    Swarm sub-tasks (comma-separated)
```

Appendix B: Installation Example Log
------------------------------------

```
$ curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_skill/main/install.sh | bash

╔═══════════════════════════════════════════════════════════════════════╗
║                                                                       ║
║   ██╗  ██╗██████╗                                                     ║
║   ██║ ██╔╝██╔══██╗                                                    ║
║   █████╔╝ ██║  ██║    AI Skill by KRACKEDDEVS                         ║
║   ██╔═██╗ ██║  ██║    https://krackeddevs.com/                        ║
║   ██║  ██╗██████╔╝                                                    ║
║   ╚═╝  ╚═╝╚═════╝                                                     ║
║                                                                       ║
╚═══════════════════════════════════════════════════════════════════════╝

[INFO] Checking dependencies...
[SUCCESS] All dependencies satisfied.
[INFO] Detected platform: linux

Select target AI tool:
  [1] Claude Code
  [2] Cursor
  [3] Antigravity

Enter choice [1-3]: 1

Select preferred language:
  [EN] English
  [MS] Bahasa Melayu

Enter choice [EN/MS]: MS

Installation Summary:
  Target: claude-code
  Language: MS
  Directory: /home/user/my-project

Proceed with installation? [Y/n]: Y

[INFO] Downloading KD files...
[SUCCESS] KD files downloaded.
[INFO] Initializing status.md...
[SUCCESS] status.md initialized.
[INFO] Setting up for Claude Code...
[SUCCESS] Claude Code setup complete.

═══════════════════════════════════════════════════════════════
  KD v1.0.0 installed successfully!
  AI Skill by KRACKEDDEVS
  https://krackeddevs.com/
═══════════════════════════════════════════════════════════════

Langkah Seterusnya:

  1. Baca system prompt:
     /home/user/my-project/.kracked/prompts/system-prompt.md

  2. Mulakan AI tool anda dan mulakan dengan:
     /KD-analyze

  3. Jejak kemajuan anda dalam:
     /home/user/my-project/status.md

KD finishes what it starts.
```

Appendix C: Glossary
--------------------

| Term              | Definition                                          |
|-------------------|-----------------------------------------------------|
| KD                | KRACKEDDEVS - Short command prefix                  |
| KRACKEDDEVS       | Official developer/brand                            |
| Party Mode        | Multi-agent parallel ideation mode                  |
| Agent Swarm       | Multi-agent parallel execution mode                 |
| status.md         | Persistent project state file                       |
| Checkpoint        | Human approval gate                                 |
| Decision Validation| Structured decision evaluation                     |
| Role              | Single responsibility context                       |
| Stage             | Workflow phase                                      |
| /KD prefix        | Command namespace for KD commands                   |

Appendix D: Quick Reference Card
--------------------------------

```
KD Quick Reference
==================

Official Site: https://krackeddevs.com/

Installation:
  curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_skill/main/install.sh | bash

Commands (all start with /KD):
  /KD-analyze          Discovery phase
  /KD-product-brief    Product brief
  /KD-prd              Requirements
  /KD-architecture     System design
  /KD-dev-story [id]   Implementation
  /KD-code-review      Quality check
  /KD-deployment-plan  Deploy strategy
  /KD-status           Current state
  /KD-help             Command reference

Multi-Agent:
  /KD-party-mode --agents=N --topic="topic"
  /KD-swarm --agents=N --tasks="task1,task2"

Files:
  .kracked/prompts/system-prompt.md  - Full system prompt
  .kracked/templates/                 - Document templates
  .kracked/checklists/                - Quality checklists
  status.md                           - Project state

Supported AI Tools:
  - Claude Code
  - Cursor
  - Antigravity

Languages:
  - EN (English)
  - MS (Bahasa Melayu)

Support:
  GitHub Issues: github.com/MoonWIRaja/Kracked_skill/issues
  Official Site: https://krackeddevs.com/
```

================================================================================
END OF PLANNING DOCUMENT
================================================================================
```