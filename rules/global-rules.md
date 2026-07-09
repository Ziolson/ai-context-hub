# Global Rules

> Universal rules that apply to **every** interaction, regardless of project, language, or technology stack.
> These are non-negotiable standards — every AI assistant consuming this context must follow them.

---

## 1. Workflow Principles

- **Spec-Driven Development**: Always follow the sequence: **understand → specify → approve → implement**. Never jump to coding without understanding what needs to be built and why.
- **Test-Driven Development**: Always follow the cycle: **failing test → minimal implementation → refactor**. Code without tests is incomplete code.
- **No coding without clarity**: Never start writing code without a clear understanding of the requirements. If the requirements are ambiguous, ask for clarification first.
- **Plan before you act**: Present a plan for approval before making significant changes. "Significant" means anything that touches more than one file, changes an API contract, modifies data models, or alters architecture.

## 2. Code Quality Fundamentals

- **SOLID Principles**: Apply Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, and Dependency Inversion across all object-oriented code.
- **DRY** (Don't Repeat Yourself): Extract repeated logic into shared functions, utilities, or base classes. But don't over-abstract — two instances of similar code are not always duplication.
- **KISS** (Keep It Simple, Stupid): Prefer the simplest solution that meets the requirements. Complexity must be justified by a concrete need, not a hypothetical future one.
- **YAGNI** (You Aren't Gonna Need It): Do not build features, abstractions, or infrastructure for requirements that don't exist yet.
- **Composition over inheritance**: Prefer composing behavior from smaller, focused components rather than building deep inheritance hierarchies.
- **Small, focused functions**: Each function/method should do one thing and do it well. If you need to use the word "and" to describe what a function does, it should probably be two functions.
- **Meaningful names**: Use descriptive, intention-revealing names for variables, functions, classes, and modules. The name should tell the reader *what* and *why*, not *how*.
  - ✅ `calculate_monthly_revenue(orders)`
  - ❌ `process(data)`

## 3. Error Handling & Robustness

- **Never silently swallow exceptions/errors**: Every `catch`/`except`/`rescue` block must either handle the error meaningfully (recover, retry, fallback) or re-raise it. Empty catch blocks are forbidden.
- **Context-rich error messages**: Every error message must include: **what** happened, **where** it happened, and **why** it matters. Include relevant variable values when safe to do so.
  - ✅ `Failed to create user: email 'foo@bar.com' already exists in tenant 'acme-corp'`
  - ❌ `Error occurred`
- **Validate at boundaries**: Validate all inputs at system boundaries — API endpoints, message consumers, file readers, CLI arguments. Internal functions can trust their callers if boundaries are guarded.
- **Handle edge cases explicitly**: Don't let edge cases fall through to unexpected behavior. Handle empty collections, null/undefined values, boundary conditions, and concurrent access explicitly.

## 4. Documentation

- **Public API documentation**: Every public function, method, class, and module must have a docstring (Python), JSDoc (JavaScript/TypeScript), or equivalent. Include: purpose, parameters, return value, exceptions/errors thrown.
- **Explain the *why***: Complex business logic requires inline comments explaining **why** a decision was made, not **what** the code does. The code shows *what*; comments show *why*.
  - ✅ `// Retry up to 3 times because the payment gateway occasionally returns transient 503s`
  - ❌ `// Retry 3 times`
- **Keep README.md current**: The project README must always reflect the current state of the project — how to set up, run, test, and deploy. Stale READMEs are worse than no README.
- **Architectural Decision Records (ADRs)**: Document significant architectural decisions using ADRs. Each ADR captures: context, decision, consequences, and status. Store in `docs/features/<feature-name>/` when feature-specific, or `docs/adr/` for project-wide decisions.

## 5. Security Baseline

- **No hardcoded secrets**: Never hardcode passwords, API keys, tokens, certificates, or any credentials in source code. Use environment variables, secret managers, or configuration files excluded from version control.
- **Sanitize external inputs**: All data from external sources (user input, API responses, file uploads, query parameters) must be sanitized and validated before use. Assume all external input is hostile.
- **Parameterized queries**: Always use parameterized queries or prepared statements for database access. Never concatenate user input into SQL, NoSQL queries, or shell commands.
- **Least privilege**: Every component, service, user, and token should have the minimum permissions required to perform its function — nothing more.

## 6. Communication & Formatting

- **Language**: Write all code, comments, documentation, commit messages, and technical communication in **English**.
- **Conventional Commits**: Use the [Conventional Commits](https://www.conventionalcommits.org/) format for all commit messages:
  - `feat:` — New feature
  - `fix:` — Bug fix
  - `refactor:` — Code change that neither fixes a bug nor adds a feature
  - `test:` — Adding or modifying tests
  - `docs:` — Documentation changes
  - `chore:` — Build process, tooling, or auxiliary changes
  - Include scope when helpful: `feat(auth): add OAuth2 login flow`
- **Ask, don't assume**: When uncertain about requirements, context, or user intent — ask for clarification rather than making assumptions. A clarifying question is always cheaper than a wrong implementation.
