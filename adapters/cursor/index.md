# ⚡ Cursor Adapter (.mdc rules)

The Cursor adapter integrates **AI Context Hub** with [Cursor IDE](https://cursor.com) using native `.mdc` rule files stored in `.cursor/rules/`.

---

## 📁 Rule Files

Each rule file references the core single-source-of-truth documentation using Cursor's `@file` directive:

| Rule File | Purpose | Reference |
|-----------|---------|-----------|
| `global-rules.mdc` | Applied to all AI interactions in Cursor | `@rules/global-rules.md` |
| `spec-driven-development.mdc` | Triggered when asking for feature specs | `@docs/workflows/spec-driven-development.md` |
| `implementation-plan.mdc` | Triggered when creating implementation plans | `@docs/workflows/implementation-plan.md` |
| `test-driven-development.mdc` | Triggered when implementing code via TDD | `@docs/workflows/test-driven-development.md` |
| `code-review.mdc` | Triggered during code reviews | `@docs/workflows/code-review.md` |
| `project-bootstrap.mdc` | Triggered when setting up new projects | `@docs/workflows/project-bootstrap.md` |

---

## 🚀 Setup for Cursor

Run the automated installer from your target project root:

```bash
/path/to/ai-context-hub/install.sh cursor
```

Or manually copy/symlink the rules into your project:

```bash
mkdir -p .cursor/rules
cp -r /path/to/ai-context-hub/rules rules
cp -r /path/to/ai-context-hub/docs docs
cp /path/to/ai-context-hub/adapters/cursor/rules/*.mdc .cursor/rules/
```
