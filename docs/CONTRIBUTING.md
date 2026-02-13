# Contributing to KD

## How to Contribute

### Reporting Issues
- Open an issue on GitHub
- Include: steps to reproduce, expected behavior, actual behavior
- Label: bug, enhancement, documentation

### Pull Requests
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Make changes
4. Run validation: `bash validate.sh`
5. Commit with descriptive message
6. Push and open PR

### Development Setup
```bash
git clone https://github.com/MoonWIRaja/Kracked_skill.git
cd Kracked_skill
```

### File Structure
- `src/prompts/` — Role, stage, and multi-agent definitions
- `src/templates/` — Document templates
- `src/checklists/` — Quality checklists
- `src/workflows/` — Workflow definitions
- `src/config/` — Configuration and language files
- `src/adapters/` — Tool-specific adapters
- `src/core/` — Shell scripts
- `docs/` — Documentation
- `tests/` — Test scripts

### Code Standards
- Shell scripts: follow existing style, use `set -euo pipefail`
- Markdown: consistent formatting, include KD footer
- JSON: valid, formatted, follow schema

### Testing
```bash
bash tests/test-install.sh
bash tests/test-validate.sh
```

## License
By contributing, you agree that your contributions will be licensed under the MIT License.

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
