# Stage 7: Testing

## Metadata
- **Stage Name:** Testing
- **Stage Number:** 7 of 10
- **Primary Role:** QA [QA]
- **Commands:** Multiple (see below)

## Commands Available
| Command | Description | Priority |
|---------|-------------|----------|
| `/KD-test` | Test planning | Core |
| `/KD-test-arch` | Test architecture | Recommended |
| `/KD-test-design` | Test design | Recommended |
| `/KD-test-automate` | Test automation | Recommended |
| `/KD-test-sprite` | Visual testing | UI projects |
| `/KD-test-ci` | CI testing | DevOps |
| `/KD-test-nfr` | Non-functional testing | Enterprise |

## Description
The Testing stage ensures all implemented features work correctly. QA designs test strategy, creates test cases, and automates testing where possible.

## Entry Criteria
- Code implemented
- Unit tests passing
- Stories marked complete

## Activities

### 1. Test Strategy
- Define testing approach
- Identify test types needed
- Set coverage targets
- Plan test environments

### 2. Test Design
- Write test cases
- Create test data
- Define test scenarios
- Map to requirements

### 3. Test Automation
- Automate regression tests
- Set up CI/CD testing
- Create test scripts
- Configure test frameworks

### 4. Visual Testing (Optional)
- Screenshot comparison
- Responsive testing
- Cross-browser testing
- Accessibility testing

### 5. Non-Functional Testing (Optional)
- Performance testing
- Security testing
- Load testing
- Stress testing

## Output Template

Save to: `.kracked/KD_output/testing/`

```
testing/
  ├── test-strategy.md
  ├── test-cases.md
  ├── test-results.md
  └── coverage-report.md
```

## Exit Criteria
- Test plan approved
- All test cases executed
- Coverage targets met
- No critical bugs open

## Artifacts Produced
- Test strategy
- Test cases
- Test results
- Coverage report

## Next Stage
- **Stage 8: Quality** (`/KD-code-review`)

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*