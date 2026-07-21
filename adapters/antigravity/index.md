# 🤖 Antigravity / Gemini Adapter

The Antigravity adapter integrates **AI Context Hub** with [Google Antigravity](https://github.com/google) using native `AGENTS.md` rules and custom skills.

---

## 📁 Adapter Files & Skills

| Component | Path | Description |
|-----------|------|-------------|
| **Global Rules** | `AGENTS.md` | Core instructions pointing to `rules/global-rules.md` |
| **Spec-Driven Dev Skill** | `skills/spec-driven-dev/SKILL.md` | Guided feature specification workflow |
| **Implementation Plan Skill** | `skills/implementation-plan/SKILL.md` | Step-by-step task breakdown workflow |
| **TDD Workflow Skill** | `skills/tdd-workflow/SKILL.md` | Red-Green-Refactor test-driven workflow |
| **Code Review Skill** | `skills/code-review/SKILL.md` | Comprehensive checklist audit workflow |
| **Project Bootstrap Skill** | `skills/project-bootstrap/SKILL.md` | New project structure initialization workflow |

---

## 🚀 Setup for Antigravity

Run the automated installer from your target project root:

```bash
/path/to/ai-context-hub/install.sh antigravity
```

Or manually symlink:

```bash
ln -s /path/to/ai-context-hub/rules rules
ln -s /path/to/ai-context-hub/docs docs
ln -s /path/to/ai-context-hub/adapters/antigravity/skills .agents/skills/ai-context-hub
cp /path/to/ai-context-hub/adapters/antigravity/AGENTS.md .agents/AGENTS.md
```
