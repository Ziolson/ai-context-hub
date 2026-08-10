# 🧪 Pragmatic Testing Practices Guide

> **Value-driven testing principles over rigid line coverage metrics.**

---

## Purpose & Overview

Testing is the safety net of continuous integration and refactoring. However, non-pragmatic testing (such as requiring 100% line coverage on trivial getters, setters, or UI styles) leads to brittle test suites that slow down feature delivery and increase maintenance overhead.

This guide outlines standards for **Pragmatic Testing**, focusing testing effort where business risk is highest.

---

## Core Architectural Principles

### 1. The Practical Testing Pyramid
Structure your test suite to balance execution speed, isolation, and confidence:

<svg viewBox="0 0 800 240" xmlns="http://www.w3.org/2000/svg" style="width: 100%; max-width: 800px; height: auto; margin: 24px 0; font-family: 'Plus Jakarta Sans', -apple-system, sans-serif;">
  <defs>
    <linearGradient id="e2eBarGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#ef4444" /><stop offset="100%" stop-color="#dc2626" />
    </linearGradient>
    <linearGradient id="intBarGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#f59e0b" /><stop offset="100%" stop-color="#d97706" />
    </linearGradient>
    <linearGradient id="unitBarGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#10b981" /><stop offset="100%" stop-color="#059669" />
    </linearGradient>
    <filter id="barShadow" x="-5%" y="-5%" width="110%" height="110%">
      <feDropShadow dx="0" dy="3" stdDeviation="4" flood-color="#000" flood-opacity="0.12"/>
    </filter>
  </defs>

  <rect x="220" y="15" width="360" height="55" rx="10" fill="url(#e2eBarGrad)" filter="url(#barShadow)"/>
  <text x="400" y="38" text-anchor="middle" fill="#ffffff" font-size="14" font-weight="800">E2E Tests (Smoke Tests)</text>
  <text x="400" y="56" text-anchor="middle" fill="#fee2e2" font-size="11">Happy paths &amp; critical checkout flows</text>

  <rect x="140" y="85" width="520" height="55" rx="10" fill="url(#intBarGrad)" filter="url(#barShadow)"/>
  <text x="400" y="108" text-anchor="middle" fill="#ffffff" font-size="14" font-weight="800">Integration Tests</text>
  <text x="400" y="126" text-anchor="middle" fill="#fef3c7" font-size="11">API endpoints, DB repositories &amp; service contracts</text>

  <rect x="60" y="155" width="680" height="55" rx="10" fill="url(#unitBarGrad)" filter="url(#barShadow)"/>
  <text x="400" y="178" text-anchor="middle" fill="#ffffff" font-size="14" font-weight="800">Unit Tests (High Density)</text>
  <text x="400" y="196" text-anchor="middle" fill="#d1fae5" font-size="11">Pure domain business logic, algorithms &amp; state machines</text>
</svg>

- **Unit Tests**: Blazing fast, zero I/O dependencies. Write extensive unit tests for complex business logic, calculations, and domain entities.
- **Integration Tests**: Verify boundaries between application layers (Database, HTTP API controllers, message queues).
- **End-to-End Tests**: Keep E2E tests focused strictly on happy path smoke tests for critical revenue-generating workflows (checkout, registration).

### 2. The AAA Pattern (Arrange - Act - Assert)
Structure every test method into three distinct, readable sections:
1. **Arrange**: Set up input data, mocks, and initial state.
2. **Act**: Invoke the target function or execution unit.
3. **Assert**: Verify output values, state mutations, or expected side effects.

### 3. Test Isolation & Determinism
- Tests must pass in any order and run independently in parallel.
- Never rely on shared global state or persistent database records left over by preceding test cases.

---

## Human Developer vs. AI Assistant Roles

| Area | Human Developer Role | AI Assistant Role |
|------|----------------------|-------------------|
| **Test Strategy** | Determines coverage targets & critical business risk paths | Writes failing test cases (Red) before writing feature code |
| **Mocking Policy**| Specifies boundaries for external API/service mocking | Uses test doubles/stubs for external dependencies without over-mocking |
| **Refactoring** | Reviews test clarity and ensures test suite execution speed | Maintains test suite stability when refactoring internal logic |

---

## Code Examples: Good vs. Bad Practices

### Anti-Pattern: Trivial Boilerplate Testing
```typescript
// BAD: Testing simple property assignment (adds zero business value)
test('User model sets name property', () => {
  const user = new User();
  user.setName('Alice');
  expect(user.getName()).toBe('Alice'); // Trivial setter test
});
```

### Production-Grade Pattern: Business Risk Testing
```typescript
// GOOD: Testing complex domain business rules with edge cases
describe('OrderDiscountCalculator', () => {
  it('should apply 20% discount when order total exceeds $100 and user is VIP', () => {
    // Arrange
    const calculator = new OrderDiscountCalculator();
    const user = createUser({ isVip: true });
    const items = [createCartItem({ price: 60, quantity: 2 })]; // Total $120

    // Act
    const discount = calculator.calculateDiscount(user, items);

    // Assert
    expect(discount).toBe(24); // 20% of 120
  });
});
```

---

## Code Review Checklist

- [ ] **AAA Structure**: Are tests organized clearly into Arrange, Act, and Assert blocks?
- [ ] **Meaningful Assertions**: Do tests verify actual business requirements rather than just calling functions to inflate coverage?
- [ ] **No Flakiness**: Are async operations properly awaited without arbitrary `setTimeout` delays?
- [ ] **Test Execution Speed**: Do unit tests execute in milliseconds without establishing real DB/network connections?

---

::: details Prompt Reference
<<< ../rules/practices/testing.md
:::
