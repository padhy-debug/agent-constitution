# Java & Kotlin Conventions

Applies whenever the project (or current task) uses Java or Kotlin.

---

## 1. Style & Idioms

- **Java**:
  - Target modern Java (LTS 17 or 21+).
  - Use `var` for local variables with obvious initializers; prefer `record` for immutable DTOs and value objects.
  - Never return `null` for collections or optionals; return `Collections.emptyList()` or `Optional.empty()`.
- **Kotlin**:
  - Leverage null-safety (`String?` vs `String`). Avoid forceful unwrapping with `!!`.
  - Use `data class` for data holders and sealed interfaces/classes for state modeling.
  - Idiomatic standard functions (`let`, `apply`, `also`) should be used cleanly without excessive nesting.

---

## 2. Spring Boot & Architecture

- **Clean Layering**:
  - `Controller` (REST API layer, request validation with `@Valid`)
  - `Service` (Business logic transactions `@Transactional(readOnly = true)` by default)
  - `Repository` (Spring Data interfaces)
  - `DTO` / `Entity` separation (never expose `@Entity` domain models directly over REST endpoints).
- **Configuration**:
  - Use `@ConfigurationProperties` with constructor binding for typed settings. Never scatter raw `@Value` strings across business logic.

---

## 3. Database & JPA Safety

- **N+1 Query Prevention**: Always watch out for lazy loading in collections. Use `@EntityGraph` or `JOIN FETCH` queries when loading related associations in bulk.
- **Transactions**: Keep `@Transactional` boundaries at the service level, as short as possible to reduce connection pool contention.

---

## 4. Testing

- Use **JUnit 5** and **AssertJ** for fluent assertions.
- Use **Testcontainers** for real integration testing with PostgreSQL, MySQL, Kafka, or Redis rather than in-memory approximations (like H2) that mask SQL dialect divergence.
- Mock external integrations with `WireMock` or `@MockBean`.
