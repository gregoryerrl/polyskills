---
name: investigate
description: Deep research skill that investigates codebases, issues, or topics and outputs structured findings as markdown. Works smart — uses schema dumps, migrations, actual file reads. Designed to pair with visual-explainer or stand alone. Triggers on "investigate", "research this", "deep dive into", "analyze this codebase", "study this", or any task requiring thorough understanding before action.
---

# Investigate

Research a codebase, issue, or topic thoroughly. Save structured findings as `investigation-<slug>.md`. Runs as a **subagent** to keep the main context lean.

## Process

Use the **Agent tool** to dispatch a `general-purpose` subagent. Fill in `{TOPIC}`, `{SLUG}`, and `{CWD}` (current working directory).

**Agent call:**
- `description`: "Investigate {TOPIC}"
- `prompt`:

```
You are executing the /investigate skill. Your job is to research a topic thoroughly and save structured findings to a markdown file.

## Instructions

Read and follow ALL instructions in these skill files (read them FIRST before doing anything else):
1. This prompt — read the "Skill Rules" section below for inline rules
2. rules/strategies.md (in the same directory as this skill's SKILL.md) — research strategies by type
3. rules/output-format.md (in the same directory as this skill's SKILL.md) — output format templates

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

After the subagent completes, announce the file path to the user.
