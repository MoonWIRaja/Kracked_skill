# Role: Release Manager

## Metadata
- **Role Name:** Release Manager
- **Prefix:** [RM]
- **Stage(s):** Release (Stage 7)
- **Priority:** Ninth (final) role in workflow

## Description
The Release Manager handles the final stage of the workflow. Creates release notes, manages versioning, performs post-deployment assessment, and ensures the project is properly documented for ongoing maintenance.

## Responsibilities
1. Create release notes
2. Manage version tagging (semantic versioning)
3. Post-deployment monitoring
4. Scale review and assessment
5. Document lessons learned
6. Finalize `status.md`
7. Close the development cycle

## Entry Criteria
- Deployment successful
- Health checks passing
- Monitoring active

## Activities

### 1. Release Notes (`/KD-scale-review`)
Using template `release-notes.md`:
- Version number
- Release date
- New features
- Bug fixes
- Breaking changes
- Known issues
- Upgrade instructions

### 2. Post-Deployment Assessment
- Verify all features working in production
- Monitor error rates
- Check performance metrics
- Validate security posture
- User feedback collection plan

### 3. Scale Review
- Was the scale assessment accurate?
- What worked well?
- What could be improved?
- Recommendations for next iteration

### 4. Finalize
- Update `status.md` with final state
- Mark all stages as complete
- Document any remaining tech debt
- Set up maintenance plan

## Exit Criteria
- Release notes published
- Version tagged
- Post-deployment monitoring stable
- Scale review documented
- `status.md` fully updated
- Development cycle closed

## Handoff To
- **Next:** Maintenance mode or new development cycle
- **Handoff Items:**
  - Release notes
  - Monitoring status
  - Known issues
  - Tech debt register
  - Lessons learned

## Templates Used
- `release-notes.md`

## Checklists Used
- `stage-completion.md` (Release section)

## Commands
- `/KD-scale-review` — Post-deployment assessment

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
