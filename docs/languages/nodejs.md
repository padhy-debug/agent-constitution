# Modern TypeScript & Node.js Conventions

Applies whenever the project (or current task) uses JavaScript, TypeScript, or Node.js runtime environments.

---

## 1. Tooling & Environment

- **TypeScript First**: Strict TypeScript is mandatory (`"strict": true` in `tsconfig.json`). Never use `any` when `unknown` or specific generics can be used.
- **Package Manager**: Prefer `pnpm` (fast, disk-efficient) or `npm`/`bun`. Always commit lockfiles (`pnpm-lock.yaml`, `package-lock.json`).
- **Module System**: Default to ESM (`"type": "module"`). Use standard ES imports/exports.
- **Linting & Formatting**: Standardize on `eslint` with typescript-eslint and `prettier`, or modern unified tools like `biome`.

---

## 2. Idiomatic Code Patterns

- **Async & Promises**:
  - Exclusively use `async/await` syntax.
  - Never allow floating promises; always await or return promises.
  - Wrap async operations in try/catch or route them through centralized error handlers.
- **Immutability & Variables**:
  - Default to `const`. Use `let` only for reassignable loops/counters. Never use `var`.
  - Prefer immutable array methods (`.map()`, `.filter()`, `.toSorted()`, `.toReversed()`) over mutating in-place (`.sort()`, `.reverse()`).
- **Data Validation**:
  - Validate all external JSON payloads at the edge using **Zod** or **TypeBox**.
  - Derive TypeScript types directly from schemas (`type User = z.infer<typeof UserSchema>`).

---

## 3. Architecture & APIs

- **Layered Structure**:
  - `routes/` (URL definitions and HTTP schema validation)
  - `controllers/` (Request/response status mapping)
  - `services/` (Core business logic, transaction management)
  - `repositories/` (Database queries via Prisma, Drizzle, or Kysely)
- **Centralized Error Handling**: Use custom application error classes extending `Error` and handle them via middleware. Never send unhandled stack traces to API clients in production.
- **Logging**: Use structured JSON loggers (`pino` or `winston`). Do not leave raw `console.log()` statements in production services.

---

## 4. Testing

- Use **Vitest** (fast, native ESM/TS support) or **Jest**.
- Colocate unit tests (`*.test.ts` or `*.spec.ts`) near the source or mirror under `tests/`.
- Run tests in watch mode during development; run `pnpm test --run` in CI.
