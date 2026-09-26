# Deployment & Production Readiness Playbook

The baseline production deployment and operational reliability standard for modern applications.

---

## 1. Twelve-Factor Foundations

1. **Codebase**: One codebase tracked in revision control, many deploys.
2. **Dependencies**: Explicitly declared and isolated via lockfiles (`package-lock.json`, `uv.lock`, `Cargo.lock`, `go.sum`).
3. **Config in Environment**: Strict separation of config from code. Never hardcode credentials, ports, or environment URLs.
4. **Backing Services**: Treat databases, queues, and caches as attached resources via connection URLs.
5. **Build, Release, Run**: Strict separation between the build stage (compilation/bundling), release stage (combining build + config), and run stage.
6. **Stateless Processes**: Application instances must be stateless and share-nothing. Persist state in backing datastores.
7. **Concurrency & Disposability**: Scale out via the process model. Maximize robustness with fast startup and graceful shutdown (`SIGTERM` handling).
8. **Dev/Prod Parity**: Keep development, staging, and production as similar as possible.

---

## 2. Secrets & Environment Variables

- Provide a fully documented `.env.example` containing every variable name, purpose, and dummy example value.
- Validate environment configurations at bootstrap (e.g. using `zod`, `pydantic-settings`, or `envalid`). Fail immediately with clear diagnostics if required variables are missing.
- Never print or serialize environment variables in logs or API errors.

---

## 3. Database Migrations & Zero Downtime

- **Additive Schema Changes**: Always design migrations to be backward-compatible with running versions of the app:
  - Step 1: Add new nullable column / table.
  - Step 2: Deploy new code that writes to both old and new columns.
  - Step 3: Backfill historical data.
  - Step 4: Deploy code that reads exclusively from new column.
  - Step 5: Drop old column in a subsequent release.
- **Rollback Scripts**: Every migration must include a verified down/rollback procedure.
- **Lock Timeouts**: Set strict lock timeouts on DDL migrations to prevent database lock contention outages.

---

## 4. Observability & Health Probes

- **Probes**:
  - `/health/live`: Fast liveness check (is the process responsive?).
  - `/health/ready`: Readiness check (can the process reach DB and dependent services?).
- **Structured JSON Logging**: Output logs in JSON with timestamp, log level, correlation/trace ID, and structured context.
- **Telemetry**: Emit key RED metrics (Rate, Errors, Duration) for all incoming API traffic.

---

## 5. Pre-Release Checklist

- [ ] All unit, integration, and security tests pass in CI.
- [ ] Dependencies have zero critical vulnerabilities (`npm audit`, `pip-audit`, `cargo audit`).
- [ ] Docker / Container builds are deterministic, minimal (multi-stage), and run as non-root users.
- [ ] Rollback strategy and responsible engineer are documented.
- [ ] `CONTEXT.md` updated with release notes and new operational requirements.
