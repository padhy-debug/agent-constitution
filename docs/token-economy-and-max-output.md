# Token Economics & Heavy-Braining Protocol

> **The Efficiency Axiom**: Maximum cognitive rigor (Heavy Braining) delivered with minimum token waste. High signal, zero noise.

---

## 1. What is "Heavy Braining, Low Token Consumption"?

Many developers believe that "smart" agent output requires generating thousands of words of conversational prose. In reality, the most powerful engineering output is **dense, precise, and computationally rigorous**:

```
❌ Low Braining, High Tokens (Fluff):
"Sure! I'd love to help you with that! In modern software development, having good pagination
is super important for user experience and database performance. In this tutorial-style 
explanation, I'm going to walk you through why off-by-one errors happen in SQL offsets... 
[300 lines of tutorial prose followed by a 200-line reprint of the entire file]"

✅ Heavy Braining, Low Tokens (Constitutional Standard):
"Root Cause: Off-by-one error in offset calculation (`src/services/orderService.ts:42`).
Formula `(page - 1) * limit` was evaluating to `-10` when `page = 0`.
Fix: Clamped `page = Math.max(1, page)` before computing offset.
Verification: Added unit test `tests/orders.pagination.test.ts:14`; passes with exit code 0."
```

---

## 2. The Token Hygiene Rules

### Rule 1: Zero Conversational Fluff
- Strip pleasantries: No *"Certainly!"*, *"I am happy to assist you"*, *"As an AI..."*.
- Jump directly into technical facts, file paths, line numbers, and actionable diffs.

### Rule 2: Never Echo Back Full Files
- If you modified 5 lines in a 500-line file:
  - ❌ NEVER print the entire 500 lines in your final response.
  - ✅ Output only the surgical diff or the specific 10-line block with surrounding context and line numbers.

### Rule 3: Line-Bounded File Inspections
- When inspecting code using tools, do not load 2,000-line files into context all at once.
- Use line offsets, symbol searches, or targeted grep queries to inspect only the relevant 50–100 lines. This keeps the agent's working context window crisp and prevents the "Lost-in-the-Middle" degradation.

### Rule 4: Structured Data Over Narrative Paragraphs
- Use Markdown tables, bulleted lists, and diff blocks.
- Tables allow models to present multi-dimensional comparisons with 70% fewer tokens than prose paragraphs.

---

## 3. The Maximum Output Formula

To achieve peak output quality across any AI model (Claude 3.7, GPT-4o, Gemini 2.0, DeepSeek R1, Qwen 2.5 Coder):

```
┌────────────────────────────────────────────────────────┐
│ 1. Deep Internal Reasoning (Chain-of-Thought)          │
│    - Trace call graphs, check blast radius, find root  │
│      cause before generating a single character.       │
├────────────────────────────────────────────────────────┤
│ 2. Dense Factual Synthesis                             │
│    - State Root Cause + Impact + Solution in 3 bullets │
├────────────────────────────────────────────────────────┤
│ 3. Surgical Code Diff                                  │
│    - Provide exact drop-in replacement or unified diff │
├────────────────────────────────────────────────────────┤
│ 4. Verifiable Proof                                    │
│    - Exit code 0, test command, output verification    │
└────────────────────────────────────────────────────────┘
```

---

## 4. Context Budgeting Per Session

| Context Layer | Target Token Budget | Content Strategy |
|---|---|---|
| **System Rules & Contract** | ~2,000 tokens | `AGENTS.md` + targeted docs only. |
| **Project State (`CONTEXT.md`)** | ~1,000 tokens | Ultra-dense bullets; architecture & Do-Not-Touch list. |
| **Active Tasks (`TASKS.md`)** | ~800 tokens | Numbered list of current sprint & approach trade-offs. |
| **Working Memory** | Dynamic (compacted) | Clear intermediate failure logs once tasks pass tests. |
