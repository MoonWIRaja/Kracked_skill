# Stage 7: Release

## Metadata
- **Stage Name:** Release
- **Stage Number:** 7
- **Primary Role:** Release Manager [RM]
- **Commands:** `/KD-scale-review`

## Description
The Release stage is the final stage of the KD workflow. The Release Manager creates release documentation, performs post-deployment assessment, and closes the development cycle.

## Entry Criteria
- Deployment successful
- Health checks passing
- Monitoring active

## Activities

### 1. Release Notes
Create using template `release-notes.md`:
- Version number (semantic versioning)
- Release date
- Feature summary
- Bug fixes
- Breaking changes
- Known issues
- Upgrade instructions

### 2. Post-Deployment Assessment
- Feature verification in production
- Error rate monitoring
- Performance metrics review
- Security posture validation

### 3. Scale Review
- Was the scale assessment accurate?
- Process effectiveness assessment
- Lessons learned documentation
- Recommendations for next cycle

### 4. Finalization
- Mark all stages complete in `status.md`
- Document remaining tech debt
- Close development cycle

## Exit Criteria
- Release notes published
- Post-deployment assessment complete
- `status.md` fully updated
- Development cycle closed

## Artifacts Produced
- `release-notes.md`
- Final `status.md`

## Checkpoint Required
- No

## Next Stage
- Maintenance mode or new development cycle

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
