# Getting Started with KD

## Prerequisites
- **bash** (version 4.0+)
- **curl** or **wget**
- One of the supported AI tools:
  - Claude Code
  - Cursor
  - Antigravity (Google Gemini)
  - Any AI tool with custom instructions support

## Installation

### Step 1: Install KD
Run in your project root directory:

```bash
curl -fsSL https://raw.githubusercontent.com/MoonWIRaja/Kracked_skill/main/install.sh | bash
```

The installer will:
1. Ask which AI tool you're using
2. Ask your preferred language (EN/MS)
3. Create the `.kracked/` directory with all system files
4. Set up the adapter for your chosen AI tool
5. Initialize `status.md` for project state tracking

### Step 2: Start Your First Session
Open your AI tool and type:
```
/KD-analyze
```

This activates the **Analyst** role and begins the **Discovery** stage.

### Step 3: Follow the Workflow
KD guides you through 7 stages:
1. **Discovery** — Understand the project
2. **Requirements** — Define what to build
3. **Architecture** — Design the system
4. **Implementation** — Write the code
5. **Quality** — Review and audit
6. **Deployment** — Ship it
7. **Release** — Document and close

## Configuration
Settings are stored in `.kracked/config/settings.json`:
```json
{
  "version": "1.0.0",
  "language": "EN",
  "target_tool": "claude-code",
  "project_name": "My Project"
}
```

## Next Steps
- Read the [Commands Reference](COMMANDS.md) for all available commands
- Read the [Roles Guide](ROLES.md) to understand each role
- Read the [Multi-Agent Guide](MULTI-AGENT.md) to learn about Party Mode and Swarm

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
