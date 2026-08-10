# 🔄 Understanding Spec-Driven Development (SDD)

> **How human developers and AI assistants collaborate through structured phase gates.**

---## Overview

**Spec-Driven Development (SDD)** is the core methodology of AI Context Hub. It enforces a strict rule: **never generate production code without an approved specification (`spec.md`).**

Instead of asking AI to *"build feature X"* in one prompt, SDD structures development into 4 distinct, testable phases:

<svg viewBox="0 0 840 130" xmlns="http://www.w3.org/2000/svg" style="width: 100%; max-width: 840px; height: auto; margin: 24px 0; font-family: 'Plus Jakarta Sans', -apple-system, sans-serif;">
  <defs>
    <linearGradient id="p1Grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#6366f1" /><stop offset="100%" stop-color="#4f46e5" />
    </linearGradient>
    <linearGradient id="p2Grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#f59e0b" /><stop offset="100%" stop-color="#d97706" />
    </linearGradient>
    <linearGradient id="p3Grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#ef4444" /><stop offset="100%" stop-color="#dc2626" />
    </linearGradient>
    <linearGradient id="p4Grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#10b981" /><stop offset="100%" stop-color="#059669" />
    </linearGradient>
    <filter id="cardShadow" x="-5%" y="-5%" width="110%" height="110%">
      <feDropShadow dx="0" dy="4" stdDeviation="5" flood-color="#000" flood-opacity="0.1"/>
    </filter>
  </defs>

  <rect x="10" y="15" width="180" height="90" rx="12" fill="url(#p1Grad)" filter="url(#cardShadow)"/>
  <text x="100" y="42" text-anchor="middle" fill="#ffffff" font-size="12" font-weight="800">PHASE 1</text>
  <text x="100" y="62" text-anchor="middle" fill="#ffffff" font-size="13" font-weight="700">Discovery &amp; Spec</text>
  <rect x="50" y="74" width="100" height="18" rx="9" fill="rgba(255,255,255,0.2)"/>
  <text x="100" y="87" text-anchor="middle" fill="#ffffff" font-size="10" font-weight="700">MANDATORY</text>

  <path d="M 195 60 L 215 60" stroke="#94a3b8" stroke-width="3" stroke-linecap="round"/>
  <polygon points="215,55 224,60 215,65" fill="#94a3b8"/>

  <rect x="225" y="15" width="180" height="90" rx="12" fill="url(#p2Grad)" filter="url(#cardShadow)"/>
  <text x="315" y="42" text-anchor="middle" fill="#ffffff" font-size="12" font-weight="800">PHASE 2</text>
  <text x="315" y="62" text-anchor="middle" fill="#ffffff" font-size="13" font-weight="700">Impl Planning</text>
  <rect x="265" y="74" width="100" height="18" rx="9" fill="rgba(255,255,255,0.2)"/>
  <text x="315" y="87" text-anchor="middle" fill="#ffffff" font-size="10" font-weight="700">OPTIONAL</text>

  <path d="M 410 60 L 430 60" stroke="#94a3b8" stroke-width="3" stroke-linecap="round"/>
  <polygon points="430,55 439,60 430,65" fill="#94a3b8"/>

  <rect x="440" y="15" width="180" height="90" rx="12" fill="url(#p3Grad)" filter="url(#cardShadow)"/>
  <text x="530" y="42" text-anchor="middle" fill="#ffffff" font-size="12" font-weight="800">PHASE 3</text>
  <text x="530" y="62" text-anchor="middle" fill="#ffffff" font-size="13" font-weight="700">TDD Implementation</text>
  <rect x="480" y="74" width="100" height="18" rx="9" fill="rgba(255,255,255,0.2)"/>
  <text x="530" y="87" text-anchor="middle" fill="#ffffff" font-size="10" font-weight="700">MANDATORY</text>

  <path d="M 625 60 L 645 60" stroke="#94a3b8" stroke-width="3" stroke-linecap="round"/>
  <polygon points="645,55 654,60 645,65" fill="#94a3b8"/>

  <rect x="655" y="15" width="175" height="90" rx="12" fill="url(#p4Grad)" filter="url(#cardShadow)"/>
  <text x="742" y="42" text-anchor="middle" fill="#ffffff" font-size="12" font-weight="800">PHASE 4</text>
  <text x="742" y="62" text-anchor="middle" fill="#ffffff" font-size="13" font-weight="700">Code Review</text>
  <rect x="692" y="74" width="100" height="18" rx="9" fill="rgba(255,255,255,0.2)"/>
  <text x="742" y="87" text-anchor="middle" fill="#ffffff" font-size="10" font-weight="700">MANDATORY</text>
</svg>

---

## Human & AI Roles

SDD establishes clear roles between the human developer and the AI assistant:

| Phase | Developer Role | AI Assistant Role |
|-------|----------------|-------------------|
| **Phase 1: Discovery & Spec** | Answers requirements, approves architectural choices & spec | Explores codebase, asks structured Q&A with recommendations, writes `spec.md` |
| **Phase 2: Implementation Plan** | Reviews and approves task breakdown & milestone gates | Analyzes dependencies, breaks spec into step-by-step tasks in `plan.md` |
| **Phase 3: TDD Implementation** | Oversees test execution, provides feedback on implementation | Writes failing tests first (Red), implements minimal green code (Green), refactors |
| **Phase 4: Code Review** | Validates final PR against acceptance criteria | Conducts systematic security, performance, and correctness audit in `review.md` |

---

## The 4 Phases of SDD

Explore the guide and live AI prompt for each phase:

| Phase | Description | Phase Guide |
|-------|-------------|-------------|
| **Phase 1: Discovery & Spec** | Requirements gathering with AI recommendations | 📖 [Discovery Guide & Prompt](/guide/discovery) |
| **Phase 2: Implementation Plan** | Milestone task breakdown & vertical slicing | 📖 [Implementation Plan Guide & Prompt](/guide/implementation-plan) |
| **Phase 3: TDD Implementation** | Red-Green-Refactor cycle per criterion | 📖 [TDD Guide & Prompt](/guide/test-driven-development) |
| **Phase 4: Code Review** | 6-point checklist code audit | 📖 [Code Review Guide & Prompt](/guide/code-review) |

---

::: details Prompt Reference
<<< ../docs/workflows/spec-driven-development.md
:::
