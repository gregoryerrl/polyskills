---
name: strategies
description: Research strategies for each investigation type — codebase, issue, topic
---

# Research Strategies

## Strategy 1: Codebase Investigation

Full architecture scan. Goal: understand everything a new team member needs to know.

### Phase 1 — Discovery (fast scan)

Read these first to get the big picture:

```
1. Package manifest (package.json, composer.json, Cargo.toml, go.mod)
2. Entry points (routes, main.*, index.*, app.*)
3. Config files (.env.example, config/, CLAUDE.md, README.md)
4. Directory listing (ls -la, tree -L 2)
```

From this, identify: language, framework, project type, key dependencies.

### Phase 2 — Database (get the truth)

Use the **fastest path to accurate schema**:

| Priority | Method | When to use |
|----------|--------|-------------|
| 1 | Schema dump command | If available (e.g., `pg_dump --schema-only`, `php artisan schema:dump`) |
| 2 | Schema file on disk | Look for `database/schema/`, `schema.sql`, `db/structure.sql` |
| 3 | Migration files | Read ALL migrations in order — they ARE the schema |
| 4 | Model/Entity files | Read model classes for relationships, casts, fillable fields |

**You MUST read the actual schema or migrations.** Listing file names is not research.

For each table, document:
- Table name
- All columns with types (from migration or schema dump)
- Primary key, foreign keys, indexes
- Relationships (from model `belongsTo`, `hasMany`, etc.)
- Notable fields (JSON columns, enums, computed columns, soft deletes)

### Phase 3 — Architecture

Read actual files to map the layers:

| Layer | What to read | What to document |
|-------|-------------|------------------|
| **Routes** | Route files | All route groups, middleware, URL patterns |
| **Controllers** | Controller files | What each does, what service it calls |
| **Services** | Service classes | Business logic, what they orchestrate |
| **Jobs** | Job classes | Async operations, what triggers them |
| **Models** | Model files | Relationships, scopes, casts, observers |
| **Frontend** | Page components | What each page renders, what props it needs |
| **Middleware** | Middleware files | Auth, permissions, request/response transforms |

### Phase 4 — Data Flow

Trace 2-3 core user actions end-to-end:
1. Pick a representative action (e.g., "user duplicates an ad")
2. Start from the route → controller → service → job → database
3. Document each step with file path and line numbers
4. Note what data flows between each layer

### Phase 5 — Patterns & Conventions

Document non-obvious things:
- Naming conventions (file names, class names, database columns)
- Authentication flow (how users log in, what identity provider)
- Permission model (roles, gates, middleware)
- Job/queue patterns (sync vs async, batching, retries)
- Testing approach (unit, integration, E2E; how to run)

---

## Strategy 2: Issue Investigation

Targeted analysis of a specific bug, feature request, or problem.

### Phase 1 — Extract Requirements

1. Fetch the issue: `gh issue view <number>` (or read the provided text)
2. Copy each requirement **word-for-word** into a numbered list
3. Classify each as:
   - **Hard constraint** — wording leaves no room for interpretation
   - **Ambiguous** — multiple valid readings, needs clarification
   - **Implicit** — not stated but logically follows from explicit requirements

### Phase 2 — Trace Code Path

For each requirement:
1. Find the entry point (route, event handler, scheduled job)
2. Read through the actual execution path
3. Document what happens at each step (file, function, line)
4. Identify where the current behavior diverges from the requirement

### Phase 3 — Root Cause (for bugs)

1. Identify the exact line(s) where behavior goes wrong
2. Explain WHY it goes wrong (not just WHAT is wrong)
3. Check for related patterns — does this same bug exist elsewhere?

### Phase 4 — Browser Testing (if applicable)

For UI issues, use Brave DevTools MCP:
1. Navigate to the relevant page
2. Reproduce the exact scenario
3. Capture screenshots as evidence
4. Record exact error messages verbatim

### Phase 5 — Web Research (when code leaves gaps)

Search when the code trace alone does not explain the behavior or you need external API/framework docs to propose a fix:
- Search the exact error message or framework-specific behavior
- Check for known issues, breaking changes, or documented constraints
- Do not search for answers the code already provides

### Phase 6 — Compliance Map

For each numbered requirement:
1. Quote it verbatim
2. Point to the exact code that implements/violates it
3. If your proposed approach deviates, state why explicitly

---

## Strategy 3: Topic Investigation

Targeted deep-dive into a specific system, feature, or concept within a codebase.

### Phase 1 — Scope

Define exactly what you're investigating:
- What is the user trying to understand?
- What files/systems are in scope?
- What's the boundary — where does this topic end?

### Phase 2 — Read the Code

Read ALL files relevant to the topic. Not file names — actual code:
1. Entry points into this system
2. Core logic files
3. Data models involved
4. Configuration that affects behavior
5. Tests that document expected behavior

### Phase 3 — Map Interactions

Document how this system interacts with others:
- What calls into this system?
- What does this system call?
- What data does it read/write?
- What events does it produce/consume?

### Phase 4 — Edge Cases & Gotchas

From reading the actual code:
- What error handling exists?
- What are the known limitations?
- What configuration changes behavior?
- What's tricky or non-obvious?

### Phase 5 — Web Research (when code leaves gaps)

Search when the code does not fully explain the behavior or external context is needed:
- Search for framework/library-specific behavior relevant to this system
- Check if third-party APIs or services have constraints that affect this system
- Do not search for answers the code already provides

---

## Strategy 4: General Concept Investigation

Research a programming concept, algorithm, pattern, or technology that exists outside any specific codebase. Examples: BigInt constraints, consistent hashing, OAuth flows, event sourcing, database isolation levels.

### Phase 1 — Define & Scope

1. What is this concept? (precise definition)
2. What problem does it solve?
3. Where does it come from? (language, spec, paper, framework)
4. What's the scope — what are we covering vs. leaving out?

### Phase 2 — Research

Use web search and authoritative sources:
- Official documentation / language specs
- RFCs or standards (if applicable)
- Well-known reference implementations

**For each claim, identify the source.** Don't state things as fact without knowing where the information comes from.

Document:
- How it works mechanically (step by step)
- Constraints, limits, edge cases
- Common misconceptions
- Real-world examples with concrete values (not abstract)

### Phase 3 — Approaches & Tradeoffs

If the concept has multiple strategies or implementations:
- Document each approach separately
- Compare: when to use which, pros/cons
- Include concrete code examples where helpful

### Phase 4 — Practical Application

- When would you actually use this?
- What are the gotchas in practice?
- How does it interact with the user's tech stack (if known)?
- Decision framework: "use X when Y, use Z when W"
