# 🗄️ Database Practices Guide

> **Relational & NoSQL schema design, SQL migration discipline, B-Tree indexing strategies, and transactional isolation.**

---

## 🎯 Purpose & Overview

Database performance and data integrity directly determine software longevity. Improper database design causes lock contention, deadlocks, N+1 query latency spikes, and corrupted state.

This guide details rules for database migrations, index selection, foreign key constraints, and query optimization.

---

## 🏛️ Core Architectural Principles

### 1. Database Migration Discipline
- **Versioned Migrations**: Every database structural change (table creation, column addition, index modification) MUST be committed as a versioned migration script (`V001__create_users_table.sql`).
- **Never Alter Production Schema Manually**: Schema drift breaks deployment pipelines and rollback capabilities.
- **Backwards-Compatible Schema Changes**: Add new columns as optional/nullable first before enforcing `NOT NULL` constraints in subsequent releases.

### 2. B-Tree Indexing Rules
- **Index Foreign Keys**: Create indexes on foreign key columns (`user_id`, `order_id`) to accelerate join queries and prevent full table scans.
- **Compound Index Order**: Put equality columns first, followed by range/sort columns (`WHERE status = 'ACTIVE' AND created_at > ?` ➔ `INDEX (status, created_at)`).
- **Avoid Over-Indexing**: Excessive indexes slow down `INSERT`, `UPDATE`, and `DELETE` operations.

### 3. Eliminating the N+1 Query Problem
When fetching lists of entities with associated relations, never issue individual queries inside a loop:

```
BAD:  SELECT * FROM orders WHERE status = 'PENDING'; -- Returns 100 rows
      -- Loop 100 times:
      SELECT * FROM users WHERE id = order.user_id;  -- 100 separate queries!

GOOD: SELECT * FROM orders o JOIN users u ON o.user_id = u.id WHERE o.status = 'PENDING'; -- 1 single join query!
```

---

## 👥 Human Developer vs. AI Assistant Roles

| Area | Human Developer Role | AI Assistant Role |
|------|----------------------|-------------------|
| **Schema Design** | Approves entity relationships, primary keys, and data types | Generates DDL scripts, ORM entities, and migration files |
| **Indexing** | Approves index strategies based on production query traffic | Identifies missing foreign key indexes and suggests query optimizations |
| **Transactions** | Defines isolation level requirements (Read Committed vs Serializable) | Wraps multi-step entity persistence operations in transaction blocks |

---

## 💡 Code Examples: Good vs. Bad Practices

### Anti-Pattern: String Concatenation SQL Injection ❌
```typescript
// BAD: Concatenating input directly into SQL query string
async function getUserByEmail(email: string) {
  // ❌ Vulnerable to SQL injection (' OR 1=1 --)
  return await db.raw(`SELECT * FROM users WHERE email = '${email}'`); 
}
```

### Production-Grade Pattern: Parameterized Prepared Statement ✅
```typescript
// GOOD: Safe parameterized query using placeholders
async function getUserByEmail(email: string) {
  return await db.query('SELECT id, email, name FROM users WHERE email = $1', [email]);
}
```

---

## 📋 Code Review Checklist for Database Practices

- [ ] **Migration Scripts Included**: Does every schema change have a corresponding versioned SQL migration file?
- [ ] **Foreign Key Indexes**: Are foreign key columns indexed to prevent full table lock scans during joins?
- [ ] **Parameterized Parameters**: Are all queries parameterized using `$1` or `?` placeholders without string interpolation?
- [ ] **No N+1 Loops**: Are ORM query eager-loading (`include`, `joinFetch`) used when iterating over entity lists?

---

::: details Prompt Reference
<<< ../rules/practices/database.md
:::
