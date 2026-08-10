# 🧠 About AI Context Hub

> **A tool-neutral knowledge base of workflow rules and skills for AI-assisted development.**

---

## Purpose & Overview

**AI Context Hub** provides a single source of truth for software development workflows — Spec-Driven Development (SDD), Test-Driven Development (TDD), Code Review, Security Baselines, and architectural practices — that works across **any AI coding assistant**.

Instead of writing fragmented system prompts in Cursor `.cursor/rules`, Antigravity `AGENTS.md`, or Claude Code `CLAUDE.md`, you maintain **one centralized context repository**. 

---

## Architecture & Single Source of Truth

AI Context Hub decouples **Core Knowledge Base** (tool-neutral rules in `rules/` and `docs/`) from **Tool Adapters** (tool-native configurations in `adapters/`):

<svg viewBox="0 0 800 240" xmlns="http://www.w3.org/2000/svg" style="width: 100%; max-width: 800px; height: auto; margin: 24px 0; font-family: 'Plus Jakarta Sans', -apple-system, sans-serif;">
  <defs>
    <linearGradient id="coreGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#6366f1" />
      <stop offset="100%" stop-color="#4f46e5" />
    </linearGradient>
    <linearGradient id="antigravityGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#3b82f6" />
      <stop offset="100%" stop-color="#1d4ed8" />
    </linearGradient>
    <linearGradient id="cursorGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#10b981" />
      <stop offset="100%" stop-color="#047857" />
    </linearGradient>
    <linearGradient id="claudeGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#f59e0b" />
      <stop offset="100%" stop-color="#b45309" />
    </linearGradient>
    <filter id="shadow" x="-10%" y="-10%" width="120%" height="120%">
      <feDropShadow dx="0" dy="4" stdDeviation="6" flood-color="#000" flood-opacity="0.12"/>
    </filter>
  </defs>
  
  <rect x="250" y="10" width="300" height="70" rx="12" fill="url(#coreGrad)" filter="url(#shadow)"/>
  <text x="400" y="38" text-anchor="middle" fill="#ffffff" font-size="16" font-weight="700">Tool-Neutral Core</text>
  <text x="400" y="58" text-anchor="middle" fill="#e0e7ff" font-size="12">rules/ • docs/workflows/ • templates/</text>
  
  <path d="M 330 80 L 150 140" stroke="#6366f1" stroke-width="3" stroke-dasharray="6,4" fill="none"/>
  <path d="M 400 80 L 400 140" stroke="#6366f1" stroke-width="3" stroke-dasharray="6,4" fill="none"/>
  <path d="M 470 80 L 650 140" stroke="#6366f1" stroke-width="3" stroke-dasharray="6,4" fill="none"/>
  
  <rect x="50" y="140" width="200" height="80" rx="12" fill="url(#antigravityGrad)" filter="url(#shadow)"/>
  <text x="150" y="172" text-anchor="middle" fill="#ffffff" font-size="14" font-weight="700">Google Antigravity</text>
  <text x="150" y="195" text-anchor="middle" fill="#dbeafe" font-size="11">AGENTS.md + 6 Skills</text>
  
  <rect x="300" y="140" width="200" height="80" rx="12" fill="url(#cursorGrad)" filter="url(#shadow)"/>
  <text x="400" y="172" text-anchor="middle" fill="#ffffff" font-size="14" font-weight="700">Cursor IDE</text>
  <text x="400" y="195" text-anchor="middle" fill="#d1fae5" font-size="11">11 .mdc @file rules</text>
  
  <rect x="550" y="140" width="200" height="80" rx="12" fill="url(#claudeGrad)" filter="url(#shadow)"/>
  <text x="650" y="172" text-anchor="middle" fill="#ffffff" font-size="14" font-weight="700">Claude Code</text>
  <text x="650" y="195" text-anchor="middle" fill="#fef3c7" font-size="11">CLAUDE.md Entry Point</text>
</svg>

- **Single Source of Truth**: Rules are written once in clean markdown files.
- **Thin Adapters**: Tool-specific adapter files reference the core docs via relative paths or native directives (`@file`).
- **Zero Content Duplication**: Updating a rule in `rules/global-rules.md` updates the rule for all connected AI tools instantly.

---

## Quick Setup & Onboarding

To connect **AI Context Hub** to any target project:

```bash
# 1. Clone the repository
git clone https://github.com/Ziolson/ai-context-hub.git

# 2. Run installer from your target project root
/path/to/ai-context-hub/install.sh all
```

*This automatically installs self-contained adapters and configures path pointers for your chosen AI assistant.*

---

::: details Prompt Reference
<<< ../rules/global-rules.md
:::
