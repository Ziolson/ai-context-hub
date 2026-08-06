# Testing Practices

> Standards for writing tests that provide real confidence — not just coverage numbers.
> For the step-by-step Red-Green-Refactor process, see `docs/workflows/test-driven-development.md`.

---

## 1. Philosophy — Value-Driven Testing

### Write tests when:
- **Core business logic** — complex calculations, state transitions, domain rules, financial operations
- **High-risk integration points** — external API calls, complex database queries, auth/permission checks
- **Bug fixes** — write a failing test that reproduces the bug before fixing it (prevents regressions)
- **Shared/reused modules** — logic consumed by multiple callers where a silent breakage spreads

### Skip or write minimal tests when:
- **Trivial code** — simple getters/setters, boilerplate, layout/styling, straightforward pass-through controllers
- **Minor isolated tweaks** — small changes with low blast radius where a single runnable check is sufficient
- **Generated code** — ORM-generated models, serializers, framework scaffolding

> **Rule of thumb**: Write a proper unit test when the logic has **multiple branches**, **external dependencies** (DB, API, filesystem), or is part of a **shared/reused module**. In all other cases, a single runnable assertion is sufficient.

---

## 2. Testing Pyramid

Structure tests according to their scope, speed, and quantity:

```
        ╱ ╲
       ╱ E2E ╲          Few — Critical user paths only
      ╱─────────╲        Slow, expensive, fragile
     ╱Integration╲      Some — API endpoints, DB queries
    ╱───────────────╲    Medium speed, real dependencies
   ╱    Unit Tests   ╲  Many — Business logic, pure functions
  ╱───────────────────╲  Fast, isolated, no I/O
```

### Unit Tests — Many, Fast, Isolated

- **What to test**: Business logic, pure functions, domain rules, calculations, validations, transformations
- **Characteristics**: No I/O, no database, no network, no filesystem. Uses test doubles for external dependencies.
- **Speed target**: Entire unit test suite runs in **under 10 seconds**

### Integration Tests — Some, Slower

- **What to test**: Repository queries against a real database, API endpoint request/response cycles, message queue producers/consumers, external service clients
- **Characteristics**: Uses real dependencies (test database, test containers) or realistic fakes. Tests the seams between components.
- **Speed target**: Entire integration test suite runs in **under 2 minutes**

### E2E Tests — Few, Slowest

- **What to test**: Critical user journeys that cross multiple services or layers — login flow, checkout process, data export pipeline
- **Characteristics**: Tests the system as a user would experience it. Uses real UI, real APIs, real databases.
- **Speed target**: Each individual E2E test runs in **under 30 seconds**

---

## 3. Test Naming Convention

Use the format: `should_[expected behavior]_when_[condition]`

| ✅ Good | ❌ Bad |
|---------|--------|
| `should_return_user_when_valid_id_provided` | `test_get_user` |
| `should_throw_not_found_when_user_does_not_exist` | `test_error` |
| `should_hash_password_when_plain_text_provided` | `test_password_hashing` |
| `should_return_empty_list_when_no_orders_exist` | `test_orders` |
| `should_deny_access_when_token_expired` | `test_auth` |

The test name should read like a sentence and make the test's purpose immediately clear **without reading the test body**.

---

## 4. Test Quality Guidelines

### Test Behavior, Not Implementation

```
// ✅ Tests behavior
TEST should_calculate_total_with_tax_when_items_provided
    cart = new Cart(items: [Item(price=100), Item(price=200)])
    ASSERT cart.total(taxRate=0.1) == 330.0

// ❌ Tests implementation detail
TEST should_call_sum_on_prices
    cart = new Cart(items: [Item(price=100)])
    cart.total(taxRate=0.1)
    ASSERT cart._internalPricesFlag == true  // private state
```

### Tests Must Be Independent

- Each test must run in isolation and in any order
- Tests must not depend on shared mutable state
- Use setup/teardown or fixtures to create fresh state for each test
- Never rely on test execution order

### Use Test Factories

Create reusable factory functions — only override what matters for the test:

