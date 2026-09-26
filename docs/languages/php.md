# Modern PHP Standards & Conventions

Applies whenever the project uses PHP (PHP 8.2 / 8.3+).

---

## 1. Tooling & Environment Management

- **Strict Typing**: Every PHP file must declare strict types as its very first statement:
  ```php
  <?php
  declare(strict_types=1);
  ```
- **Package Management**: Use **Composer** with committed `composer.lock`. Require explicit platform constraints (`config.platform.php`).
- **Static Analysis**: Enforce **PHPStan** (level 8 or max) or **Psalm**. CI builds must fail on static analysis errors.
- **Code Style**: Enforce PSR-12 / PER Coding Style 2.0 via `PHP-CS-Fixer` or `Pint`.

---

## 2. Idiomatic Modern PHP

- **Constructor Property Promotion & Readonly**:
  - Use constructor property promotion to declare class properties concisely.
  - Mark immutable DTOs and value objects `readonly class`:
    ```php
    readonly class UserRegisteredEvent
    {
        public function __construct(
            public string $userId,
            public DateTimeImmutable $occurredAt,
        ) {}
    }
    ```
- **Type Safety & Native Types**:
  - Explicit return types and parameter types on all functions and methods.
  - Use union types (`int|float`), intersection types (`Countable&Traversable`), and DNF types (`(HasTitle&HasAuthor)|null`).
  - Use `match` expressions instead of legacy `switch` statements for strict equality and exhaustive evaluation.
- **Enums**:
  - Use native backed enums (`enum Status: string`) instead of string constants or class constants for finite state sets.

---

## 3. Web & API Frameworks (Laravel / Symfony)

- **Laravel**:
  - Keep controllers skinny; delegate domain logic to Action classes or Domain Services.
  - Always validate incoming requests using FormRequest classes with strict validation rules.
  - Database operations: Guard against N+1 problems via `Model::preventLazyLoading(!app()->isProduction())`.
- **Symfony**:
  - Leverage autowiring and attribute-based routing and validation (`#[Route]`, `#[Assert\NotBlank]`).
  - Isolate business logic into stateless services injected through constructor dependency injection.

---

## 4. Testing & Verification

- **Test Frameworks**: Standardize on **Pest PHP** or **PHPUnit 10+**.
- **Database Testing**: Use transactions (`RefreshDatabase`) or test database fixtures to isolate test mutations.
- **Mocking**: Use Mockery or native PHPUnit test doubles; assert external API contracts using HTTP client fakes (`Http::fake()` in Laravel).
