# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# SKILL 8: TESTING & QA
# Scope: Dev, QA | File: 08-testing-qa.md
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## When to Apply
When writing tests, designing test strategies, or performing QA activities.

## Testing Pyramid

```
        ┌─────────┐
        │   E2E   │ ← Few, Slow, Expensive
        ├─────────┤
        │Integration│ ← Some, Medium
        ├─────────┤
        │  Unit   │ ← Many, Fast, Cheap
        └─────────┘
```

## Test Types

### Unit Tests
```typescript
// Test isolated functions/components
describe('formatCurrency', () => {
  it('formats USD correctly', () => {
    expect(formatCurrency(1234.56, 'USD')).toBe('$1,234.56');
  });

  it('handles zero', () => {
    expect(formatCurrency(0, 'USD')).toBe('$0.00');
  });

  it('handles negative values', () => {
    expect(formatCurrency(-100, 'USD')).toBe('-$100.00');
  });
});
```

### Integration Tests
```typescript
// Test component interactions
describe('UserRegistration', () => {
  it('submits form successfully', async () => {
    render(<RegistrationForm />);
    
    await userEvent.type(screen.getByLabelText('Email'), 'test@example.com');
    await userEvent.type(screen.getByLabelText('Password'), 'Secure123!');
    await userEvent.click(screen.getByRole('button', { name: 'Register' }));
    
    await waitFor(() => {
      expect(screen.getByText('Registration successful')).toBeInTheDocument();
    });
  });
});
```

### E2E Tests (Playwright)
```typescript
// Test full user flows
test('user can complete checkout', async ({ page }) => {
  await page.goto('/products');
  await page.click('[data-testid="add-to-cart"]');
  await page.click('[data-testid="checkout"]');
  await page.fill('[name="email"]', 'test@example.com');
  await page.click('[data-testid="place-order"]');
  
  await expect(page.locator('.success-message')).toBeVisible();
});
```

## Testing Commands

| Command | Purpose |
|---------|---------|
| `/KD-test` | Plan test strategy |
| `/KD-test-arch` | Design test architecture |
| `/KD-test-design` | Create test cases |
| `/KD-test-automate` | Automate tests |
| `/KD-test-sprite` | Visual regression |
| `/KD-test-ci` | CI/CD testing |
| `/KD-test-nfr` | Non-functional tests |

## Test Coverage Guidelines

| Type | Target | Critical Path |
|------|--------|---------------|
| Unit | 80%+ | 100% |
| Integration | 60%+ | 80%+ |
| E2E | Key flows | All checkout/auth |

## TestSprite Integration

```bash
# Run TestSprite visual tests
node src/testsprite/testsprite-core.js --mode=visual

# Generate report
node src/testsprite/testsprite-core.js --report
```

## Common Test Patterns

### AAA Pattern
```typescript
it('calculates total with tax', () => {
  // Arrange
  const items = [{ price: 100 }, { price: 50 }];
  const taxRate = 0.1;
  
  // Act
  const total = calculateTotal(items, taxRate);
  
  // Assert
  expect(total).toBe(165); // (100 + 50) * 1.1
});
```

### Given-When-Then (BDD)
```typescript
describe('Shopping Cart', () => {
  it('adds item to empty cart', () => {
    // Given
    const cart = new Cart();
    
    // When
    cart.addItem({ id: 1, price: 99 });
    
    // Then
    expect(cart.items).toHaveLength(1);
    expect(cart.total).toBe(99);
  });
});
```

## Performance Testing

### Load Testing (k6)
```javascript
import http from 'k6/http';

export const options = {
  stages: [
    { duration: '1m', target: 100 },  // Ramp up
    { duration: '3m', target: 100 },  // Steady
    { duration: '1m', target: 0 },    // Ramp down
  ],
};

export default function() {
  http.get('https://api.example.com/products');
}
```

## Security Testing Checklist

- [ ] SQL injection tests
- [ ] XSS vulnerability tests
- [ ] CSRF token validation
- [ ] Authentication bypass attempts
- [ ] Authorization boundary tests
- [ ] Input fuzzing
- [ ] Rate limiting verification

---
*Test early, test often, test automatically*