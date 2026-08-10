# 🧠 AI Context Hub

**Tool-neutral knowledge base of workflow rules and skills for AI-assisted development.**

AI Context Hub provides a single source of truth for development workflows — Spec-Driven Development, Test-Driven Development, Code Review, and more — that works across any AI coding assistant. Write your rules once, use them everywhere.

---

## 📦 What's Inside

```
ai-context-hub/
├── .vitepress/                   # VitePress documentation site configuration
├── .github/workflows/deploy.yml  # Automated GitHub Pages deployment
├── index.md                      # Documentation landing page
├── rules/                        # Global coding rules
│   └── global-rules.md           # Universal rules for every interaction
├── docs/
│   ├── workflows/                # Step-by-step workflow guides
│   │   ├── spec-driven-development.md
│   │   ├── discovery.md
│   │   ├── implementation-plan.md
│   │   ├── test-driven-development.md
│   │   ├── code-review.md
│   │   └── project-bootstrap.md
│   ├── templates/                # Reusable document templates
│   │   ├── spec-template.md
│   │   ├── adr-template.md
│   │   └── review-checklist-template.md
│   └── features/                 # Per-feature documentation
│       └── <feature-name>/
│           ├── spec.md
│           ├── adr-*.md
│           └── review.md
└── adapters/                     # Tool-specific adapter files
    ├── antigravity/              # Google Antigravity / Gemini
    ├── cursor/                   # Cursor IDE
    └── claude-code/              # Claude Code (Anthropic)
```

### Core Knowledge (tool-neutral)

| Directory | Purpose |
|-----------|---------|
| `rules/` | Global rules that apply to **every** AI interaction — coding standards, naming conventions, error handling policies |
| `docs/workflows/` | Step-by-step workflow guides for each phase of development |
| `docs/templates/` | Reusable templates for specifications, ADRs, and reviews |
| `docs/features/` | Per-feature documentation generated during development |

### Adapters (tool-specific)

Adapters are thin configuration files that **reference** the core docs — they never duplicate content. Each adapter speaks the native format of its target tool:

| Adapter | Format | Files |
|---------|--------|-------|
| **Antigravity / Gemini** | `AGENTS.md` + `SKILL.md` | Global rules + 6 skills |
| **Cursor** | `.mdc` rules | 11 rule files with `@file` references |
| **Claude Code** | `CLAUDE.md` | Single file referencing all docs |

---

## 🌐 Documentation Site

