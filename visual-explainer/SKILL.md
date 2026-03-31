---
name: visual-explainer
description: Generate rich, interactive HTML explainer pages for learning codebases, debugging issues, or teaching concepts. Designed for deep visual learners. Triggers on "explain visually", "visualize this", "teach me about", "create explainer", "visual walkthrough", "learning page".
---

# Visual Explainer

Generate standalone HTML pages that teach through diagrams, code, and structured visual narratives.

## Non-Negotiables

1. Output is ALWAYS a single `.html` file — no dependencies except CDN links
2. Include dark/light mode toggle in header. Default to dark. Persist choice in `localStorage`.
3. Every major section MUST have at least one Mermaid diagram
4. Every code reference MUST use Prism.js with a file-path header showing filename and line range
5. Mermaid: set `startOnLoad: false`, render manually, re-render on theme toggle with swapped node colors. See [rules/design-system.md](rules/design-system.md) for dual-theme config and color swap map.
6. Dark mode: use solid dark-tinted backgrounds for callout cards (e.g. `#2a1215` for red). Do NOT use `rgba()` — it washes out on dark canvas.
7. Sticky TOC with scroll-spy. Sections animate in via IntersectionObserver (no library).
8. Use CDN stack and component patterns from [rules/design-system.md](rules/design-system.md)
9. Follow the content pattern matching the request type — [rules/content-patterns.md](rules/content-patterns.md)
10. Start from the HTML skeleton in [rules/html-skeleton.md](rules/html-skeleton.md) — do not build from scratch

## Process

### 1. Classify

| Type | Signal | Pattern |
|------|--------|---------|
| **Codebase** | "explain this repo", "onboard me" | Codebase Exploration |
| **Issue/Bug** | "explain this issue", "why does X fail" | Issue Deep-Dive |
| **Concept** | "teach me about", "how does X work" | Concept Teaching |

### 2. Research

- **Codebase**: Package manifest, entry points, routes, models, services
- **Issue**: Issue/PR, code path trace, root cause, affected files
- **Concept**: Key ideas, strategies, tradeoffs, code examples

### 3. Plan sections BEFORE generating HTML

Each section: heading + at least one visual element (diagram, code block, comparison table, or callout) + narrative link to next section.

### 4. Generate HTML from skeleton

Fill in: title, subtitle, TOC entries, content sections with Mermaid diagrams and Prism code blocks, callout cards, file reference lists.

### 5. Save and open

```bash
cat > visual-explainer-<slug>.html <<'HTMLEOF'
<generated html>
HTMLEOF
open visual-explainer-<slug>.html
```

Print: `Saved to: <absolute path>`

## Writing Style

Teach like a patient senior engineer. Lead with "why" before "how". Bold key terms on first use. Paragraphs max 3-4 sentences. Use callout cards for insights that break the narrative flow.

## Quality Gate

- [ ] Opens in browser without console errors
- [ ] ALL Mermaid diagrams render in BOTH themes (toggle and verify)
- [ ] Dark/light toggle works, Mermaid re-renders with correct node colors
- [ ] Prism code blocks have correct `language-*` class and visible left padding
- [ ] TOC scroll-spy highlights active section
- [ ] Every TOC link scrolls to the correct section (no Mermaid ID collisions)
- [ ] Every section has at least one visual element
- [ ] No `{{placeholder}}` text remains
- [ ] Mobile: TOC collapses, layout is readable
- [ ] Diagram text has no cutoff — click-to-zoom works on all diagrams
