# Modern C++ Standards & Conventions

Applies whenever the project uses C++ (C++20 / C++23 standards).

---

## 1. Tooling & Build Management

- **Build Systems**: Standardize on modern **CMake** (version 3.25+) with target-based commands (`target_include_directories`, `target_link_libraries`). Never use global `include_directories()` or manual link flags.
- **Package Management**: Use **vcpkg** or **Conan** for deterministic third-party dependency resolution. Commit dependency lockfiles (`vcpkg.json`).
- **Linters & Formatters**:
  - Enforce code style via `.clang-format`.
  - Enforce static analysis and defect prevention via `clang-tidy` integrated into compile commands (`compile_commands.json`).
- **Compiler Warnings**: Enable `-Wall -Wextra -Wpedantic -Wconversion -Werror` (or `/W4 /WX` on MSVC).

---

## 2. Idiomatic Modern C++

- **Resource Acquisition Is Initialization (RAII)**:
  - Zero raw `new` / `delete`. All dynamic allocations must be wrapped in `std::unique_ptr` or `std::shared_ptr`.
  - Use `std::make_unique` and `std::make_shared` to guarantee exception safety.
- **Concepts & Type Constraints (C++20)**:
  - Constrain templates using `requires` clauses and concepts (`std::integral`, `std::invocable`) to produce comprehensible compiler errors.
- **String & Span Views**:
  - Prefer `std::string_view` for read-only string parameters (zero allocation overhead). Ensure lifetime of underlying string outlives the view.
  - Use `std::span<T>` for contiguous buffer passes instead of pointer + length pairs.
- **Value Semantics & Move Optimization**:
  - Default to pass-by-value with `std::move` or `const T&` for read-only parameters.
  - Mark move constructors and move assignment operators `noexcept` to allow standard containers to optimize reallocation.
- **Error Handling**:
  - For operations where failure is expected, use `std::expected<T, E>` (C++23) or `std::optional<T>` rather than throwing exceptions across high-throughput loops.

---

## 3. Concurrency & Memory Safety

- **Threading**: Use `std::jthread` (C++20) which automatically joins on destruction and supports cooperative cancellation via `std::stop_token`.
- **Synchronization**:
  - Prefer `std::scoped_lock` over `std::lock_guard` to lock multiple mutexes without deadlock risks.
  - Use `std::atomic<T>` for lightweight lock-free synchronization.
- **Sanitizers**:
  - Build test suites with AddressSanitizer (`-fsanitize=address`), UndefinedBehaviorSanitizer (`-fsanitize=undefined`), and ThreadSanitizer (`-fsanitize=thread`). Clean sanitizer runs are required before deployment.

---

## 4. Testing & Verification

- **Test Frameworks**: Standardize on **GoogleTest (GTest)** or **Catch2**.
- **Deterministic Testing**: Write unit tests isolating memory ownership, edge-case allocations, and exception rollback invariants.
