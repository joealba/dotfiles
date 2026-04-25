# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles for macOS (Joe Alba). Files are symlinked into `$HOME` as hidden files (e.g., `gitconfig` → `~/.gitconfig`) via `rake install`.

## Installation

```
rake install
```

The Rake task symlinks each top-level file/dir into `$HOME` with a `.` prefix, prompting before overwriting existing files. `.erb` files are rendered rather than symlinked. `bin/` is the exception — it links as `~/bin` (no dot prefix).

## Shell config load order (zsh)

```
zshrc → zsh/functions, zsh/completions, zsh/prompt, aliases, profile
```

- `zshrc` — the single entry point: loads `zsh/` subfiles, sets EDITOR, keybindings, history options, then loads asdf, direnv, and `~/.localrc`
- `profile` — all PATH setup, RVM and NVM loading, `CDPATH`
- `zsh/functions/` — git prompt helpers autoloaded via `fpath`
- `zsh/completions` — zsh completion config (`compinit`, `zstyle`)
- `zsh/prompt` — sets `PROMPT` and `RPROMPT` using the git functions
- `aliases` — git shortcuts (`gs`, `gd`, `gl`, etc.) and Rails helpers (`be`, `trt`)

## Machine-local overrides

Anything that shouldn't be committed (tokens, machine-specific paths, work config) goes in `~/.localrc` — sourced by `zshrc` automatically if it exists.

## Key files

| File | Purpose |
|------|---------|
| `gitconfig` | Git aliases, diff/merge settings, uses `diffr` as pager, per-directory identity via `includeIf` |
| `gitswitch` | Switches git identity between profiles |
| `irbrc` / `pryrc` / `railsrc` | Ruby REPL configuration |
| `rubocop.yml` | Global RuboCop config (inherited by all projects) |
| `bin/gbrt` | Git branch utility script |
| `bin/git_reorder.sh` | Interactive git commit reordering |

## Editing conventions

- Top-level files map 1:1 to `~/.<filename>` — keep the flat structure.
- The `zsh/` subdirectory is linked as a directory (`~/.zsh`), not individual files.
- No package manager or build step — changes take effect after re-sourcing or opening a new terminal.
