# 🎨 Frontend Practices Guide

> **Modern UI design systems, component architecture, state management, accessibility, and Core Web Vitals.**

---

## 🎯 Purpose & Overview

Frontend interfaces are the primary touchpoint for users. When AI tools write frontend code without strict component guidelines, they often generate massive single-file components, mix local component state with global stores, use inline pixel offsets, or omit accessibility (`a11y`) attributes.

This guide outlines standards for component atomic design, state encapsulation, design system tokens, and performance optimization.

---

## 🏛️ Core Architectural Principles

### 1. Component Atomic Decomposition
Divide user interfaces into focused, single-responsibility components:
- **Atoms**: Pure, stateless UI elements (Buttons, Inputs, Badges, Typography).
- **Molecules**: Combinations of atoms (Form Fields, Search Bars, Card Headers).
- **Organisms**: Complex interface sections (Navigation Bars, Data Grids, Modal Dialogs).
- **Pages / Views**: Route handlers that compose organisms and bind data hooks.

### 2. State Encapsulation Rules
- **Local UI State**: Keep transient UI state (modal open/closed, input focus, hover states) strictly inside local component state (`useState`).
- **Shared Application State**: Store global session data or cross-cutting user preferences in global stores (Pinia, Redux, Zustand, React Context).
- **Server Data Cache**: Use data fetching libraries (TanStack Query, SWR) for API requests rather than storing fetched arrays manually in global stores.

### 3. Accessibility (a11y) & Semantic HTML
- Use native HTML5 semantic elements (`<header>`, `<main>`, `<nav>`, `<article>`, `<button>`).
- Ensure all interactive elements have visible focus indicators, dynamic ARIA attributes (`aria-expanded`, `aria-label`), and full keyboard navigation support (`Tab`, `Enter`, `Escape`).

---

## 👥 Human Developer vs. AI Assistant Roles

| Area | Human Developer Role | AI Assistant Role |
|------|----------------------|-------------------|
| **Design System** | Defines color palettes, spacing tokens, and typography scale | Applies predefined CSS variables/tokens without ad-hoc inline pixels |
| **User Experience**| Validates micro-interactions, responsive flows, & visual polish | Implements semantic HTML markup, ARIA roles, and keyboard hooks |
| **Performance** | Monitors Core Web Vitals (LCP, INP, CLS) in DevTools | Implements lazy loading, dynamic imports, and memoized selectors |

---

## 💡 Code Examples: Good vs. Bad Practices

### Anti-Pattern: Non-Semantic Div Click Handlers ❌
```html
<!-- BAD: Using div with click handler, invisible to screen readers & keyboard users -->
<div class="submit-btn" onclick="submitForm()">
  <span>Submit Request</span>
</div>
```

### Production-Grade Pattern: Accessible Semantic Button ✅
```html
<!-- GOOD: Semantic button with accessible aria attributes & focus styles -->
<button 
  type="submit" 
  class="btn btn-primary"
  aria-busy="false"
  onclick="submitForm()">
  <span>Submit Request</span>
</button>
```

---

## 📋 Code Review Checklist for Frontend

- [ ] **Semantic Markup**: Does the component use proper HTML5 elements (`<button>`, `<dialog>`, `<section>`) instead of clickable `<div>` tags?
- [ ] **Design Tokens**: Are spacing and color attributes referencing CSS design system variables rather than hardcoded pixel values (`margin: 17px`)?
- [ ] **State Isolation**: Is transient UI state kept local rather than mutated in global array stores?
- [ ] **Keyboard Navigation**: Can the component be navigated and operated using keyboard alone (`Tab`, `Space`, `Enter`, `Esc`)?

---

::: details Prompt Reference
<<< ../rules/practices/frontend.md
:::
