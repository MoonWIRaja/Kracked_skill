# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# SKILL 11: API DESIGN
# Scope: Architect, Dev | File: 11-api-design.md
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## When to Apply
When designing REST APIs, GraphQL schemas, or API architecture.

## RESTful API Design

### Resource Naming
```
✅ Good                    ❌ Bad
GET /users                 GET /getUsers
GET /users/{id}            GET /userById?id=
POST /users                POST /createUser
PUT /users/{id}            PUT /updateUser
DELETE /users/{id}         DELETE /deleteUser?id=

GET /users/{id}/orders     GET /getUserOrders
```

### HTTP Methods
| Method | Purpose | Idempotent |
|--------|---------|------------|
| GET | Retrieve | Yes |
| POST | Create | No |
| PUT | Replace | Yes |
| PATCH | Partial update | No |
| DELETE | Remove | Yes |

### Status Codes
| Code | Meaning | When to Use |
|------|---------|-------------|
| 200 | OK | Successful GET, PUT, PATCH |
| 201 | Created | Successful POST |
| 204 | No Content | Successful DELETE |
| 400 | Bad Request | Invalid input |
| 401 | Unauthorized | Missing auth |
| 403 | Forbidden | Insufficient permissions |
| 404 | Not Found | Resource doesn't exist |
| 409 | Conflict | Duplicate resource |
| 422 | Unprocessable | Validation failed |
| 500 | Server Error | Unexpected error |

## Request/Response Patterns

### Pagination
```typescript
// Request
GET /products?page=2&limit=20&sort=-createdAt

// Response
{
  "data": [...],
  "pagination": {
    "page": 2,
    "limit": 20,
    "total": 150,
    "totalPages": 8,
    "hasNext": true,
    "hasPrev": true
  }
}
```

### Filtering
```
GET /products?category=electronics&price[gte]=100&price[lte]=500
GET /users?status=active&role=admin
```

### Error Response
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input data",
    "details": [
      {
        "field": "email",
        "message": "Must be a valid email"
      }
    ],
    "requestId": "req_abc123",
    "timestamp": "2026-02-18T00:00:00Z"
  }
}
```

## API Commands

| Command | Purpose |
|---------|---------|
| `/KD-api-design` | Design API architecture |
| `/KD-architecture` | System design |

## OpenAPI Specification

```yaml
openapi: 3.0.0
info:
  title: Product API
  version: 1.0.0

paths:
  /products:
    get:
      summary: List products
      parameters:
        - name: page
          in: query
          schema:
            type: integer
            default: 1
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProductList'
```

## GraphQL Patterns

### Schema Design
```graphql
type User {
  id: ID!
  email: String!
  name: String
  orders: [Order!]!
}

type Query {
  user(id: ID!): User
  users(page: Int, limit: Int): UserConnection!
}

type Mutation {
  createUser(input: CreateUserInput!): User!
  updateUser(id: ID!, input: UpdateUserInput!): User!
}
```

### N+1 Prevention
```typescript
// Use DataLoader for batching
const userLoader = new DataLoader(async (ids) => {
  const users = await User.find({ _id: { $in: ids } });
  return ids.map((id) => users.find((u) => u.id === id));
});
```

## Security

### Authentication Headers
```
Authorization: Bearer <jwt_token>
X-API-Key: <api_key>
```

### Rate Limiting
```typescript
// Express rate limiting
import rateLimit from 'express-rate-limit';

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // 100 requests per window
  message: { error: 'Too many requests' }
});

app.use('/api/', limiter);
```

## Versioning Strategies

| Strategy | Example | Pros | Cons |
|----------|---------|------|------|
| URL | /v1/users | Simple | URL pollution |
| Header | Accept: v1 | Clean URLs | Discovery |
| Query | /users?v=1 | Flexible | Cache issues |

---
*APIs should be intuitive, consistent, and evolve gracefully*