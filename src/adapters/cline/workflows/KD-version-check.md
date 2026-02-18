# KD Version Compatibility Checker

## Latest Version & Compatibility Analysis

**Purpose**: Check latest versions of technologies and analyze compatibility between them

### Features

1. **Version Checking**
   - Fetches latest versions from npm registry
   - Fetches Node.js versions from nodejs.org
   - Fetches GitHub releases for tools like Deno
   - Caches results for 24 hours

2. **Compatibility Analysis**
   - Checks known compatibility rules
   - Warns about known issues between technology combinations
   - Suggests alternatives when conflicts detected

3. **Recommendations**
   - Suggests compatible versions
   - Warns about downgrades needed
   - Provides alternative technologies

### Usage

```bash
# Check single technology
/KD-version-check --tech="next.js"

# Check multiple technologies
/KD-version-check --tech="next.js,express.js"

# Check with Node.js compatibility
/KD-version-check --tech="next.js,react,node"

# Save report to file
/KD-version-check --tech="next.js,express" --output

# Output as JSON
/KD-version-check --tech="react,vue" --json
```

### Parameters

| Parameter | Description | Example |
|-----------|-------------|---------|
| `--tech` | Comma-separated list of technologies | `next.js,express.js` |
| `--output` | Save report to file | (flag) |
| `--json` | Output as JSON format | (flag) |

### Supported Technologies

#### Frontend
- React, Vue, Angular, Svelte
- Next.js, Nuxt, Astro, Remix

#### Backend
- Express, NestJS, Fastify, Hono
- FastAPI, Django, Flask

#### Database
- Prisma, Drizzle, Mongoose
- Supabase

#### Build Tools
- Vite, Webpack, Turbo

#### Testing
- Jest, Vitest, Playwright, Cypress

#### Styling
- Tailwind CSS, Material-UI, Ant Design
- Chakra UI, shadcn/ui

#### Runtime
- Node.js, Bun, Deno

### Known Compatibility Rules

| Tech 1 | Tech 2 | Constraint |
|--------|--------|------------|
| Next.js 15.x | React | Requires ^19.0.0 |
| Next.js 14.x | React | Requires ^18.2.0 |
| Next.js 15.x | Node.js | Requires >=18.18.0 |
| Angular 19.x | TypeScript | Requires >=5.5.0 |
| Nuxt 3.x | Vue | Requires ^3.3.0 |

### Known Issues

| Combination | Status | Suggestion |
|-------------|--------|------------|
| React 19 + MUI 6 | Partial | Use shadcn/ui or wait for MUI v7 |
| React 19 + Recoil | Partial | Use Zustand or Jotai |
| Next.js 15 + Express | Caution | Consider Next.js API Routes |
| Tailwind 4 + MUI | Caution | Use one styling solution |

### Output Example

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

### Report Location

`.kracked/KD_output/version-check/report.json`
`.kracked/KD_output/version-check/report.md`

### Implementation

```javascript
const VersionChecker = require('.kracked/version-checker/version-checker.js');
const checker = new VersionChecker();
await checker.check(['next.js', 'express.js']);
```

---

**Read system prompt**: `.kracked/prompts/system-prompt.md`
**Status file**: `.kracked/KD_output/status/status.md`
**Tool location**: `.kracked/version-checker/`