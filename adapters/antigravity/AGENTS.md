Read and follow the rules defined in: rules/global-rules.md

# Workflow Skills

The following skills implement the Spec-Driven Development (SDD) cycle. Activate the appropriate skill based on the current phase of work:

- `spec-driven-development` — Activate to get an overview of the full SDD cycle, or when unsure which phase applies
- `discovery` — Activate for **Phase 1**: requirements discovery and writing a spec.md (new feature, API change, or significant behavioral change)
- `implementation-plan` — Activate for **Phase 2**: breaking an approved spec into an ordered implementation plan (optional for simple features)
- `tdd-workflow` — Activate for **Phase 3**: implementing code using Red-Green-Refactor, driven by the approved spec
- `code-review` — Activate for **Phase 4**: systematic review of code changes against the spec before committing
- `project-bootstrap` — Activate when starting a **brand new project** from scratch (runs before SDD)

# Best Practices

The following domain-specific best practice rules are available in `rules/practices/`. Apply the relevant ones based on the project type and task at hand — not all rules apply to every project:

- `rules/practices/api-design.md` — Apply when designing or modifying API endpoints
- `rules/practices/git-workflow.md` — Apply when working with branches, commits, or pull requests
- `rules/practices/frontend.md` — Apply when working on UI components, client-side logic, or styling
- `rules/practices/backend.md` — Apply when working on server-side application logic or service architecture
- `rules/practices/database.md` — Apply when designing schemas, writing queries, or creating migrations

