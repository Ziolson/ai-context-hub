# Spec-Driven Development (SDD)

> The universal process for all non-trivial feature and bug work.
> Every change follows the same cycle: **discover → specify → approve → plan & implement → review**

---

## When to Use SDD

**Activate SDD when the user wants to:**

- Add a new feature or capability
- Create or modify an API endpoint
- Modify system architecture or data models
- Build a new component or module
- Make any significant change that affects behavior, contracts, or structure

**SDD is NOT needed for:**

- Simple bug fixes with obvious solutions
- Typo corrections or formatting changes
- Dependency updates with no behavioral change

---

## The SDD Cycle

| Phase | Workflow | File | Required? |
|-------|----------|------|-----------|
| **Phase 1** | Discovery & Specification | [`discovery.md`](./discovery.md) | ✅ Yes |
| **Phase 2** | Implementation Planning | [`implementation-plan.md`](./implementation-plan.md) | ⚡ Optional |
| **Phase 3** | TDD Implementation | [`test-driven-development.md`](./test-driven-development.md) | ✅ Yes |
| **Phase 4** | Code Review | [`code-review.md`](./code-review.md) | ✅ Yes |

```
Phase 1: Discovery & Specification
  discover → specify → approve
  ↓ spec.md Status: Approved
Phase 2: Implementation Planning (optional — skip for simple features)
  analyze → plan → review plan
  ↓ plan.md approved (or skipped)
Phase 3: TDD Implementation
  Red-Green-Refactor per acceptance criterion
  ↓ all acceptance criteria pass
Phase 4: Code Review
  systematic review → feedback → fix/approve
  ↓ review approved, spec Status: Done
```

> [!IMPORTANT]
> ### Mandatory Rules
> - **Phase 2 is the only optional phase.** Skip it only for simple features where the path from spec to code is obvious. When in doubt, ask the user.
> - **Phase 3 (TDD) is mandatory.** Every acceptance criterion MUST have a failing test before implementation begins. Code-level unit tests follow pragmatic testing principles — write them for complex logic, skip for trivial one-liners. See [`test-driven-development.md`](./test-driven-development.md) for the full Red-Green-Refactor workflow.
> - **Phase 4 (Code Review) is mandatory.** Every implementation must be reviewed against the spec before the feature is considered done.
> - **Never skip phases silently.** If you believe a phase can be skipped, ask the user explicitly.

---

## Per-Feature Documentation Structure

Every feature gets its own folder under `docs/features/`:

```
docs/features/<feature-name>/
├── spec.md                    # Feature specification (Phase 1)
├── plan.md                    # Implementation plan (Phase 2)
├── review.md                  # Code review results (Phase 4)
└── ADR-NNN-<title>.md         # Architectural decisions (as needed)
```

**Naming convention**: Use lowercase kebab-case for `<feature-name>` (e.g., `user-authentication`, `payment-processing`, `csv-export`).

---

## Spec Status Tracking

Every `spec.md` includes a `Status` field that tracks progress through the SDD cycle:

| Status | Meaning | Active Phase |
|--------|---------|-------------|
| `Draft` | Spec is being written or refined | Phase 1 |
| `Approved` | Spec reviewed and approved by user | Phase 1 complete |
| `In Progress` | Implementation has started | Phase 2 or 3 |
| `Done` | All acceptance criteria pass, code review complete | Phase 4 complete |
| `Deprecated` | Feature abandoned, superseded, or rolled back | — |
