# Roles Index — KD v5.0.0

## Available Roles (16)

| Role | Prefix | Skills | Focus |
|------|--------|--------|-------|
| Analyst | [ANA] | 6, 10 | Research, Analysis |
| PM | [PM] | 6, 10 | Product, Requirements |
| Architect | [ARCH] | 1, 3, 4, 5, 6, 7, 10 | System Design |
| Tech Lead | [TL] | 1, 3, 4, 5, 6, 10 | Technical Direction |
| Engineer | [DEV] | 1, 2, 3, 4, 5, 6, 7, 9, 10 | Implementation |
| QA | [QA] | 1, 2, 3, 4, 5, 6, 10 | Testing, Quality |
| Security | [SEC] | 2, 6, 10 | Security, Compliance |
| DevOps | [DEVOPS] | 5, 6, 7, 10 | CI/CD, Infrastructure |
| Release Manager | [RM] | 6, 10 | Releases, Deployment |
| UX Designer | [UX] | 4, 6, 10 | User Experience |
| Data Scientist | [DS] | 6, 10 | Data, Analytics |
| DBA | [DBA] | 1, 6, 10 | Database |
| Mobile Dev | [MOB] | 3, 4, 6, 9, 10 | Mobile Apps |
| Scrum Master | [SM] | 6, 10 | Agile, Process |
| Solo Dev | [SOLO] | 1, 2, 3, 4, 5, 6, 7, 9, 10 | Full Stack |
| Tech Writer | [TW] | 6, 10 | Documentation |

## Activation

```
/KD-role-[name]
```

## Role Details Location

```
.kracked/prompts/roles/[role-name].md
```

## Rules

1. Single role active at a time
2. Load associated skills on activation
3. Update status when switching roles

---
*Load role details on demand*