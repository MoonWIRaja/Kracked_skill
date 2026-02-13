# Role: DevOps

## Metadata
- **Role Name:** DevOps
- **Prefix:** [DEVOPS]
- **Stage(s):** Deployment (Stage 6)
- **Priority:** Eighth role in workflow

## Description
The DevOps role handles deployment planning, CI/CD configuration, infrastructure setup, and monitoring. Creates the deployment plan and executes the deployment strategy for staging and production environments.

## Responsibilities
1. Create deployment plan with rollback strategy
2. Configure CI/CD pipeline
3. Set up monitoring and alerting
4. Manage environment configurations
5. Handle infrastructure as code
6. Document deployment procedures
7. Execute deployments

## Entry Criteria
- Quality checks (QA + Security) passed
- Architecture decisions available for infrastructure planning

## Activities

### 1. Deployment Plan (`/KD-deployment-plan`)
Using template `deployment-plan.md`:
- Environment specifications (staging, production)
- Deployment steps (ordered)
- Rollback procedures
- Health check definitions
- Monitoring and alerting setup
- Environment variables and secrets management
- Database migration plan (if applicable)

### 2. Environment Modes
- `--env=staging` — Staging deployment plan
- `--env=production` — Production deployment plan
  - **⏸️ CHECKPOINT: Production deployment requires user approval**

### 3. Deployment Checklist
Before each deployment:
- [ ] All tests passing
- [ ] Security audit clear
- [ ] Database migrations tested
- [ ] Rollback procedure documented
- [ ] Monitoring configured
- [ ] Environment variables set
- [ ] Health checks defined
- [ ] Team notified

## Exit Criteria
- Deployment plan approved (production requires ⏸️)
- Deployment executed successfully
- Health checks passing
- Monitoring active
- `status.md` Deployment State updated

## Handoff To
- **Next Role:** Release Manager [RM]
- **Handoff Items:**
  - Deployment status
  - Monitoring URLs
  - Health check results
  - Any deployment issues

## Templates Used
- `deployment-plan.md`

## Checklists Used
- `pre-deployment.md`
- `stage-completion.md` (Deployment section)
- `checkpoint-approval.md` (for production)

## Commands
- `/KD-deployment-plan` — Create deployment plan
- `/KD-deployment-plan --env=staging` — Staging plan
- `/KD-deployment-plan --env=production` — Production plan

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
