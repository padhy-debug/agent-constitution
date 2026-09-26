# Universal Stack & Ecosystem Auto-Detection

> **Core Principle**: An elite AI agent does not force its favorite language or framework onto a project. It automatically fingerprints the codebase, discovers existing tooling, and writes idiomatic code for ANY language in existence.

---

## 1. Universal Stack Fingerprinting

Before generating or modifying code, the agent must inspect the repository root to detect the language, package manager, and build system:

| Ecosystem | Manifest / Fingerprint Files | Common Build & Test Runners |
|---|---|---|
| **Rust** | `Cargo.toml`, `Cargo.lock` | `cargo check`, `cargo test`, `cargo clippy` |
| **Go** | `go.mod`, `go.sum` | `go build ./...`, `go test -race ./...` |
| **TypeScript / Node** | `package.json`, `pnpm-lock.yaml`, `tsconfig.json` | `pnpm test`, `npm run build`, `vitest`, `jest` |
| **Python** | `pyproject.toml`, `uv.lock`, `poetry.lock`, `Pipfile` | `uv run pytest`, `pytest`, `ruff check`, `mypy` |
| **Java / Kotlin** | `pom.xml`, `build.gradle`, `build.gradle.kts` | `./gradlew test`, `mvn clean test` |
| **C# / .NET** | `*.csproj`, `*.sln`, `Directory.Build.props` | `dotnet build`, `dotnet test` |
| **C / C++** | `CMakeLists.txt`, `Makefile`, `meson.build` | `cmake --build .`, `ctest`, `ninja` |
| **PHP** | `composer.json`, `composer.lock` | `composer test`, `vendor/bin/pest`, `phpunit` |
| **Ruby** | `Gemfile`, `Gemfile.lock`, `.rubocop.yml` | `bundle exec rspec`, `bundle exec rake` |
| **Elixir** | `mix.exs`, `mix.lock` | `mix test`, `mix dialyzer` |
| **Swift / iOS** | `Package.swift`, `*.xcodeproj`, `Podfile` | `swift test`, `xcodebuild test` |
| **Dart / Flutter** | `pubspec.yaml`, `pubspec.lock` | `flutter test`, `dart test`, `flutter analyze` |
| **Infrastructure / IaC** | `main.tf`, `Pulumi.yaml`, `Dockerfile`, `docker-compose.yml` | `terraform validate`, `docker build` |

---

## 2. Dynamic Linter & Style Discovery

Agents must never impose arbitrary formatting. They must dynamically discover and inherit the repository's configuration:

1. **Check for Config Files**:
   - Look for `.editorconfig`, `.prettierrc`, `ruff.toml`, `.golangci.yml`, `rustfmt.toml`, `phpcs.xml`, `.rubocop.yml`, etc.
2. **Inherit Existing Patterns**:
   - If the codebase uses tabs, use tabs.
   - If the codebase uses single quotes, use single quotes.
   - If the codebase uses 2 spaces, never introduce 4 spaces.
3. **Respect Existing Architecture**:
   - Notice whether the repository is a Monorepo (Turborepo, Nx, Cargo Workspace, Go Workspaces) or a single package.

---

## 3. Universal Idiomatic Standard

Regardless of the detected stack, all code produced by the agent must fulfill the **Universal Engineering Standard**:

- **Strict Type Discipline**: Enable and satisfy the strongest type checking available in that language (e.g. strict TypeScript, Rust ownership checks, Go compile safety, MyPy strict mode, modern C++ types).
- **Explicit Error Handling**: Follow the language's native error handling pattern (Go errors as values, Rust `Result<T, E>`, Swift `throw`, Java typed exceptions). Never write empty catch/rescue blocks.
- **Resource Cleanup**: Use language-native RAII or context management (`with` in Python, `defer` in Go, `try-with-resources` in Java, `using` in C#, Drop in Rust).
- **Native Test Runners**: Execute tests using the project's native test runner before declaring any task complete.
