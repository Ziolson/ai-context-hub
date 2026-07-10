# Project Rules

Read and follow the rules defined in: rules/global-rules.md

# Best Practices

The following domain-specific best practice rules are available. Apply the relevant ones based on the project type and task at hand:

- rules/practices/api-design.md — Apply when designing or modifying API endpoints (REST conventions, error formats, pagination, versioning)
- rules/practices/git-workflow.md — Apply when working with branches, commits, or pull requests (extends the Conventional Commits rules in global-rules.md)
- rules/practices/frontend.md — Apply when working on UI components, client-side logic, or styling (component design, state management, a11y, performance)
- rules/practices/backend.md — Apply when working on server-side logic, application architecture, or service communication (layered architecture, transactions, logging, caching)
- rules/practices/database.md — Apply when designing schemas, writing queries, or creating migrations (naming, indexing, migration safety, soft deletes)

> Not all rules apply to every project. Use context to select the relevant files:
> - Frontend-only project: `frontend.md` + `git-workflow.md`
> - Backend API: `api-design.md` + `backend.md` + `database.md` + `git-workflow.md`
> - Full-stack: all of the above

# Workflows

The following workflow guides are available. Apply the relevant one based on the task:
- docs/workflows/spec-driven-development.md — Use when adding features or modifying architecture
- docs/workflows/implementation-plan.md — Use when planning implementation of a spec
- docs/workflows/test-driven-development.md — Use when implementing code
- docs/workflows/code-review.md — Use when reviewing code
- docs/workflows/project-bootstrap.md — Use when creating a new project

# Templates

Use the templates in docs/templates/ when creating specs, ADRs, test plans, or reviews.
