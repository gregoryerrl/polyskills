---
name: visual-explainer
description: Generate rich, interactive HTML explainer pages for learning codebases, debugging issues, or teaching concepts. Designed for deep visual learners. Triggers on "explain visually", "visualize this", "teach me about", "create explainer", "visual walkthrough", "learning page".
---

# Visual Explainer

Generate standalone HTML pages that make concepts visually undeniable. Your audience is the most extreme visual learner imaginable — someone who will skip every paragraph but study every animation, diagram, and interactive element until the concept clicks.

## Creative Philosophy

You are a creative director, not a documentation generator. There is no lookup table for which visualization to use. Let the concept tell you what it wants to be.

Ask yourself: **"If someone couldn't read a single word on this page, would they still understand the concept from the visuals alone?"** If yes, you've done your job.

Your palette is everything HTML can render. That includes but is not limited to:

- **Rich typography** — color-coded text, highlighted keywords, bold emphasis that makes relationships visible inline
- **Layout as explanation** — side-by-side panels, tabbed views, collapsible sections, card grids that group related ideas
- **Color as meaning** — color-coded backgrounds, borders, and text that create visual associations across sections
- **Interactive elements** — tabs, toggles, accordions, drag-to-compare sliders, clickable reveals
- **Diagrams** — Mermaid, custom SVG, hand-drawn-style paths, entity maps
- **Animation** — CSS transitions, keyframe sequences, Canvas rendering, SVG `<animate>`, scroll-triggered reveals
- **Data visualization** — charts, gauges, treemaps, progress bars, visual diffs
- **Anything else** — if HTML can do it and it helps someone *see* the concept, use it

Sometimes the best visualization is a particle system. Sometimes it's a paragraph where three key terms are color-coded to match the three boxes in a diagram above it. Both are valid. Use whatever makes the concept land.

The only constraint on your creativity is that **what you build must actually work**.

## Non-Negotiables

### Creative freedom
- There are NO rules about which technique to use for which concept
- A "visual element" is anything that helps someone *see* the idea — a diagram, an animation, colored text, an interactive widget, a well-designed card, a color-coded table, a styled inline comparison. It does NOT have to be a diagram or animation.
- Trust your instincts — if a concept feels like it wants to be a particle system, build one. If it just needs color-coded text and a clean card layout, do that. Don't overcomplicate what's naturally simple, don't oversimplify what's naturally rich.

### Technical strictness — if you build it, it MUST work
- **Theme awareness**: Every visualization MUST look correct in both dark and light mode. Canvas elements must re-render on toggle. SVG elements must swap colors. No exceptions.
- **Animations**: Use `requestAnimationFrame` for rendering loops. Use CSS transitions/keyframes for declarative motion. Never use `setInterval` for visual rendering.
- **Interactivity**: Every interactive element MUST have visible affordances — cursor changes, hover states, focus indicators. If something is clickable, the user must know before clicking. If something is draggable, show it.
- **Responsiveness**: Canvas and SVG elements MUST handle window resize. Layouts must not break on mobile. Touch interactions must work where mouse interactions do.
- **Isolation**: Each visualization script MUST be wrapped in an IIFE to prevent variable collisions. Multiple visualizations on one page must not interfere with each other.
- **Performance**: Animations that leave the viewport should pause. Don't run 10 canvas loops simultaneously when only 2 are visible.

### Page structure
1. Output is ALWAYS a single `.html` file — no dependencies except CDN links
2. Include dark/light mode toggle in header. Default to dark. Persist choice in `localStorage`.
3. Every code reference MUST use Prism.js with a file-path header showing filename and line range
4. If using Mermaid: set `startOnLoad: false`, render manually, re-render on theme toggle with swapped node colors. See [rules/design-system.md](rules/design-system.md) for dual-theme config.
5. Dark mode: use solid dark-tinted backgrounds for callout cards (e.g. `#2a1215` for red). Do NOT use `rgba()` — it washes out on dark canvas.
6. Sticky TOC with scroll-spy. Sections animate in via IntersectionObserver (no library).
7. Use CDN stack and component patterns from [rules/design-system.md](rules/design-system.md)
8. Follow the content pattern matching the request type — [rules/content-patterns.md](rules/content-patterns.md)
9. Start from the HTML skeleton in [rules/html-skeleton.md](rules/html-skeleton.md) — do not build from scratch

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

### 3. Plan sections — VISUALS FIRST, TEXT SECOND

For each section:
1. What is the core idea someone needs to *see*?
2. What visual would make it undeniable? Don't reference a technique menu — just imagine the best way to show it.
3. Write the visual first in your mind, then wrap supporting text around it.

Each section: heading + visual element + just enough narrative to connect the visuals together.

### 4. Generate HTML from skeleton

Fill in: title, subtitle, TOC entries, content sections with visualizations, code blocks, callout cards.

### 5. Save and open

```bash
cat > visual-explainer-<slug>.html <<'HTMLEOF'
<generated html>
HTMLEOF
open visual-explainer-<slug>.html
```

Print: `Saved to: <absolute path>`

## Writing Style

Teach like a patient senior engineer. Lead with "why" before "how". Bold key terms on first use. Paragraphs max 3-4 sentences. Use callout cards for insights that break the narrative flow. But remember: the visuals carry the explanation. Text is the connective tissue, not the skeleton.

## Quality Gate

Every item here is non-negotiable. If any fails, fix before saving.

- [ ] Opens in browser with zero console errors
- [ ] Dark/light toggle works — ALL visualizations (canvas, SVG, Mermaid, CSS) adapt correctly to both themes
- [ ] If Mermaid is used: diagrams render in both themes, re-render on toggle with correct node colors
- [ ] Prism code blocks have correct `language-*` class and visible left padding
- [ ] TOC scroll-spy highlights active section
- [ ] Every TOC link scrolls to the correct section (no Mermaid ID collisions)
- [ ] Every section has at least one visual element
- [ ] All animations run smoothly — no jank, no `setInterval` rendering
- [ ] Every interactive element has visible affordances (cursor, hover state, label/hint)
- [ ] Canvas/SVG visualizations resize on window resize without breaking
- [ ] Interactive elements respond to both mouse and touch
- [ ] No `{{placeholder}}` text remains
- [ ] Mobile: TOC collapses, layout is readable
