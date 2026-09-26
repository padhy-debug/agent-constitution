# Rust Conventions

Applies whenever the project (or current task) is Rust.

---

## 1. Style & Idioms

- Run `cargo fmt` and ensure code satisfies `cargo clippy --all-targets -- -D warnings`.
- **Idiomatic Ownership**: Prefer borrowing (`&str`, `&[T]`) over cloning (`.clone()`) unless transfer of ownership or thread isolation is explicitly required.
- **Error Handling**:
  - Never call `.unwrap()` or `.expect()` in production or library code.
  - In applications, use `anyhow::Result` with `.context("descriptive context")`.
  - In libraries, define domain errors using `thiserror`.
- **Pattern Matching**: Exhaustive pattern matching over chained `if let` or deep boolean trees.

---

## 2. Project Layout

Follow standard Cargo workspace or package structures:

```
project-root/
├── Cargo.toml
├── Cargo.lock
├── src/
│   ├── main.rs (or lib.rs)
│   ├── config.rs
│   ├── domain/
│   ├── handlers/
│   ├── services/
│   └── errors.rs
├── tests/                    # Integration tests
│   └── integration_test.rs
└── benches/                  # Benchmarks
```

---

## 3. Concurrency & Async

- When using `tokio`, avoid blocking the async runtime. Offload CPU-heavy or synchronous file I/O to `tokio::task::spawn_blocking`.
- Select carefully between `Arc<Mutex<T>>`, `Arc<RwLock<T>>`, and channel-based actor patterns (`tokio::sync::mpsc`).
- Keep lock guard lifetimes as short as possible to prevent deadlocks.

---

## 4. Testing & Safety

- Use unit tests in module sub-blocks (`#[cfg(test)] mod tests { ... }`).
- Place external integration tests in `tests/`.
- **Zero Unsafe**: Do not use `unsafe` blocks without explicit justification, extensive documentation of safety invariants, and unit tests verifying those invariants.
