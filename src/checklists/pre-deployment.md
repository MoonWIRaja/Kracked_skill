# Checklist: Pre-Deployment

> Used by DevOps [DEVOPS] before any deployment

---

## Code Readiness
- [ ] All features implemented
- [ ] All tests passing
- [ ] Code review verdict: PASS
- [ ] Security audit verdict: SECURE
- [ ] No critical bugs open
- [ ] Build succeeds without warnings

## Environment
- [ ] Target environment configured
- [ ] Environment variables set
- [ ] Secrets configured in vault/env
- [ ] SSL certificates valid
- [ ] DNS configured
- [ ] Database accessible

## Database
- [ ] Migration scripts tested
- [ ] Rollback migration tested
- [ ] Data backup created
- [ ] No destructive migrations without review

## Monitoring
- [ ] Health check endpoints ready
- [ ] Monitoring dashboards configured
- [ ] Alert thresholds set
- [ ] Error tracking enabled
- [ ] Log aggregation configured

## Deployment
- [ ] Deployment script/pipeline tested
- [ ] Rollback procedure documented
- [ ] Deployment window communicated
- [ ] Team notified

## Post-Deployment Verification
- [ ] Health checks passing
- [ ] Key user flows tested
- [ ] Error rates nominal
- [ ] Performance metrics acceptable
- [ ] Monitoring active

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
