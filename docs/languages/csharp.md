# Modern C# & .NET Standards & Conventions

Applies whenever the project uses C# and the .NET ecosystem (.NET 8/9+).

---

## 1. Tooling & Environment Management

- **Target Framework**: Standardize on modern .NET (.NET 8 LTS or .NET 9). Never target legacy .NET Framework unless explicitly required by legacy constraints.
- **Nullable Reference Types**: `<Nullable>enable</Nullable>` must be enabled across all `.csproj` files. Never suppress warnings with `#nullable disable` or blind null-forgiving operators (`!`) without documented invariants.
- **Static Analysis**: Enable `<TreatWarningsAsErrors>true</TreatWarningsAsErrors>` in CI. Utilize Roslyn analyzers and `.editorconfig` for formatting enforcement.
- **Package Management**: Use Central Package Management (`Directory.Packages.props`) for multi-project solutions. Pin exact versions.

---

## 2. Idiomatic C# Code

- **Immutability & Domain Models**:
  - Prefer `record` and `record struct` for DTOs, value objects, and events.
  - Use `init`-only properties (`public string Id { get; init; }`) for immutable state.
- **Pattern Matching & Expressions**:
  - Use switch expressions, property patterns, and positional patterns instead of nested `if-else` or procedural type casting.
  - Use collection expressions (`int[] nums = [1, 2, 3];`) in modern C# 12+.
- **Resource Management**:
  - Always use `using` declarations (`using var stream = ...;`) or `await using` for `IAsyncDisposable`.
  - Never call `.Result` or `.Wait()` on asynchronous Tasks (prevents thread-pool starvation and deadlocks). Always `await`.
- **Memory & Performance**:
  - Use `ReadOnlySpan<T>` and `Memory<T>` for high-throughput string or buffer parsing to eliminate allocations.
  - Avoid multiple enumeration over `IEnumerable<T>`; materialize with `.ToList()` or `.ToArray()` only once when necessary.

---

## 3. Web & API Frameworks (ASP.NET Core)

- **Minimal APIs & Controllers**:
  - Favor Minimal APIs for lightweight microservices; use Controllers for complex CRUD or large hypermedia APIs.
  - Validate incoming payloads using `FluentValidation` or DataAnnotations before business logic execution.
- **Dependency Injection**:
  - Strictly respect service lifetimes: `Transient` (stateless operations), `Scoped` (per HTTP request / DB context), `Singleton` (stateless shared cache/options).
  - Never resolve Scoped services from a Singleton root (captive dependency defect).
- **Entity Framework Core (EF Core)**:
  - Always use `.AsNoTracking()` for read-only queries.
  - Avoid N+1 query traps: explicitly specify `.Include()` or project directly using `.Select()`.
  - Bounded queries: Always enforce `.Take()` pagination; never execute open-ended `.ToListAsync()`.

---

## 4. Testing & Verification

- **Test Frameworks**: Use `xUnit` or `NUnit` paired with `FluentAssertions` for expressive assertion diagnostics.
- **Integration Testing**: Use `WebApplicationFactory<Program>` in conjunction with `Testcontainers` for reliable containerized database and messaging tests.
- **Mocking**: Use `NSubstitute` or `Moq` for interface mocking; verify exact call contracts without over-mocking domain logic.
