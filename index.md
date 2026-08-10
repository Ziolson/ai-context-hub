---
layout: home

hero:
  name: "AI Context Hub"
  text: "Tool-neutral knowledge base & workflows for AI-assisted development"
  tagline: Ready-to-use coding standards and SDD workflows for Antigravity, Cursor, Claude Code, and more.
  actions:
    - theme: brand
      text: Explore Guides
      link: /guide/
    - theme: alt
      text: Explore SDD Workflow
      link: /guide/spec-driven-development-explained
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

Connect **AI Context Hub** to your project in seconds using the automated installer:

```bash
# Clone the repository
git clone https://github.com/Ziolson/ai-context-hub.git

# Run setup from your project root
/path/to/ai-context-hub/install.sh all
```

---

## 📊 Spec-Driven Development (SDD) Workflow

The core methodology of AI Context Hub. Every non-trivial feature or bug follows a structured 4-phase development cycle:

<div class="sdd-grid">
  <div class="sdd-card">
    <div>
      <div class="card-header">
        <span class="badge badge-required">Phase 1 • Mandatory</span>
      </div>
      <h3 class="card-title">1. Discovery & Spec</h3>
      <p class="card-desc">Collaborative Q&A with AI recommendations to discover requirements and write an approved feature spec (<code>spec.md</code>).</p>
    </div>
    <a href="/ai-context-hub/docs/workflows/discovery" class="card-link">Explore Phase 1 →</a>
  </div>

  <div class="sdd-card">
    <div>
      <div class="card-header">
        <span class="badge badge-optional">Phase 2 • Optional</span>
      </div>
      <h3 class="card-title">2. Implementation Plan</h3>
      <p class="card-desc">Break down approved specs into actionable tasks, milestones, and step gates for complex architectural changes.</p>
    </div>
    <a href="/ai-context-hub/docs/workflows/implementation-plan" class="card-link">Explore Phase 2 →</a>
  </div>

  <div class="sdd-card">
    <div>
      <div class="card-header">
        <span class="badge badge-required">Phase 3 • Mandatory</span>
      </div>
      <h3 class="card-title">3. TDD Implementation</h3>
      <p class="card-desc">Red-Green-Refactor cycle ensuring every acceptance criterion has a failing test before code is written.</p>
    </div>
    <a href="/ai-context-hub/docs/workflows/test-driven-development" class="card-link">Explore Phase 3 →</a>
  </div>

  <div class="sdd-card">
    <div>
      <div class="card-header">
        <span class="badge badge-required">Phase 4 • Mandatory</span>
      </div>
      <h3 class="card-title">4. Code Review</h3>
      <p class="card-desc">Systematic audit checklist evaluating correctness, security, performance, and spec alignment before completion.</p>
    </div>
    <a href="/ai-context-hub/docs/workflows/code-review" class="card-link">Explore Phase 4 →</a>
  </div>
</div>

> 💡 **New Repository?** Setting up a project from scratch? Check out the **[Project Bootstrap Workflow](/docs/workflows/project-bootstrap)** (`project-bootstrap.md`).

---

## 🔌 Supported AI Assistant Adapters

Thin native adapter configurations referencing the single source of truth in `rules/` and `docs/`:

<div class="adapter-grid">
  <div class="adapter-card">
    <div>
      <div class="card-header">
        <span class="badge badge-done">AGENTS.md + Skills</span>
      </div>
      <h3 class="card-title">Google Antigravity</h3>
      <p class="card-desc">Native <code>AGENTS.md</code> global rules file combined with 6 specialized AGY skills for each SDLC phase.</p>
    </div>
    <div>
      <div class="cmd-snippet"><code>./install.sh antigravity</code></div>
      <a href="/ai-context-hub/adapters/antigravity/" class="card-link" style="margin-top: 12px;">Antigravity Adapter Docs →</a>
    </div>
  </div>

  <div class="adapter-card">
    <div>
      <div class="card-header">
        <span class="badge badge-done">.mdc Rules</span>
      </div>
      <h3 class="card-title">Cursor IDE</h3>
      <p class="card-desc">11 granular <code>.mdc</code> rule files using Cursor's <code>@file</code> directives to bind context automatically.</p>
    </div>
    <div>
      <div class="cmd-snippet"><code>./install.sh cursor</code></div>
      <a href="/ai-context-hub/adapters/cursor/" class="card-link" style="margin-top: 12px;">Cursor Adapter Docs →</a>
    </div>
  </div>

  <div class="adapter-card">
    <div>
      <div class="card-header">
        <span class="badge badge-done">CLAUDE.md</span>
      </div>
      <h3 class="card-title">Claude Code</h3>
      <p class="card-desc">Single root <code>CLAUDE.md</code> entry point mapping all global rules, practices, workflows, and templates.</p>
    </div>
    <div>
      <div class="cmd-snippet"><code>./install.sh claude</code></div>
      <a href="/ai-context-hub/adapters/claude-code/" class="card-link" style="margin-top: 12px;">Claude Code Adapter Docs →</a>
    </div>
  </div>
</div>

</div>
