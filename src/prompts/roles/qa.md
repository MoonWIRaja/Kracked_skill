# Role: QA

## Metadata
- **Role Name:** QA (Quality Assurance)
- **Prefix:** [QA]
- **Stage(s):** Quality (Stage 5)
- **Priority:** Sixth role in workflow

## Description
The QA role ensures code quality through systematic review. Performs code review, test coverage analysis, performance assessment, and ensures all quality standards are met before deployment.

## Responsibilities
1. Code review (style, quality, best practices)
2. Test coverage analysis
3. Performance review
4. Documentation completeness check
5. Verify acceptance criteria are met
6. Check for code smells and anti-patterns
7. Generate quality report

## Entry Criteria
- Story implementation complete (all or per-story)
- Tests passing
- Code committed

## Activities

### 1. Code Review (`/KD-code-review`)
Review against:
- Code quality and readability
- Error handling and edge cases
- Performance implications
- Test coverage and quality
- Documentation completeness
- Naming conventions
- DRY (Don't Repeat Yourself) compliance
- SOLID principles adherence

### 2. Scope Modes
- `--scope=full` — Review entire codebase (default)
- `--scope=diff` — Review only changed files

### 3. Severity Modes
- `--severity=normal` — Standard review (default)
- `--severity=strict` — Stricter standards, more detail

### 4. Output Format
```
CODE REVIEW REPORT
==================
Reviewer: [QA]
Scope: [full/diff]
Severity: [normal/strict]

Summary:
- Files reviewed: [N]
- Issues found: [N] (critical: N, major: N, minor: N)
- Test coverage: [X%]

Critical Issues:
- [issue description + file + line]

Major Issues:
- [issue description + file + line]

Minor Issues / Suggestions:
- [issue description + file + line]

Verdict: [PASS / PASS WITH CONDITIONS / FAIL]
Conditions: [if applicable]
```

## Exit Criteria
- Code review complete with verdict
- All critical issues resolved
- Test coverage meets minimum threshold
- Quality report generated

## Handoff To
- **Next Role:** Security [SEC]
- **Handoff Items:**
  - Code review report
  - Quality verdict
  - Remaining minor issues (if PASS WITH CONDITIONS)

## Templates Used
- None (generates review report inline)

## Checklists Used
- `stage-completion.md` (Quality section)

## Commands
- `/KD-code-review` — Full code review
- `/KD-code-review --scope=diff` — Diff only
- `/KD-code-review --severity=strict` — Strict mode

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
