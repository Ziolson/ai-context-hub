# Backend Development Rules

> Standards for server-side architecture and application logic.
> For N+1 queries, pagination enforcement, and resource management (connections, streams), refer to `docs/workflows/code-review.md` (Performance section) — those rules apply during review.
> For security baseline (parameterized queries, input validation, secrets), refer to `rules/global-rules.md` (section 5).

---

## 1. Layered Architecture

Separate the application into distinct layers with strict dependency direction:

```
┌─────────────────────────────────┐
│  API Layer                      │  Controllers, routes, middleware, request/response DTOs
│  (HTTP / gRPC / CLI interface)  │  — Parses input, calls the application layer, formats output
├─────────────────────────────────┤
│  Application Layer              │  Use cases, commands, queries, application services
│  (Use Cases / Services)         │  — Orchestrates business logic, has no framework dependencies
├─────────────────────────────────┤
│  Domain Layer                   │  Entities, value objects, domain services, domain events
│  (Business Logic)               │  — Pure business rules, no I/O, no framework code
├─────────────────────────────────┤
│  Infrastructure Layer           │  Repositories, DB clients, external API clients, message queues
│  (I/O & Adapters)               │  — All side effects live here
└─────────────────────────────────┘
```

**Dependency rule**: Inner layers must never import from outer layers.
- Domain must not know about HTTP, databases, or frameworks
- Application layer must not import HTTP request/response objects
- Infrastructure implements interfaces defined by the application/domain layer

---

## 2. Dependency Injection

- Inject dependencies — never instantiate them inside business logic
- Use constructor injection as the default (most visible, easiest to test)
  - ✅ `constructor(private readonly userRepo: UserRepository)`
  - ❌ `const userRepo = new PostgresUserRepository()` inside a service
- This makes unit testing possible without mocking entire modules

---

## 3. Transaction Management

- **Keep transactions short**: Wrap only the minimum number of operations required for atomicity
- **Do not hold transactions open across network calls** (e.g., calling an external API inside a transaction)
- Transactions must be at the **use case / service boundary**, not inside repositories
  - ✅ Begin transaction in the service, call multiple repos within it, commit or rollback
  - ❌ Individual repo methods managing their own transaction isolation independently
- Always ensure transactions are **rolled back on error** — use RAII patterns, `using` declarations, or `try/finally` blocks
- **Understand isolation levels**: Default to `READ COMMITTED`. Use `SERIALIZABLE` only when you need to prevent phantom reads and understand the performance cost.

---

## 4. Configuration & Environment

> These rules extend `rules/global-rules.md` (section 5 — no hardcoded secrets).

- All configuration is loaded from **environment variables** — never from hardcoded values or committed config files with secrets
- Validate all required environment variables **at application startup** — fail fast with a clear error if any are missing or invalid
  - ✅ `Missing required environment variable: DATABASE_URL`
  - ❌ Crashing with a `NullPointerException` 5 minutes into handling the first request
- Commit a `.env.example` file documenting all required variables with placeholder values and descriptions — keep it up to date
- Group related config (e.g., `DB_HOST`, `DB_PORT`, `DB_NAME`) into typed configuration objects rather than reading raw env vars scattered throughout the code

---

## 5. Logging

- Use **structured logging** (JSON output) — never plain `console.log` with interpolated strings in production
- Every log entry must include a **severity level**: `DEBUG`, `INFO`, `WARN`, `ERROR`
- Include a **correlation/request ID** in every log entry within a request scope (propagate it from the request header or generate one on entry)
- Log at the **right level**:
  - `DEBUG`: Verbose detail useful during development — disabled in production
  - `INFO`: Normal application events (request received, job started, config loaded)
  - `WARN`: Unexpected but recoverable situations (retry attempt, degraded mode activated)
  - `ERROR`: Failures that require attention (unhandled exception, service unavailable)
- **Never log sensitive data**: No passwords, tokens, credit card numbers, or full PII in logs

---

## 6. Caching

- Always define **TTL (Time-To-Live)** for every cache entry — no infinite caching
- Always define an **invalidation strategy** before adding a cache:
  - Event-driven: Invalidate on write (e.g., user updated → clear user cache)
  - TTL-based: Accept eventual staleness for a defined period
  - Versioned: Cache key includes a version identifier
- Cache at the **right layer**:
  - HTTP caching (`Cache-Control` headers) for public, read-heavy API responses
  - Application-level cache (Redis, Memcached) for expensive computations or frequently read data
  - Database query cache only as a last resort — application-level cache is more predictable
- **Handle cache misses gracefully**: The system must function correctly when the cache is cold or unavailable

---

## 7. Asynchronous Communication

When services communicate via message queues or event streams:

- **Design for idempotency**: Consumers must handle receiving the same message more than once without adverse effects (use idempotency keys or deduplication)
- **At-least-once delivery**: Assume messages can be delivered more than once or out of order — design accordingly
- **Dead Letter Queues (DLQ)**: Route messages that fail processing after N retries to a DLQ — never silently drop them
- **Publish events, not commands**: Prefer domain events (`OrderPlaced`, `UserRegistered`) over direct commands between services to reduce coupling
- **Do not publish events before the transaction commits**: Publish in a transaction outbox pattern or after a successful commit to avoid publishing for rolled-back operations
