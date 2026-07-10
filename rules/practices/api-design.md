# API Design Rules

> Standards for designing RESTful APIs. Apply these rules whenever creating or modifying API endpoints.
> These rules complement the security rules in `rules/global-rules.md` (parameterized queries, input validation, no hardcoded secrets).

---

## 1. Resource Naming

- Use **plural nouns** for resource names: `/users`, `/orders`, `/invoices`
- Use **kebab-case** for multi-word resources: `/user-accounts`, `/payment-methods`
- **Never use verbs** in URLs — the HTTP method is the verb:
  - ✅ `POST /orders`
  - ❌ `POST /createOrder`
- **Nest resources max 2 levels** deep to express ownership:
  - ✅ `GET /users/{userId}/orders`
  - ❌ `GET /users/{userId}/orders/{orderId}/items/{itemId}/discounts`
  - For deeper relationships, use query parameters or a flat resource

---

## 2. HTTP Method Semantics

| Method | Semantics | Idempotent? | Body? |
|--------|-----------|-------------|-------|
| `GET` | Read a resource or collection | ✅ Yes | No |
| `POST` | Create a new resource | ❌ No | Yes |
| `PUT` | Full replacement of a resource | ✅ Yes | Yes |
| `PATCH` | Partial update of a resource | No (by convention) | Yes |
| `DELETE` | Remove a resource | ✅ Yes | Rarely |

- `GET` requests must **never** cause side effects
- `PUT` must replace the entire resource — omitted fields must be treated as null/empty
- `PATCH` must accept only the fields to update — do not require the full resource body
- `DELETE` must be idempotent — deleting an already-deleted resource returns `204` or `404`, never `500`

---

## 3. URL Structure

- Always use **lowercase** paths
- Always use **kebab-case** in path segments: `/payment-methods`, not `/paymentMethods`
- Include the **API version** as a URL prefix: `/api/v1/users`
- Avoid trailing slashes: `/api/v1/users` not `/api/v1/users/`

---

## 4. HTTP Status Codes

Use the most specific, accurate status code. Common codes:

| Code | Meaning | When to use |
|------|---------|-------------|
| `200 OK` | Success | Successful GET, PUT, PATCH |
| `201 Created` | Resource created | Successful POST that creates a resource |
| `204 No Content` | Success, no body | Successful DELETE, or PUT/PATCH when no body returned |
| `400 Bad Request` | Invalid request syntax | Malformed JSON, missing required fields |
| `401 Unauthorized` | Not authenticated | No valid auth credentials provided |
| `403 Forbidden` | Not authorized | Authenticated but lacks permission |
| `404 Not Found` | Resource not found | Requested resource does not exist |
| `409 Conflict` | State conflict | Duplicate resource, version conflict |
| `422 Unprocessable Entity` | Validation error | Request is well-formed but business validation fails |
| `429 Too Many Requests` | Rate limited | Client has exceeded rate limit |
| `500 Internal Server Error` | Server error | Unexpected server-side failure |

---

## 5. Error Response Format

All error responses must use a consistent structure:

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Request validation failed",
    "details": [
      {
        "field": "email",
        "message": "must be a valid email address"
      }
    ]
  }
}
```

- `code` — machine-readable error code (SCREAMING_SNAKE_CASE), stable across releases
- `message` — human-readable summary (safe to display to end users if applicable)
- `details` — optional array of field-level or context-specific error details
- **Never expose** stack traces, internal class names, or database error messages in the response body

---

## 6. Pagination

For all list endpoints that could return more than ~50 items, pagination is mandatory.

**Preferred: Cursor-based pagination** (stable under concurrent inserts)

```
GET /api/v1/orders?limit=25&cursor=eyJpZCI6MTIzfQ
```

Response envelope:
```json
{
  "data": [...],
  "pagination": {
    "limit": 25,
    "next_cursor": "eyJpZCI6MTQ4fQ",
    "has_more": true
  }
}
```

**Alternative: Offset-based pagination** (simpler, use for admin UIs and stable datasets)

```
GET /api/v1/orders?page=2&per_page=25
```

- Always define a **maximum `limit`/`per_page`** (e.g., 100) — never allow unbounded queries
- Document the default limit in the API spec

---

## 7. Filtering & Sorting

Use query parameters for filtering and sorting:

```
GET /api/v1/orders?filter[status]=shipped&filter[created_after]=2024-01-01&sort=-created_at
```

- Prefix with `filter[field]` for field-level filtering
- Use `sort=field` for ascending, `sort=-field` for descending
- Support multiple sort keys: `sort=-created_at,id`
- Document all supported filter fields — reject unknown filter fields with `400`

---

## 8. Versioning

- Use **URL prefix versioning**: `/api/v1/`, `/api/v2/`
- Never break backwards compatibility within a version — add new fields, don't rename or remove
- Deprecate old versions with a `Deprecation` response header and a documented sunset date
- **Do not version in the `Accept` header** — URL versioning is more discoverable and simpler to debug

---

## 9. Request & Response Design

- Always return a **response body** for `POST` (the created resource) and `PUT`/`PATCH` (the updated resource)
- Use **consistent field naming**: `snake_case` for JSON fields (or `camelCase` — pick one and never mix)
- Use **ISO 8601** for all date/time fields: `"2024-07-10T16:00:00Z"`
- Use **strings for monetary amounts** to avoid floating-point precision errors, or represent as integers (cents/pence)
- Wrap collections in a `data` key to allow adding metadata later:
  - ✅ `{ "data": [...], "pagination": {...} }`
  - ❌ `[...]` (bare array at the root)
