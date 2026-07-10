# Frontend Development Rules

> Standards for building web application frontends. Apply when working on UI components, client-side logic, or styling.
> These rules apply regardless of framework (React, Vue, Angular, Svelte, etc.) unless a framework-specific rule is noted.

---

## 1. Component Design

- **Single Responsibility**: Each component does one thing. If you need "and" to describe what it does, split it.
- **Composition over inheritance**: Build complex UIs by composing small, focused components — not by inheriting from base components
- **Explicit props**: Always define and validate the types/shapes of props passed to components
- **Avoid prop drilling beyond 2 levels**: If you're passing the same prop through 3+ layers, consider lifting state or using a context/store
- **Keep components small**: If a component's render function exceeds ~150 lines, it's a candidate for splitting

### Naming
- Components: `PascalCase` (`UserAvatar`, `PaymentSummary`)
- Files: match the component name (`UserAvatar.tsx`, `PaymentSummary.vue`)
- Event handlers: `handle<Event>` prefix (`handleSubmit`, `handleUserSelect`)
- Boolean props: `is`/`has`/`can` prefix (`isLoading`, `hasError`, `canEdit`)

---

## 2. State Management

Follow this hierarchy — start at the top and only move down when necessary:

| Level | When to use | Examples |
|-------|-------------|---------|
| **1. Local state** | Default choice — state used only within a single component | Form inputs, toggle open/closed, local loading flag |
| **2. Lifted state** | State shared between a parent and its direct children | Selected item in a list passed to a detail panel |
| **3. Server state / cache** | Remote data fetched from an API | User profile, product list, paginated results |
| **4. Global client state** | Truly app-wide state that persists across routes | Auth session, theme preference, shopping cart |

Rules:
- **Do not put server data in global state** — use a server-state library (React Query, SWR, Apollo, etc.) with caching instead
- **Global state is a last resort** — question every addition to a global store
- **Derive state where possible**: Compute values from existing state rather than storing duplicates
  - ✅ Compute `isFormValid` from field values on each render
  - ❌ Store `isFormValid` as a separate state variable and keep it in sync

---

## 3. Styling

- **Scoped styles by default**: Avoid global CSS that can bleed across components. Use CSS Modules, scoped CSS, or component-level styled-components.
- **Use design tokens**: Define spacing, colors, and typography as variables/tokens — never hardcode magic values like `margin: 13px` or `color: #1a2b3c` inline
- **Mobile-first**: Write styles for mobile viewport first, then add breakpoints for larger screens
- **Avoid overriding framework/library styles directly**: Extend or configure them instead — overrides break on upgrades
- **No inline styles for layout/theme**: Inline styles (`style={{ color: 'red' }}`) are acceptable for truly dynamic values only (e.g., progress bar width from data). Static styles belong in CSS.
- **Class naming (when using vanilla CSS)**: Use BEM or a consistent naming convention. Avoid single-word class names that risk collisions.

---

## 4. Accessibility (a11y)

Accessibility is not optional. Minimum requirements:

### Semantic HTML First
- Use the correct element for the job — **always prefer native elements** before reaching for ARIA
  - ✅ `<button>` for clickable actions
  - ✅ `<a href>` for navigation
  - ✅ `<nav>`, `<main>`, `<header>`, `<footer>`, `<section>` for page structure
  - ❌ `<div onClick>` for interactive elements

### Images
- Every `<img>` must have an `alt` attribute
- Decorative images: `alt=""` (empty string, not omitted)
- Informative images: `alt` describes the content/meaning, not just the filename

### Keyboard Navigation
- All interactive elements must be reachable and operable via keyboard (Tab, Enter, Space, arrow keys)
- Never remove the `:focus` outline without providing an equally visible replacement
- Logical tab order — generally follows the visual reading order

### Color & Contrast
- Text contrast ratio minimum: **4.5:1** for normal text, **3:1** for large text (WCAG AA)
- Never convey information through color alone — always pair with text, icon, or pattern

### ARIA
- Use ARIA attributes only when native HTML semantics are insufficient
- Common ARIA attributes: `aria-label`, `aria-labelledby`, `aria-describedby`, `role`, `aria-expanded`, `aria-hidden`
- Test with a screen reader (VoiceOver, NVDA) for any custom interactive widgets

---

## 5. Performance

- **Lazy-load routes**: Split the bundle at the route level — load only the code needed for the current page
- **Lazy-load heavy components**: Any component with a large dependency (charts, editors, maps) should be lazy-loaded
- **Optimize images**:
  - Use modern formats (WebP, AVIF) with fallbacks
  - Always specify `width` and `height` to prevent layout shifts (CLS)
  - Use responsive images (`srcset`, `sizes`) for different viewports
  - Lazy-load below-the-fold images (`loading="lazy"`)
- **Minimize bundle size**:
  - Import only what you use (tree-shaking)
  - Avoid importing entire utility libraries for a single function (`lodash` → `lodash-es` or native)
  - Audit bundle size regularly — set a budget alert
- **Avoid layout shifts**: Explicit dimensions on images, embeds, and dynamically loaded content
- **Memoize expensive computations**: Use memoization (`useMemo`, `computed`) for calculations that are expensive and depend on stable inputs — but don't over-optimize; profile first

---

## 6. Error Handling in the UI

- **Always handle loading, error, and empty states** for any async data — never show a blank screen
- Show **user-friendly error messages** — never expose raw API errors or stack traces to the user
- Implement **error boundaries** (or equivalent) to catch rendering errors and show a fallback UI instead of a blank page
- Log errors to a monitoring service (Sentry, etc.) for observability
