# Phase 1 — Spec-Driven Development

> **Discovery & Specification Workflow**
> Collaborative process to go from a vague idea to an approved, actionable specification.

---

## Purpose & Trigger

**Activate this workflow when the user wants to:**

- Add a new feature or capability
- Create or modify an API endpoint
- Modify system architecture or data models
- Build a new component or module
- Make any significant change that affects behavior, contracts, or structure

**This workflow is NOT needed for:**

- Simple bug fixes with obvious solutions
- Typo corrections or formatting changes
- Dependency updates with no behavioral change

## What This Workflow Produces

| Artifact | Path | Description |
|----------|------|-------------|
| Feature Spec | `docs/features/<feature-name>/spec.md` | Complete specification document |
| ADRs (optional) | `docs/features/<feature-name>/ADR-NNN-<title>.md` | Architectural Decision Records |

### Per-Feature Documentation Structure

Every feature gets its own folder under `docs/features/`:

```
docs/features/<feature-name>/
├── spec.md                    # Feature specification (this workflow)
├── plan.md                    # Implementation plan (Phase 2)
├── review.md                  # Code review results (Phase 4)
└── ADR-NNN-<title>.md         # Architectural decisions (as needed)
```

**Naming convention**: Use lowercase kebab-case for `<feature-name>` (e.g., `user-authentication`, `payment-processing`, `csv-export`).

### Spec Status Tracking

Every `spec.md` includes a `Status` field in its frontmatter that tracks progress:

| Status | Meaning |
|--------|---------|
| `Draft` | Spec is being written or refined — not ready for implementation |
| `Approved` | Spec has been reviewed and explicitly approved by the user |
| `In Progress` | Implementation has started (Phase 2 or Phase 3 active) |
| `Done` | All acceptance criteria pass, code review complete |
| `Deprecated` | Feature was abandoned, superseded, or rolled back |

---

## Step 1 — Discover Requirements

> **Mode**: Collaborative conversation
> **Goal**: Build a complete understanding of what needs to be built, for whom, and why

This is an interactive, open-ended conversation between the AI and the user. The conversation continues until the user decides there is enough context to write a specification.

### How the AI Should Behave

**Every question must come with a recommendation or suggestion.** The AI must NEVER just ask bare questions. Every question should be accompanied by:

- A suggested answer based on analysis of the existing codebase
- A recommendation based on industry best practices
- An inference based on the user's previous decisions and patterns

The user can then **accept**, **modify**, or **reject** each recommendation.

#### Example — Good ✅

> "For the authentication system, should we support OAuth2, API keys, or both?
>
> **My recommendation**: Based on your existing REST API structure and the fact that you already have a `User` model with email/password, I'd suggest starting with **JWT-based authentication** with email/password login, and adding OAuth2 as a follow-up feature. This keeps the initial scope manageable while setting up the token infrastructure you'll need for OAuth2 later.
>
> Want to go with this approach, or do you have different requirements?"

#### Example — Bad ❌

> "What authentication method should we use?"

### Focus Areas During Discovery

| Area | Key Questions |
|------|--------------|
| **Users & Actors** | Who uses this feature? What are their roles and permissions? |
| **Core Behavior** | What is the happy path? What does success look like? |
| **Edge Cases** | What happens when inputs are invalid, missing, or unexpected? |
| **Affected Components** | Which existing files, modules, or services will be touched? |
| **Constraints** | Performance requirements? Compatibility needs? Deadlines? |
| **Dependencies** | Does this depend on or block other features? |
| **Out of Scope** | What are we explicitly NOT building right now? |

### AI Proactive Responsibilities

- **Identify issues early**: If the user's request conflicts with the existing architecture, say so immediately.
- **Surface trade-offs**: When there are multiple valid approaches, present the trade-offs clearly.
- **Analyze the codebase**: Before asking questions, examine the existing code to understand current patterns, conventions, and constraints.
- **Reference previous decisions**: If similar decisions were made before (in ADRs or other specs), reference them.

### Fast-Track for Simple Requests

For straightforward requests where the requirements are obvious:

> "This seems straightforward — I'd suggest [approach with brief rationale]. Want me to proceed directly to the spec, or would you like to discuss further?"

The user can accept the fast-track or opt for full discovery.

---

## Step 2 — Write Specification

> **Goal**: Produce a complete, unambiguous spec document that can drive implementation and testing

### Actions

1. **Create the feature folder**: `docs/features/<feature-name>/`
2. **Create `spec.md`** using the standard spec template (see below)
3. **Set Status**: `Draft`
4. **Create ADRs** if any architectural decisions were made during discovery

### Spec Template

```markdown
# Feature: <Feature Name>

| Field       | Value            |
|-------------|------------------|
| Status      | Draft            |
| Author      | <name>           |
| Created     | <YYYY-MM-DD>     |
| Updated     | <YYYY-MM-DD>     |

## Problem Statement

What problem are we solving? Why does it matter? Who is affected?

## Proposed Solution

High-level description of the approach. What will be built and how will it work?

## User Stories

- As a [role], I want [capability] so that [benefit].
- As a [role], I want [capability] so that [benefit].

## Acceptance Criteria

### AC-1: <Criteria Title>
- **Given** <precondition>
- **When** <action>
- **Then** <expected result>

### AC-2: <Criteria Title>
- **Given** <precondition>
- **When** <action>
- **Then** <expected result>

## API Contract

### `METHOD /path`

**Request**:
\```json
{
  "field": "type — description"
}
\```

**Response (success)**:
\```json
{
  "field": "type — description"
}
\```

**Response (error)**:
\```json
{
  "error": "string — error message"
}
\```

## Data Model Changes

Describe any new tables, columns, indexes, or schema modifications.

## Error Scenarios

| Scenario | Expected Behavior | HTTP Status |
|----------|-------------------|-------------|
| Invalid input | Return validation error | 400 |
| Not found | Return not found error | 404 |

## Non-Functional Requirements

- **Performance**: <requirements>
- **Security**: <requirements>
- **Scalability**: <requirements>

## Out of Scope

List what is explicitly NOT included in this feature.

## Open Questions

List any unresolved questions (should be empty before Approved status).
```

---

## Step 3 — Review & Approve

> **Goal**: Get explicit user approval before any implementation begins

### Process

1. **Present the spec**: Share the complete `spec.md` with the user
2. **Solicit feedback**: Ask the user to review each section
3. **Iterate**: Update the spec based on feedback — this may require multiple rounds
4. **Get explicit approval**: The user must explicitly say the spec is approved. Look for phrases like "approved", "looks good, proceed", "LGTM", etc.
5. **Update Status**: Change Status from `Draft` to `Approved`

### Critical Rule

> ⚠️ **Do NOT proceed to implementation without explicit approval.**
> A spec in `Draft` status must never be used as input for Phase 2 or Phase 3.
> If the user seems to want to skip approval, remind them: "I want to make sure we're aligned before writing code. Could you confirm the spec looks good?"

---

## Handoff

Once the spec Status is `Approved`, this workflow is complete. The approved spec becomes the input for:

- **Phase 2 — Implementation Planning** (`docs/workflows/implementation-plan.md`): For complex features that need a detailed plan
- **Phase 3 — TDD Implementation** (`docs/workflows/test-driven-development.md`): For features ready to implement directly

The user decides which phase to enter next.
