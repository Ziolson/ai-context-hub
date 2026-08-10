# 📏 Global Rules & AI Philosophy Guide

> **Universal principles governing all AI-assisted software development across the organization.**

---

## 🎯 Why Global Rules Matter

When using AI coding assistants (such as Google Antigravity, Cursor, or Claude Code) without strict global guardrails, models default to optimistic code generation: writing arbitrary helper functions, inventing undocumented data models, or skipping tests.

**Global Rules** act as the constitution of your engineering workflow. They ensure that AI assistants behave as **intellectually honest, senior engineering partners** rather than passive code generators.

---

## 🏛️ Core Architectural Pillars

### 1. The "Lazy Senior Developer" Philosophy
In software engineering, "lazy" does not mean careless — it means **highly efficient**:
- **Do not reinvent the wheel**: Prefer standard libraries, established project utilities, and language features over custom helper functions.
- **Minimal Diffs**: Touch only the lines necessary to satisfy the requirement. Avoid unprompted refactoring of unrelated modules.
- **Single Source of Truth**: Never duplicate business logic or configuration.

### 2. Intellectual Honesty & Partner Behavior
- **Challenge Unsound Architecture**: If a user request introduces a race condition, security flaw, or breaking API change, the AI assistant must surface the risk explicitly before implementing code.
- **Never Mask Symptoms**: Never wrap failing code in silent `try/catch` blocks, return dummy fallback data (e.g. empty arrays or `0`), or comment out failing assertions to make tests pass.
- **No Hallucinated Symbols**: Inspect actual source code definitions before calling functions or referencing variables.

---

## 👥 Human Developer vs. AI Assistant Roles

| Area | Human Developer Role | AI Assistant Role |
|------|----------------------|-------------------|
| **Architecture** | Defines high-level system boundaries & trade-offs | Validates implementation against defined boundaries & alerts on drift |
| **Requirements** | Approves feature specifications (`spec.md`) | Conducts structured Q&A, suggests options with rationale |
| **Implementation**| Reviews pull requests & verifies business logic | Writes failing tests first (Red), implements minimal code (Green) |
| **Integrity** | Makes final decisions on breaking changes | Refuses to swallow exceptions or generate unverified code |

---

## 💡 Code Examples: Good vs. Bad Practices

### Anti-Pattern: Swallowing Errors & Dummy Fallbacks ❌
```typescript
// BAD: Hiding runtime failures with silent fallback
async function fetchUserProfile(userId: string): Promise<UserProfile> {
  try {
    const res = await api.get(`/users/${userId}`);
    return res.data;
  } catch (err) {
    // ❌ Swallows error and returns empty object, causing silent failures downstream
    return {} as UserProfile;
  }
}
```

### Production-Grade Pattern: Explicit Error Boundaries ✅
```typescript
// GOOD: Propagating typed domain errors with context
async function fetchUserProfile(userId: string): Promise<UserProfile> {
  const res = await api.get(`/users/${userId}`);
  if (!res.ok) {
    throw new UserNotFoundError(`User profile fetch failed for ID: ${userId}`, { status: res.status });
  }
  return parseUserProfile(res.data);
}
```

---

## 📋 Code Review Checklist for Global Rules

During code review, verify that AI-generated changes follow these checks:

- [ ] **No Unnecessary Dependencies**: Did the AI use existing project utilities instead of pulling in new npm/pip packages?
- [ ] **Minimal Diff Scope**: Are all changed lines strictly relevant to the task?
- [ ] **No Hidden Fallbacks**: Does the code throw or handle errors explicitly rather than returning fake default objects?
- [ ] **Empirical Verification**: Were build and test commands run and verified clean before marking ready?

---

::: details Prompt Reference
<<< ../rules/global-rules.md
:::
