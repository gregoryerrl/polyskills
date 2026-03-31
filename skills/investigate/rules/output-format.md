---
name: output-format
description: Markdown output format for investigation findings — structured for human reading and visual-explainer consumption
---

# Output Format

Save findings to `investigation-<slug>.md`. The format varies by investigation type but follows a common structure.

## Common Header

Every investigation file starts with:

```markdown
# Investigation: <Title>

**Type:** Codebase | Issue | Topic | Concept
**Date:** YYYY-MM-DD
**Scope:** <what was investigated>

---
```

## Codebase Investigation Output

```markdown
## Overview
- What the project does (2-3 sentences)
- Who uses it
- Tech stack table (language, framework, database, key deps)
- Scale numbers (models, controllers, pages, jobs, routes)

## Architecture
- Layer diagram description (what connects to what)
- For each layer: purpose, key files, responsibilities
- Middleware/pipeline description

## Database Schema
For each table (grouped by domain):
### <TableName>
| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| id | uuid | PK | |
| name | string | required | |
...
**Relationships:** belongs_to X, has_many Y
**Notable:** soft deletes, JSON columns, computed fields, etc.

## Key Flows
For each traced flow:
### <Flow Name> (e.g., "User duplicates an ad")
1. **Route**: `POST /api/...` → `Controller@method`
2. **Controller**: validates input, calls service
3. **Service**: orchestrates business logic
4. **Job**: async operation dispatched
5. **Result**: what the user sees

## Features
For each major feature:
### <Feature Name>
- What it does
- Key files (controller, service, job, page)
- How it works (brief)

## Patterns & Conventions
- Authentication: how it works
- Authorization: role model, permission checks
- Naming: file naming, class naming, column naming
- Queue/Jobs: sync vs async patterns
- Testing: what exists, how to run
```

## Issue Investigation Output

```markdown
## Requirements
(Numbered, verbatim from issue)

1. **[Hard]** "exact quote from issue"
   - Key phrases: `highlighted terms`
2. **[Ambiguous]** "exact quote"
   - Possible readings: A or B
3. **[Implicit]** Logically follows from #1 and #2

## Current Behavior
- What happens now (with evidence — screenshots, error messages, code references)

## Code Trace
### Step 1: <Entry Point>
- File: `path/to/file.php:42`
- What happens: description
- Relevant code: key lines

### Step 2: <Next Step>
...

## Root Cause
- The exact line(s) where behavior diverges from requirements
- WHY it happens (not just what)
- Related patterns (does this bug exist elsewhere?)

## Proposed Approach
For each requirement:
1. Quote requirement verbatim
2. How the fix satisfies it
3. Files to change

## Tensions
- Any conflicts between requirements and technical reality
- Presented honestly for user decision
```

## Topic Investigation Output

```markdown
## What This Is
- Definition and purpose (2-3 sentences)
- Where it lives in the codebase

## How It Works
- Detailed mechanism explanation
- Key files and their roles
- Configuration that affects behavior

## Interactions
- What calls into this system
- What this system calls
- Data read/written

## Code Reference
For each key file:
### `path/to/file.ext`
- Purpose: what this file does
- Key functions/methods and what they do
- Notable patterns or gotchas

## Edge Cases & Gotchas
- Error handling
- Known limitations
- Non-obvious behavior
```

## Concept Investigation Output

```markdown
## Definition
- What this concept is (precise, 2-3 sentences)
- What problem it solves
- Where it comes from (language spec, RFC, paper, framework)

## How It Works
- Step-by-step mechanism with concrete values
- Constraints and limits (with specific numbers where applicable)
- Common misconceptions and corrections

## Approaches
For each strategy/implementation:
### <Approach Name>
- How it works (2-3 sentences)
- Concrete example with real values
- Pros and cons

## Comparison
| Criteria | Approach A | Approach B | Approach C |
|----------|-----------|-----------|-----------|
| ... | ... | ... | ... |

## When to Use What
- Decision framework: "use X when Y, use Z when W"
- Practical gotchas in real codebases
- How it applies to the user's tech stack (if known)

## Sources
- Links to authoritative documentation, specs, or references used
```

## Writing Rules

1. **Tables over prose** for structured data (schemas, comparisons, file lists)
2. **Code references** always include file path and line numbers
3. **No filler** — every sentence must convey information. Cut "This section covers..."
4. **Verify before writing** — re-read the file if you're unsure about a detail
5. **Group by domain** — organize tables/models by feature area, not alphabetically
