# Polyskills

Research, visualization, and synthesis skills for Claude Code.

## Skills

| Skill | Purpose | Trigger |
|-------|---------|---------|
| `polyskills:investigate` | Deep research into codebases, issues, topics, or concepts | "investigate", "research this", "deep dive", "analyze this codebase" |
| `polyskills:visual-explainer` | Interactive HTML explainer pages with Mermaid diagrams | "explain visually", "visualize this", "teach me about", "create explainer" |
| `polyskills:synthesize` | Chains investigate → visual-explainer for verified visual docs | "synthesize", "research and visualize", "deep visual explainer" |

## Workflow

```
investigate → markdown findings
visual-explainer → interactive HTML page
synthesize → investigate + visual-explainer (chained)
```

### Skill Priority

1. **investigate** when you need accurate, verified research before doing anything
2. **visual-explainer** when you have information and want to teach it visually
3. **synthesize** when you need both — research accuracy AND visual presentation

## Output Conventions

- Investigation files: `investigation-<slug>.md` in the working directory
- Visual explainer files: `visual-explainer-<slug>.html` in the working directory
- Both are self-contained and portable

## Rules

- Skills run as subagents to keep the main context lean
- investigate: every claim must be traceable to a file read or web source
- visual-explainer: every section must have at least one visual element (Mermaid diagram, code block, or comparison table)
- synthesize: the visual-explainer subagent must use data FROM the investigation, not independently researched data
