---
name: kracked-language
description: |
  Language System for KRACKED supporting English (EN) and Bahasa Melayu (MS).

  Rules:
  - Language is set at project initialization
  - All conversations use selected language
  - CODE and TECHNICAL TERMS remain in English
  - Comments in code follow selected language preference
  - Documentation uses selected language
---

# KRACKED Language System

## Supported Languages

| Code    | Language        | Native Name      |
|---------|-----------------|------------------|
| EN      | English         | English          |
| MS      | Bahasa Melayu   | بهاس ملايو       |

## Language Rules

### 1. Conversation Language
- All prompts, responses, discussions use selected language
- Role transitions and handoffs use selected language
- Error messages and recovery prompts use selected language

### 2. Code Language (ALWAYS ENGLISH)
- Variable names: English
- Function names: English
- Class names: English
- API endpoints: English
- Database tables/columns: English
- File names: English

### 3. Code Comments
Follow selected language preference:

**Example (English):**
```javascript
// Validate user input before processing
function validateInput(data) {
  return data !== null;
}
```

**Example (Bahasa Melayu):**
```javascript
// Sahkan input pengguna sebelum diproses
function validateInput(data) {
  return data !== null;
}
```

### 4. Documentation
- Product Brief: Selected language
- PRD: Selected language
- Architecture docs: Selected language
- API Documentation: English (industry standard)
- Code comments: Selected language
- README.md: Selected language

### 5. Technical Terms
Keep in English when no common translation exists:
- "database", "API", "endpoint", "deployment", "cache", "authentication"

## Language Selection (New Project)

```
┌────────────────────────────────────────────────────────────┐
│ 🌐 LANGUAGE SELECTION                                   │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Please select your preferred language:                 │
│                                                         │
│   [EN] English                                          │
│       - All conversations in English                    │
│       - Code comments in English                        │
│       - Documentation in English                        │
│                                                         │
│   [MS] Bahasa Melayu                                    │
│       - Semua perbualan dalam Bahasa Melayu          │
│       - Kod dan istilah teknikal dalam Bahasa Inggeris  │
│       - Dokumentasi dalam Bahasa Melayu                │
│       - Komen kod dalam Bahasa Melayu                  │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

## Language Change Request

To change language mid-project:

```
┌────────────────────────────────────────────────────────────┐
│ ⚠️ LANGUAGE CHANGE REQUEST                              │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Current Language: [current]                           │
│ Requested Language: [new]                             │
│                                                         │
│ Impact Analysis:                                      │
│   • Existing artifacts will remain in original language │
│   • New artifacts will use new language               │
│   • This may create inconsistency                     │
│                                                         │
│ Recommendation:                                      │
│   [1] Continue with current language              │
│   [2] Create new project with preferred language  │
│   [3] Proceed with language change               │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

## Status.md Language Field

```markdown
# PROJECT STATUS

## Meta
- Project: [name]
- Language: [EN|MS]  ← LANGUAGE SETTING
- ...
```

## Multi-Agent Language
- All agents use the same selected language
- Aggregation and voting displays in selected language

## Translations Reference

| English | Bahasa Melayu |
|---------|----------------|
| Analyze | Analisis |
| Architecture | Seni Bina |
| Deploy | Pasang |
| Review | Semakan |
| Risk | Risiko |
| Stage | Peringkat |
| User Story | Cerita Pengguna |
| Artifact | Artifak |
| Deploy | Pasang |
| Monitor | Pantau |
| Release | Pelepasan |
