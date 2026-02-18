# Version Compatibility Checker

> AI Tool by KRACKEDDEVS | https://krackeddevs.com/

Check latest versions and compatibility between technologies.

## Usage

### Command Line

```bash
node version-checker.js <tech1,tech2,...> [options]
```

### Options

| Option | Description |
|--------|-------------|
| `--output=<path>` | Save report to file |
| `--json` | Output as JSON |

### Examples

```bash
# Check single technology
node version-checker.js next.js

# Check multiple technologies
node version-checker.js next.js,express.js

# Check with React compatibility
node version-checker.js next.js,react,node

# Save report
node version-checker.js next.js,express --output=./report.json

# Output as JSON
node version-checker.js react,vue,angular --json
```

## KD Command

```
/KD-version-check --tech="next.js,express.js"
```

## Features

### 1. Version Checking
- Fetches latest versions from npm registry
- Fetches Node.js versions from nodejs.org
- Fetches GitHub releases for tools like Deno
- Caches results for 24 hours

### 2. Compatibility Analysis
- Checks known compatibility rules
- Warns about known issues
- Suggests alternatives

### 3. Recommendations
- Suggests compatible versions
- Warns about downgrades needed
- Provides alternative technologies

## Supported Technologies

### Frontend
- React, Vue, Angular, Svelte
- Next.js, Nuxt, Astro, Remix

### Backend
- Express, NestJS, Fastify, Hono
- FastAPI, Django, Flask

### Database
- Prisma, Drizzle, Mongoose
- Supabase

### Build Tools
- Vite, Webpack, Turbo

### Testing
- Jest, Vitest, Playwright, Cypress

### Styling
- Tailwind CSS, Material-UI, Ant Design
- Chakra UI, shadcn/ui

### Runtime
- Node.js, Bun, Deno

## Output Example

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📦 VERSION COMPATIBILITY CHECK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📅 Date: 18/02/2026

🔍 Checking next.js...
   ✓ next.js: 15.1.0
   ✓ LTS: 14.2.20
🔍 Checking express.js...
   ✓ express.js: 4.21.2

🔗 Compatibility Analysis:

   ✅ No compatibility issues detected!

📊 Recommended Configuration:
   ┌─────────────────────────────────────────────┐
   │ next.js      15.1.0                        │
   │ express.js   4.21.2                        │
   └─────────────────────────────────────────────┘

💡 Recommendations:

   ℹ️ Next.js requires React. React 19.x is recommended for Next.js 15.x

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Files

| File | Description |
|------|-------------|
| `version-checker.js` | Core logic |
| `registry.json` | Cached version data |
| `compatibility-rules.json` | Compatibility rules |

## Integration

This tool integrates with KD system prompt. Use `/KD-version-check` command.

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*