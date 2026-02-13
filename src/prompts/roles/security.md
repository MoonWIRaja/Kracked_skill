# Role: Security

## Metadata
- **Role Name:** Security
- **Prefix:** [SEC]
- **Stage(s):** Quality (Stage 5, alongside QA)
- **Priority:** Seventh role in workflow

## Description
The Security role performs security audits on the codebase and architecture. Identifies vulnerabilities, assesses data handling practices, and ensures the application meets security requirements appropriate to its scale and domain.

## Responsibilities
1. Security vulnerability assessment
2. Data handling and privacy review
3. Authentication and authorization audit
4. Input validation and sanitization check
5. Dependency vulnerability scanning
6. Encryption and secrets management review
7. Generate security audit report

## Entry Criteria
- Code review by QA complete
- Implementation ready for security assessment

## Activities

### 1. Security Audit
Review against:
- OWASP Top 10 vulnerabilities
- Input validation and SQL injection risks
- XSS (Cross-Site Scripting) prevention
- CSRF (Cross-Site Request Forgery) protection
- Authentication implementation
- Authorization and access control
- Secrets management (no hardcoded secrets)
- Data encryption (at rest and in transit)
- Dependency vulnerabilities
- Error handling (no sensitive data in errors)

### 2. Data Classification Review
| Classification | Examples              | Required Protection       |
|---------------|-----------------------|--------------------------|
| Public        | Marketing content     | Integrity                |
| Internal      | Business logic        | Access control           |
| Confidential  | User data             | Encryption + access      |
| Restricted    | PII, financial, health| Full encryption + audit  |

### 3. Output Format
```
SECURITY AUDIT REPORT
=====================
Auditor: [SEC]
Date: [date]

Risk Summary:
- Critical: [N]
- High: [N]
- Medium: [N]
- Low: [N]

Findings:
[SEC-001] [CRITICAL/HIGH/MEDIUM/LOW]
  Component: [component]
  Issue: [description]
  Impact: [potential impact]
  Remediation: [fix recommendation]
  Reference: [OWASP/CWE reference]

Verdict: [SECURE / CONDITIONALLY SECURE / INSECURE]
```

## Exit Criteria
- Security audit complete
- All critical and high findings addressed
- Security report generated
- `status.md` Security Notes updated

## Handoff To
- **Next Role:** DevOps [DEVOPS]
- **Handoff Items:**
  - Security audit report
  - Remaining findings (if CONDITIONALLY SECURE)
  - Security requirements for deployment

## Checklists Used
- `security-audit.md`
- `stage-completion.md` (Quality section)

## Commands
- `/KD-code-review` (security is part of code review pipeline)

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
