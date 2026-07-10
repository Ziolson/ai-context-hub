# Phase 3 — Test-Driven Development

> **From Spec to Working Code**
> Implement functionality using the Red-Green-Refactor cycle at two levels: feature-level and code-level.

---

## Purpose & Trigger

**Activate this workflow when:**

- Implementing functionality based on an approved spec (with or without an implementation plan)
- Fixing bugs (write a failing test that reproduces the bug first)
- Refactoring code (ensure existing tests pass before and after changes)

**Inputs:**

| | Path | Description |
|---|------|-------------|
| **Reads** | `docs/features/<feature-name>/spec.md` | Approved specification |
| **Reads (optional)** | `docs/features/<feature-name>/plan.md` | Implementation plan if it exists |

**Produces:**

- Working code with passing tests
- Spec Status updated to `In Progress` (if not already)

---

## Pragmatic Testing Approach (Value-Driven Testing)

Testing is not about ticking boxes or chasing 100% code coverage. It is about confidence, stability, and speed. Focus testing efforts where they provide real business value.

### When to write tests:
- **Core Business Logic**: Complex calculations, state transitions, domain rules, and financial operations.
- **High-Risk Integration Points**: External API integrations, complex database queries, auth/permission checks.
- **Bug Fixes**: Write a test reproducing a bug before fixing it to prevent regressions.

### When to skip or write minimal tests (e.g., "One Runnable Check"):
- **Trivial Code**: Simple getters/setters, boilerplate, layout styling, simple UI/HTML changes, straightforward pass-through controllers.
- **Minor Tweaks**: Small, isolated code modifications with low blast radius. A simple self-check or assertion is often enough.

### Levels of Testing (Use when appropriate)

```
Feature-Level (outer loop):
  📋 Pick acceptance criterion AC-1 from spec
  🔴 Write failing integration/E2E test for AC-1
  │
  │  Code-Level (inner loop):
  │    🔴 Write failing unit test for function/class needed
  │    🟢 Write minimum code to pass unit test
  │    🔵 Refactor, keeping unit test green
  │    (repeat for each function/class needed)
  │
  🟢 Integration/E2E test for AC-1 now passes
  🔵 Refactor across the feature, keeping all tests green
  
  📋 Pick next acceptance criterion AC-2...
```

---

## The Red-Green-Refactor Cycle

### 🔴 Red — Write a Failing Test

**Feature-level**: Translate the acceptance criterion directly into a test.

```
Acceptance Criterion:
  Given a registered user with valid credentials
  When they submit a login request
  Then they receive a 200 response with a valid JWT token

Test:
  should_return_jwt_token_when_valid_credentials_provided()
```

**Code-level**: Before writing any function or class, write a test that describes what it should do.

```
Test:
  should_hash_password_with_bcrypt_when_plain_text_provided()
```

**Rules:**
- The test MUST fail before you write implementation code
- The test MUST fail for the RIGHT reason (not due to syntax errors or missing imports)
- Run the test and confirm it fails — do not skip this step

### 🟢 Green — Write Minimum Code to Pass

- Write the **absolute minimum** code needed to make the failing test pass
- Do not add extra logic, optimizations, or "while I'm here" improvements
- Do not refactor yet — ugly code that passes is fine at this stage
- The goal is speed: get to green as fast as possible

**Example of "minimum code":**

```
// 🔴 Test
TEST should_return_empty_list_when_no_items_exist
    repo = new ItemRepository()
    ASSERT repo.findAll() == []

// 🟢 Minimum implementation
CLASS ItemRepository
    FUNCTION findAll()
        RETURN []
```

Yes, returning an empty list is valid at this stage. The next test will force a more complete implementation.

### 🔵 Refactor — Clean Up While Green

- Improve code structure, naming, readability, and design
- Extract methods, remove duplication, simplify conditionals
- **Run ALL tests after every refactor step** — they must stay green
- Apply SOLID principles, design patterns, and project conventions
- This is where code quality happens — don't skip it

**Refactoring checklist:**
- [ ] No duplication (DRY)
- [ ] Clear, descriptive names
- [ ] Small, focused functions (single responsibility)
- [ ] Proper error handling
- [ ] Consistent with project conventions

---

## Test Naming Convention

Use the format: `should_[expected behavior]_when_[condition]`

