# Architecture & System Design Standards

> **Goal**: Any project governed by this constitution must look like it was architected by a staff engineer from day one — clean, maintainable, modular, and resilient to scale.

---

## 1. Core Architectural Axioms

1. **Separation of Concerns (SoC)**:
   - Presentation/Transport layer (HTTP, gRPC, CLI)
   - Business / Domain logic (Pure services, rules, calculations)
   - Data Access / Persistence (ORM, SQL repositories, caches)
   - Infrastructure & Configuration (Environment, third-party SDKs)
2. **Single Responsibility & File Sizing**:
   - Files should not exceed ~300 lines without exceptional justification.
   - If a file has multiple unrelated responsibilities, decompose it into focused modules.
3. **Dependency Rule**:
   - Dependencies must point inward: domain logic must never import from transport controllers or database drivers directly. Use interfaces / dependency inversion where appropriate.
4. **Predictable Navigation**:
   - A newly onboarded developer should be able to deduce the exact location of any feature from folder names alone.
5. **Configuration Decoupling**:
   - Code must be build-once, run-anywhere. All environment differences are injected via validated environment variables.

---

## 2. Standard Layout Archetypes

### Archetype A: Modular Full-Stack App
```
project-root/
├── AGENTS.md                 # Constitution Master Contract
├── CONTEXT.md                # Project Persistent Memory
├── TASKS.md                  # Active Task Ledger
├── docs/                     # Standards & Protocols
├── src/
│   ├── app/                  # Application bootstrap & routing
│   ├── modules/              # Domain-driven feature modules
│   │   ├── users/
│   │   │   ├── users.controller.ts
│   │   │   ├── users.service.ts
│   │   │   ├── users.repository.ts
│   │   │   ├── users.schema.ts
│   │   │   └── tests/
│   │   └── payments/
│   ├── shared/               # Shared cross-cutting primitives
│   │   ├── config/           # Validated env settings
│   │   ├── middleware/       # Auth, logging, rate limiting
│   │   ├── errors/           # Standardized error hierarchy
│   │   └── utils/
│   └── main.ts
├── tests/                    # End-to-end and integration suites
└── .env.example
```

### Archetype B: Clean Architecture / Hexagonal Service
```
project-root/
├── src/
│   ├── domain/               # Enterprise entities & business rules (0 external deps)
│   ├── usecases/             # Application workflows & orchestration
│   ├── ports/                # Inbound/outbound interfaces (driven & driving ports)
│   └── adapters/             # Concrete implementations
│       ├── primary/          # HTTP controllers, CLI commands, event listeners
│       └── secondary/        # Database repos, external API clients, message brokers
```

---

## 3. Rules for Autonomous Agents

1. **Check Ownership**: Before creating any new file, check if an existing module already owns that domain responsibility. Extend or refactor; never fork logic.
2. **Folder Discipline**: Never create top-level directories without verifying alignment with existing architecture in `CONTEXT.md`.
3. **Dependency Budget**: Adding a third-party dependency is an architectural decision. Always consider if the standard library or an existing package can accomplish the goal.
4. **No God Objects**: Never lump all utility functions into a single generic `utils.js` or `helpers.py`. Group utilities by purpose (e.g. `crypto.ts`, `dates.ts`, `sanitization.ts`).
