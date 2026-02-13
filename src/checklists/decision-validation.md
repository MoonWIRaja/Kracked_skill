# Checklist: Decision Validation

> Used by Architect [ARCH] when running Decision Validation Blocks

---

## Before Making Decision
- [ ] Problem clearly stated
- [ ] At least 3 options considered
- [ ] Each option has documented pros and cons
- [ ] Alignment with PRD checked
- [ ] Alignment with existing architecture checked

## During Validation
- [ ] Impact assessment completed (performance, security, scalability, maintainability, cost)
- [ ] Confidence score assigned (HIGH/MEDIUM/LOW)
- [ ] Reversibility assessed (easy/moderate/difficult)
- [ ] Risks identified
- [ ] Mitigations proposed for each risk

## After Decision
- [ ] Decision documented in `status.md` → Architecture Decisions
- [ ] Rationale clearly explained
- [ ] Decision communicated to user (if HIGH impact)
- [ ] Decision ID assigned (DV-XXX)

## Validation Thresholds
- **HIGH Confidence + Easy Reversibility:** Proceed immediately
- **MEDIUM Confidence:** Document caveats, proceed with monitoring
- **LOW Confidence:** Consult user before proceeding
- **Difficult Reversibility:** Mandatory user review regardless of confidence

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
