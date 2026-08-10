# Phase 3 — TDD Implementation

> Part of the **Spec-Driven Development** cycle — see [`spec-driven-development.md`](./spec-driven-development.md) for the full process definition.
> This phase covers: implementing functionality using the Red-Green-Refactor cycle, driven by the approved spec.

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

## Testing Standards

> Testing philosophy, the pyramid, naming conventions, test doubles strategy, coverage policy, and external integration testing are defined in **`rules/practices/testing.md`**. Read it before implementing tests.

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
- **Strict Separation**: NEVER write implementation code and test code in the same step. You MUST execute the failing test via terminal and inspect failure output before writing production code.

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

## Testing Reference

> Testing philosophy, the full pyramid with speed targets, naming conventions, test doubles strategy, coverage policy, and external integration patterns are defined in **`rules/practices/testing.md`**. Read it before implementing tests.

Quick pyramid reference:

```
        ╱ ╲
       ╱ E2E ╲          Few — Critical user paths only
      ╱─────────╲        Slow, expensive, fragile
     ╱Integration╲      Some — API endpoints, DB queries
    ╱───────────────╲    Medium speed, real dependencies
   ╱    Unit Tests   ╲  Many — Business logic, pure functions
  ╱───────────────────╲  Fast, isolated, no I/O
```

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
