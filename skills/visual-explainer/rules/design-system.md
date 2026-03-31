---
name: design-system
description: CDN stack, dual-theme Mermaid config, dark mode CSS, and reusable component patterns for visual explainer pages
---

# Design System

## CDN Stack (include ALL in `<head>`)

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/prismjs@1.29.0/themes/prism-tomorrow.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/prismjs@1.29.0/prism.min.js"></script>
<!-- Add prism-{language}.min.js components as needed -->
```

## Tailwind Config

```javascript
tailwind.config = {
  darkMode: 'class',
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
        mono: ['JetBrains Mono', 'monospace'],
      },
    }
  }
}
```

## Mermaid Dual Theme

Set `startOnLoad: false`. Initialize and render manually so diagrams re-render on theme toggle.

### Mermaid Gotchas

**Source capture must use `innerHTML`** — The skeleton captures mermaid sources before rendering. It MUST use `el.innerHTML.trim()`, NOT `el.textContent.trim()`. `textContent` strips `<br/>` tags from node labels, destroying line breaks. `innerHTML` preserves them.

**Section IDs must not collide with Mermaid icon names** — Mermaid renders built-in icons as `<symbol id="...">` inside SVG `<defs>`. If a section shares that ID, `document.getElementById()` finds the SVG symbol instead of the section, breaking TOC navigation and scroll-spy. **Banned section IDs**: `database`, `server`, `cloud`, `clock`, `flag`, `heart`, `star`, `lightning`, `gear`, `lock`, `user`, `mail`, `phone`, `document`, `folder`, `search`. Use prefixed alternatives like `db-schema`, `server-arch`, `cloud-infra`, etc.

**SVG overflow must be visible** — Mermaid SVGs default to `overflow: hidden`, clipping text that overflows node boundaries. The skeleton sets `overflow: visible !important` on `.mermaid svg`, `foreignObject`, and their zoom overlay equivalents. Do not remove these rules.

```javascript
const mermaidThemes = {
  light: {
    primaryColor: '#dbeafe', primaryTextColor: '#1e293b', primaryBorderColor: '#3b82f6',
    lineColor: '#64748b', secondaryColor: '#f0fdf4', tertiaryColor: '#fef3c7',
    fontFamily: 'Inter, system-ui, sans-serif', fontSize: '14px',
    clusterBkg: '#f8fafc', clusterBorder: '#cbd5e1',
  },
  dark: {
    primaryColor: '#1e3a5f', primaryTextColor: '#e2e8f0', primaryBorderColor: '#60a5fa',
    lineColor: '#64748b', secondaryColor: '#14352a', tertiaryColor: '#3d2008',
    fontFamily: 'Inter, system-ui, sans-serif', fontSize: '14px',
    clusterBkg: '#1e293b', clusterBorder: '#334155',
    edgeLabelBackground: '#1e293b',
  }
};
mermaid.initialize({ startOnLoad: false });
```

### Mermaid Node Color Swaps

Mermaid `style` directives use hardcoded hex colors that only work in one theme. Store source strings with light-mode colors, swap to dark equivalents before rendering.

**CRITICAL**: The swap function must be one-directional. Sources are always light-mode. Only swap when dark. Do NOT attempt to reverse-swap in light mode — color collisions will corrupt fills.

```javascript
const nodeColorSwaps = [
  // [lightFill, lightStroke, lightText] → [darkFill, darkStroke, darkText]
  { light: ['#f0fdf4','#10b981','#065f46'], dark: ['#064e3b','#34d399','#d1fae5'] }, // green/success
  { light: ['#fee2e2','#ef4444','#991b1b'], dark: ['#450a0a','#f87171','#fecaca'] }, // red/error
  { light: ['#fef3c7','#f59e0b','#92400e'], dark: ['#451a03','#fbbf24','#fde68a'] }, // amber/warning
  { light: ['#dbeafe','#3b82f6','#1e3a5f'], dark: ['#172554','#60a5fa','#bfdbfe'] }, // blue
];

function swapNodeColors(source, isDark) {
  if (!isDark) return source;
  let s = source;
  for (const { light, dark } of nodeColorSwaps) {
    s = s.replaceAll(light[0], dark[0]).replaceAll(light[1], dark[1]).replaceAll(light[2], dark[2]);
  }
  return s;
}
```

## Dark Mode CSS

Use solid dark-tinted backgrounds — NOT rgba(). Transparent backgrounds wash out on dark canvas.

### Callout Card Dark Colors

| Type | Light bg | Dark bg | Dark border | Dark text |
|------|----------|---------|-------------|-----------|
| Red/error | `red-50` | `#2a1215` | `#5c1d1d` | `#fca5a5` |
| Amber/warning | `amber-50` | `#271506` | `#6b3a0a` | `#fcd34d` |
| Emerald/success | `emerald-50` | `#0a2118` | `#155e3e` | `#6ee7b7` |
| Violet/tip | `violet-50` | `#1a0f2e` | `#4c1d95` | `#c4b5fd` |
| Blue/info | `blue-50` | `#0c1a33` | `#1e4a8a` | `#93c5fd` |

### Key Dark Overrides

