# Project Bootstrap

> **From Zero to Production-Ready Project**
> Step-by-step workflow for setting up a new project with proper structure, tooling, quality gates, and documentation.

---

## Purpose & Trigger

**Activate this workflow when:**

- The user wants to create a new project from scratch
- The user says "new project", "start a project", "bootstrap", "scaffold", or similar
- A new service/microservice needs to be created within an existing ecosystem

**This workflow is NOT for:**

- Adding features to an existing project (use Phase 1 — Spec-Driven Development)
- Migrating or refactoring an existing project

---

## Step 1 — Requirements Gathering

> **Mode**: Collaborative conversation with recommendations
> **Goal**: Understand what we're building, for whom, and with what constraints

### What to Discover

| Area | Key Questions | AI Should Recommend |
|------|--------------|---------------------|
| **Project type** | Web app? API? CLI? Library? Mobile? | Based on the user's description and use case |
| **Language & framework** | What technology stack? | Based on project type, team expertise, ecosystem maturity |
| **Architecture** | Monolith? Microservices? Serverless? | Based on expected scale, team size, deployment target |
| **Database** | Relational? Document? Key-value? None? | Based on data model needs and query patterns |
| **Authentication** | Needed? What type? | Based on whether the app has users |
| **Deployment target** | Cloud? On-prem? Container? | Based on project type and user's infrastructure |
| **CI/CD** | GitHub Actions? GitLab CI? Jenkins? | Based on hosting platform and team conventions |
| **Team conventions** | Existing style guides? Mono-repo? | Based on user's other projects if visible |

### How to Conduct the Conversation

Follow the same principles as Phase 1 — Spec-Driven Development:

- **Every question comes with a recommendation** based on best practices and context
- The user can accept, modify, or reject each recommendation
- For simple projects, offer a fast-track: "For a typical [type] project, I'd suggest [stack]. Want to go with this or customize?"

### Deliverable

A clear understanding of:
- Technology stack (language, framework, database, key libraries)
- Project structure preferences
- Development environment requirements
- Quality and deployment standards

---

## Step 2 — Project Scaffold

> **Goal**: Create the project directory structure with all necessary files

### Actions

1. **Initialize the project** using the appropriate tool:
   - `npm init` / `npx create-*` for JavaScript/TypeScript projects
   - `cargo init` for Rust
   - `go mod init` for Go
   - `poetry init` / `uv init` for Python
   - Framework-specific CLI for frameworks (Next.js, Django, Spring Boot, etc.)

2. **Set up the directory structure** following conventions for the chosen stack. Example for a typical backend API:

   ```
   project-root/
   ├── src/
   │   ├── config/          # Configuration and environment
   │   ├── domain/          # Business logic, entities, value objects
   │   ├── application/     # Use cases, services
   │   ├── infrastructure/  # Database, external APIs, messaging
   │   └── api/             # Controllers, routes, middleware
   ├── tests/
   │   ├── unit/
   │   ├── integration/
   │   └── e2e/
   ├── docs/
   │   ├── features/        # Feature documentation (specs, plans, reviews)
   │   └── adr/             # Project-wide architectural decisions
   ├── scripts/             # Development and deployment scripts
   └── ...config files
   ```

3. **Install core dependencies** for the chosen stack.

---

## Step 3 — Connect ai-context-hub

> **Goal**: Set up the AI context system so AI assistants have full project context

### Actions

1. **Detect the AI tool** the user works with (or ask):
   - GitHub Copilot → `.github/copilot-instructions.md`
   - Cursor → `.cursor/rules/`
   - Windsurf → `.windsurf/rules/`
   - Claude Code → `CLAUDE.md`
   - Other tools → ask for the appropriate format

2. **Set up the adapter**: Create the adapter file that references the core knowledge base files from `ai-context-hub/`:
   - Reference global rules
   - Reference relevant workflow documents
   - Add project-specific context (tech stack, conventions, domain knowledge)

3. **Verify the connection**: Ensure the AI tool picks up the context by checking its configuration format and path conventions.

---

## Step 4 — Development Environment

> **Goal**: Configure tooling for consistent, high-quality development

### Linter & Formatter

Set up language-appropriate tools:

| Language | Linter | Formatter |
|----------|--------|-----------|
| TypeScript/JavaScript | ESLint | Prettier |
| Python | Ruff (lint + format) | Ruff |
| Go | golangci-lint | gofmt |
| Rust | clippy | rustfmt |
| Java/Kotlin | Checkstyle / ktlint | google-java-format / ktlint |

**Configuration**: Create config files with sensible defaults. Extend from popular shared configs when available (e.g., `eslint:recommended`, `@typescript-eslint/recommended`).

### Test Framework

Set up the testing framework and structure:

| Language | Framework | Notes |
|----------|-----------|-------|
| TypeScript/JavaScript | Jest or Vitest | Vitest for Vite-based projects |
| Python | pytest | With `pytest-cov` for coverage |
| Go | Built-in `testing` | With `testify` for assertions |
| Rust | Built-in `#[test]` | With integration test directory |
| Java | JUnit 5 | With Mockito for mocking |

Create example test files to establish patterns:
- `tests/unit/example.test.ts` — Shows unit test conventions
- `tests/integration/example.test.ts` — Shows integration test setup

