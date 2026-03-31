---
name: html-skeleton
description: Base HTML template with dark/light toggle, Mermaid dual-theme, scroll-spy — copy and fill in sections
---

# HTML Skeleton

Copy this template. Replace all `{{PLACEHOLDER}}` values. Add Prism language components as needed.

```html
<!DOCTYPE html>
<html lang="en" class="scroll-smooth dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{PAGE_TITLE}}</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">

  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      darkMode: 'class',
      theme: { extend: { fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
        mono: ['JetBrains Mono', 'monospace'],
      }}}
    }
  </script>

  <script src="https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js"></script>
  <script>
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
        clusterBkg: '#1e293b', clusterBorder: '#334155', edgeLabelBackground: '#1e293b',
      }
    };
    const nodeColorSwaps = [
      { light: ['#f0fdf4','#10b981','#065f46'], dark: ['#064e3b','#34d399','#d1fae5'] },
      { light: ['#fee2e2','#ef4444','#991b1b'], dark: ['#450a0a','#f87171','#fecaca'] },
      { light: ['#fef3c7','#f59e0b','#92400e'], dark: ['#451a03','#fbbf24','#fde68a'] },
      { light: ['#dbeafe','#3b82f6','#1e3a5f'], dark: ['#172554','#60a5fa','#bfdbfe'] },
    ];
    mermaid.initialize({ startOnLoad: false });
  </script>

  <link href="https://cdn.jsdelivr.net/npm/prismjs@1.29.0/themes/prism-tomorrow.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/prismjs@1.29.0/prism.min.js"></script>
  {{PRISM_LANGUAGE_COMPONENTS}}

  <style>
    .scroll-mt-24 { scroll-margin-top: 6rem; }
    .mermaid { display: flex; justify-content: center; overflow-x: auto; }
    .mermaid svg { max-width: 100%; height: auto; cursor: zoom-in; }
    .mermaid svg { overflow: visible !important; }
    .mermaid svg foreignObject { overflow: visible !important; }
    .diagram-overlay-inner svg { overflow: visible !important; }
    .diagram-overlay-inner svg foreignObject { overflow: visible !important; }
    pre[class*="language-"], pre:has(> code[class*="language-"]) { margin: 0 !important; border-radius: 0 !important; padding: 1.25em !important; }

    /* Diagram zoom overlay */
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
      -webkit-overflow-scrolling: touch;
    }
    .diagram-overlay-inner svg { max-width: none !important; cursor: grab; }
    .diagram-overlay-inner.dragging { cursor: grabbing; }
    .diagram-overlay-inner.dragging svg { cursor: grabbing; }
    .diagram-overlay-hint {
      position: fixed; bottom: 24px; left: 50%; transform: translateX(-50%);
      color: #94a3b8; font-size: 13px; font-family: Inter, system-ui, sans-serif;
      pointer-events: none;
    }
    code[class*="language-"] { font-family: 'JetBrains Mono', monospace !important; font-size: 0.875rem !important; }
    .toc-link { transition: all 0.2s ease; }
    .toc-link.active { color: #2563eb; font-weight: 600; border-left-color: #2563eb; background-color: #eff6ff; }
    .section-animate { opacity: 0; transform: translateY(24px); transition: opacity 0.6s ease-out, transform 0.6s ease-out; }
    .section-animate.visible { opacity: 1; transform: translateY(0); }
    .theme-toggle { transition: all 0.3s ease; }
    .theme-toggle:hover { transform: rotate(15deg); }

    /* Dark mode — use solid backgrounds, not rgba() */
    html.dark { color-scheme: dark; }
    .dark body { background-color: #0f172a; color: #cbd5e1; }
    .dark header { background-color: rgba(15, 23, 42, 0.88) !important; border-color: #1e293b !important; }
    .dark header h1 { color: #f1f5f9 !important; }
    .dark .bg-white { background-color: #1e293b !important; }
    .dark .bg-slate-50 { background-color: #0f172a !important; }
    .dark .border-slate-200 { border-color: #334155 !important; }
    .dark .bg-slate-200 { background-color: #334155 !important; }
    .dark .bg-slate-800 { background-color: #0f172a !important; }
    .dark h1, .dark h2, .dark h3, .dark h4 { color: #f1f5f9 !important; }
    .dark strong { color: #e2e8f0 !important; }
    .dark code:not([class*="language-"]) { background-color: #334155 !important; color: #e2e8f0 !important; }
    .dark .text-slate-900 { color: #f1f5f9 !important; }
    .dark .text-slate-800 { color: #e2e8f0 !important; }
    .dark .text-slate-700 { color: #cbd5e1 !important; }
    .dark .text-slate-600 { color: #94a3b8 !important; }
    .dark .text-slate-500 { color: #64748b !important; }
    .dark .toc-link { color: #64748b !important; border-color: #1e293b !important; }
    .dark .toc-link:hover { color: #60a5fa !important; border-color: #3b82f6 !important; }
    .dark .toc-link.active { color: #60a5fa !important; border-left-color: #60a5fa !important; background-color: #1e293b !important; }
    .dark #toc-mobile { background-color: #1e293b !important; border-color: #334155 !important; }

    /* Callout dark overrides — solid dark-tinted backgrounds */
    .dark .bg-red-50 { background-color: #2a1215 !important; }
    .dark .border-red-200 { border-color: #5c1d1d !important; }
    .dark .text-red-900, .dark .text-red-800 { color: #fca5a5 !important; }
    .dark .text-red-600 { color: #f87171 !important; }
    .dark .bg-amber-50 { background-color: #271506 !important; }
    .dark .border-amber-200 { border-color: #6b3a0a !important; }
    .dark .text-amber-900, .dark .text-amber-800 { color: #fcd34d !important; }
    .dark .bg-emerald-50 { background-color: #0a2118 !important; }
    .dark .border-emerald-200 { border-color: #155e3e !important; }
    .dark .text-emerald-900, .dark .text-emerald-800 { color: #6ee7b7 !important; }
    .dark .bg-violet-50 { background-color: #1a0f2e !important; }
    .dark .border-violet-200 { border-color: #4c1d95 !important; }
    .dark .text-violet-900, .dark .text-violet-800 { color: #c4b5fd !important; }
    .dark .bg-blue-50 { background-color: #0c1a33 !important; }
    .dark .bg-blue-100 { background-color: #112244 !important; }
    .dark .border-blue-300 { border-color: #1e4a8a !important; }
    .dark .text-blue-700 { color: #93c5fd !important; }
    .dark .text-blue-600 { color: #60a5fa !important; }

    @media print {
      nav, header, #toc-mobile { display: none !important; }
      main { margin-left: 0 !important; }
      .section-animate { opacity: 1 !important; transform: none !important; }
    }
  </style>
</head>
<body class="bg-slate-50 text-slate-800 font-sans antialiased">

  <header class="fixed top-0 left-0 right-0 z-50 bg-white/80 backdrop-blur-md border-b border-slate-200">
    <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
      <div>
        <h1 class="text-lg font-bold text-slate-900 leading-tight">{{PAGE_TITLE}}</h1>
        <p class="text-xs text-slate-500">{{SUBTITLE}}</p>
      </div>
      <div class="flex items-center gap-2">
        <button onclick="toggleTheme()" class="theme-toggle p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors" title="Toggle theme">
          <svg id="icon-sun" class="w-5 h-5 text-amber-400 hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"/>
          </svg>
          <svg id="icon-moon" class="w-5 h-5 text-slate-600 hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"/>
          </svg>
        </button>
        <button onclick="document.getElementById('toc-mobile').classList.toggle('hidden')"
                class="lg:hidden p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
          </svg>
        </button>
      </div>
    </div>
  </header>

  <div id="toc-mobile" class="hidden fixed top-16 left-0 right-0 z-40 bg-white border-b border-slate-200 shadow-lg lg:hidden p-4 max-h-[70vh] overflow-y-auto">
    <nav class="space-y-1">{{TOC_LINKS_MOBILE}}</nav>
  </div>

  <div class="max-w-7xl mx-auto pt-24 px-6 flex gap-10">
    <aside class="hidden lg:block w-56 flex-shrink-0">
      <nav class="sticky top-24 space-y-0.5 text-sm max-h-[calc(100vh-8rem)] overflow-y-auto" id="toc">
        {{TOC_LINKS}}
      </nav>
    </aside>

    <main class="flex-1 min-w-0 pb-24">
      <div class="mb-16 section-animate">
        <h1 class="text-4xl font-extrabold text-slate-900 mb-4 leading-tight">{{HERO_TITLE}}</h1>
        <p class="text-lg text-slate-600 leading-relaxed max-w-2xl">{{HERO_DESCRIPTION}}</p>
      </div>
      {{SECTIONS}}
    </main>
  </div>

  <!-- Diagram zoom overlay -->
  <div class="diagram-overlay" id="diagram-overlay" onclick="closeDiagramZoom()">
    <div class="diagram-overlay-inner" id="diagram-overlay-inner" onclick="event.stopPropagation()"></div>
    <div class="diagram-overlay-hint">Click outside or press Esc to close &middot; Drag or scroll to pan</div>
  </div>

  <script>
    // Save mermaid sources before rendering
    const mermaidSources = [];
    document.querySelectorAll('.mermaid').forEach((el, i) => {
      mermaidSources.push(el.innerHTML.trim());
      el.setAttribute('data-idx', i);
    });

    function isDarkMode() { return document.documentElement.classList.contains('dark'); }

    function initMermaid(isDark) {
      mermaid.initialize({
        startOnLoad: false, theme: 'base',
        themeVariables: isDark ? mermaidThemes.dark : mermaidThemes.light,
        flowchart: { curve: 'basis', padding: 20 },
        sequence: { actorMargin: 50, messageMargin: 40 },
      });
    }

    function swapNodeColors(source, isDark) {
      if (!isDark) return source;
      let s = source;
      for (const { light, dark } of nodeColorSwaps) {
        s = s.replaceAll(light[0], dark[0]).replaceAll(light[1], dark[1]).replaceAll(light[2], dark[2]);
      }
      return s;
    }

    // Diagram click-to-zoom with drag-to-pan
    function openDiagramZoom(e) {
      const svg = e.currentTarget;
      const overlay = document.getElementById('diagram-overlay');
      const inner = document.getElementById('diagram-overlay-inner');
      const clone = svg.cloneNode(true);
      clone.style.maxWidth = 'none';
      clone.style.width = 'auto';
      clone.style.height = 'auto';
      clone.style.minWidth = Math.max(svg.viewBox.baseVal.width, 800) + 'px';
      clone.style.cursor = 'default';
      inner.innerHTML = '';
      inner.appendChild(clone);
      overlay.classList.add('open');
      document.body.style.overflow = 'hidden';
      setupDragToPan(inner);
    }
    function closeDiagramZoom() {
      document.getElementById('diagram-overlay').classList.remove('open');
      document.body.style.overflow = '';
    }
    document.addEventListener('keydown', (e) => { if (e.key === 'Escape') closeDiagramZoom(); });

    // Drag-to-pan for the zoom overlay container
    function setupDragToPan(el) {
      let isDragging = false, startX, startY, scrollLeft, scrollTop;
      el.onmousedown = (e) => {
        isDragging = true;
        el.classList.add('dragging');
        startX = e.pageX - el.offsetLeft;
        startY = e.pageY - el.offsetTop;
        scrollLeft = el.scrollLeft;
        scrollTop = el.scrollTop;
        e.preventDefault();
      };
      el.onmousemove = (e) => {
        if (!isDragging) return;
        const dx = e.pageX - el.offsetLeft - startX;
        const dy = e.pageY - el.offsetTop - startY;
        el.scrollLeft = scrollLeft - dx;
        el.scrollTop = scrollTop - dy;
      };
      el.onmouseup = el.onmouseleave = () => {
        isDragging = false;
        el.classList.remove('dragging');
      };
      // Touch support for mobile swipe-to-pan
      let touchStartX, touchStartY, touchScrollLeft, touchScrollTop;
      el.ontouchstart = (e) => {
        const t = e.touches[0];
        touchStartX = t.pageX;
        touchStartY = t.pageY;
        touchScrollLeft = el.scrollLeft;
        touchScrollTop = el.scrollTop;
      };
      el.ontouchmove = (e) => {
        const t = e.touches[0];
        el.scrollLeft = touchScrollLeft - (t.pageX - touchStartX);
        el.scrollTop = touchScrollTop - (t.pageY - touchStartY);
        e.preventDefault();
      };
    }

    async function renderMermaid() {
      const dark = isDarkMode();
      document.querySelectorAll('.mermaid').forEach(el => {
        const idx = el.getAttribute('data-idx');
        el.removeAttribute('data-processed');
        el.innerHTML = swapNodeColors(mermaidSources[idx], dark);
      });
      await mermaid.run({ querySelector: '.mermaid' });
      // Attach click-to-zoom on rendered SVGs
      document.querySelectorAll('.mermaid svg').forEach(svg => {
        svg.removeEventListener('click', openDiagramZoom);
        svg.addEventListener('click', openDiagramZoom);
      });
    }

    function updateToggleIcons() {
      const dark = isDarkMode();
      document.getElementById('icon-sun').classList.toggle('hidden', !dark);
      document.getElementById('icon-moon').classList.toggle('hidden', dark);
    }

    function toggleTheme() {
      const willBeDark = !isDarkMode();
      document.documentElement.classList.toggle('dark', willBeDark);
      localStorage.setItem('ve-theme', willBeDark ? 'dark' : 'light');
      updateToggleIcons();
      initMermaid(willBeDark);
      renderMermaid();
    }

    // Init: apply saved preference (default dark)
    if (localStorage.getItem('ve-theme') === 'light') document.documentElement.classList.remove('dark');
    updateToggleIcons();
    initMermaid(isDarkMode());
    renderMermaid();

    // Scroll-spy
    const tocLinks = document.querySelectorAll('.toc-link');
    const sections = document.querySelectorAll('section[id]');
    const tocObs = new IntersectionObserver(entries => {
      entries.forEach(e => { if (e.isIntersecting) {
        tocLinks.forEach(l => l.classList.remove('active'));
        const a = document.querySelector(`.toc-link[href="#${e.target.id}"]`);
        if (a) a.classList.add('active');
      }});
    }, { rootMargin: '-20% 0px -75% 0px' });
    sections.forEach(s => tocObs.observe(s));

    // Section fade-in
    const animObs = new IntersectionObserver(entries => {
      entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('visible'); });
    }, { threshold: 0.08 });
    document.querySelectorAll('.section-animate').forEach(el => animObs.observe(el));

    // TOC click: force target section visible (fixes navigation to off-screen sections)
    document.querySelectorAll('.toc-link, #toc-mobile a').forEach(link => {
      link.addEventListener('click', () => {
        const targetId = link.getAttribute('href')?.replace('#', '');
        if (!targetId) return;
        const target = document.getElementById(targetId);
        if (target && target.classList.contains('section-animate')) {
          target.classList.add('visible');
        }
        document.querySelectorAll('.section-animate').forEach(el => {
          if (el.getBoundingClientRect().top < window.innerHeight * 1.5) {
            el.classList.add('visible');
          }
        });
      });
    });

    Prism.highlightAll();
  </script>
</body>
</html>
```

## TOC Link Formats

Desktop: `<a href="#id" class="toc-link block pl-3 py-1.5 border-l-2 border-slate-200 text-slate-600 hover:text-blue-600 hover:border-blue-400 rounded-r-lg">Title</a>`

Mobile: `<a href="#id" onclick="document.getElementById('toc-mobile').classList.add('hidden')" class="block px-3 py-2 rounded-lg text-sm text-slate-700 hover:bg-slate-100">Title</a>`
