# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# SKILL 12: DEVOPS & DEPLOYMENT
# Scope: DevOps, Architect | File: 12-devops-deployment.md
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## When to Apply
When planning deployments, CI/CD pipelines, or infrastructure.

## Deployment Commands

| Command | Purpose |
|---------|---------|
| `/KD-deployment-plan` | Create deployment plan |
| `/KD-validate-workflow` | Validate workflow |

## CI/CD Pipeline

### GitHub Actions
```yaml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install
        run: npm ci
      
      - name: Test
        run: npm test
      
      - name: Build
        run: npm run build
      
      - name: Deploy
        run: |
          # Deployment commands
```

### Deployment Stages

```
┌──────────┐   ┌──────────┐   ┌───────────┐   ┌───────────┐
│  Build   │──▶│   Test   │──▶│  Staging  │──▶│Production │
│          │   │          │   │           │   │           │
│ Compile  │   │ Unit     │   │ Smoke     │   │ Monitor   │
│ Bundle   │   │ E2E      │   │ UAT       │   │ Alert     │
│ Optimize │   │ Security │   │ Perf      │   │ Scale     │
└──────────┘   └──────────┘   └───────────┘   └───────────┘
```

## Environment Configuration

### Environment Variables
```bash
# .env.example
NODE_ENV=production
DATABASE_URL=postgresql://...
NEXT_PUBLIC_API_URL=https://api.example.com
SECRET_KEY=your-secret-key

# Platform specific
VERCEL_URL=https://app.vercel.app
AWS_REGION=us-east-1
```

### Config by Environment
```typescript
const config = {
  development: {
    api: 'http://localhost:3001',
    db: 'localhost:5432/dev',
  },
  staging: {
    api: 'https://staging-api.example.com',
    db: 'staging-db.example.com',
  },
  production: {
    api: 'https://api.example.com',
    db: 'prod-db.example.com',
  }
};
```

## Deployment Platforms

### Vercel
```json
// vercel.json
{
  "buildCommand": "npm run build",
  "outputDirectory": ".next",
  "framework": "nextjs",
  "regions": ["sin1", "iad1"],
  "env": {
    "NEXT_PUBLIC_API_URL": "@api_url"
  }
}
```

### Docker
```dockerfile
# Multi-stage build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:20-alpine AS runner
WORKDIR /app
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
EXPOSE 3000
CMD ["npm", "start"]
```

### Kubernetes
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    spec:
      containers:
        - name: app
          image: myapp:latest
          ports:
            - containerPort: 3000
          resources:
            limits:
              memory: "512Mi"
              cpu: "500m"
```

## Monitoring & Alerts

### Health Check
```typescript
app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    version: process.env.APP_VERSION
  });
});
```

### Logging
```typescript
import { logger } from './logger';

logger.info('User logged in', { userId: user.id });
logger.error('Payment failed', { orderId, error: err.message });
logger.warn('Rate limit approached', { ip: req.ip });
```

## Rollback Strategy

```bash
# Quick rollback
vercel rollback

# Kubernetes rollback
kubectl rollout undo deployment/app

# Database rollback
npx prisma migrate rollback
```

## Deployment Checklist

- [ ] All tests passing
- [ ] Environment variables configured
- [ ] Database migrations ready
- [ ] Health check endpoint working
- [ ] Monitoring configured
- [ ] Rollback plan documented
- [ ] Team notified

---
*Deploy with confidence, rollback with ease*