Explore the full documentation, workflows, and rule reference online at **[ziolson.github.io/ai-context-hub](https://ziolson.github.io/ai-context-hub/)**.

To run the documentation site locally:

```bash
# Install dependencies
npm install

# Start local dev server
npm run docs:dev
```

---

## 🚀 Quick Setup

The easiest way to connect this repository to your project is using the automated `install.sh` script, which automatically creates the necessary symlinks.

### Option A — Automated Setup (Recommended)

Run the script from your **target project root**, pointing to the cloned `ai-context-hub` directory:

```bash
# Setup a specific tool (antigravity, cursor, or claude)
/path/to/ai-context-hub/install.sh [tool_name]

# Setup all tools
/path/to/ai-context-hub/install.sh all
```

*This will automatically symlink the core `rules/` and `docs/` folders, and configure your chosen adapter files.*

---

### Option B — Manual Setup

If you prefer to configure the symlinks manually, follow the commands below based on your tool. Make sure to replace `/path/to/ai-context-hub/` with the actual path to your cloned repository.

#### Antigravity / Gemini

**Symlink core folders and the skills directory:**

```bash
# From your project root
ln -s /path/to/ai-context-hub/rules rules
ln -s /path/to/ai-context-hub/docs docs
ln -s /path/to/ai-context-hub/adapters/antigravity/skills .agents/skills/ai-context-hub
cp /path/to/ai-context-hub/adapters/antigravity/AGENTS.md .agents/AGENTS.md
```

#### Cursor

**Symlink the rules and configuration into your project:**

```bash
# From your project root
ln -s /path/to/ai-context-hub/rules rules
ln -s /path/to/ai-context-hub/docs docs
mkdir -p .cursor/rules
ln -s /path/to/ai-context-hub/adapters/cursor/rules/*.mdc .cursor/rules/
```

Or copy them directly:

```bash
# From your project root
cp -r /path/to/ai-context-hub/rules rules
cp -r /path/to/ai-context-hub/docs docs
mkdir -p .cursor/rules
cp /path/to/ai-context-hub/adapters/cursor/rules/*.mdc .cursor/rules/
```

#### Claude Code

**Symlink the rules and configuration to your project root:**

```bash
# From your project root
ln -s /path/to/ai-context-hub/rules rules
ln -s /path/to/ai-context-hub/docs docs
ln -s /path/to/ai-context-hub/adapters/claude-code/CLAUDE.md CLAUDE.md
```

Or copy:

```bash
# From your project root
cp -r /path/to/ai-context-hub/rules rules
cp -r /path/to/ai-context-hub/docs docs
cp /path/to/ai-context-hub/adapters/claude-code/CLAUDE.md CLAUDE.md
```

> **Note:** All adapters reference files using relative paths from the project root. The commands above ensure that the core `docs/` and `rules/` directories are placed or symlinked directly at the root of your project.

---

## 🔄 Spec-Driven Development (SDD) Workflow Overview

AI Context Hub enforces **Spec-Driven Development (SDD)** as the universal workflow for feature and bug development. Every non-trivial change follows a 4-phase cycle:

```
┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│ Phase 1:         │────▶│ Phase 2:         │────▶│ Phase 3:         │────▶│ Phase 4:         │
│ Discovery & Spec │     │ Impl Plan        │     │ TDD Cycle        │     │ Code Review      │
│ (discovery.md)   │     │ (optional)       │     │ (tdd.md)         │     │ (code-review.md) │
└──────────────────┘     └──────────────────┘     └──────────────────┘     └──────────────────┘
```

> Hub Overview: [`docs/workflows/spec-driven-development.md`](docs/workflows/spec-driven-development.md)

### Phase 1: Discovery & Specification

**Workflow:** [`docs/workflows/discovery.md`](docs/workflows/discovery.md)

Before writing any code, create an approved specification (`spec.md`). The AI guides you through:
1. **Discover** — Analyze requirements, explore codebase, identify constraints with AI recommendations
2. **Specify** — Write a formal feature spec using standard template
3. **Approve** — Get explicit user approval before moving to implementation

### Phase 2: Implementation Planning (Optional)

**Workflow:** [`docs/workflows/implementation-plan.md`](docs/workflows/implementation-plan.md)

Break an approved spec into actionable tasks with dependencies and milestones. Skip only for simple features.

### Phase 3: TDD Implementation

**Workflow:** [`docs/workflows/test-driven-development.md`](docs/workflows/test-driven-development.md)

Implement features using Test-Driven Development:
1. **Red** — Write a failing test for acceptance criteria
2. **Green** — Write minimal code to pass
3. **Refactor** — Clean up while keeping tests green

### Phase 4: Code Review

**Workflow:** [`docs/workflows/code-review.md`](docs/workflows/code-review.md)

Systematic code review using a structured checklist covering correctness, security, performance, and maintainability.

> **Starting a new project?** Use the **[Project Bootstrap Workflow](docs/workflows/project-bootstrap.md)** (`project-bootstrap.md`) to set up initial repository structure, context adapters, quality gates, and initial architecture.

---

## 📁 Per-Feature Documentation

Each feature gets its own documentation directory under `docs/features/`:

```
docs/features/user-authentication/
├── spec.md                 # Feature specification
├── adr-001-jwt-vs-session.md  # Architectural Decision Record
└── review.md               # Code review checklist
```

This creates a **living record** of every design decision, making onboarding and future modifications dramatically easier.

---

## 🤝 Contributing

### Adding a New Workflow

1. Create the workflow guide in `docs/workflows/<workflow-name>.md`
2. Create any needed templates in `docs/templates/`
3. Add adapter files for each supported tool:
   - `adapters/antigravity/skills/<skill-name>/SKILL.md`
   - `adapters/cursor/rules/<rule-name>.mdc`
   - Update `adapters/claude-code/CLAUDE.md`

### Adding a New Tool Adapter

1. Create a new directory under `adapters/<tool-name>/`
2. Use the tool's native configuration format
3. **Reference** core docs — never duplicate content
4. Update this README with setup instructions

### Key Principles

- **Single Source of Truth** — All knowledge lives in `docs/` and `rules/`. Adapters only reference.
- **Tool Neutrality** — Core docs contain no tool-specific syntax.
- **Thin Adapters** — Each adapter is a lightweight pointer, not a copy.

---

## 🗺️ Roadmap

### Iteration 2 — Tech-Specific Skills

Upcoming skills for technology-specific workflows:

| Skill | Description |
|-------|-------------|
| **Java** | Spring Boot conventions, Maven/Gradle, package structure |
| **TypeScript** | Strict mode, type patterns, framework conventions |
| **SQL** | Schema design, migration workflows, query optimization |
| **NoSQL** | Document modeling, denormalization strategies |
| **Docker** | Dockerfile best practices, compose patterns, multi-stage builds |
| **CI/CD** | Pipeline templates, deployment strategies |
| **API Design** | REST/GraphQL conventions, versioning, documentation |
| **Security** | OWASP guidelines, dependency scanning, secrets management |

### Future Iterations

- **Team presets** — Shareable rule bundles for teams
- **Validation tooling** — CLI to verify adapter ↔ core doc consistency
- **More AI tools** — Adapters for Windsurf, Copilot, Cody, and others

---

## 📄 License

See [LICENSE](https://github.com/Ziolson/ai-context-hub/blob/main/LICENSE) for details.