---
name: content-patterns
description: Section structure for each content type — what to cover, not how to visualize it
---

# Content Patterns

## Section ID Rules (applies to ALL patterns)

Section `id` attributes MUST NOT collide with Mermaid's built-in SVG icon `<symbol>` IDs. Mermaid renders icons like `<symbol id="database">` inside `<defs>`, which shadows any `<section id="database">`, breaking TOC navigation.

**Banned IDs** (Mermaid icon names): `database`, `server`, `cloud`, `clock`, `flag`, `heart`, `star`, `lightning`, `gear`, `lock`, `user`, `mail`, `phone`, `document`, `folder`, `search`

**Use prefixed alternatives**: `db-schema`, `server-arch`, `cloud-infra`, `auth-flow`, `file-ref`, etc.

---

## The visual-first rule

Every section below describes **what** to cover. It does NOT tell you **how** to visualize it. That's your creative decision. The only rule: every section must have at least one visual element that could communicate the core idea on its own, without the surrounding text.

Ask: "If I deleted all the paragraphs in this section, would a visual learner still get it from the visuals alone?"

---

## Pattern 1: Codebase Exploration

Use when explaining a repo, onboarding, or presenting a project.

### Required Sections

1. **Overview** (`id="overview"`) — What the project does, tech stack, key dependencies. Show how the major pieces relate to each other.

2. **Features** (`id="features"`) — The main capabilities of the project. Make each feature visually distinct and scannable.

3. **Pages / Views** (`id="pages"`) — Screens, routes, or entry points. Show how a user navigates between them.

4. **Architecture** (`id="architecture"`) — The layers of the system and how they connect. Show what talks to what.

5. **Data Flow** (`id="data-flow"`) — Trace a core user action end-to-end: from user interaction through every layer to the database and back. This section should feel like watching the system work.

6. **Database** (`id="db-schema"`) — Models and their relationships. Show how data is structured and connected.

7. **Key Files Reference** (`id="key-files"`) — Consolidated list of important files with their layer and role.

### Depth Guide
- Don't just list files — explain what each layer DOES and WHY it's structured that way
- Show at least one complete request lifecycle from user click to database and back
- Highlight non-obvious conventions (naming, folder structure, shared patterns)

---

## Pattern 2: Issue Deep-Dive

Use when explaining a bug, error, issue, or PR.

### Required Sections

1. **The Problem** — What's happening vs. what's expected. Show the symptom — what does the user actually see or experience? Error messages should be verbatim in red callout cards.

2. **User Flow** — Steps to reproduce. Show the path a user takes and where it breaks. The failure point should be visually unmistakable.

3. **Code Walkthrough** — Step-by-step trace through the code path. Each step: what the code does, what file it's in, and why it matters for this issue.

4. **Root Cause** — WHY it breaks. This is the "aha moment" — the reader should understand it intuitively, not just intellectually. Make the cause *visible*.

5. **The Fix** — What changes and why. Show the difference between before and after. If the flow changes, show the corrected flow.

6. **Files Involved** — Reference list of all files related to this issue.

### Depth Guide
- Start with the symptom (what the user sees) before diving into code
- Every code snippet must have a "so what" — explain what this code does and why it matters for the issue
- The root cause section should be an "aha moment" — make the reader *see* why it breaks, not just read about it

---

## Pattern 3: Concept Teaching

Use when teaching a programming concept, algorithm, pattern, or technology.

### Required Sections

1. **What & Why** — What is this concept and why does it matter. Ground it with an analogy or metaphor — but don't just write the metaphor, *show* it.

2. **How It Works** — The core mechanism. This is the most important section. The reader should be able to *watch* the concept in action. Make it concrete — use real values, real steps, real transformations. Not abstract descriptions.

3. **Strategies / Approaches** — For each approach:
   - What it does and how (2-3 sentences)
   - A visual that makes this approach's unique tradeoff obvious
   - Code example with syntax highlighting
   - Pros/cons in emerald/amber callout cards

4. **Comparison** — All approaches side by side. Make differences scannable at a glance.

5. **When to Use What** — A decision guide. Help the reader arrive at the right choice for their situation.

6. **Further Reading** — Links and resources for going deeper.

### Depth Guide
- Teach like explaining to a smart colleague who hasn't encountered this specific topic
- Use concrete numbers and examples, not abstract descriptions
- Each strategy section should be self-contained — reader can understand it without reading the others
- The "How It Works" section is the centerpiece — spend your most creative energy here
