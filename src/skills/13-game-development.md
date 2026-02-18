# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# SKILL 13: GAME DEVELOPMENT
# Scope: Game Dev | File: 13-game-development.md
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## When to Apply
When building games, game architecture, or game-related projects.

## Game Dev Commands

| Command | Purpose |
|---------|---------|
| `/KD-game-gdd` | Game Design Document |
| `/KD-game-arch` | Game Architecture |
| `/KD-game-brief` | Game Brief |
| `/KD-game-dev` | Game Development |
| `/KD-game-qa` | Game Testing |
| `/KD-game-narrative` | Story/Narrative |
| `/KD-game-solo` | Solo Game Dev |

## Game Architecture

```
┌────────────────────────────────────────────────┐
│                  Game Engine                    │
├────────────────────────────────────────────────┤
│  ┌──────────┐  ┌──────────┐  ┌──────────┐     │
│  │  Input   │  │  Logic   │  │ Render   │     │
│  │ Manager  │──│  Engine  │──│  System  │     │
│  └──────────┘  └──────────┘  └──────────┘     │
│       │              │              │          │
│       ▼              ▼              ▼          │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐     │
│  │  Audio   │  │ Physics  │  │   UI     │     │
│  │ System   │  │  Engine  │  │  System  │     │
│  └──────────┘  └──────────┘  └──────────┘     │
└────────────────────────────────────────────────┘
```

## Game Engines

| Engine | Language | Best For |
|--------|----------|----------|
| Unity | C# | 2D/3D, Mobile, Cross-platform |
| Unreal | C++/Blueprint | AAA, 3D, High-fidelity |
| Godot | GDScript/C# | Indie, 2D, Open source |
| Phaser | JavaScript | Web games, 2D |
| Three.js | JavaScript | Web 3D |

## Game Design Document

```markdown
# Game Design Document

## Overview
- Title: [Game Name]
- Genre: [Genre]
- Platform: [PC/Mobile/Console]
- Target Audience: [Audience]

## Core Loop
1. Action → Reward → Progression → Repeat

## Mechanics
- Primary: [Main gameplay]
- Secondary: [Supporting systems]

## Progression
- Short-term: [Session goals]
- Medium-term: [Level/stage goals]
- Long-term: [End-game goals]

## Monetization (if applicable)
- Model: [Premium/F2P/Subscription]
- IAP: [What's sold]
- Ads: [Ad strategy]
```

## Game Patterns

### State Machine (AI)
```typescript
enum State { IDLE, PATROL, CHASE, ATTACK }

class EnemyAI {
  private state: State = State.IDLE;
  
  update(player: Player) {
    switch (this.state) {
      case State.IDLE:
        if (this.canSee(player)) this.state = State.CHASE;
        break;
      case State.CHASE:
        if (this.inRange(player)) this.state = State.ATTACK;
        else if (!this.canSee(player)) this.state = State.PATROL;
        break;
      // ...
    }
  }
}
```

### Object Pooling
```typescript
class BulletPool {
  private pool: Bullet[] = [];
  
  get(): Bullet {
    return this.pool.find(b => !b.active) || this.create();
  }
  
  release(bullet: Bullet) {
    bullet.active = false;
  }
}
```

### Game Loop
```typescript
function gameLoop(timestamp: number) {
  const deltaTime = timestamp - lastTime;
  
  // Fixed update for physics
  accumulator += deltaTime;
  while (accumulator >= FIXED_DT) {
    updatePhysics(FIXED_DT);
    accumulator -= FIXED_DT;
  }
  
  // Variable update for rendering
  update(deltaTime);
  render(interpolation);
  
  requestAnimationFrame(gameLoop);
}
```

## Performance Tips

- Object pooling for frequently created/destroyed objects
- Spatial partitioning for collision detection
- LOD (Level of Detail) for distant objects
- Culling for off-screen rendering
- Asset streaming for large worlds

## Game Testing

| Test Type | Focus |
|-----------|-------|
| Functional | Gameplay works correctly |
| Performance | Frame rate, memory |
| Compatibility | Devices, platforms |
| Usability | Player experience |
| Balance | Difficulty, progression |
| Regression | New changes don't break |

---
*Build fun first, optimize later*