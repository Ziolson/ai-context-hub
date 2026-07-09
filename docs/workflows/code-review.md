# Phase 4 — Code Review

> **Quality Gate Before Commit**
> Systematic review of code changes against the specification, project standards, and best practices.

---

## Purpose & Trigger

**Activate this workflow when:**

- Implementation is complete and all acceptance criteria tests pass (after Phase 3)
- The user asks to review code changes before committing
- Reviewing a pull request or merge request
- The user asks for a code quality check on specific files

**Inputs:**

| | Path | Description |
|---|------|-------------|
| **Reads** | `docs/features/<feature-name>/spec.md` | The approved specification |
| **Reads** | Code changes (diff or files) | The implementation to review |

**Produces:**

| | Path | Description |
|---|------|-------------|
| **Creates** | `docs/features/<feature-name>/review.md` | Structured review feedback |

---

## Phase 1 — Understanding

> **Goal**: Build context before reviewing any code

Before looking at a single line of code, read and understand:

1. **The specification**: Read `spec.md` to understand what was supposed to be built. Pay special attention to:
   - Acceptance criteria — these define "correct"
   - API contract — these define the interface
   - Error scenarios — these define robustness
   - Non-functional requirements — these define quality attributes

2. **The implementation plan**: If `plan.md` exists, read it to understand the intended approach and structure.

3. **The scope**: Understand what is in scope and what is explicitly out of scope. Do not flag items that are intentionally deferred.

---

## Phase 2 — Systematic Review

> **Goal**: Evaluate code changes against a comprehensive checklist

Review every changed file against the following checklist. For each category, note any issues found.

### Review Checklist

| Category | What to Check | Key Questions |
|----------|--------------|---------------|
| **Correctness** | Spec compliance | Does the code implement all acceptance criteria? Are edge cases from the spec handled? |
| | Edge cases | Are boundary conditions handled? Empty collections, null values, concurrent access? |
| | Error handling | Are errors caught and handled meaningfully? Do error messages include context? Are exceptions never silently swallowed? |
| **Tests** | Coverage | Do tests cover happy path, error paths, and edge cases? Are acceptance criteria covered by feature-level tests? |
| | Naming | Do test names follow `should_[behavior]_when_[condition]`? |
| | Independence | Can each test run in isolation? No shared mutable state? |
| | Assertions | Are assertions specific and meaningful? No `assertTrue(result != null)` when `assertEquals` is more appropriate? |
| **Design** | SOLID principles | Single responsibility? Open/closed? Proper abstractions? Dependency inversion? |
| | Complexity | Are functions small and focused? Is cyclomatic complexity reasonable? Can complex logic be simplified? |
| | Separation of concerns | Is business logic separated from infrastructure? Are layers respected? |
| | Duplication | Is there repeated code that should be extracted? (But don't over-abstract — the Rule of Three applies) |
| **Naming** | Clarity | Do names reveal intent? Can you understand the purpose without reading the implementation? |
| | Domain language | Do names use the project's domain language consistently? |
| | Consistency | Do names follow existing project conventions? |
| **Security** | Secrets | Any hardcoded credentials, API keys, or tokens? |
| | Input validation | Are all external inputs sanitized and validated at boundaries? |
| | Injection | Are queries parameterized? Is user input ever concatenated into SQL, commands, or templates? |
| | Authorization | Are access controls enforced? Does every endpoint check permissions? |
| **Performance** | N+1 queries | Are there database queries inside loops? Should they be batched? |
| | Pagination | Are list endpoints paginated? Could unbounded queries return millions of rows? |
| | Resource management | Are connections, files, and streams properly closed? |
| | Unnecessary work | Is there computation that could be cached, deferred, or eliminated? |
| **Documentation** | API docs | Do public functions/methods have docstrings/JSDoc? |
| | Comments | Do complex business rules have comments explaining *why*? Are there stale or misleading comments? |
| | README | Does the README need updating for the new feature? |

---

## Phase 3 — Feedback

> **Goal**: Provide clear, actionable, prioritized feedback

### Severity Categories

Every piece of feedback must be categorized by severity:

| Icon | Severity | Meaning | Action Required |
|------|----------|---------|-----------------|
| 🔴 | **Must Fix** | Bugs, security issues, spec violations, data loss risks | Must be fixed before merge. Blocks the review. |
| 🟡 | **Should Fix** | Code quality issues, missing tests, poor naming, design concerns | Should be fixed in this PR. Can be deferred with justification. |
| 🟢 | **Suggestion** | Style improvements, alternative approaches, minor optimizations | Optional. Nice to have but not required. |
| 💬 | **Question** | Clarification needed, intent unclear, potential issue | Needs a response but may not require code changes. |

### Review Document Template

Create `docs/features/<feature-name>/review.md`:

```markdown
# Code Review: <Feature Name>

| Field       | Value            |
|-------------|------------------|
| Spec        | [spec.md](./spec.md) |
| Reviewer    | AI               |
| Date        | <YYYY-MM-DD>     |
| Verdict     | Approved / Changes Requested |

## Summary

Brief overall assessment of the implementation quality, structure, and completeness.

## Findings

### 🔴 Must Fix

#### R-1: <Title>
- **File**: `path/to/file.ts:42`
- **Issue**: Description of the problem
- **Impact**: Why this matters
- **Suggestion**: How to fix it

```diff
-current_problematic_code()
+suggested_fix()
```

---

### 🟡 Should Fix

#### R-2: <Title>
- **File**: `path/to/file.ts:78`
- **Issue**: Description of the concern
- **Suggestion**: Recommended improvement

---

### 🟢 Suggestions

#### R-3: <Title>
- **File**: `path/to/file.ts:15`
- **Suggestion**: Alternative approach or improvement

---

### 💬 Questions

#### R-4: <Title>
- **File**: `path/to/file.ts:93`
- **Question**: What needs clarification

---

## Checklist Summary

| Category | Status |
|----------|--------|
| Correctness | ✅ Pass / ⚠️ Issues Found |
| Tests | ✅ Pass / ⚠️ Issues Found |
| Design | ✅ Pass / ⚠️ Issues Found |
| Naming | ✅ Pass / ⚠️ Issues Found |
| Security | ✅ Pass / ⚠️ Issues Found |
| Performance | ✅ Pass / ⚠️ Issues Found |
| Documentation | ✅ Pass / ⚠️ Issues Found |
```

### Feedback Guidelines

- **Be specific**: Reference exact file paths and line numbers
- **Be constructive**: Always suggest a fix or alternative, don't just point out problems
- **Show, don't tell**: Use code snippets and diffs to illustrate suggestions
- **Explain impact**: Say why an issue matters, not just that it exists
- **Acknowledge good work**: If something is done particularly well, say so

---

## Handoff

### If 🔴 Must Fix items exist:

- Set the review Verdict to `Changes Requested`
- The implementation goes back to **Phase 3 — TDD Implementation** to address the issues
- After fixes are applied, re-run this review workflow

### If no 🔴 Must Fix items:

- Set the review Verdict to `Approved`
- Update the spec Status from `In Progress` to `Done`
- The feature is ready to commit

### Commit Message

When the review passes, suggest a commit message following Conventional Commits:

```
feat(<scope>): <short description>

<body explaining what was built and why>

Spec: docs/features/<feature-name>/spec.md
```
