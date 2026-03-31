---
name: content-patterns
description: Section templates for each content type — codebase exploration, issue deep-dive, concept teaching
---

# Content Patterns

## Section ID Rules (applies to ALL patterns)

Section `id` attributes MUST NOT collide with Mermaid's built-in SVG icon `<symbol>` IDs. Mermaid renders icons like `<symbol id="database">` inside `<defs>`, which shadows any `<section id="database">`, breaking TOC navigation.

**Banned IDs** (Mermaid icon names): `database`, `server`, `cloud`, `clock`, `flag`, `heart`, `star`, `lightning`, `gear`, `lock`, `user`, `mail`, `phone`, `document`, `folder`, `search`

**Use prefixed alternatives**: `db-schema`, `server-arch`, `cloud-infra`, `auth-flow`, `file-ref`, etc.

---

## Pattern 1: Codebase Exploration

Use when explaining a repo, onboarding, or presenting a project.

### Required Sections

1. **Overview** (`id="overview"`) — What the project does, tech stack, key dependencies. Include a high-level system architecture diagram (`graph TD` with grouped layers).
2. **Features** (`id="features"`) — Card grid of main features with icons and brief descriptions.
3. **Pages / Views** (`id="pages"`) — List of screens/routes with descriptions. Navigation flow diagram (`graph LR` showing page transitions).
4. **Architecture** (`id="architecture"`) — Layered diagram (Frontend → API → Services → Database). Explain each layer with its key files and responsibilities.
5. **Data Flow** (`id="data-flow"`) — Sequence diagram (`sequenceDiagram`) showing a core user action end-to-end: user → frontend → API → service → DB → response.
6. **Database** (`id="db-schema"`) — ER diagram (`erDiagram`) of key models and their relationships.
7. **Key Files Reference** (`id="key-files"`) — Consolidated files-reference list table with file path, layer, and role.

### Depth Guide
- Don't just list files — explain what each layer DOES and WHY it's structured that way
- Show at least one complete request lifecycle from user click to database and back
- Highlight non-obvious conventions (naming, folder structure, shared patterns)

---

## Pattern 2: Issue Deep-Dive

Use when explaining a bug, error, issue, or PR.

### Required Sections

1. **The Problem** — What's happening vs. what's expected. Error messages in red callout cards (verbatim). Screenshot or description of the symptom.
2. **User Flow** — Diagram showing steps to reproduce (`graph TD`). Highlight the failure point with a red-styled node.
3. **Code Walkthrough** — Step-by-step trace through the code path using the numbered-step trace component. Show code snippets at each step with file paths and line numbers. Connect steps with arrows.
4. **Root Cause** — Diagram showing WHY it breaks (`graph LR` with error path highlighted). Violet "Key Insight" callout card explaining the core issue.
5. **The Fix** — Before/after code comparison. Explain what changes and why. Diagram showing the corrected flow if applicable.
6. **Files Involved** — Reference list of all files related to this issue.

### Depth Guide
- Start with the symptom (what the user sees) before diving into code
- Every code snippet must have a "so what" — explain what this code does and why it matters for the issue
- The root cause section should be an "aha moment" — make the reader understand it intuitively

---

## Pattern 3: Concept Teaching

Use when teaching a programming concept, algorithm, pattern, or technology.

### Required Sections

1. **What & Why** — What is this concept and why does it matter. Use an analogy or visual metaphor to ground it. Diagram showing the high-level idea.
2. **How It Works** — Core mechanism explained visually. Diagram showing the fundamental process step by step. Keep it concrete — use real values, not abstract placeholders.
3. **Strategies / Approaches** — For each approach:
   - Explanation paragraph (2-3 sentences)
   - Visual diagram or data representation
   - Code example with syntax highlighting
   - Emerald/amber callout for pros/cons
4. **Comparison** — Side-by-side comparison table of all approaches (use comparison table component).
5. **When to Use What** — Decision flowchart (`graph TD` with diamond decision nodes) guiding the reader to the right approach based on their constraints.
6. **Further Reading** — Links and resources for going deeper.

### Depth Guide
- Teach like explaining to a smart colleague who hasn't encountered this specific topic
- Use concrete numbers and examples, not abstract descriptions
- Each strategy section should be self-contained — reader can understand it without reading the others
- The comparison table is the "cheat sheet" — make it scannable
- The decision flowchart is the "practical takeaway" — make it actionable
