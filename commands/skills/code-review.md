---
name: code-review
description: Stage 5 - Quality and security code review
params:
  - name: scope
    description: Review scope (full|diff)
    required: false
    default: full
  - name: severity
    description: Review strictness (strict|normal)
    required: false
    default: normal
---

# Stage 5: Quality & Security

## Active Role: QA → SECURITY

KRACKED quality phase - comprehensive testing and security audit.

## Parameters

- `--scope=full`: Review entire codebase
- `--scope=diff`: Review only changed files
- `--severity=strict`: Critical review with zero tolerance
- `--severity=normal`: Standard review

## Process

### 1. QA: Quality Review

#### Test Coverage

- Verify all user stories have tests
- Check edge case coverage
- Validate error handling tests

#### Code Quality

- Review for bugs and logic errors
- Check for security vulnerabilities
- Assess adherence to project conventions
- Identify technical debt

#### Output Format

```
┌────────────────────────────────────────────────────────────┐
│ 🔍 QUALITY REVIEW REPORT                             │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Scope: [full|diff]                                     │
│ Files Reviewed: [count]                                 │
│ Lines of Code: [count]                                  │
│                                                         │
├────────────────────────────────────────────────────────────┤
│ TEST COVERAGE                                         │
├────────────────────────────────────────────────────────────┤
│ Overall Coverage: [X]%                                  │
│ Critical Files Coverage: [X]%                            │
│                                                         │
├────────────────────────────────────────────────────────────┤
│ ISSUES FOUND                                          │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Critical: [count]                                       │
│ High: [count]                                          │
│ Medium: [count]                                        │
│ Low: [count]                                           │
│                                                         │
│ [Detailed issue list with locations]                      │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

### 2. Security: Security Audit

#### Vulnerability Check

- SQL injection vulnerabilities
- XSS vulnerabilities
- Authentication/authorization issues
- Data exposure risks
- Dependency vulnerabilities

#### Security Report

```
┌────────────────────────────────────────────────────────────┐
│ 🛡️ SECURITY AUDIT REPORT                              │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Vulnerabilities Found: [count]                            │
│                                                         │
├────────────────────────────────────────────────────────────┤
│ CRITICAL VULNERABILITIES                              │
├────────────────────────────────────────────────────────────┤
│ [List if any]                                          │
│                                                         │
├────────────────────────────────────────────────────────────┤
│ SECURITY RECOMMENDATIONS                               │
├────────────────────────────────────────────────────────────┤
│ [List of improvements]                                  │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

### 3. Update status.md

```markdown
## Completed Stages
| Stage | Status | Completed | Key Artifact |
|-------|--------|-----------|--------------|
| ... | ... | ... | ... |
| Quality | ✅ | [date] | code-review-report.md |

## Known Issues
| ID | Issue | Severity | Workaround | Status |
|----|-------|----------|------------|--------|
```

## Exit Criteria

- [ ] No critical vulnerabilities
- [ ] No high-risk bugs
- [ ] Test coverage meets threshold
- [ ] All issues documented

## User Actions

[APPROVE] - Proceed to Deployment stage
[REVIEW] - Review detailed issues
[RETEST] - Request re-review after fixes
