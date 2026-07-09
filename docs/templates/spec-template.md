# [Feature Name]

## Status
<!-- Draft | Approved | In Progress | Done | Deprecated -->
Draft

## Problem Statement
<!-- Describe the problem this feature solves. Why is it needed? What pain points does it address? -->
[What problem does this solve? Why is it needed?]

## Proposed Solution
<!-- High-level description of the approach. Keep it concise — details go in sub-sections below. -->
[High-level approach]

## User Stories
<!-- List user stories in the standard format. Add as many as needed. -->
- As a [role], I want [capability], so that [benefit]

## Acceptance Criteria
<!-- Define testable acceptance criteria using Given/When/Then format. -->
- [ ] Given [context], when [action], then [expected result]

## API Contract (if applicable)
<!-- Define endpoints, request/response schemas, and status codes. Remove this section if there is no API. -->

### `[METHOD] /path`
- **Request:**
  ```json
  {}
  ```
- **Response (200):**
  ```json
  {}
  ```
- **Response (4xx/5xx):**
  ```json
  {
    "error": "string",
    "message": "string"
  }
  ```

## Data Model Changes
<!-- Describe new tables/collections, modified fields, indexes, and required migrations. -->
[New tables/collections, modified fields, migrations]

## Error Scenarios
<!-- List known error scenarios, their root causes, and how the system should handle them. -->

| Error | Cause | Handling |
|-------|-------|----------|
| [Error name/code] | [What triggers this error] | [How the system responds] |

## Non-Functional Requirements
<!-- Specify measurable targets for performance, security, scalability, etc. -->
- **Performance:** [e.g., Response time < 200ms at p95]
- **Security:** [e.g., All inputs validated, authentication required]
- **Scalability:** [e.g., Must support 10k concurrent users]
- **Availability:** [e.g., 99.9% uptime SLA]

## Out of Scope
<!-- Explicitly list what this feature does NOT cover to prevent scope creep. -->
- [Item that is explicitly excluded from this feature]

## Open Questions
<!-- Track unresolved questions that need answers before or during implementation. -->
- [ ] [Question that needs resolution]
