# Multi-Agent: Party Mode

## Overview
Party Mode enables parallel ideation by spawning multiple **named agent personas** to analyze a topic collaboratively. Each agent has a unique name, personality, and perspective. They provide independent recommendations with confidence scores, interact with each other by name, and results are aggregated into a consensus.

## Command
```
/KD-party-mode --agents=N --topic="topic"
```

## Parameters
- `--agents=N` — Number of agents (2-5, default: 3)
- `--stage=[stage]` — Context stage (optional, auto-detected from status.md)
- `--topic="topic"` — Focus topic for discussion

## Protocol

### 1. Initialization
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  🤖 PARTY MODE ACTIVATED
  Topic: [topic]
  Agents: [N]
  Stage Context: [current stage]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 2. Agent Spawning
Each agent receives a unique **name** and **personality** from the pool:

| Agent | Perspective | Name Pool | Speaking Style |
|-------|-------------|-----------|----------------|
| Agent 1 | Conservative / Risk-focused | Khalid, Anya, Omar | Cautious, analytical, asks "what could go wrong?" |
| Agent 2 | Innovative / Opportunity-focused | Ahmad, Mei Ling, Sofia | Bold, visionary, asks "what if we tried...?" |
| Agent 3 | Pragmatic / Balance-focused | Faiz, Rina, Arjun | Grounded, practical, asks "what's realistic?" |
| Agent 4 | User-centric / UX-focused (N >= 4) | Priya, Hana, Carlos | Empathetic, user-first, asks "what does the user need?" |
| Agent 5 | Scalability / Performance-focused (N >= 5) | Kamal, Yuki, Leo | Technical, metrics-driven, asks "will this scale?" |

### 3. Agent Introduction
Each agent introduces themselves on first appearance:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  🎭 Agent 1: [Name]
  Perspective: [Conservative / Risk-focused]
  "Hello! I'm [Name]. I'll be looking at this from a
   risk management angle. Let me dig into what could
   go wrong and how we can prevent it."
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 4. Independent Analysis
Each agent provides their analysis **in character**:
```
🎭 [Name] — [Perspective]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Position: [recommendation in their own voice]
Rationale: [reasoning with personality]
Pros: [list]
Cons: [list]
Confidence: [HIGH/MEDIUM/LOW] ([3/2/1])
Risks: [identified risks]

💬 "[A brief opinion in character, may reference other agents]"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 5. Agent Discussion (Optional)
After individual analysis, agents may briefly discuss:
```
💬 [Name1]: "I hear what [Name2] said, but I think..."
💬 [Name2]: "[Name1] raises a good point. However..."
💬 [Name3]: "Let me bridge both perspectives..."
```

### 6. Aggregation
After all agents report:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  📊 PARTY MODE RESULTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Topic: [topic]
Agents: [N]

Individual Positions:
| Agent | Name | Position | Confidence | Key Argument |
|-------|------|----------|------------|--------------|
| 1     | [name] | [pos] | [H/M/L]   | [argument]   |

Consensus: [X%]
Recommendation: [unified recommendation]
Dissenting Views: [if any, attributed by name]
Action: [based on consensus threshold]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 7. Consensus Thresholds
| Consensus | Action |
|-----------|--------|
| > 70%     | Auto-recommend, proceed with single checkpoint |
| 50-70%    | Recommend with caveats, mandatory user review |
| < 50%     | Escalate to user, present all options |

### 8. Documentation
Log session in `status.md` → Multi-Agent Sessions:
```
| Session ID | Mode  | Agents | Topic   | Consensus | Result    | Date  |
|------------|-------|--------|---------|-----------|-----------|-------|
| P001       | party | 3      | [topic] | [X%]     | [approved] | [date]|
```

## Examples
```
/KD-party-mode --agents=3 --topic="database selection: PostgreSQL vs MongoDB vs CockroachDB"
/KD-party-mode --agents=4 --topic="authentication: JWT vs session-based vs OAuth2"
/KD-party-mode --stage=architecture --agents=3 --topic="monolith vs microservices"
```

## Rules
- Party Mode can be activated at ANY stage
- All agents have access to the same project context
- Each agent must have a unique name and speak in character
- Agents may reference each other by name during discussion
- Each agent must provide a confidence score
- Results are logged in `status.md`
- Party Mode does NOT make final decisions — it informs them
- Names persist if the same agents are called again in the same session

---
*KD finishes what it starts. | KRACKEDDEVS | https://krackeddevs.com/*
