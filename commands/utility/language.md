---
name: language
description: Display or change language setting (EN=English, MS=Bahasa Melayu)
params:
  - name: lang
    description: Language code (EN or MS)
    required: false
---

# Language Command

## Current Language Check

Read `status.md` and display the current language setting.

```
┌────────────────────────────────────────────────────────────┐
│ 🌐 CURRENT LANGUAGE SETTING                             │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Language: [English | Bahasa Melayu]                   │
│ Code: [EN | MS]                                        │
│                                                         │
│ To change: /language [EN|MS]                          │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

## Language Change Request

If user provides a language parameter:

1. Read current language from `status.md`
2. Display change request prompt:

```
┌────────────────────────────────────────────────────────────┐
│ ⚠️ LANGUAGE CHANGE REQUEST                              │
├────────────────────────────────────────────────────────────┤
│                                                         │
│ Current: [current language]                             │
│ Requested: [new language]                               │
│                                                         │
│ Impact:                                                │
│   • Existing artifacts stay in original language       │
│   • New artifacts use new language                     │
│   • May create documentation inconsistency            │
│                                                         │
│ [1] Keep current | [2] New project | [3] Proceed        │
│                                                         │
└────────────────────────────────────────────────────────────┘
```

3. If user confirms, update `status.md`:

```markdown
## Meta
- Language: [EN|MS]
```

4. Confirm change and remind about language rules.

## Language Rules Reminder

- Conversations: Selected language
- Code: Always English
- Code comments: Selected language
- Technical terms: English (no translation)
