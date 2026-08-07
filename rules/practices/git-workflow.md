# Git Workflow Rules

> Standards for Git usage, branching, and team collaboration.
> This file EXTENDS the Conventional Commits format already defined in `rules/global-rules.md` (section 6) — refer there for commit message format. This file covers everything else: branching, PRs, and merge strategy.

---

## 1. Branching Strategy — Trunk-Based Development

Use **Trunk-Based Development** as the default strategy:

- `main` is always in a releasable state — never commit broken code directly
- Feature branches are **short-lived** (ideally 1–3 days, maximum 1 week)
- Long-running branches are a sign that work needs to be broken into smaller pieces
- Use **feature flags** to merge incomplete features to `main` safely

---

## 2. Branch Naming

Format: `<type>/<ticket-id>-<short-description>`

| Type | When to use | Example |
|------|-------------|---------|
| `feature/` | New functionality | `feature/AUTH-42-oauth2-login` |
| `bugfix/` | Bug fix (non-urgent) | `bugfix/CART-17-discount-rounding` |
| `hotfix/` | Urgent production fix | `hotfix/PAY-99-null-pointer-checkout` |
| `chore/` | Tooling, deps, config | `chore/update-node-20` |
| `refactor/` | Code restructuring without behavior change | `refactor/AUTH-55-extract-token-service` |
| `docs/` | Documentation only | `docs/api-auth-readme` |

Rules:
- Always **lowercase** with **hyphens** (no underscores, no slashes within the description)
- Include the ticket/issue ID when one exists
- Keep descriptions **short and readable** (3–5 words)

---

## 3. Commit Hygiene

> See `rules/global-rules.md` section 6 for the Conventional Commits format.

Additional rules beyond the commit message format:

- **Atomic commits**: Each commit must represent one cohesive, deliverable stage of work that leaves the repository in a consistent, working state. The test: would `git revert <hash>` undo a meaningful unit of work without breaking surrounding functionality? If yes — the commit is well-scoped. Split commits when changes are *unrelated*, not just when they are *multiple*.
- **No `WIP` commits on `main`**: Squash work-in-progress commits before merging
- **No commented-out code**: Delete it — Git history preserves it if needed
- **No debugging artifacts**: Remove `console.log`, `print`, `debugger`, `TODO: remove this` before committing
- **Verify before committing**: Run linter and tests locally before pushing

---

## 4. Pull Request Standards

### Size
- Target **under 400 lines changed** per PR (excluding generated files, lockfiles)
- If larger, split into smaller PRs with a logical dependency order
- A PR that "just" does two unrelated things should be two PRs

### Description Template

Every PR must include:

```markdown
## What
Brief description of the change.

## Why
Why is this change needed? Link to the ticket/issue.

## How
Key implementation decisions or non-obvious approaches.

## Testing
How was this tested? What scenarios were covered?

## Checklist
- [ ] Tests added/updated
- [ ] Documentation updated (if needed)
- [ ] No hardcoded secrets or credentials
```

### Self-Review
Before requesting a review:
1. Read your own diff from top to bottom
2. Leave comments on anything non-obvious so reviewers don't have to guess
3. Verify the PR description accurately describes the diff

### Review Turnaround
- Respond to review requests **within one business day**
- Do not merge without at least one approval (unless explicitly agreed otherwise on the team)

---

## 5. Merge Strategy

- **Feature branches → `main`**: **Squash merge** — keeps `main` history clean with one commit per feature
- **Hotfixes**: Merge commit (preserve the hotfix context)
- Always **rebase** your branch on top of `main` before merging to resolve conflicts locally
- **Never force-push** to `main` or any shared branch
- Delete the source branch after merging

---

## 6. Tags & Releases

- Use **semantic versioning**: `v<MAJOR>.<MINOR>.<PATCH>` (e.g., `v2.3.1`)
- Tag every production release on `main`
- Write a changelog entry for every release (auto-generate from Conventional Commits if possible)

---

## 7. What NOT to Commit

Add these to `.gitignore` — never commit:

- Environment files with secrets (`.env`, `.env.local`) — always commit a `.env.example` template instead
- Build output (`dist/`, `build/`, `*.class`, `*.pyc`)
- Dependency directories (`node_modules/`, `vendor/`, `.venv/`)
- IDE/editor files (`.idea/`, `.vscode/` unless team-shared settings)
- OS files (`.DS_Store`, `Thumbs.db`)
- Test coverage reports and logs
