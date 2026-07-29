# Agent instructions

## Tools

- If you need Node, use nvm

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
