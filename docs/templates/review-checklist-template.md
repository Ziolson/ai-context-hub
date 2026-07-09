# Code Review Checklist: [Feature / PR Title]

## Review Info
- **Reviewer:** [name]
- **Date:** [YYYY-MM-DD]
- **PR/MR:** [link]

## Checklist

| Category | Check | Status |
|----------|-------|--------|
| **Correctness** | Does the code implement the spec correctly? | ⬜ |
| **Correctness** | Are edge cases handled? | ⬜ |
| **Correctness** | Is error handling complete and meaningful? | ⬜ |
| **Tests** | Are there tests? Do they cover happy path + error cases? | ⬜ |
| **Tests** | Do test names describe behavior? | ⬜ |
| **Tests** | Are tests independent and deterministic? | ⬜ |
| **Design** | Is the code following SOLID principles? | ⬜ |
| **Design** | Is there unnecessary complexity? Can it be simplified? | ⬜ |
| **Design** | Are responsibilities properly separated? | ⬜ |
| **Naming** | Are names clear, descriptive, and consistent? | ⬜ |
| **Naming** | Do names match the domain language? | ⬜ |
| **Security** | No hardcoded secrets? | ⬜ |
| **Security** | Inputs validated and sanitized? | ⬜ |
| **Security** | SQL/NoSQL injection prevention? | ⬜ |
| **Performance** | Any N+1 queries or unnecessary loops? | ⬜ |
| **Performance** | Large data sets handled with pagination/streaming? | ⬜ |
| **Docs** | Public APIs documented? | ⬜ |
| **Docs** | Complex logic has explanatory comments? | ⬜ |

<!-- Status legend: ✅ Pass | ❌ Fail | ⬜ Not reviewed | ➖ N/A -->

## Findings
<!-- List all findings grouped by severity. Remove empty sections if not applicable. -->

### 🔴 Must Fix
<!-- Critical issues that block merging. Bugs, security flaws, data loss risks. -->
1. [description] — [file:line reference]

### 🟡 Should Fix
<!-- Important issues that should be addressed before merging if possible. -->
1. [description] — [file:line reference]

### 🟢 Suggestion
<!-- Nice-to-have improvements. Not blocking, but would improve code quality. -->
1. [description] — [file:line reference]

### 💬 Question
<!-- Questions for the author to clarify intent or approach. -->
1. [description] — [file:line reference]

## Summary
<!-- Brief overall assessment: Approve / Request Changes / Needs Discussion -->
[Overall assessment and key takeaways]
