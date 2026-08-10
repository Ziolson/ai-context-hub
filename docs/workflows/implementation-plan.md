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

> [!NOTE]
> Plan steps should represent complete functional slices (Vertical Slices) based on the Acceptance Criteria (AC) from the spec. Each step implements a given AC end-to-end (from database to API). Avoid layer-by-layer planning (e.g., all database models first, then all business logic).

### Step 1: Implement AC-1 [Short Title]

**Description**: Technical implementation details for this AC from backend to presentation layer.

**Files to create/modify**:
- `path/to/model.ext` — Data model changes
- `path/to/service.ext` — Business logic for this AC
- `path/to/controller.ext` — API endpoint for this AC

**Tests**:
- `path/to/file.test.ext` — Target integration/E2E and unit tests for this AC. Test scenarios and edge cases will be verified in code during the TDD Red phase.

**Depends on**: None (or list previous steps)

---

### Step 2: Implement AC-2 [Short Title]

**Description**: Technical implementation details.

**Files to create/modify**:
- `path/to/file.ext` — Changes

**Tests**:
- `path/to/file.test.ext` — Tests for AC-2

**Depends on**: Step 1

---

(Continue for all steps/ACs...)

## Risks & Mitigations

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| <risk description> | High/Medium/Low | High/Medium/Low | <mitigation strategy> |

## Out of Scope

Reference the spec's Out of Scope section and add any implementation-specific exclusions.
```

### Guidelines for Ordering Steps

1. **Vertical Slicing**: Organize steps around Acceptance Criteria (AC). Start with foundational, independent ACs, then move to more complex ones that build on them.
2. **End-to-End Implementation**: Each step should touch all necessary application layers (database, logic, API) required to deliver the functionality described by that AC.
3. **Do not plan test cases in markdown**: The plan should only specify test file paths. Concrete test scenarios will be verified directly in code during the TDD (Red-Green-Refactor) phase.

Each step must be testable via an integration or E2E test according to TDD principles. If a step only creates a database model without any accessible logic to interact with, it is a horizontal (layer-based) step rather than a Vertical Slice. Adjust the approach to be vertical.

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
