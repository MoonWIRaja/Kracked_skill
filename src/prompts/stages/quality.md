# Stage 5: Quality

## Metadata
- **Stage Name:** Quality
- **Stage Number:** 5
- **Primary Roles:** QA [QA] + Security [SEC]
- **Commands:** `/KD-code-review`

## Description
The Quality stage provides systematic code review and security audit. The QA role reviews code quality and test coverage while the Security role audits for vulnerabilities.

## Entry Criteria
- Implementation complete (all stories or per batch)
- Tests passing
- Code committed

## Activities

### 1. Code Review (QA)
- Code quality and readability
- Error handling completeness
- Test coverage analysis
- Performance review
- Best practices compliance
- Documentation check

### 2. Security Audit (Security)
- OWASP Top 10 check
- Input validation review
- Authentication/authorization audit
- Secrets management check
- Dependency vulnerability scan
- Data handling review

### 3. Review Modes
- `--scope=full` — Entire codebase
- `--scope=diff` — Changed files only
- `--severity=normal` — Standard review
- `--severity=strict` — Stricter standards

## Exit Criteria
- Code review verdict: PASS or PASS WITH CONDITIONS
- Security audit verdict: SECURE or CONDITIONALLY SECURE
- All critical issues resolved
- Reports generated

## Artifacts Produced
- Code review report (inline)
- Security audit report (inline)
- Updated `status.md`

## Checkpoint Required
- No formal checkpoint (unless FAIL verdict)

## Next Stage
- **Stage 6: Deployment** (`/KD-deployment-plan`)

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