```css
html.dark { color-scheme: dark; }
.dark body { background-color: #0f172a; color: #cbd5e1; }
.dark header { background-color: rgba(15, 23, 42, 0.88) !important; border-color: #1e293b !important; }
.dark .bg-white { background-color: #1e293b !important; }
.dark .bg-slate-50 { background-color: #0f172a !important; }
.dark .border-slate-200 { border-color: #334155 !important; }
.dark .bg-slate-200 { background-color: #334155 !important; }
.dark .bg-slate-800 { background-color: #0f172a !important; }
.dark h1, .dark h2, .dark h3, .dark h4 { color: #f1f5f9 !important; }
.dark strong { color: #e2e8f0 !important; }
.dark code:not([class*="language-"]) { background-color: #334155 !important; color: #e2e8f0 !important; }
.dark .toc-link { color: #64748b !important; border-color: #1e293b !important; }
.dark .toc-link.active { color: #60a5fa !important; border-left-color: #60a5fa !important; background-color: #1e293b !important; }
```

Extend with callout overrides using the color table above. Pattern: `.dark .bg-{color}-50 { background-color: <dark bg> !important; }` etc.

## Component Patterns

### Code Block with File Path

```html
<div class="rounded-xl overflow-hidden border border-slate-200 shadow-sm">
  <div class="flex items-center gap-2 px-4 py-2.5 bg-slate-800 text-slate-300 text-sm font-mono">
    <!-- file icon SVG --> <span>path/to/file.tsx</span>
    <span class="ml-auto text-slate-500 text-xs">L42-58</span>
  </div>
  <pre class="!m-0 !rounded-none"><code class="language-tsx">// code</code></pre>
</div>
```

### Diagram Container

Diagrams are click-to-zoom — clicking an SVG opens a full-screen overlay at native resolution with scroll panning.

```html
<div class="my-8 p-6 bg-white rounded-xl border border-slate-200 shadow-sm">
  <p class="flex items-center gap-2 mb-4 text-sm font-medium text-slate-500">
    <!-- diagram icon SVG --> Diagram Title
  </p>
  <div class="mermaid">graph LR
    A --> B</div>
</div>
```

### Diagram Zoom Overlay

Place before `</body>`. The skeleton template includes this automatically.

```html
<div class="diagram-overlay" id="diagram-overlay" onclick="closeDiagramZoom()">
  <div class="diagram-overlay-inner" id="diagram-overlay-inner" onclick="event.stopPropagation()"></div>
  <div class="diagram-overlay-hint">Click outside or press Esc to close &middot; Scroll to pan</div>
</div>
```

CSS (included in skeleton):
```css
.diagram-overlay {
  position: fixed; inset: 0; z-index: 100;
  background: rgba(0,0,0,0.85);
  display: flex; align-items: center; justify-content: center;
  cursor: zoom-out;
  opacity: 0; transition: opacity 0.2s ease;
  pointer-events: none;
}
.diagram-overlay.open { opacity: 1; pointer-events: auto; }
.diagram-overlay-inner {
  max-width: 95vw; max-height: 90vh;
  overflow: auto; padding: 24px;
}
.diagram-overlay-inner svg { max-width: none !important; cursor: grab; overflow: visible !important; }
.diagram-overlay-inner svg foreignObject { overflow: visible !important; }
```

**CRITICAL**: Mermaid SVGs default to `overflow: hidden`, which clips text that overflows node boundaries. Always set `overflow: visible !important` on both the `<svg>` and `foreignObject` elements — in both the inline `.mermaid` container and the zoom overlay.

### Callout Card (one pattern, vary colors by type)

```html
<div class="flex gap-4 p-5 rounded-xl bg-{color}-50 border border-{color}-200">
  <div class="flex-shrink-0 text-{color}-600 mt-0.5"><!-- icon SVG --></div>
  <div>
    <p class="font-semibold text-{color}-900 mb-1">Title</p>
    <p class="text-{color}-800 text-sm leading-relaxed">Content.</p>
  </div>
</div>
```

Color mapping: red = error, amber = warning, emerald = success, violet = tip/insight, sky = info.

### Step-by-Step Trace

```html
<div class="relative pl-8 space-y-8 before:absolute before:left-3 before:top-2 before:bottom-2 before:w-0.5 before:bg-blue-200">
  <div class="relative">
    <div class="absolute -left-8 top-1 w-6 h-6 rounded-full bg-blue-600 text-white text-xs font-bold flex items-center justify-center">1</div>
    <h4 class="font-semibold text-slate-900 mb-2">Step Title</h4>
    <p class="text-sm text-slate-600 mb-3">Explanation.</p>
    <!-- code block or diagram -->
  </div>
</div>
```

### Section with Numbered Header

```html
<section id="slug" class="mb-16 scroll-mt-24 section-animate">
  <h2 class="text-2xl font-bold text-slate-900 mb-6 flex items-center gap-3">
    <span class="flex items-center justify-center w-8 h-8 rounded-lg bg-blue-100 text-blue-700 text-sm font-bold">1</span>
    Title
  </h2>
  <div class="space-y-6"><!-- content --></div>
</section>
```

### Files Reference List

```html
<div class="p-5 rounded-xl bg-slate-50 border border-slate-200">
  <h4 class="text-sm font-semibold text-slate-700 mb-3"><!-- folder icon --> Files Involved</h4>
  <ul class="space-y-2">
    <li class="flex items-start gap-2 text-sm">
      <code class="font-mono text-blue-700 bg-blue-50 px-1.5 py-0.5 rounded text-xs whitespace-nowrap">path/file.tsx</code>
      <span class="text-slate-600">— Role description</span>
    </li>
  </ul>
</div>
```