### Containerization (Optional)

If the project will be containerized:

- Create `Dockerfile` with multi-stage build (build → production)
- Create `docker-compose.yml` for local development (app + database + other services)
- Create `.dockerignore` to exclude unnecessary files

### Scripts

Add common development scripts to `package.json` / `Makefile` / `Taskfile` / `justfile`:

```
dev          — Start development server with hot reload
test         — Run all tests
test:unit    — Run unit tests only
test:int     — Run integration tests only
test:cov     — Run tests with coverage report
lint         — Run linter
format       — Run formatter
build        — Build for production
db:migrate   — Run database migrations
```

---

## Step 5 — Quality Gates

> **Goal**: Automated checks that prevent low-quality code from being committed

### Pre-commit Hooks

Set up pre-commit hooks using the appropriate tool:

- **JavaScript/TypeScript**: `husky` + `lint-staged`
- **Python**: `pre-commit` framework
- **Go**: Custom Git hooks or `pre-commit`
- **Language-agnostic**: `lefthook`

**Minimum hooks:**
- `pre-commit`: Run linter and formatter on staged files
- `commit-msg`: Validate Conventional Commit format

### Code Coverage

Configure coverage thresholds:

- **Minimum recommended**: 80% for business logic / domain layer
- **Don't enforce globally**: Skip coverage for configuration, migrations, generated code
- **Report format**: Generate HTML report for local review, lcov for CI integration

### .gitignore

Create a comprehensive `.gitignore` for the chosen stack. Must include:

- Build artifacts and compiled output
- Dependency directories (`node_modules/`, `venv/`, `.venv/`)
- IDE-specific files (`.idea/`, `.vscode/settings.json`)
- Environment files (`.env`, `.env.local` — but commit `.env.example`)
- OS files (`.DS_Store`, `Thumbs.db`)
- Coverage reports and test artifacts
- Log files

---

## Step 6 — Documentation & Feature Docs Structure

> **Goal**: Establish documentation practices from day one

### Create Documentation Structure

```
docs/
├── features/                   # Feature specifications (empty, ready for Phase 1)
│   └── .gitkeep
└── adr/                        # Project-wide ADRs
    └── ADR-001-initial-architecture.md
```

### README.md

Create a comprehensive README with:

```markdown
# <Project Name>

<One-line description>

## Overview

What this project does and why it exists.

## Tech Stack

- **Language**: ...
- **Framework**: ...
- **Database**: ...
- **Testing**: ...

## Getting Started

### Prerequisites

- Node.js >= 20 (or relevant runtime)
- Docker (optional, for local database)

### Setup

\```bash
# Clone the repository
git clone <repo-url>
cd <project-name>

# Install dependencies
npm install

# Set up environment
cp .env.example .env
# Edit .env with your values

# Start development
npm run dev
\```

### Running Tests

\```bash
npm test          # All tests
npm run test:unit # Unit tests only
npm run test:cov  # With coverage
\```

## Project Structure

Brief explanation of the directory structure and where to find things.

## Contributing

- Follow the workflows in `docs/workflows/`
- Use Conventional Commits for all commit messages
- All features require a spec before implementation (see Spec-Driven Development)

## License

<License type>
```

### Project-Specific Rules

Create project-specific rules that extend the global rules from `ai-context-hub`. These capture decisions and conventions unique to this project:

- Chosen architecture pattern and layer responsibilities
- Naming conventions beyond the global rules
- Database conventions (naming, indexing, migration rules)
- API conventions (versioning, pagination, error format)
- Domain-specific terminology

### First ADR

Create `docs/adr/ADR-001-initial-architecture.md`:

```markdown
# ADR-001: Initial Architecture

| Field     | Value           |
|-----------|-----------------|
| Status    | Accepted        |
| Date      | <YYYY-MM-DD>    |

## Context

<Why this project was created and what constraints exist>

## Decision

<The architectural decisions made during bootstrap>
- Language/framework chosen and why
- Architecture pattern chosen and why
- Database chosen and why
- Key libraries chosen and why

## Consequences

### Positive
- <benefits of these decisions>

### Negative
- <trade-offs accepted>

### Risks
- <risks to monitor>
```

---

## Step 7 — First Commit

> **Goal**: Save the project scaffold with a clean initial commit

### Actions

1. **Review everything**: Walk through the created files with the user
2. **Verify the setup**:
   - `npm install` (or equivalent) succeeds
   - `npm run lint` passes
   - `npm test` passes (example tests)
   - `npm run build` succeeds (if applicable)
3. **Initial commit**:
   ```
   chore: bootstrap <project-name>

   - Initialize <framework> project with <language>
   - Set up testing with <test-framework>
   - Configure linting and formatting
   - Add pre-commit hooks and quality gates
   - Create documentation structure
   - Connect ai-context-hub adapter

   ADR-001: Initial Architecture
   ```

---

## What's Next

After the project is bootstrapped:

1. **Add the first feature**: Use Phase 1 — Spec-Driven Development to specify the first feature
2. **Plan the implementation**: Use Phase 2 — Implementation Planning if the feature is complex
3. **Build it with TDD**: Use Phase 3 — TDD Implementation to write the code
4. **Review before committing**: Use Phase 4 — Code Review to ensure quality
