# 🔍 Phase 4: Code Review Guide

> **Systematic quality audit before merging code into main.**

---

## 🎯 The 6-Point Audit Checklist

Before a feature is marked <span class="badge badge-done">Done</span>, Phase 4 evaluates implementation changes against 6 quality categories:

1. **Correctness**: Spec compliance & edge case coverage.
2. **Tests**: Independent, robust tests with clear naming conventions.
3. **Design**: SOLID principles, low cyclomatic complexity.
4. **Naming**: Domain-specific terms and clear intent.
5. **Security**: Zero secrets, parameterized queries, input validation.
6. **Performance**: No N+1 queries, unbounded lists, or resource leaks.

---

::: details Prompt Reference
<<< ../docs/workflows/code-review.md
:::
