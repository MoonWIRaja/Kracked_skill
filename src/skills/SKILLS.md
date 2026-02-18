# ══════════════════════════════════════════════════════════
# DEVSTACK — Master Skill Library v2.0
# Curated Skills for Kracked_Skills
# ══════════════════════════════════════════════════════════
#
# 15 production-grade skills covering all domains.
# Each skill provides domain knowledge only.
#
# ══════════════════════════════════════════════════════════

## Table of Contents

| # | Skill Name | Domain | Scope |
|---|------------|---------|-------|
| 1 | Supabase Postgres | Backend Structure | Project-wide |
| 2 | Insecure Defaults | Backend Security | Dev, QA |
| 3 | React & Next.js | Frontend Core | Project-wide |
| 4 | Premium Design System | UI/UX + Library | Project-wide |
| 5 | Web Performance | Production Optimization | Project-wide |
| 6 | Code Review | Code Quality | Global |
| 7 | PWA & Service Workers | Offline-First PWA | Architect, Dev |
| 8 | Testing & QA | Quality Assurance | Dev, QA |
| 9 | Animations & Components | Motion + Icons | Dev |
| 10 | Recursive Decomposition | Token Optimization | Global |
| 11 | API Design | REST/GraphQL | Architect, Dev |
| 12 | DevOps & Deployment | CI/CD, Infrastructure | DevOps |
| 13 | Game Development | Games, Game Engines | Game Dev |
| 14 | Mobile Development | iOS, Android | Mobile Dev |
| 15 | Documentation | Tech Writing | All Roles |

---

## Role Activation Map

```
┌────────────────┬─────────────────────────────────────────────────┐
│ Role           │ Skills That Load                                │
├────────────────┼─────────────────────────────────────────────────┤
│ Analyst        │ 6, 10, 15                                       │
│ PM             │ 6, 10, 15                                       │
│ Architect      │ 1, 3, 4, 5, 6, 7, 10, 11, 12                   │
│ Tech Lead      │ 1, 3, 4, 5, 6, 10, 11, 15                      │
│ Engineer       │ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 15          │
│ QA             │ 2, 5, 6, 8, 10, 15                              │
│ Security       │ 2, 6, 10                                        │
│ DevOps         │ 5, 6, 7, 10, 12, 15                             │
│ Mobile Dev     │ 3, 4, 6, 8, 9, 10, 14, 15                       │
│ Game Dev       │ 6, 8, 10, 13, 15                                │
│ UX Designer    │ 4, 6, 9, 10, 15                                 │
│ Release Mgr    │ 6, 10, 12, 15                                   │
└────────────────┴─────────────────────────────────────────────────┘
```

---

## Skill Files Location

```
.kracked/skills/
├── SKILLS.md                    ← This file (index)
├── 01-supabase-postgres.md     ← Backend, Database
├── 02-insecure-defaults.md     ← Security
├── 03-react-nextjs.md          ← Frontend
├── 04-premium-design-system.md ← UI/UX
├── 05-web-perf.md              ← Performance
├── 06-code-review.md           ← Quality
├── 07-pwa-service-worker.md    ← PWA
├── 08-testing-qa.md            ← Testing ← NEW
├── 09-animations-components.md ← Animations
├── 10-recursive-decomposition.md ← Optimization
├── 11-api-design.md            ← APIs ← NEW
├── 12-devops-deployment.md     ← DevOps ← NEW
├── 13-game-development.md      ← Games ← NEW
├── 14-mobile-development.md    ← Mobile ← NEW
└── 15-documentation.md         ← Docs ← NEW
```

---

## Quick Reference

### Skill 1: Supabase Postgres
- **When:** Designing database schemas, writing SQL, creating migrations
- **Key:** Row Level Security, indexing strategies, query optimization

### Skill 2: Insecure Defaults Detection
- **When:** Writing auth, config, crypto, API keys, CORS
- **Key:** Hardcoded secrets, weak crypto, permissive defaults

### Skill 3: React & Next.js
- **When:** Building components, data fetching, App Router
- **Key:** Server vs Client components, hydration, dynamic imports

### Skill 4: Premium Design System
- **When:** Design decisions, UI components, typography, colors
- **Key:** Anti-generic aesthetics, library discipline, visual hierarchy

### Skill 5: Web Performance
- **When:** Optimizing load times, Core Web Vitals
- **Key:** LCP, INP, CLS optimization, resource hints

### Skill 6: Code Review
- **When:** Reviewing code changes, quality checks
- **Key:** Correctness, security, performance, maintainability

### Skill 7: PWA & Service Workers
- **When:** Building PWA manifests, service workers
- **Key:** Caching strategies, offline support, background sync

### Skill 8: Testing & QA ← NEW
- **When:** Writing tests, QA activities
- **Key:** Unit, Integration, E2E, TestSprite

### Skill 9: Animations & Components
- **When:** UI animations, icon libraries
- **Key:** Framer Motion, Lucide icons, micro-interactions

### Skill 10: Recursive Decomposition
- **When:** Large codebases, context limits
- **Key:** Task decomposition, context loading, summarization

### Skill 11: API Design ← NEW
- **When:** Designing REST/GraphQL APIs
- **Key:** Resource naming, status codes, versioning, security

### Skill 12: DevOps & Deployment ← NEW
- **When:** CI/CD, deployment planning
- **Key:** GitHub Actions, Docker, monitoring, rollback

### Skill 13: Game Development ← NEW
- **When:** Building games
- **Key:** Game engines, GDD, game patterns, performance

### Skill 14: Mobile Development ← NEW
- **When:** iOS/Android apps
- **Key:** React Native, Flutter, platform guidelines, deployment

### Skill 15: Documentation ← NEW
- **When:** Writing docs
- **Key:** README, API docs, changelog, diagrams

---

## By Stage

| Stage | Skills |
|-------|--------|
| 1. Discovery | 6, 10, 15 |
| 2. Ideation | 6, 10, 15 |
| 3. Requirements | 6, 10, 15 |
| 4. Architecture | 1, 3, 4, 5, 6, 7, 10, 11, 12, 15 |
| 5. Planning | 1, 3, 6, 10, 15 |
| 6. Implementation | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 15 |
| 7. Testing | 2, 5, 6, 8, 10, 15 |
| 8. Quality | 2, 6, 8, 10, 15 |
| 9. Deployment | 5, 6, 10, 12, 15 |
| 10. Release | 6, 10, 12, 15 |

---

# ══════════════════════════════════════════════════════════
# DEVSTACK v2.0 — 15 Skills for Complete Development
# ══════════════════════════════════════════════════════════