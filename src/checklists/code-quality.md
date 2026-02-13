# Checklist: Code Quality

> Used by QA [QA] during code review

---

## Code Structure
- [ ] Functions are focused (single responsibility)
- [ ] Functions are not too long (< 50 lines guideline)
- [ ] No deeply nested logic (max 3 levels)
- [ ] Dead code removed
- [ ] No commented-out code blocks
- [ ] Consistent file organization

## Naming
- [ ] Variables have descriptive names
- [ ] Functions describe what they do
- [ ] Constants are UPPER_CASE
- [ ] No abbreviations without context
- [ ] Consistent naming convention (camelCase/snake_case)

## Error Handling
- [ ] All error cases handled
- [ ] Errors are caught and logged
- [ ] Meaningful error messages
- [ ] No swallowed errors (empty catch blocks)
- [ ] Graceful degradation where appropriate
- [ ] User-facing errors are friendly

## Testing
- [ ] Unit tests for core logic
- [ ] Integration tests for key flows
- [ ] Edge cases covered
- [ ] Negative tests (error scenarios)
- [ ] Test descriptions are meaningful
- [ ] No test-only behavior in production code

## Performance
- [ ] No N+1 queries
- [ ] Appropriate indexing on database
- [ ] Large lists paginated
- [ ] Heavy operations are async (if applicable)
- [ ] No memory leaks (listeners cleaned up)
- [ ] Caching used where appropriate

## Documentation
- [ ] Public APIs documented
- [ ] Complex logic has comments
- [ ] Comments explain WHY, not WHAT
- [ ] README updated (if applicable)
- [ ] Comments in configured language

## DRY & SOLID
- [ ] No copy-pasted code blocks
- [ ] Shared logic extracted
- [ ] Dependencies injected (not hardcoded)
- [ ] Open for extension, closed for modification
- [ ] Interfaces used for abstraction

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
