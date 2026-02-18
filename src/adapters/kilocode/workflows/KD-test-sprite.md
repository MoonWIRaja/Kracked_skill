---
name: 'KD-test-sprite'
description: 'TestSprite: Automated visual and functional testing'
disable-model-invocation: true
---

Read the full system prompt at .kracked/prompts/system-prompt.md and follow the instructions for the /KD-test-sprite command exactly as written.
If specific instructions for this command are not in the system prompt, infer the intent from the command name (TestSprite: Automated visual and functional testing) and execute accordingly.

## TestSprite Integration
**Purpose**: Automated visual and functional testing system

### Features
1. Visual Regression Testing
2. Functional Testing
3. Performance Testing
4. Accessibility Testing
5. Cross-browser Testing

### Usage
```bash
/KD-test-sprite --url=http://localhost:3000
```

### Output
- Visual regression reports
- Functional test results
- Performance metrics
- Accessibility audit (WCAG 2.1)
- Cross-browser compatibility

### Reports Location
`.kracked/testsprite/reports/`
- `latest.json` - JSON report
- `latest.md` - Markdown report
- `latest.html` - HTML report

**Status file**: `.kracked/KD_output/status/status.md`