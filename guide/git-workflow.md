# 🔀 Git & Branching Workflow Guide

> **Conventional Commits, feature branch lifecycle, clean PR history, and hybrid human-AI collaboration.**

---

## 🎯 Purpose & Overview

A clean Git history is essential for software auditability, bisecting regressions, and maintaining readable release notes. When AI assistants generate code without strict git rules, they create vague commit messages (`fixed stuff`, `update code`), make monolithic commits touching 30 files, or commit sensitive files.

This guide outlines standards for **Conventional Commits**, feature branch naming, atomic commits, and pull request hygiene.

---

## 🏛️ Core Architectural Principles

### 1. Conventional Commits Specification
All commit messages must strictly follow the Conventional Commits format:

```
<type>(<scope>): <short summary in imperative present tense>

[optional body explaining motivation and technical rationale]

[optional footer(s), e.g. Closes #123, BREAKING CHANGE]
```

#### Allowed Commit Types:
- `feat`: A new end-user or system feature.
- `fix`: A bug fix for existing functionality.
- `docs`: Documentation changes only (`README.md`, `/guide/`).
- `style`: Formatting, missing semi-colons, white-space changes (no production code change).
- `refactor`: Refactoring production code without changing external behavior or adding tests.
- `test`: Adding or updating test cases.
- `chore`: Maintenance tasks, dependency updates, build configuration changes.

### 2. Feature Branch Lifecycle
- **Branch Naming**: Use prefixed kebab-case branch names:
  - `feature/<feature-name>` (e.g. `feature/user-authentication`)
  - `fix/<bug-description>` (e.g. `fix/jwt-expiration-handling`)
  - `refactor/<scope>` (e.g. `refactor/database-repository-layer`)
- **Atomic Commits**: Group related changes into small, logical commits rather than one massive commit at the end of feature development.

---

## 👥 Human Developer vs. AI Assistant Roles

| Area | Human Developer Role | AI Assistant Role |
|------|----------------------|-------------------|
| **Branching** | Creates feature branches and opens Pull Requests | Formats commit messages in conventional commits format |
| **Commit History** | Approves PR merge strategy (Squash & Merge vs Rebase) | Ensures single responsibility per commit |
| **Pull Requests** | Conducts final code review and signs off on merge | Summarizes pull request changes and verification results |

---

## 💡 Code Examples: Good vs. Bad Practices

### Anti-Pattern: Uninformative Commit Message ❌
```bash
# BAD: Vague, non-standard commit message
git commit -m "fixed bugs and updated login logic and updated README"
```

### Production-Grade Pattern: Conventional Commit Format ✅
```bash
# GOOD: Conventional commit with clear type, scope, and summary
git commit -m "fix(auth): resolve JWT expiration token refresh race condition

- Implement mutex lock during refresh token exchange
- Add unit test verifying parallel HTTP refresh requests
- Update authentication token error handling in user service"
```

---

## 📋 Code Review Checklist for Git Workflow

- [ ] **Conventional Commit Format**: Does the commit message start with an approved type (`feat:`, `fix:`, `docs:`)?
- [ ] **Imperative Mood**: Is the summary written in imperative present tense (*"add user endpoint"* instead of *"added user endpoint"*)?
- [ ] **Atomic Changes**: Are changes in the commit strictly focused on a single logical change?
- [ ] **No Secret Files**: Are `.env`, `.pem`, or local credential files excluded via `.gitignore`?

---

::: details Prompt Reference
<<< ../rules/practices/git-workflow.md
:::
