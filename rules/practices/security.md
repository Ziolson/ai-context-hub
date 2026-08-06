# Security Practices

> Standards for building secure applications. Apply these rules whenever implementing endpoints, handling user data, or designing authentication flows.
> These rules extend the security baseline in `rules/global-rules.md` (section 5). Both files apply — this one provides the implementation detail.

---

## 1. Authentication

### Password Handling

- **Never store plain-text passwords** — always hash with a slow, salted algorithm: **bcrypt** (cost ≥ 12), **Argon2id**, or **scrypt**
- Never use MD5, SHA-1, or unsalted SHA-256 for passwords — they are not password hashing algorithms
- **Never log passwords** — not even hashed ones
- On failed login, return a generic message: `"Invalid credentials"` — never distinguish between "user not found" and "wrong password" (prevents user enumeration)

### JWT (JSON Web Tokens)

- **Sign with a strong algorithm**: RS256 or ES256 (asymmetric) for distributed systems; HS256 is acceptable only for single-service setups with a secret ≥ 256 bits
- **Never use `alg: none`** — reject tokens that specify no algorithm
- **Set short expiry for access tokens**: 15 minutes is a good default; never more than 24 hours
- **Use refresh tokens** for long-lived sessions — store them server-side (DB or Redis) to allow revocation
- **Validate all claims**: `iss` (issuer), `aud` (audience), `exp` (expiry) — reject tokens missing any expected claim
- **Never put sensitive data in the payload** — JWT payloads are base64-encoded, not encrypted; treat them as public

```
// ✅ Minimal, safe JWT payload
{ "sub": "user-uuid", "role": "viewer", "exp": 1720000000 }

// ❌ Sensitive data in payload
{ "sub": "user-uuid", "email": "user@example.com", "password_hash": "...", "exp": 1720000000 }
```

### Session Management

- Generate session IDs with a cryptographically secure random source (not `Math.random()`)
- Session IDs must be at least 128 bits of entropy
- Rotate session ID on privilege escalation (e.g., after login, after sudo-style confirmation)
- Set cookies with: `HttpOnly`, `Secure`, `SameSite=Strict` (or `Lax` if cross-site navigation is needed)
- Invalidate sessions server-side on logout — do not rely solely on client-side cookie deletion

### Multi-Factor Authentication (MFA)

- When implementing MFA, use time-based one-time passwords (TOTP — RFC 6238) or WebAuthn
- Never implement SMS-only MFA as the sole second factor — it is vulnerable to SIM swapping
- Provide backup codes for account recovery — store them hashed, not plain-text

---

## 2. Authorization

### Check at Every Layer

Enforce authorization at the **application/service layer**, not only at the routing/middleware layer — a passing route guard does not mean the resource belongs to the requesting user.

```
// ❌ Only checks if user is logged in, not if they own the resource
router.get('/orders/:id', requireAuth, async (req) => {
    return db.getOrder(req.params.id)  // Any logged-in user can read any order
})

// ✅ Checks ownership at the service layer
router.get('/orders/:id', requireAuth, async (req) => {
    const order = await orderService.getOrderForUser(req.params.id, req.user.id)
    // orderService throws 403 if order.userId !== req.user.id
    return order
})
```

### RBAC / ABAC

- Use **Role-Based Access Control (RBAC)** for coarse-grained permissions (admin, editor, viewer)
- Use **Attribute-Based Access Control (ABAC)** for fine-grained rules (user can only edit their own resources, editors can only publish in their assigned tenant)
- Define permissions as an explicit allowlist — deny by default, grant explicitly
- Never use role checks scattered throughout business logic — centralize them in a permission/policy layer

### Horizontal Privilege Escalation (IDOR)

- Every query that fetches a user-owned resource must include `owner_id` / `tenant_id` in the WHERE clause — never trust a valid session as sufficient authorization

```
// ❌ Fetches by ID without verifying ownership
GET /api/documents/4821

// ✅ Always scope queries to the authenticated user/tenant
SELECT * FROM documents WHERE id = ? AND owner_id = ?
```

- Every query that fetches a user-owned resource must include the `owner_id` / `tenant_id` in the WHERE clause
- Never trust that a valid session is sufficient authorization — always verify ownership

---

## 3. Input Validation & Output Encoding

Validate all external input at:
- API endpoints (request body, query params, path params, headers)
- Message queue consumers
- File readers and parsers
- Webhook receivers

- Reject unknown fields (allowlist-based schema validation)
- Enforce type, format, length, and range constraints
- For free-text fields: enforce a maximum length to prevent storage exhaustion
- Validate file types by **content (magic bytes)**, not by file extension — extensions are user-controlled

### Cross-Site Scripting (XSS)

- **Never render raw user input as HTML** — always escape or sanitize first
- In React/Vue/Angular: use the framework's safe rendering methods (`innerHTML` is a red flag)
- If HTML input is required (rich text editors): sanitize with a safe allowlist library (e.g., DOMPurify) — never use a blocklist approach
- Set `Content-Security-Policy` headers to restrict script sources

```
// ❌ Direct interpolation into HTML
element.innerHTML = `Welcome, ${user.name}`

// ✅ Safe text content
element.textContent = user.name
```

### Command Injection

- Never construct shell commands from user input
- Use language-native APIs instead of shelling out where possible
- If shell execution is unavoidable, use argument arrays (never string interpolation):

```
// ❌ Shell injection risk
exec(`convert ${userFilename} output.png`)

// ✅ Arguments as array — no shell interpolation
execFile('convert', [userFilename, 'output.png'])
```

