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

- Adding features to an existing project (use the SDD cycle — see `spec-driven-development.md`)
- Migrating or refactoring an existing project

---

## Step 1 — Product Discovery & Requirements Gathering (Sesja Planistyczna)

> **Mode**: Collaborative interactive Q&A discovery session with AI recommendations
> **Goal**: Help the user clarify the product vision, define MVP scope, and select the technology stack — even when the user starts with only an abstract idea or problem statement.

### What to Discover

| Area | Key Questions | AI Should Recommend |
|------|--------------|---------------------|
| **Product Vision & Goals** | What problem are we solving? Who are the users? What is the core MVP? | 1-2 core value propositions and initial MVP feature boundary |
| **Project type** | Web app? API? CLI? Library? Mobile? | Based on the user's description and use case |
| **Language & framework** | What technology stack? | Based on project type, team expertise, ecosystem maturity |
| **Architecture** | Monolith? Microservices? Serverless? | Based on expected scale, team size, deployment target |
| **Database** | Relational? Document? Key-value? None? | Based on data model needs and query patterns |
| **Authentication** | Needed? What type? | Based on whether the app has users |
| **Deployment target** | Cloud? On-prem? Container? | Based on project type and user's infrastructure |
| **CI/CD** | GitHub Actions? GitLab CI? Jenkins? | Based on hosting platform and team conventions |

### How to Conduct the Conversation

- **Structured Thematic Blocks**: Group questions logically (Block 1: Product Vision & MVP Scope, Block 2: Tech Stack & Database, Block 3: Tooling & Infra).
- **Every question MUST include a concrete AI recommendation** with clear rationale. Never ask bare questions without options.
- **Support Vague Ideas**: If the user says *"I'm not sure yet"*, provide 2-3 concrete options/scenarios with pros and cons, or suggest a standard fast-track baseline.
- **Phase Gate & User Approval**: Summarize the findings of Step 1 and obtain explicit approval before generating files.

### Deliverables from Step 1

1. **High-Level Product Vision**: MVP scope definition (feeds directly into the first Spec-Driven Dev feature after bootstrap).
2. **Technical Architecture Choices**: Stack, structure, database, and tooling (feeds directly into Step 2 Scaffold and `ADR-001`).

---

## Step 2 — Project Scaffold

> **Goal**: Create the project directory structure with all necessary files

### Actions

1. **Initialize the project** using the appropriate initialization command or tool for the chosen technology stack (e.g., package initializer, project generator, or framework CLI).

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

Configure the standard code analysis, style checking (linting), and formatting tools for the chosen stack.

**Configuration**:
- Create configuration files for style guides and static analysis with sensible defaults.
- Choose settings that are standard for the ecosystem and extend from popular shared configurations.
- Ensure the formatter and linter configurations do not conflict.

### Test Framework

Configure the testing framework and test runner.

- Set up unit and integration test directories.
- Create example test files with basic configurations to establish naming and assertions patterns for unit and integration testing.
- Configure code coverage reporting tools if applicable.

### Containerization (Optional)

If the project will be containerized:

- Create a multi-stage container build configuration file (e.g., `Dockerfile`) targeting build vs production environments.
- Create a container orchestrator file (e.g., `docker-compose.yml`) for local development (orchestrating the application, databases, and dependencies).
- Create a container exclusion file (e.g., `.dockerignore`) to exclude unnecessary files.

### Task Runner & Scripts

Add common tasks or scripts to the project runner (e.g., package manager scripts, `Makefile`, `Taskfile`, or similar task runner):

- **dev** / **start**: Start the development server or application with hot-reload.
- **test**: Run the entire test suite.
- **test:unit**: Run unit tests only.
- **test:integration**: Run integration tests only.
- **test:coverage**: Run tests and generate a coverage report.
- **lint**: Run code analysis and style checks.
- **format**: Format all source files.
- **build**: Build the application for production.
- **db:migrate**: Run database migrations (if database is used).

---

## Step 5 — Quality Gates

> **Goal**: Automated checks that prevent low-quality code from being committed

### Pre-commit Hooks

Set up local automated checks (such as pre-commit hooks) using the standard tool for the ecosystem.

**Minimum automated gates:**
- Run code analysis (linter) and formatting on staged or modified files.
- Validate commit messages to ensure they follow Conventional Commit guidelines.

### Code Coverage

Configure coverage thresholds:

- **Minimum recommended**: 80% for business logic / domain layer
- **Don't enforce globally**: Skip coverage for configuration, migrations, generated code
- **Report format**: Generate HTML report for local review, lcov for CI integration

### .gitignore

Create a comprehensive git exclusion file (e.g., `.gitignore`). Must exclude:

- Build/compiled artifacts and output directories
- External dependency directories (e.g. packages, vendor folders, virtual environments)
- Editor and IDE-specific files/settings
- Local environment configuration files (always commit a template file, e.g., `.env.example`)
- Operating system temporary files
- Local test reports and coverage outputs
- Application logs and transient runtime files

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

````markdown
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

- <language/runtime version>
- <any external dependencies, e.g., database, Docker>

### Setup

```bash
# Clone the repository
git clone <repo-url>
cd <project-name>

# Install dependencies
<install-dependencies-command>

# Set up environment
cp .env.example .env
# Edit .env with your values

# Start development
<run-dev-command>
```

### Running Tests

```bash
<run-tests-command>          # All tests
<run-unit-tests-command>     # Unit tests only
<run-coverage-command>       # With coverage
```

## Project Structure

Brief explanation of the directory structure and where to find things.

## Contributing

- Follow the workflows in `docs/workflows/`
- Use Conventional Commits for all commit messages
- All features require a spec before implementation (see Spec-Driven Development)

## License

<License type>
````

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
   - Dependency installation command succeeds
   - Code analysis/linting passes
   - Test execution command passes (including example tests)
   - Production build command succeeds (if applicable)
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

1. **Add the first feature**: Use the SDD cycle (`spec-driven-development.md`) starting from Phase 1 — Discovery & Specification to specify the first feature
2. **Plan the implementation**: Use Phase 2 — Implementation Planning if the feature is complex
3. **Build it with TDD**: Use Phase 3 — TDD Implementation to write the code
4. **Review before committing**: Use Phase 4 — Code Review to ensure quality
