# 🔌 Adapters & Architecture

> **How AI Context Hub integrates seamlessly with any AI coding tool without duplicating manual rule writing.**

---

## 🎯 The Zero-Duplication Core Pattern

A core design principle of AI Context Hub is **Single Source of Truth**. 

All rules, workflows, and templates live in a single central repository:
- `rules/` — Core coding rules and practices
- `docs/workflows/` — Workflow phase guides
- `docs/templates/` — Document templates

<svg viewBox="0 0 820 220" xmlns="http://www.w3.org/2000/svg" style="width: 100%; max-width: 820px; height: auto; margin: 24px 0; font-family: 'Plus Jakarta Sans', -apple-system, sans-serif;">
  <defs>
    <linearGradient id="hubGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#6366f1" />
      <stop offset="100%" stop-color="#4f46e5" />
    </linearGradient>
    <linearGradient id="targetGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#3b82f6" />
      <stop offset="100%" stop-color="#1d4ed8" />
    </linearGradient>
    <filter id="svgShadow" x="-10%" y="-10%" width="120%" height="120%">
      <feDropShadow dx="0" dy="4" stdDeviation="5" flood-color="#000" flood-opacity="0.12"/>
    </filter>
  </defs>

  <rect x="20" y="20" width="340" height="180" rx="14" fill="#ffffff" stroke="#6366f1" stroke-width="2" filter="url(#svgShadow)"/>
  <rect x="20" y="20" width="340" height="40" rx="14" fill="url(#hubGrad)"/>
  <text x="190" y="46" text-anchor="middle" fill="#ffffff" font-size="14" font-weight="700">AI Context Hub Repository</text>
  
  <rect x="40" y="75" width="300" height="35" rx="8" fill="#e0e7ff"/>
  <text x="190" y="97" text-anchor="middle" fill="#3730a3" font-size="12" font-weight="600">rules/ (Global &amp; Practice Rules)</text>
  
  <rect x="40" y="120" width="300" height="35" rx="8" fill="#e0e7ff"/>
  <text x="190" y="142" text-anchor="middle" fill="#3730a3" font-size="12" font-weight="600">docs/workflows/ (SDD 4-Phase Specs)</text>

  <path d="M 370 92 L 440 92" stroke="#6366f1" stroke-width="3" stroke-dasharray="6,4" fill="none"/>
  <polygon points="440,87 450,92 440,97" fill="#6366f1"/>

  <path d="M 370 137 L 440 137" stroke="#6366f1" stroke-width="3" stroke-dasharray="6,4" fill="none"/>
  <polygon points="440,132 450,137 440,142" fill="#6366f1"/>

  <rect x="460" y="20" width="340" height="180" rx="14" fill="#ffffff" stroke="#3b82f6" stroke-width="2" filter="url(#svgShadow)"/>
  <rect x="460" y="20" width="340" height="40" rx="14" fill="url(#targetGrad)"/>
  <text x="630" y="46" text-anchor="middle" fill="#ffffff" font-size="14" font-weight="700">Your Target Project Root</text>
  
  <rect x="480" y="75" width="300" height="35" rx="8" fill="#dbeafe"/>
  <text x="630" y="97" text-anchor="middle" fill="#1e40af" font-size="12" font-weight="600">.agents/ | .cursor/context/ | .claude/</text>
  
  <rect x="480" y="120" width="300" height="35" rx="8" fill="#dbeafe"/>
  <text x="630" y="142" text-anchor="middle" fill="#1e40af" font-size="12" font-weight="600">Self-Contained Installer Copies</text>
  
  <text x="630" y="180" text-anchor="middle" fill="#64748b" font-size="11" font-weight="600">AGENTS.md • .cursor/rules/*.mdc • CLAUDE.md</text>
</svg>

**Adapters** are tool-specific installation bundles. When you run `./install.sh <tool>`, the installer copies the central core rules and workflows self-containedly into the hidden configuration directory of your target tool (`.agents/`, `.cursor/`, or `.claude/`) and automatically rewrites relative paths so the target repository is 100% self-contained and portable.

---

## Supported Tool Adapters

AI Context Hub includes native adapters for three major AI coding tool formats:

### 1. Google Antigravity / Gemini (`AGENTS.md` + Skills)

- **Format**: `AGENTS.md` root rules + unnested `skills/` folders.
- **How it works**: The installer creates a self-contained `.agents/` folder inside your target project containing `.agents/rules/`, `.agents/docs/`, `.agents/skills/`, and `.agents/AGENTS.md`.
- 📖 [Antigravity Adapter Documentation](/adapters/antigravity/)

::: details Antigravity Prompt Reference: adapters/antigravity/AGENTS.md
<<< ../adapters/antigravity/AGENTS.md
:::

---

### 2. Cursor IDE (`.mdc` Rules)

- **Format**: `.cursor/rules/*.mdc` rule files + `.cursor/context/`.
- **How it works**: The installer copies rules into `.cursor/context/` and creates `.cursor/rules/*.mdc` files configured with Cursor's native `@.cursor/context/...` file bindings.
- 📖 [Cursor Adapter Documentation](/adapters/cursor/)

::: details Cursor Prompt Reference: adapters/cursor/rules/global-rules.mdc
<<< ../adapters/cursor/rules/global-rules.mdc
:::

---

### 3. Claude Code (`CLAUDE.md`)

- **Format**: Root `CLAUDE.md` entry point + `.claude/` rules directory.
- **How it works**: The installer creates `.claude/rules/` and `.claude/docs/`, then places `CLAUDE.md` at project root with updated path pointers.
- 📖 [Claude Code Adapter Documentation](/adapters/claude-code/)

::: details Claude Code Prompt Reference: adapters/claude-code/CLAUDE.md
<<< ../adapters/claude-code/CLAUDE.md
:::

---

## ⚙️ Automated Installer (`install.sh`)

The automated installer script `install.sh` manages copying core folders and rewriting tool paths directly for target projects:

```bash
# Setup Antigravity adapter (.agents/)
/path/to/ai-context-hub/install.sh antigravity

# Setup Cursor adapter (.cursor/)
/path/to/ai-context-hub/install.sh cursor

# Setup Claude Code adapter (.claude/ & CLAUDE.md)
/path/to/ai-context-hub/install.sh claude

# Setup all adapters
/path/to/ai-context-hub/install.sh all
```

