---
name: deployment-plan
description: Stage 6 - Deployment strategy and infrastructure setup
params:
  - name: env
    description: Deployment environment (staging|production)
    required: false
    default: staging
---

# Stage 6: Deployment

## Active Role: DEVOPS

KRACKED deployment phase - infrastructure setup, CI/CD, monitoring, and rollout strategy.

## Parameters

- `--env=staging`: Staging environment deployment
- `--env=production`: Production environment deployment (requires extra validation)

## Process

### 1. Decision Validation (Required for Production)

```
┌────────────────────────────────────────────────────────────┐
│ DECISION VALIDATION: DEPLOYMENT                         │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Environment: [staging|production]                       │
│                                                         │
│ Security Assessment:                                    │
│   Data Classification: [PUBLIC|INTERNAL|CONFIDENTIAL]   │
│   Threats Considered: [list]                          │
│   Mitigations: [how addressed]                          │
│                                                         │
│ Deployment:                                           │
│   Risk: [Low|Medium|High]                              │
│   Rollback Strategy: [specific steps]                   │
│   Monitoring: [what to watch]                            │
│                                                         │
│ Recommendation: [Proceed/Proceed with Caution]          │
└────────────────────────────────────────────────────────────┘
```

### 2. Create Deployment Plan

Create `docs/deployment.md`:

```markdown
# Deployment Plan

## Environment: [staging|production]
## Date: [date]

## Infrastructure

### Hosting
- Provider: [AWS/GCP/Azure/other]
- Region: [region]
- Services: [list]

### CI/CD Pipeline
- Platform: [GitHub Actions/GitLab CI/other]
- Stages: [build, test, deploy]
- Triggers: [main branch, tags]

### Environment Configuration
- Variables: [list with sensitivity]
- Secrets: [management method]

## Deployment Strategy

### Staging
- Strategy: [Continuous deployment]
- Frequency: [On merge to main]
- Approval: [None/auto]

### Production
- Strategy: [Blue-Green/Canary/Rolling]
- Steps: [detailed rollout]
- Rollback: [procedure]

## Monitoring

### Health Checks
- Endpoint: [url]
- Frequency: [interval]
- Conditions: [pass criteria]

### Logging
- Platform: [CloudWatch/other]
- Retention: [period]
- Alerts: [conditions]

### Metrics
- Business: [key metrics]
- Technical: [performance, errors]
- Dashboards: [links]

## Rollback Plan

### Triggers
- Error rate > [threshold]
- Response time > [threshold]
- [other conditions]

### Procedure
1. [Step 1]
2. [Step 2]
3. [Verify rollback success]

## Deployment Checklist

### Pre-Deployment
- [ ] All tests pass
- [ ] Security scan clean
- [ ] Dependencies updated
- [ ] Database migrations prepared
- [ ] Rollback tested

### Post-Deployment
- [ ] Health checks passing
- [ ] Monitoring active
- [ ] No errors in logs
- [ ] Key metrics normal
```

### 3. Update status.md

```markdown
## Deployment State
- Environment: [staging|production]
- Last Deploy: [datetime]
- Status: [pending|deployed|failed|rolledback]
- Version: [version/tag]

## Monitoring State
- Health Check: [url]
- Logs: [url]
- Alerts: [configured items]
- Dashboard: [url]
```

## Exit Criteria

- [ ] Deployment tested (staging)
- [ ] Monitoring active
- [ ] Rollback validated
- [ ] Rollback strategy documented

## User Actions

[DEPLOY] - Execute deployment
[APPROVE] - Approve deployment plan
[SHOW] - Show deployment details
