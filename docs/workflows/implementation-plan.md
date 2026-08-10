# Phase 2 — Implementation Planning

> Part of the **Spec-Driven Development** cycle — see [`spec-driven-development.md`](./spec-driven-development.md) for the full process definition.
> This phase covers: analyzing the approved spec and producing an ordered, testable implementation plan.

---

## Purpose & Trigger

**Activate this workflow when:**

- The user asks to plan the implementation of a feature with an approved spec
- A feature is complex enough that jumping straight to code would be risky
- Multiple files, modules, or services need coordinated changes

**This workflow is optional** for small, self-contained features where the path from spec to code is obvious. When in doubt, ask the user:

> "This feature touches [N files/modules]. Would you like me to create an implementation plan first, or should we go straight to TDD?"

## Inputs & Outputs

| | Path | Description |
|---|------|-------------|
| **Reads** | `docs/features/<feature-name>/spec.md` | Approved specification (Status must be `Approved`) |
| **Produces** | `docs/features/<feature-name>/plan.md` | Ordered implementation plan |

### Prerequisite

The spec must have Status `Approved`. If the spec is still `Draft`, redirect to Phase 1 — Discovery & Specification ([`discovery.md`](./discovery.md)) first.

---

## Step 1 — Analyze

> **Goal**: Understand the full scope of changes needed

### Actions

1. **Read the spec thoroughly**: Understand every acceptance criterion, API contract, data model change, and error scenario.
2. **Analyze the codebase**: Examine the existing code to understand:
   - Current project structure and conventions
   - Existing patterns for similar functionality
   - Files and components that will be affected
   - Shared utilities, base classes, or infrastructure that can be reused
3. **Identify the blast radius**: Map out every file that needs to be created or modified.
4. **Spot risks and unknowns**: Flag anything that could block or complicate implementation.

### Checklist

- [ ] All acceptance criteria are understood and implementable
- [ ] Affected files and modules are identified
- [ ] Existing patterns and conventions are documented
- [ ] Dependencies (libraries, services, APIs) are identified
- [ ] Potential risks and blockers are flagged

---

## Step 2 — Create the Plan

> **Goal**: Produce a clear, ordered plan that can be followed step-by-step

### Create `plan.md` Using This Structure

```markdown
# Implementation Plan: <Feature Name>

| Field       | Value            |
|-------------|------------------|
| Spec        | [spec.md](./spec.md) |
| Created     | <YYYY-MM-DD>     |
| Updated     | <YYYY-MM-DD>     |

## Summary

Brief overview of what will be implemented and the general approach.

## Prerequisites

- [ ] Any setup, configuration, or dependencies needed before starting
- [ ] Database migrations to run
- [ ] Environment variables to configure

## Implementation Steps

### Step 1: <Title>

**Description**: What this step accomplishes and why it comes first.

**Files to create/modify**:
- `path/to/file.ext` — Description of changes
- `path/to/new-file.ext` — New file, purpose

**Tests**:
- `path/to/file.test.ext` — Test descriptions

**Depends on**: None (or list previous steps)

---

### Step 2: <Title>

**Description**: What this step accomplishes.

**Files to create/modify**:
- `path/to/file.ext` — Description of changes

**Tests**:
- `path/to/file.test.ext` — Test descriptions

**Depends on**: Step 1

---

(Continue for all steps...)

## Risks & Mitigations

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| <risk description> | High/Medium/Low | High/Medium/Low | <mitigation strategy> |

## Out of Scope

Reference the spec's Out of Scope section and add any implementation-specific exclusions.
```

### Guidelines for Ordering Steps

1. **Data model first**: Database schemas, migrations, and entity/model definitions
2. **Core logic second**: Business logic, domain services, and core algorithms
3. **Integration third**: Repository/DAO implementations, external service clients
4. **API layer fourth**: Controllers, routes, request/response DTOs, validation
5. **Cross-cutting last**: Logging, monitoring, caching, authorization policies

Each step should be independently testable. If you can't write a test for a step in isolation, the step is too large — break it down further.

### What Makes a Good Plan

- **Atomic steps**: Each step can be implemented and tested independently
- **Clear dependencies**: It's obvious which steps must come before others
- **Concrete file paths**: Specific files to create or modify, not vague descriptions
- **Test-aware**: Every step includes the tests that should be written alongside it
- **Risk-conscious**: Known risks are surfaced with mitigation strategies

---

## Step 3 — Review & Activate

> **Goal**: Align with the user on the plan before writing code

### Process

1. **Present the plan**: Share `plan.md` with the user
2. **Walk through the steps**: Explain the reasoning behind the order and grouping
3. **Discuss risks**: Highlight any risks and proposed mitigations
4. **Get feedback**: The user may want to:
   - Reorder steps
   - Combine or split steps
   - Add or remove scope
   - Adjust the approach
5. **Finalize**: Update the plan based on feedback
6. **Update spec Status**: Change the spec Status from `Approved` to `In Progress`

---

## Handoff

Once the plan is finalized and the spec Status is `In Progress`, this workflow is complete. The plan becomes the input for:

- **Phase 3 — TDD Implementation** (`docs/workflows/test-driven-development.md`): Follow the plan step-by-step, using TDD for each step

The AI should follow the plan's steps in order, applying the TDD workflow to each step individually.
