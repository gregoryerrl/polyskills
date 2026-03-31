---
name: synthesize
description: Chain command that runs /investigate then /visual-explainer to produce a thoroughly-researched interactive HTML explainer. Triggers on "synthesize", "research and visualize", "deep visual explainer", "thorough explainer", or when the user wants both research accuracy AND visual presentation.
---

# Synthesize

Research a topic thoroughly, then visualize the findings as an interactive HTML page. Runs `/investigate` and `/visual-explainer` as **subagents** to keep the main context lean.

## When to Use

- User wants a visual explainer backed by **accurate, verified data**
- User says "synthesize", "research and visualize", or "deep explainer"
- User asks to "teach me about X" and the topic requires reading actual code/schema to get right

## When NOT to Use

- User already has a markdown/text file they want visualized → use `/visual-explainer` directly
- User just needs research findings without visualization → use `/investigate` directly
- User wants a quick conceptual explanation → use `/visual-explainer` directly

## Process

### Step 1: Investigate (subagent)

Use the **Agent tool** to dispatch a `general-purpose` subagent. The subagent executes the investigation directly (do NOT tell it to read SKILL.md — that would cause double-nesting).

**Agent call:**
- `description`: "Investigate {topic}"
- `prompt`: Use the template below, filling in `{TOPIC}`, `{SLUG}`, and `{CWD}` (current working directory).

```
You are executing the /investigate skill. Your job is to research a topic thoroughly and save structured findings to a markdown file. Execute directly — do NOT dispatch another subagent.

## Instructions

Read and follow ALL instructions in these skill files (read them FIRST before doing anything else):
1. The investigate skill's rules/strategies.md (located as a sibling skill in the same skill pack) — research strategies by type
2. The investigate skill's rules/output-format.md (located as a sibling skill in the same skill pack) — output format templates

## Task

- Topic: {TOPIC}
- Working directory: {CWD}
- Output file: {CWD}/investigation-{SLUG}.md

Execute the full investigation process: classify the topic, follow the matching strategy, write findings in the correct output format, and save to disk. Do not abbreviate or skip phases.

When done, confirm the file was saved and report the absolute path.

## Skill Rules

### Non-Negotiables
1. **Output is a markdown file saved to disk.** Do not answer inline. Always save to `investigation-<slug>.md`.
2. Read actual source files — do not infer structure from naming conventions alone.
3. Use the fastest path to accurate data (schema dump > migrations > model files > guessing).
4. Every claim must be traceable to a file you read or a web source you searched.
5. For issues: extract requirements **verbatim** — do not paraphrase or rationalize away.
6. Web search: use when file reads and your knowledge leave gaps. Do not web search for answers available in local files.

### Classify

| Type | Signal | Strategy |
|------|--------|----------|
| **Codebase** | "investigate this codebase", "analyze the project" | Full architecture scan |
| **Issue** | "investigate issue #X", "research this bug" | Requirement extraction + code trace |
| **Topic (in codebase)** | "investigate how auth works", "research the duplication system" | Targeted deep-dive into codebase feature |
| **Concept (general)** | "investigate BigInt constraints", "research consistent hashing" | General concept research via web + docs |

### Anti-Rationalization (issue investigations)

| If you think... | Reality |
|---|---|
| "This requirement is unnecessary" | You are rationalizing. Document it literally. |
| "This is technically the same as..." | It might not be. Flag as ambiguous. |
| "We can simplify this by..." | Simplification that drops a requirement is a bug. |
| "The user probably meant..." | Read what they wrote, not what you infer. |

### Quality Gate

**All types:**
- [ ] Output saved to `investigation-<slug>.md` (not inline)
- [ ] No placeholder or guessed information
- [ ] Every claim traceable to a file read or web source
- [ ] Output is self-contained and readable without the codebase open

**Codebase / Topic:**
- [ ] Every model/table includes actual fields from schema or migration reads
- [ ] Every relationship verified from model code, not assumed
- [ ] Every code path traced by reading actual files

**Issue:**
- [ ] Every requirement quoted verbatim with classification (Hard/Ambiguous/Implicit)
- [ ] Compliance map links each requirement to exact code

**Concept:**
- [ ] Every factual claim has an identified source (docs, spec, RFC)
- [ ] Concrete examples with real values, not abstract placeholders
```

**Wait for this subagent to complete before starting Step 2.** The investigation output is the data source for visualization.

### Step 2: Visualize (subagent)

Use the **Agent tool** to dispatch a `general-purpose` subagent. The subagent reads the skill files and the investigation output, then generates the HTML page.

**Agent call:**
- `description`: "Visualize {topic}"
- `prompt`: Use the template below, filling in `{TOPIC}`, `{SLUG}`, and `{CWD}`.

```
You are executing the /visual-explainer skill. Your job is to generate a standalone interactive HTML page that teaches through diagrams, code, and structured visual narratives.

## Instructions

Read and follow ALL instructions in these skill files (read them FIRST before doing anything else):
1. The visual-explainer skill's SKILL.md (located as a sibling skill in the same skill pack) — main skill definition
2. The visual-explainer skill's rules/design-system.md — CDN stack, Mermaid dual-theme, dark mode CSS, component patterns
3. The visual-explainer skill's rules/content-patterns.md — section templates by content type
4. The visual-explainer skill's rules/html-skeleton.md — base HTML template (copy and fill in)

## Data Source

Read {CWD}/investigation-{SLUG}.md FIRST. This is your PRIMARY data source. Use ONLY verified data from this investigation file:
- Use the exact schema/fields documented (do not re-discover or guess)
- Use the exact relationships and code traces documented
- Render diagrams that reflect verified facts from the investigation
- Do NOT add information that is not in the investigation file

## Task

- Topic: {TOPIC}
- Working directory: {CWD}
- Output file: {CWD}/visual-explainer-{SLUG}.html

Generate the HTML page following the skill rules exactly. Save to disk.

When done, confirm the file was saved and report the absolute path.
```

### Step 3: Deliver

After both subagents complete:
1. Open the HTML file in the browser: `open visual-explainer-{SLUG}.html`
2. Announce both file paths to the user

## Quality Gate

- [ ] Investigation subagent completed and file exists with verified data
- [ ] Visual-explainer subagent used data FROM the investigation (not independently researched)
- [ ] Both files saved and paths announced
- [ ] HTML opened in browser
