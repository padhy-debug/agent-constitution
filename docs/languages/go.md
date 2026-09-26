# Go (Golang) Conventions

Applies whenever the project (or current task) is Go.

---

## 1. Style & Idioms

- Follow the standard [Effective Go](https://go.dev/doc/effective_go) and [Go Code Review Comments](https://go.dev/wiki/CodeReviewComments).
- Enforce formatting with `gofmt` or `goimports`. Run `golangci-lint` for static analysis.
- **Explicit Error Handling**: Never ignore errors using `_`. Always handle or wrap errors:
  ```go
  if err != nil {
      return fmt.Errorf("failed to load user %q: %w", userID, err)
  }
  ```
- **Context Propagation**: Always pass `ctx context.Context` as the first argument to functions performing I/O, database queries, or network calls. Respect cancellation.
- **Zero Values**: Make the zero value of structs useful whenever feasible.

---

## 2. Project Layout

Follow the standard Go project layout:

```
project-root/
├── cmd/
│   └── app/
│       └── main.go           # Minimal bootstrap only
├── internal/                 # Private application code
│   ├── config/               # Env loading & config parsing
│   ├── domain/               # Core business models/entities
│   ├── handler/              # HTTP / gRPC transport adapters
│   ├── service/              # Application business logic
│   └── repository/           # Database / external store access
├── pkg/                      # Public library code (if intended for import)
├── api/                      # OpenAPI / Proto specs
├── go.mod
└── go.sum
```

---

## 3. Concurrency & Goroutines

- **No Leaking Goroutines**: Every goroutine spawned must have a clear termination path (via `context.Context` done channel or `sync.WaitGroup`).
- **Data Races**: Always run tests with the race detector enabled: `go test -race ./...`.
- Prefer channels for communication, but use `sync.Mutex` / `sync.RWMutex` when synchronizing simple in-memory state. Avoid premature concurrency complexity.

---

## 4. Testing

- Use Go's standard `testing` package with table-driven tests:
  ```go
  func TestValidateEmail(t *testing.T) {
      tests := []struct {
          name    string
          email   string
          wantErr bool
      }{
          {"valid", "user@example.com", false},
          {"missing @", "userexample.com", true},
          {"empty", "", true},
      }
      for _, tt := range tests {
          t.Run(tt.name, func(t *testing.T) {
              err := ValidateEmail(tt.email)
              if (err != nil) != tt.wantErr {
                  t.Errorf("ValidateEmail(%q) err = %v, wantErr %v", tt.email, err, tt.wantErr)
              }
          })
      }
  }
  ```
- For assertions, prefer standard `if` checks or well-adopted libraries like `testify/assert` if already present in `go.mod`.
