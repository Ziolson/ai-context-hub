# Database Design & Operations Rules

> Standards for designing schemas, writing queries, and operating databases safely.
> For parameterized queries and injection prevention, refer to `rules/global-rules.md` (section 5).

---

## 1. Naming Conventions

- **Tables**: plural nouns, `snake_case` — `users`, `orders`, `payment_methods`
- **Columns**: `snake_case` — `first_name`, `created_at`, `is_active`
- **Indexes**: `idx_<table>_<columns>` — `idx_orders_user_id`, `idx_users_email`
- **Foreign keys**: `fk_<table>_<referenced_table>` — `fk_orders_users`
- **Junction/join tables**: combine both table names — `user_roles`, `order_items`
- Never abbreviate unless the abbreviation is universally understood (e.g., `id`, `url`)

---

## 2. Schema Design

### Primary Keys
- Every table must have a primary key
- Use **UUIDs (`uuid` / `uuid_generate_v4()`)** for public-facing identifiers — prevents enumeration attacks and allows distributed ID generation
- Internal/join tables may use composite primary keys or auto-incrementing integers
- Never expose auto-incrementing integer IDs in public APIs

### Standard Columns
Include these on every business entity table:

```sql
id          UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
updated_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
```

- `created_at` / `updated_at` must always be stored in **UTC** (`TIMESTAMPTZ`)
- Update `updated_at` via a database trigger or in the application layer on every write

### Data Types
- Use **`TIMESTAMPTZ`** (with timezone) for all datetime columns — never `TIMESTAMP` without timezone
- Use **`TEXT`** instead of `VARCHAR(n)` unless you specifically need a length constraint enforced at the DB level
- Use **`BOOLEAN`** for boolean flags — never `TINYINT(1)` or `CHAR(1)` 'Y'/'N'
- Store **monetary amounts** as `INTEGER` (cents/smallest currency unit) or `NUMERIC(19,4)` — never `FLOAT` or `DOUBLE`
- Store **JSON** as `JSONB` (binary JSON with indexing support), not `JSON` (stored as text)

---

## 3. Indexing

- Index **every foreign key column** — unindexed foreign keys cause full table scans on joins and cascades
- Index columns used frequently in **`WHERE` clauses** with high cardinality (many distinct values)
- Use **composite indexes** for frequent multi-column queries — order matters (most selective / most frequently filtered column first)
- Use **partial indexes** for queries that always include a constant condition:
  ```sql
  CREATE INDEX idx_orders_pending ON orders (created_at) WHERE status = 'pending';
  ```
- Regularly review unused indexes (they slow down writes) and missing indexes (they slow down reads)
- Do not index every column — over-indexing has real write performance and storage costs

---

## 4. Migration Safety

Migrations must be **safe to run in production without downtime**. Follow these rules:

### Always Safe (do freely)
- Add a new nullable column
- Add a new table
- Add an index `CONCURRENTLY` (non-blocking)
- Add a new nullable foreign key

### Requires Care
- **Add a NOT NULL column**: Always add with a `DEFAULT` value first, backfill, then optionally add the constraint in a separate migration
- **Add an index**: Use `CREATE INDEX CONCURRENTLY` to avoid locking the table
- **Add a constraint** (`CHECK`, `UNIQUE`): Validate data first, then add `NOT VALID`, then validate separately

### Never Do in a Single Deployment
- **Rename a column or table**: This breaks existing code still running the old version. Use the expand/contract pattern:
  1. Add the new column, write to both old and new
  2. Backfill data to the new column
  3. Migrate reads to the new column
  4. Remove writes to the old column
  5. Drop the old column in a future migration
- **Drop a column or table**: Ensure no running code references it first (deploy code removal first, then drop)
- **Change a column's data type**: Use a new column + backfill + switch + drop pattern

### Migration Rules
- Every migration must be **reversible** (provide a `down` migration) or explicitly documented as irreversible with justification
- Never modify a migration that has already been applied to production — create a new migration instead
- Run migrations as a **separate step** before deploying new code (code should handle both old and new schema for zero-downtime)
- **Always take a database backup** before running destructive migrations in production

---

## 5. Query Practices

- **Never use `SELECT *`**: Specify the exact columns needed — prevents unexpected breakage when schema changes and avoids transferring unnecessary data
- **Always limit result sets**: Never query an unbounded set of rows — always use `LIMIT` (or equivalent) in queries that could return many rows
- **Use query parameters**: Always use parameterized queries — never string-concatenate user input into SQL (see `rules/global-rules.md`)
- **Avoid `OFFSET` pagination on large tables**: Use cursor-based pagination (keyset pagination) for large datasets — `OFFSET 10000` scans 10,000 rows to discard them
- **Understand `EXPLAIN ANALYZE`**: Before deploying a non-trivial query, run `EXPLAIN ANALYZE` to verify it uses indexes and has no unexpected seq scans on large tables

---

## 6. Soft Deletes vs Hard Deletes

Choose one strategy per table and document it:

| Strategy | When to use | Implementation |
|----------|-------------|----------------|
| **Hard delete** | Default — data has no audit requirements, no foreign key dependencies | `DELETE FROM table WHERE id = ?` |
| **Soft delete** | Audit trails needed, data referenced by other records, "undo" required | Add `deleted_at TIMESTAMPTZ NULL` column; filter `WHERE deleted_at IS NULL` in all queries |

If using soft deletes:
- Add a partial unique index to exclude soft-deleted rows from uniqueness constraints:
  ```sql
  CREATE UNIQUE INDEX idx_users_email_active ON users (email) WHERE deleted_at IS NULL;
  ```
- Ensure all queries filter `WHERE deleted_at IS NULL` — consider a database view or ORM scope to enforce this
- Periodically hard-delete old soft-deleted rows if storage is a concern (document the retention policy)