```
// ✅ Factory pattern — only override what matters for the test
FUNCTION makeUser(overrides = {})
    defaults = { id: 1, email: "user@example.com", role: "viewer", active: true }
    RETURN merge(defaults, overrides)

// Usage — test intent is immediately clear
user = makeUser({ role: "admin" })
```

---

## 5. Test Doubles Strategy

| Double | What it is | Use when |
|--------|-----------|----------|
| **Stub** | Returns a fixed value | You need to control input to the unit under test |
| **Mock** | Verifies calls were made | You need to assert that a side effect occurred (e.g., email sent) |
| **Fake** | Lightweight working implementation | You need realistic behavior without the real dependency (e.g., in-memory repo) |
| **Spy** | Wraps a real object and records calls | You want real behavior but also want to observe interactions |

### Rules for using test doubles:

- **Mock only what you own** — do not mock third-party libraries directly; wrap them in an adapter and mock the adapter
- **Prefer fakes over mocks** for stateful dependencies (repositories, caches) — they produce more realistic tests with less setup noise
- **Avoid over-mocking** — if a unit test requires mocking 5+ dependencies, the code under test has too many responsibilities (refactor first)
- **Do not mock the system under test** — only mock collaborators, never the class being tested

```
// ✅ Mock the adapter you own
emailAdapter = mock(EmailAdapter)
service = new UserService(emailAdapter)
service.register(user)
ASSERT emailAdapter.send called once with recipient=user.email

// ❌ Mock the third-party library directly
sendGrid = mock(SendGridClient)  // You don't own this interface
```

---

## 6. Coverage Policy

### What matters:
- **Branch coverage over line coverage** — uncovered branches are where bugs hide, not uncovered lines
- **High coverage of business logic and domain rules** — aim for 80–90%+ in the domain and application layers
- **Meaningful scenarios**: happy path, error paths, edge cases, boundary conditions

### What does not matter:
- Chasing **100% line coverage** — it creates incentive to write tests that execute code without asserting anything
- Coverage of **trivial code** — getters, setters, framework boilerplate, generated code
- Coverage of **configuration and wiring** — leave that to integration tests

### Red flags in coverage reports:
- Tests with no assertions (coverage goes up, confidence does not)
- Tests that only verify `not null` or `no exception thrown` on non-trivial logic
- Large gaps in error-handling branches

---

## 7. External Integration Testing

### Option 1 — Test Containers (preferred for DB/infra)

Spin up a real instance of the dependency (PostgreSQL, Redis, Kafka) inside a container for the test run. The test uses the real protocol; no faking needed.

- ✅ High confidence — tests the real driver and query behavior
- ✅ No drift between test doubles and real system
- ⚠️ Slower startup — use for integration tests, not unit tests

### Option 2 — Contract Testing (preferred for service-to-service APIs)

Use a contract testing tool (e.g., Pact) to verify that the consumer and provider agree on the API shape, independently and without deploying both services simultaneously.

- ✅ Catches breaking API changes early
- ✅ Fast — no real service needed at test time
- Use when you own both sides, or when the provider publishes a Pact broker

### Option 3 — HTTP Stubs / Record-Replay (for third-party APIs you don't control)

Use a stub server (e.g., WireMock) or record-replay tool to simulate third-party HTTP responses.

- ✅ Deterministic — no flakiness from network or third-party rate limits
- ⚠️ Can drift from reality — refresh recorded responses periodically
- Use when the third-party has no sandbox or the sandbox is unreliable

### Option 4 — Sandbox Environments

Use the vendor-provided test/sandbox environment (e.g., Stripe test mode, Twilio test credentials).

- ✅ Closest to production behavior
- ⚠️ Requires network — not suitable for offline or CI-constrained environments
- Use for smoke tests and final pre-release validation

### What to avoid:
- **Calling real production APIs in tests** — data pollution, rate limits, flakiness, cost
- **Mocking HTTP clients at the framework level** (e.g., mocking `axios` or `fetch`) — too fragile; mock at your own adapter boundary instead
