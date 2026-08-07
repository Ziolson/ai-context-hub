---
name: spec-driven-development
description: >
  Enforces Spec-Driven Development workflow for features and modules in an existing
  or bootstrapped project. Activate when the user wants to add features, create endpoints,
  or modify existing functionality (discover → specify → approve).
---

# Spec-Driven Development

Read and follow the instructions from the following files:
- `docs/workflows/spec-driven-development.md` — Full workflow guide
- `docs/templates/spec-template.md` — Specification template
- `docs/templates/adr-template.md` — ADR template (when architectural decisions are needed)

Also apply the global rules from `rules/global-rules.md`.

## Key Workflow Rules

### 1. Mandatory Phase Gate & Transition Checkpoints
- Always state active Phase and Step in responses.
- Do NOT transition between phases without explicit user approval ("Approved", "Proceed", "LGTM").

### 2. Discovery Lock & Per-Feature Documentation
- During Step 1 (Discover Requirements), DO NOT generate `spec.md`, `ADR`, or `plan.md`.
- All persistent documentation MUST be created in the repository under:
  - `docs/features/<feature-name>/spec.md` (Phase 1)
  - `docs/features/<feature-name>/plan.md` (Phase 2)
- System-level brain artifacts (e.g., `implementation_plan.md` in the brain directory) are NOT substitutes for repository feature documentation.

### 3. Requirement Discovery Format
- Organize discovery questions into logical, thematic blocks (e.g., Block 1: Data Model, Block 2: UX/Offline, Block 3: Tech Stack).
- EVERY question MUST include a concrete AI recommendation with clear rationale. Bare questions without recommendations are forbidden.

