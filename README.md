# Polyskills

Research, visualization, and synthesis skills for Claude Code.

Three skills that work together: **investigate** anything thoroughly, **visualize** findings as interactive HTML pages, or **synthesize** both in one command.

## Skills

### `polyskills:investigate`

Deep research into codebases, issues, topics, or concepts. Outputs structured markdown findings with every claim traceable to actual file reads or web sources.

**Triggers:** "investigate", "research this", "deep dive into", "analyze this codebase", "study this"

**Output:** `investigation-<slug>.md`

### `polyskills:visual-explainer`

Generates standalone interactive HTML pages with Mermaid diagrams, Prism.js code highlighting, dark/light mode, sticky TOC with scroll-spy, and click-to-zoom diagrams.

**Triggers:** "explain visually", "visualize this", "teach me about", "create explainer", "visual walkthrough"

**Output:** `visual-explainer-<slug>.html`

### `polyskills:synthesize`

Chains `/investigate` then `/visual-explainer` to produce a thoroughly-researched interactive HTML explainer. The visual output is backed by verified data from the investigation phase.

**Triggers:** "synthesize", "research and visualize", "deep visual explainer", "thorough explainer"

**Output:** Both `investigation-<slug>.md` and `visual-explainer-<slug>.html`

## Install

### Claude Code

```
/install-plugin https://github.com/gregoryerrl/polyskills
```

### Manual

Clone into your plugins directory:

```bash
git clone https://github.com/gregoryerrl/polyskills.git
```

## Usage

After installation, skills trigger automatically. Just ask:

```
investigate this codebase
```

```
explain visually how the auth system works
```

```
synthesize the payment flow
```

## Structure

```
polyskills/
├── .claude-plugin/
│   ├── plugin.json
│   └── marketplace.json
├── hooks/
│   ├── hooks.json
│   ├── run-hook.cmd
│   └── session-start
├── skills/
│   ├── investigate/
│   │   ├── SKILL.md
│   │   └── rules/
│   │       ├── strategies.md
│   │       └── output-format.md
│   ├── visual-explainer/
│   │   ├── SKILL.md
│   │   └── rules/
│   │       ├── design-system.md
│   │       ├── content-patterns.md
│   │       └── html-skeleton.md
│   └── synthesize/
│       └── SKILL.md
├── CLAUDE.md
├── AGENTS.md
├── README.md
├── LICENSE
└── package.json
```

## License

[MIT](LICENSE) © Gregory Errl Babela
