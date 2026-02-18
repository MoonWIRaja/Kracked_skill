---
name: 'KD-tool-selector'
description: 'Intelligent tool and technology selector'
disable-model-invocation: true
---

Read the full system prompt at .kracked/prompts/system-prompt.md and follow the instructions for the /KD-tool-selector command exactly as written.
If specific instructions for this command are not in the system prompt, infer the intent from the command name (Intelligent tool and technology selector) and execute accordingly.

## Context-Aware Technology Recommendations
**Purpose**: Analyzes project context and recommends optimal technologies

### Features
1. Frontend Framework Selection
2. Backend Framework Selection
3. Database Selection
4. Additional Tools Selection
5. Full Stack Recommendation

### Usage
```bash
/KD-select-stack --type=web --scale=medium --team=5 --timeline=12 --expertise=javascript,react
```

### Analysis Criteria
- Team Expertise
- Learning Curve
- Ecosystem
- Performance
- Scalability
- Community
- Job Market
- Project Suitability

### Output
- Recommended tech stack with scores
- Alternative options
- Detailed reasoning
- Confidence score

### Report Location
`.kracked/KD_output/architecture/tech-stack-recommendation.md`

**Status file**: `.kracked/KD_output/status/status.md`