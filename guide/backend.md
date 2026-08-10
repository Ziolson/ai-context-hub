# ⚙️ Backend Practices Guide

> **Clean architecture, domain-driven design, transactional boundaries, and robust error handling.**

---

## 🎯 Purpose & Overview

Backend microservices and API applications are the backbone of application data integrity and business rules. 

Without strict backend rules, AI tools tend to write monolithic controller methods that directly mix SQL queries, business calculations, HTTP status handling, and third-party API calls in one huge function.

This guide outlines **Clean Architecture** patterns that keep backend code testable, maintainable, and decoupled.

---

## 🏛️ Core Architectural Principles

### 1. Clean Layering & Separation of Concerns
Every backend module must maintain strict directional dependencies:

```
[ HTTP Controller / Router ] ──▶ [ Application Service / Use Case ] ──▶ [ Domain Entity / Logic ]
                                              │
                                              ▼
                                 [ Repository Interface ] ──▶ [ Infrastructure DB Driver ]
```

- **Controllers / Handlers**: Responsible ONLY for parsing HTTP requests, validating input DTOs, invoking services, and formatting HTTP responses.
- **Application Services**: Orchestrates domain workflows, manages database transaction boundaries, and coordinates external notifications.
- **Domain Layer**: Pure business rules and entity behavior, free of HTTP or database framework dependencies.
- **Repositories**: Encapsulates raw data persistence queries behind interface abstractions.

### 2. Transaction Management & Idempotency
- Explicitly define database transaction boundaries using `@Transactional` decorators or database transaction blocks.
- Ensure mutating operations (POST, PUT, DELETE) support idempotency keys where network retries are possible.

---

## 👥 Human Developer vs. AI Assistant Roles

| Area | Human Developer Role | AI Assistant Role |
|------|----------------------|-------------------|
| **Domain Modeling** | Defines aggregates, value objects, and domain boundaries | Implements layer DTOs, mapping interfaces, and domain methods |
| **Persistence** | Approves DB index placement and transaction scopes | Generates parameterized queries and repository implementations |
| **Error Handling** | Defines global application error hierarchy & status codes | Maps domain exceptions to standard HTTP error responses |

---

## 💡 Code Examples: Good vs. Bad Practices

### Anti-Pattern: Mixed Layering in HTTP Handlers ❌
```typescript
// BAD: Controller executing raw SQL and business logic directly
export async function createOrderHandler(req: Request, res: Response) {
  const { userId, items } = req.body;
  
  // ❌ Raw DB call directly in HTTP layer
  const user = strokeDb.query("SELECT * FROM users WHERE id = " + userId); 
  
  let total = 0;
  for (const item of items) {
    total += item.price * item.quantity;
  }
  
  // ❌ Business logic and persistence mixed in HTTP request handler
  const order = await strokeDb.query(`INSERT INTO orders VALUES (...)`);
  res.json(order);
}
```

### Production-Grade Pattern: Clean Layer Separation ✅
```typescript
// GOOD: Controller delegates to Application Service using DTOs
export class OrderController {
  constructor(private readonly orderService: OrderApplicationService) {}

  async createOrder(req: Request, res: Response): Promise<void> {
    const command = CreateOrderCommand.parse(req.body); // Validates input DTO
    const result = await this.orderService.execute(command);
    res.status(201).json(OrderResponseDto.fromDomain(result));
  }
}
```

---

## 📋 Code Review Checklist for Backend

- [ ] **No Leakage of Infrastructure**: Are database models (ORM entities) separated from HTTP response DTOs?
- [ ] **Transaction Safety**: Are multi-step mutations executed within explicit database transaction blocks?
- [ ] **Non-Blocking I/O**: Are async/await patterns used properly without blocking main event dispatchers?
- [ ] **Typed Exception Hierarchy**: Are domain failures handled using custom domain exceptions rather than generic `Error` objects?

---

::: details Prompt Reference
<<< ../rules/practices/backend.md
:::
