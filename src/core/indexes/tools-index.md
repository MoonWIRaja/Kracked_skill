# Tools Index — KD v5.0.0

## Available Tools

| Tool | Location | Purpose | Trigger |
|------|----------|---------|---------|
| Tool Selector | `tool-selector/` | Framework/DB selection | `/KD-tool-selector` |
| Version Checker | `version-checker/` | Version compatibility | `/KD-version-check` |
| TestSprite | `testsprite/` | Automated testing | `/KD-test-sprite` |
| Multi-Agent | `config/agents/`, `prompts/multi-agent/` | Party mode, Swarm | `/KD-party-mode`, `/KD-swarm` |
| Exporters | `exporters/` | Jira, PDF export | `/KD-doc-project` |
| Analytics | `analytics/` | Performance tracking | Auto |
| Git Integration | `git-integration/` | Auto commit | Auto |
| Core Scripts | `core/` | Shell utilities | Auto |

## Tool Selector

Selects optimal tech stack based on:
- Frameworks: React, Vue, Angular, Svelte, Next.js, Nuxt
- Backend: Express, NestJS, FastAPI, Django, Spring Boot
- Databases: PostgreSQL, MySQL, MongoDB, Redis

## Version Checker

Checks version compatibility:
- Latest stable versions
- Compatibility matrix
- Recommended configurations
- Warning for conflicts

```bash
node src/version-checker/version-checker.js next.js,react,node
```

## TestSprite

Automated test generation:
- Unit tests
- Integration tests
- E2E tests

## Multi-Agent

- **Party Mode**: Multiple agents ideate together
- **Swarm**: Multiple agents execute tasks

## Exporters

- Jira export
- PDF generation
- Consolidated export

---
*Load tools on demand*