| ✅ Good | ❌ Bad |
|---------|--------|
| `should_return_user_when_valid_id_provided` | `test_get_user` |
| `should_throw_not_found_when_user_does_not_exist` | `test_error` |
| `should_hash_password_when_plain_text_provided` | `test_password_hashing` |
| `should_return_empty_list_when_no_orders_exist` | `test_orders` |
| `should_deny_access_when_token_expired` | `test_auth` |

The test name should read like a sentence and make the test's purpose immediately clear without reading the test body.

---

## Testing Pyramid

Structure your tests according to the testing pyramid:

```
        ╱ ╲
       ╱ E2E ╲          Few — Critical user paths only
      ╱─────────╲        Slow, expensive, fragile
     ╱Integration╲      Some — API endpoints, DB queries
    ╱───────────────╲    Medium speed, real dependencies
   ╱    Unit Tests   ╲  Many — Business logic, pure functions
  ╱───────────────────╲  Fast, isolated, no I/O
```

### Unit Tests (Many, Fast, Isolated)

- **What to test**: Business logic, pure functions, domain rules, calculations, validations, transformations
- **Characteristics**: No I/O, no database, no network, no filesystem. Uses mocks/stubs for external dependencies.
- **Speed target**: Entire unit test suite runs in under 10 seconds

### Integration Tests (Some, Slower)

- **What to test**: Repository queries against real database, API endpoint request/response cycles, message queue producers/consumers, external service clients
- **Characteristics**: Uses real dependencies (test database, test containers) or realistic fakes. Tests the seams between components.
- **Speed target**: Entire integration test suite runs in under 2 minutes

### E2E Tests (Few, Slowest)

- **What to test**: Critical user journeys that cross multiple services or layers — login flow, checkout process, data export pipeline
- **Characteristics**: Tests the system as a user would experience it. Uses real UI, real APIs, real databases.
- **Speed target**: Each E2E test runs in under 30 seconds

---

## Testing Guidelines

### Test Behavior, Not Implementation

```
// ✅ Tests behavior: what the function does
TEST should_calculate_total_with_tax_when_items_provided
    cart = new Cart(items: [Item(price=100), Item(price=200)])
    ASSERT cart.total(taxRate=0.1) == 330.0

// ❌ Tests implementation: how the function does it
TEST should_call_sum_on_prices
    cart = new Cart(items: [Item(price=100)])
    cart.total(taxRate=0.1)
    ASSERT cart._internalPricesFlag == true  // Testing internal/private state
```

### Tests Must Be Independent

- Each test must be able to run in isolation and in any order
- Tests must not depend on shared mutable state
- Use setup/teardown or fixtures to create fresh state for each test
- Never rely on test execution order

### Use Test Fixtures and Factories

- Create reusable test fixtures for common test data
- Use factory functions or builders to construct test objects
- Keep fixture data close to reality but minimal

```
// ✅ Factory / builder pattern
FUNCTION makeItem(overrides)
    defaults = { id: 1, name: "Default Item", status: "active" }
    RETURN merge(defaults, overrides)
```

### Meaningful Coverage

- Aim for high coverage of **business logic and domain rules**
- Do not chase 100% line coverage — focus on meaningful scenarios
- Cover: happy path, error paths, edge cases, boundary conditions
- Skip: trivial getters/setters, framework boilerplate, generated code

---

## Workflow for Bug Fixes

1. **Reproduce**: Write a failing test that demonstrates the bug
2. **Fix**: Write the minimum code change to make the test pass
3. **Verify**: Ensure all existing tests still pass
4. **Refactor**: Clean up if needed, keeping all tests green
5. **Document**: Add a comment explaining what the bug was and why the fix works

---

## Workflow for Refactoring

1. **Verify**: Ensure all existing tests pass (if no tests exist, write them first)
2. **Refactor**: Make structural changes in small, incremental steps
3. **Test after each step**: Run the full test suite after every change
4. **Never change behavior**: Refactoring must not change what the code does, only how it does it

---

## Handoff

When all acceptance criteria from the spec have corresponding passing tests:

- The feature implementation is complete
- The spec Status should be `In Progress` (it will be updated to `Done` after code review)
- Proceed to **Phase 4 — Code Review** (`docs/workflows/code-review.md`)
