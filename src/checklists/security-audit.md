# Checklist: Security Audit

> Used by Security [SEC] role during Quality stage

---

## OWASP Top 10
- [ ] A01: Broken Access Control
- [ ] A02: Cryptographic Failures
- [ ] A03: Injection
- [ ] A04: Insecure Design
- [ ] A05: Security Misconfiguration
- [ ] A06: Vulnerable and Outdated Components
- [ ] A07: Identification and Authentication Failures
- [ ] A08: Software and Data Integrity Failures
- [ ] A09: Security Logging and Monitoring Failures
- [ ] A10: Server-Side Request Forgery (SSRF)

## Input Validation
- [ ] All user inputs validated
- [ ] SQL injection prevention (parameterized queries)
- [ ] XSS prevention (output encoding)
- [ ] CSRF protection (tokens)
- [ ] File upload validation (if applicable)
- [ ] Rate limiting on sensitive endpoints

## Authentication
- [ ] Strong password policy enforced
- [ ] Secure session management
- [ ] MFA support (if required)
- [ ] Brute force protection
- [ ] Secure password storage (bcrypt/argon2)

## Authorization
- [ ] Principle of least privilege
- [ ] Role-based access verified
- [ ] No horizontal privilege escalation
- [ ] No vertical privilege escalation
- [ ] Resource ownership validated

## Data Protection
- [ ] Data encrypted in transit (TLS 1.2+)
- [ ] Sensitive data encrypted at rest
- [ ] No sensitive data in logs
- [ ] No sensitive data in error messages
- [ ] No sensitive data in URLs
- [ ] PII handling compliant with requirements

## Secrets Management
- [ ] No hardcoded secrets in code
- [ ] No secrets in version control
- [ ] Environment variables used correctly
- [ ] API keys properly scoped
- [ ] Secrets rotation plan documented

## Dependencies
- [ ] Dependencies scanned for known vulnerabilities
- [ ] No deprecated packages
- [ ] Lock file present (package-lock.json, etc.)
- [ ] Minimal dependency surface

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
