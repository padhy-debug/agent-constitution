# 🌟 Acknowledgements & Standing on the Shoulders of Giants

**Agent Constitution** was born from hundreds of hours of debugging agent hallucinations, catastrophic code regressions, silent requirement drops, and token burnout across production software systems. 

Rather than inventing rules from vacuum, this project synthesizes, standardizes, and operationalizes the collective wisdom of the world's leading AI labs, autonomous coding frameworks, and software engineering pioneers.

We gratefully acknowledge and credit the following projects, research papers, and communities whose insights directly shaped this constitution:

---

## 1. AI Labs & Foundational Research

- **Anthropic**:
  - *Constitutional AI: Harmlessness from AI Feedback* (Bai et al.) — The philosophical cornerstone of providing explicit, self-governing behavioral contracts to language models.
  - *Claude System Prompt Engineering & Tool-Use Guidelines* — Best practices for anti-hallucination, epistemic modesty, and structured tool invocations.
- **Google DeepMind**:
  - *Advanced Agentic Coding & Tool-Grounding Research* — Grounding agent responses in verified environment execution, avoiding speculative assertions, and context hygiene.
- **OpenAI & OpenAI Research**:
  - *Model Spec & Instruction Hierarchy* — Separation of core governing instructions from user inputs and untrusted data to mitigate prompt injection.

---

## 2. Autonomous Agent Frameworks & Tooling

- **Aider ([paulgauthier/aider](https://github.com/paulgauthier/aider))**:
  - Pioneered Git-backed agent development, concise repo-map generation via tree-sitter ASTs, and the powerful Architect/Editor multi-agent separation.
- **Cursor ([cursor.com](https://cursor.com)) & Cursor Rules Community**:
  - Popularized `.cursorrules` and modern `.cursor/rules/*.mdc` project-level governance, proving that localized contextual constraints dramatically increase model output quality.
- **Superpowers & Agentic Workflow Community**:
  - *Test-Driven Development (TDD) for Agents*: Enforcing red-green-refactor cycles to provide deterministic runtime feedback loops.
  - *Systematic Debugging Protocol*: The 4-phase isolation discipline that prevents agents from randomly thrashing code.
  - *Verification Before Completion*: Demanding raw terminal evidence before asserting task success.
- **Claude-Mem & MemPalace Ecosystem**:
  - Cross-session persistent memory, timeline extraction, and structured project distillation (`CONTEXT.md` / `TASKS.md` architecture) to eradicate session amnesia.
- **GSD (Get-Stuff-Done) Engine**:
  - Ambiguity scoring matrices, Socratic scoping protocols, and wave parallelization strategies for complex phase execution.
- **OpenHands ([All-Hands-AI/OpenHands](https://github.com/All-Hands-AI/OpenHands)) & Devin (Cognition)**:
  - Deep empirical analysis of real-world agent failure modes on the SWE-bench benchmark.

---

## 3. Software Engineering & Security Pioneers

- **OWASP (Open Web Application Security Project)**:
  - The OWASP Top 10 and Application Security Verification Standard (ASVS), adapted in `docs/security-and-depth.md` to prevent agents from introducing security vulnerabilities.
- **Kent Beck & Extreme Programming (XP)**:
  - The principles of Test-Driven Development (TDD), simple design, and regression safety.
- **Adam Wiggins & Heroku (The Twelve-Factor App)**:
  - The declarative, stateless, and environment-decoupled patterns enshrined in `docs/deployment-guide.md`.
- **Martin Fowler**:
  - Architectural patterns for refactoring, domain-driven design, and blast radius containment.

---

## 4. Contributing & Community

This constitution is an evolving, living document. If your project, research, or idea has contributed to improving autonomous agent reliability and you would like to be credited or suggest refinements, please open a PR or issue! See [`CONTRIBUTING.md`](./CONTRIBUTING.md).
