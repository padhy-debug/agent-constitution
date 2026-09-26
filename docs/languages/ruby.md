# Modern Ruby Standards & Conventions

Applies whenever the project uses Ruby (Ruby 3.2 / 3.3+).

---

## 1. Tooling & Environment Management

- **Ruby Version**: Target modern MRI Ruby (3.2+). Specify exact version in `.ruby-version` and `Gemfile`.
- **Package Management**: Use **Bundler** with committed `Gemfile.lock`. Regularly run `bundle audit` to catch vulnerable dependencies.
- **Linting & Code Style**:
  - Enforce **RuboCop** with project-tailored `.rubocop.yml` (e.g., `rubocop-rails`, `rubocop-performance`, `rubocop-rspec`).
  - Zero auto-formatting of untouched lines.
- **Type Checking (Optional/Encouraged)**:
  - Use **Sorbet** (`typed: strict` / `typed: true`) or **RBS** / Steep in typed codebases.

---

## 2. Idiomatic Modern Ruby

- **Pattern Matching**:
  - Utilize native pattern matching (`in` / `case ... in`) for hash and array deconstruction instead of deeply nested conditional branches.
- **Keyword Arguments**:
  - Use keyword arguments with trailing comma hygiene for multi-parameter methods to maintain explicit call-site readability.
- **Frozen String Literals**:
  - Ensure `# frozen_string_literal: true` is placed at the top of every file (or enabled globally via Ruby CLI / Bundler).
- **Safe Navigation & Value Objects**:
  - Use safe navigation operator (`&.`) deliberately, avoiding masking genuine missing object bugs.
  - Utilize `Data.define` (Ruby 3.2+) for immutable, lightweight value objects:
    ```ruby
    Address = Data.define(:street, :city, :zip)
    ```

---

## 3. Web Frameworks (Rails / Sinatra)

- **Ruby on Rails**:
  - Keep controllers thin and models focused. Put multi-model business workflows in Service Objects / Interactors.
  - Mitigate N+1 database queries: Use `strict_loading` in development / test environments (`config.active_record.strict_loading_by_default = true`).
  - Strong Parameters: Never permit unfiltered parameter mass-assignment (`params.require(...).permit(...)`).
  - Background Jobs: Use Active Job with an established backend (Sidekiq, Solid Queue); ensure job payloads only pass record IDs, not complex marshaled objects.

---

## 4. Testing & Verification

- **Test Frameworks**: Standardize on **RSpec** with clean `describe` / `context` / `it` hierarchy or modern Minitest.
- **Fixtures vs. Factories**: Use `FactoryBot` with build strategies (`build_stubbed` over `create` where database persistence is not required to maximize test execution speed).
- **Time Freezing**: Use `ActiveSupport::Testing::TimeHelpers` (`travel_to`, `freeze_time`) for deterministic testing of time-dependent logic.
