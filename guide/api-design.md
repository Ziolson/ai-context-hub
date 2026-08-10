# 🌐 API Design Practices Guide

> **RESTful API standards, contract design, RFC 7807 error responses, versioning, and idempotency.**

---

## 🎯 Purpose & Overview

APIs are the contract between backend servers, frontend clients, and third-party integrations. Poorly designed APIs result in breaking integration changes, ambiguous status codes, and brittle client code.

This guide outlines standards for resource-oriented URI design, standard HTTP verbs, structured error payloads, and semantic versioning.

---

## 🏛️ Core Architectural Principles

### 1. Resource-Oriented Nouns over Action Verbs
URIs identify **resources**, while HTTP verbs define the **operation**:

```
BAD:  POST /api/v1/getUserDetails
BAD:  POST /api/v1/deleteUserById?id=42

GOOD: GET    /api/v1/users/42      (Retrieve user 42)
GOOD: PUT    /api/v1/users/42      (Replace user 42)
GOOD: PATCH  /api/v1/users/42      (Partial update user 42)
GOOD: DELETE /api/v1/users/42      (Remove user 42)
```

### 2. Standardized Problem Details (RFC 7807)
Never return plain text strings or inconsistent error shapes on HTTP 4xx/5xx responses. Always format error responses according to the **RFC 7807 Problem Details** standard:

```json
{
  "type": "https://api.example.com/errors/invalid-payment",
  "title": "Invalid Payment Method",
  "status": 422,
  "detail": "The card provided has expired.",
  "instance": "/api/v1/orders/1092/payments",
  "invalidParams": [
    { "name": "expiryMonth", "reason": "Must be in the future" }
  ]
}
```

### 3. HTTP Status Code Discipline
- `200 OK`: Successful GET, PATCH, or PUT request.
- `201 Created`: Successful POST request that created a new resource (includes `Location` header).
- `204 No Content`: Successful DELETE request.
- `400 Bad Request`: Malformed syntax or schema validation failure.
- `401 Unauthorized`: Missing or invalid authentication token.
- `403 Forbidden`: Authenticated user lacks permission for target resource.
- `404 Not Found`: Target resource URI does not exist.
- `409 Conflict`: Business state collision (e.g. duplicate email address).
- `422 Unprocessable Entity`: Validation failure on syntactically correct input payload.

---

## 👥 Human Developer vs. AI Assistant Roles

| Area | Human Developer Role | AI Assistant Role |
|------|----------------------|-------------------|
| **API Contract** | Approves OpenAPI/Swagger specifications & endpoint design | Generates route controllers, input validators, and response DTOs |
| **Versioning** | Determines API deprecation policy and major version bumps | Maintains backward compatibility within existing API versions |
| **Error Handling** | Defines domain error catalogs and HTTP status mapping | Enforces RFC 7807 response formatting across all controller routes |

---

## 💡 Code Examples: Good vs. Bad Practices

### Anti-Pattern: Ad-Hoc Error Object ❌
```typescript
// BAD: Inconsistent 200 OK with error payload
res.status(200).json({
  success: false,
  error_msg: "Payment failed",
  code: 99
});
```

### Production-Grade Pattern: RFC 7807 Error Response ✅
```typescript
// GOOD: Proper HTTP 422 with RFC 7807 structured problem details
res.status(422).contentType('application/problem+json').json({
  type: "https://api.example.com/errors/unprocessable-entity",
  title: "Unprocessable Entity",
  status: 422,
  detail: "Payment execution failed due to insufficient funds.",
  instance: req.originalUrl
});
```

---

## 📋 Code Review Checklist for API Design

- [ ] **Resource Naming**: Are URIs using plural nouns (`/users`, `/orders`) without embedded verbs (`/getUsers`)?
- [ ] **Proper Verbs**: Are HTTP methods used strictly according to their semantics (GET is safe/read-only, PUT/DELETE are idempotent)?
- [ ] **RFC 7807 Compliance**: Do all error responses return `application/problem+json` format with standard keys?
- [ ] **Pagination**: Are collections paginated using standard query params (`?page=1&limit=20` or `?cursor=...`)?

---

::: details Prompt Reference
<<< ../rules/practices/api-design.md
:::
