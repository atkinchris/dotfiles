# Agent instructions

## Tools

- Node -> nvm
- Python -> uv

## Changes to existing code

Every changed line should trace to what I asked for. Don't improve adjacent code, comments, or formatting on the way past. Match the surrounding style even where you'd do it differently. Mention unrelated dead code rather than deleting it; do remove imports and helpers your change orphaned.

## Ambiguity

If there are several plausible readings of a request, say so and ask rather than picking one silently. I'd rather be interrupted than have to unwind a change.

## GitHub Actions

When writing or modifying GitHub Actions workflows, always check the latest major version of any `actions/*` action before using it. Do not assume the version already in the file is current.

## Commit style

Match the commit message style already in the repo's history. Where the history is mixed or absent, don't use prefixes like `feat:` or `fix:`.

## Documentation style

Don't use emojis.

Do not hard-wrap prose or list items in Markdown files. Keep each paragraph or list item on a single physical line unless the content is a code block or requires intentional line breaks.

### Punctuation

Use only ASCII punctuation throughout all Markdown documents.

- Use `->` for arrows and mappings (not `→`)
- Use `-` as an inline separator between a label and its value (not `--`, `—`, or `–`)
- Use `-` for numeric ranges (e.g. `87-93`)
- Exception: preserve `--` inside code blocks when it is part of actual command syntax (e.g. the POSIX end-of-options separator `--`)

### English

Use British English.

Examples: `behaviour`, `behavioural`, `labelled`, `artefact`, `localised`, `whilst`, `organise`.

### Code fences

Every fenced code block must have a language tag.

### Emails and comms from me directly (rather than documentation)

Direct, analytical, evidence-led.

- Lead with the point, decision, or ask. For anything long, open with a one-line `TL;DR:`.
- Back every claim with a number, a named system, a ticket, or a published standard. Be specific; vagueness reads as not understanding the problem.
- Give options with their trade-offs, then a clear personal recommendation. Use "we" for the org, "I" for your own position.
- Criticise the work or process, never the person. Flag systemic problems as systemic.
- Explain hard concepts by breaking them down and reaching for a plain, slightly wry analogy.
- Ask pointed, answerable questions to expose gaps.
- Full, connected sentences. No staccato fragments for effect. Tight paragraphs (2-4 sentences).
- Match length to the substance, not the topic. Don't inflate a simple point; don't truncate a real argument.

No emojis. No LLM-isms or filler ("I hope this finds you well", "It's worth noting", reflexive hedging).

Self-check: point up top? every claim specific? criticism on the work not the person? full sentences? British English, ASCII, no emojis, no LLM-isms? Sounds like a sharp engineer, not a template?
