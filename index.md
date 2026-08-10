---
layout: home

hero:
  name: "AI Context Hub"
  text: "Tool-neutral knowledge base & workflows for AI-assisted development"
  tagline: Write your rules once. Use them across Antigravity, Cursor, Claude Code, and more.
  actions:
    - theme: brand
      text: Get Started
      link: /README
    - theme: alt
      text: Explore Workflows
      link: /docs/workflows/spec-driven-development
    - theme: alt
      text: View on GitHub
      link: https://github.com/Ziolson/ai-context-hub

features:
  - icon: 🧠
    title: Tool-Neutral Core
    details: Universal coding rules and 4-phase development workflows decoupled from specific AI coding assistants.
  - icon: ⚡
    title: Thin Adapters
    details: Native adapter configs for Antigravity/Gemini, Cursor (.mdc), and Claude Code (CLAUDE.md) referencing the single source of truth.
  - icon: 🔄
    title: 4-Phase SDLC
    details: Discovery & Specification -> Implementation Planning -> Test-Driven Development -> Structured Code Review.
  - icon: 📦
    title: Automated Setup
    details: Simple install.sh script to symlink rules and docs directly into your project root.
---

<div class="custom-home-content" style="max-width: 1152px; margin: 40px auto 0; padding: 0 24px;">

## ⚡ Quick Start

Connect **AI Context Hub** to your project using the automated installer:

```bash
# Clone the repository
git clone https://github.com/Ziolson/ai-context-hub.git

# Run setup from your project root
/path/to/ai-context-hub/install.sh all
```

---

## 📊 Spec-Driven Development (SDD) Workflow

```
┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│ Phase 1:         │────▶│ Phase 2:         │────▶│ Phase 3:         │────▶│ Phase 4:         │
│ Discovery & Spec │     │ Impl Plan        │     │ TDD Cycle        │     │ Code Review      │
└──────────────────┘     └──────────────────┘     └──────────────────┘     └──────────────────┘
```

1. **[Phase 1 — Discovery & Specification](/docs/workflows/discovery)**: Collaborative requirements discovery and writing an approved feature spec (`spec.md`).
2. **[Phase 2 — Implementation Plan](/docs/workflows/implementation-plan)**: Break approved specs into actionable, milestone-based implementation steps (*optional*).
3. **[Phase 3 — Test-Driven Development](/docs/workflows/test-driven-development)**: Red -> Green -> Refactor cycle to maintain quality and avoid regressions.
4. **[Phase 4 — Structured Code Review](/docs/workflows/code-review)**: Rigorous checklist evaluating correctness, security, performance, and maintainability.

> For the full overview, see **[Spec-Driven Development](/docs/workflows/spec-driven-development)**. Starting a new repository? See **[Project Bootstrap](/docs/workflows/project-bootstrap)**.

</div>