### Server-Side Request Forgery (SSRF)

When fetching URLs provided by or derived from user input:
- Validate that the target URL resolves to an allowed domain or IP range
- Block requests to private IP ranges (`10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`, `127.0.0.0/8`)
- Block requests to cloud metadata endpoints (`169.254.169.254`)
- Use an allowlist of permitted domains where possible

---

## 4. CORS (Cross-Origin Resource Sharing)

- **Never use `Access-Control-Allow-Origin: *` for authenticated endpoints** — wildcard allows any site to make credentialed requests
- Maintain an explicit allowlist of trusted origins:
  ```
  Allowed origins: https://app.example.com, https://admin.example.com
  ```
- `Access-Control-Allow-Credentials: true` requires a specific (non-wildcard) origin
- Restrict `Access-Control-Allow-Methods` to only the HTTP methods the endpoint actually uses
- Do not configure CORS based on user input or request headers — the allowlist must be static and server-controlled

---

## 5. Rate Limiting & Brute-Force Protection

Apply rate limiting at multiple layers:

| Endpoint Type | Recommended Limit | Strategy |
|---------------|-------------------|----------|
| Login / auth | 5–10 attempts / 15 min per IP | Exponential backoff + temporary lockout |
| Password reset | 3 requests / hour per email | Token-based, single-use |
| API (authenticated) | 100–1000 req/min per user | Token bucket or sliding window |
| API (unauthenticated) | 30–60 req/min per IP | Token bucket |
| File upload | 10 uploads / hour per user | Per-user quota |

Rules:
- Return `429 Too Many Requests` with a `Retry-After` header
- **Lock accounts after repeated failures** — but always provide an unlock path (email, admin) to prevent account lockout as a DoS vector
- Log all rate limit events — sudden spikes are an attack signal
- Implement rate limiting at the infrastructure level (API gateway, reverse proxy) as well as the application level — defense in depth

---

## 6. File Upload Security

- **Validate file type by content** (magic bytes / MIME sniffing), not extension
- **Enforce file size limits** — both per-file and cumulative per-user (prevent storage exhaustion)
- **Never execute uploaded files** — store them outside the web root
- **Rename files on storage** — never use the user-supplied filename. Generate a UUID or content hash for the stored filename.
- **Scan for malware** if your threat model requires it (ClamAV or cloud-based scanning)
- Serve user-uploaded files from a **separate domain or CDN** (never `cdn.yourdomain.com/uploads/file.html` — this enables XSS via uploaded HTML files)
- For images: re-encode through an image processing library (strips EXIF metadata and embedded payloads)

```
// ✅ Safe upload handling
const ext = mime.extension(detectedMimeType)   // derived from content, not input
const storedName = `${uuid()}.${ext}`
await storage.put(storedName, fileBuffer)
// Record original filename in DB for display purposes only
```

---

## 7. Secrets & Sensitive Data

> The no-hardcoded-secrets rule is in `rules/global-rules.md`. This section covers the broader handling of sensitive data in flight and at rest.

### At Rest

- Encrypt sensitive PII at the **column level** (not just full-disk encryption) for data like SSNs, financial details, health records
- Use **envelope encryption**: encrypt data with a data key, encrypt the data key with a master key managed by a KMS (AWS KMS, GCP KMS, HashiCorp Vault)
- Secrets (API keys, tokens, DB passwords) must live in a secret manager — not in environment variable files committed to the repo

### In Transit

- Enforce **TLS 1.2 minimum**, prefer TLS 1.3
- Use **HSTS** (`Strict-Transport-Security`) with a long `max-age` (≥ 1 year) on all HTTPS responses
- Do not transmit secrets in URL query parameters — they appear in server logs, browser history, and referrer headers
  - ❌ `GET /api/data?api_key=secret123`
  - ✅ `Authorization: Bearer secret123` (header)

### Logging & Error Responses

- **Never log**: passwords, tokens, credit card numbers, SSNs, full PII
- **Never return** stack traces, internal class names, or database error messages in API responses
- Log the error internally with full context; return a generic, safe error message to the client

---

## 8. Dependency Security

- **Pin dependency versions** — do not use unbounded version ranges (`^`, `~`) in production dependencies; they allow unexpected updates
- **Audit dependencies regularly**: run `npm audit`, `pip-audit`, `gradle dependencyCheckAnalyze`, or equivalent as part of CI
- **Act on high/critical CVEs**: treat a critical CVE in a direct dependency as a production incident — patch within 24–48 hours
- **Minimize the dependency surface** — before adding a library, verify it is actively maintained and has a reasonable security track record
- **Do not pull from unverified sources** — use official package registries; verify checksums for direct downloads

---

## 9. Security Headers

Every HTTP response from a web application should include:

| Header | Recommended Value | Purpose |
|--------|-------------------|---------|
| `Strict-Transport-Security` | `max-age=31536000; includeSubDomains` | Enforce HTTPS |
| `Content-Security-Policy` | Define script/style/media sources | Prevent XSS |
| `X-Content-Type-Options` | `nosniff` | Prevent MIME sniffing |
| `X-Frame-Options` | `DENY` or `SAMEORIGIN` | Prevent clickjacking |
| `Referrer-Policy` | `strict-origin-when-cross-origin` | Limit referrer leakage |
| `Permissions-Policy` | Restrict camera, microphone, geolocation | Limit browser feature access |

- **Remove server identification headers**: `Server`, `X-Powered-By` — do not advertise your technology stack
- Use a security headers scanning tool (e.g., [securityheaders.com](https://securityheaders.com)) to verify configuration
