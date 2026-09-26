# Modern Python Standards & Conventions

Applies whenever the project (or current task) uses Python.

---

## 1. Tooling & Environment Management

- **Package & Virtual Environment**: Prefer **`uv`** (or `poetry`) for blazing fast, reproducible dependency resolution.
- **Project Configuration**: Use `pyproject.toml` (PEP 621) as the single source of truth for dependencies, build settings, and tool configurations.
- **Linting & Formatting**: Standardize on **`ruff`** for both formatting and linting. It replaces `black`, `isort`, `flake8`, and `pyupgrade` in a single tool.
- **Type Checking**: Enforce strict type hints with `mypy` or `pyright`. Function signatures must have type annotations for all parameters and return types.

---

## 2. Idiomatic Python Code

- **Path Handling**: Always use `pathlib.Path` instead of raw `os.path` strings.
- **Resource Management**: Always use context managers (`with` / `async with`) for files, database sessions, HTTP clients, and thread locks.
- **Data Modeling**:
  - Use `pydantic` v2 (`BaseModel`) for data validation and API schemas.
  - Use standard library `@dataclass(slots=True, frozen=True)` for internal immutable domain models.
- **String Formatting**: Exclusively use f-strings (`f"Hello {name}"`). Never use `%` formatting or `.format()`.

---

## 3. Web & API Frameworks (FastAPI / Django)

- **FastAPI**:
  - Keep route handlers thin; orchestrate logic via domain services.
  - Use dependency injection (`Depends`) for database sessions and auth contexts.
  - Validate query/body parameters via Pydantic models.
- **Async I/O**:
  - Never execute blocking synchronous calls (`time.sleep()`, synchronous `requests`, or sync file writes) directly inside `async def` functions.
  - Use `asyncio.sleep()`, `httpx.AsyncClient()`, or wrap blocking calls with `asyncio.to_thread()`.

---

## 4. Testing & Reliability

- **Pytest Suite**:
  - Use `pytest` with fixtures organized cleanly in `conftest.py`.
  - Use `pytest-asyncio` for asynchronous tests.
  - Prefer parameterized tests (`@pytest.mark.parametrize`) to test boundary values concisely.
- **Mocking**: Use `unittest.mock` or `pytest-mock` to isolate external network calls.
