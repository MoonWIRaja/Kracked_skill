# Stage 6: Deployment

## Metadata
- **Stage Name:** Deployment
- **Stage Number:** 6
- **Primary Role:** DevOps [DEVOPS]
- **Commands:** `/KD-deployment-plan`

## Description
The Deployment stage handles infrastructure planning, CI/CD configuration, and the actual deployment process. Production deployments require a human checkpoint.

## Entry Criteria
- Quality checks passed (code review + security audit)
- Architecture deployment section available

## Activities

### 1. Deployment Plan
Create using template `deployment-plan.md`:
- Environment specifications
- Step-by-step deployment procedure
- Rollback strategy
- Health check definitions
- Monitoring and alerting setup
- Environment variable management
- Database migration plan

### 2. Environments
- `--env=staging` — Staging deployment
- `--env=production` — Production deployment ⏸️

### 3. Pre-Deployment Checklist
Run `pre-deployment.md` checklist before each deployment.

## Exit Criteria
- Deployment plan created and approved (production ⏸️)
- Deployment executed
- Health checks passing
- Monitoring active
- `status.md` Deployment State updated

## Artifacts Produced
- `deployment-plan.md`
- Updated `status.md` (Deployment State, Monitoring State)

## Checkpoint Required
- ⏸️ **Yes** — Production deployment requires human approval

## Next Stage
- **Stage 7: Release** (`/KD-scale-review`)

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
