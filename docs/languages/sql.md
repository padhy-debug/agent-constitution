# SQL & Database Architecture Standards & Conventions

Applies whenever writing SQL queries, designing schemas, or authoring database migrations (PostgreSQL, MySQL, SQLite).

---

## 1. Schema Migrations & Zero-Downtime DDL

- **Migration Linearity & Reversibility**:
  - Every migration must be version-ordered and reversible (`up` and `down` steps).
  - Never alter an already-applied migration file in a shared environment; write an additive new migration.
- **Lock Contention & Zero-Downtime Practices (PostgreSQL / MySQL)**:
  - **Adding Columns**: Add columns as `NULLABLE` or with standard defaults (`DEFAULT value` without rewrite in PostgreSQL 11+). Never add non-nullable columns without defaults on large production tables.
  - **Adding Indexes**: Always create indexes concurrently to prevent read/write locks:
    ```sql
    -- PostgreSQL
    CREATE INDEX CONCURRENTLY idx_users_email ON users(email);
    -- MySQL / InnoDB
    ALTER TABLE users ADD INDEX idx_users_email (email), ALGORITHM=INPLACE, LOCK=NONE;
    ```
  - **Renaming Columns/Tables**: Use the expand-contract pattern:
    1. Add the new column/table.
    2. Dual-write to both old and new columns in application code.
    3. Backfill historic data.
    4. Switch reads to new column.
    5. Drop old column in a later release.

---

## 2. Query Performance & Defensive SQL

- **Index Grounding**:
  - Every `WHERE`, `JOIN`, and `ORDER BY` clause operating on tables with >10,000 rows must be supported by an index.
  - Use composite indexes matching the query prefix order: Equality columns first, range/sort columns second.
- **Bounded Result Sets**:
  - Never execute unbounded `SELECT * FROM table` queries.
  - Mandate explicit column selection (`SELECT id, status, created_at`) and bounded pagination (`LIMIT :limit OFFSET :offset` or keyset/cursor pagination).
- **Execution Plan Verification**:
  - Profile complex queries using `EXPLAIN ANALYZE` (or `EXPLAIN EXTENDED`).
  - Eliminate sequential scans (`Seq Scan`) on large tables.

---

## 3. Transaction Isolation & Safety Guardrails

- **Explicit Transactions**:
  - Wrap multi-table mutations in an explicit transaction block (`BEGIN` / `COMMIT`).
  - Keep transactions as short as possible to prevent lock escalation and connection-pool exhaustion.
- **Destructive Command Lockout**:
  - Hard prohibition on destructive queries (`DROP DATABASE`, `TRUNCATE`, bulk `DELETE` or `UPDATE` without `WHERE` clause).
  - Always run a `SELECT COUNT(*)` with the identical `WHERE` predicate before executing bulk mutations.

---

## 4. Security & Data Integrity

- **SQL Injection Prevention**:
  - 100% parameterized queries. Zero raw string interpolation (`f"SELECT * WHERE id = '{id}'"` is a critical vulnerability).
- **Integrity Constraints**:
  - Enforce referential integrity at the database layer via Foreign Keys with appropriate `ON DELETE` rules (`RESTRICT`, `CASCADE`, or `SET NULL`).
  - Enforce domain validation via `CHECK` constraints (e.g., `CHECK (price >= 0)`).
