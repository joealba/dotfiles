---
name: reslice-branch
description: Rewrite an existing feature branch's messy commit history into a handful of clean, atomic, reviewable commits WITHOUT changing the final tree. Use when a branch has grown organically (feature commits interleaved with fixup/follow-up/test-fix commits, empty commits, or "wip" noise) and the user wants to redeliver the same work as logical vertical slices before opening or updating a PR. Triggers on requests like "reslice this branch", "squash these into atomic commits", "clean up my branch history", "rebase into vertical slices".
---

# Reslice a branch into atomic commits

Rewrite a branch's history into a small set of clean, atomic commits while producing a **byte-identical final tree**. The guiding invariant: **no code changes, only history changes.** Every step is designed so this can be proven, not assumed.

## Safety rules (non-negotiable)

- **Back up before any destructive op.** Create a backup branch and verify it points at the current HEAD before touching anything.
- **Never force-push without explicit approval.** If the branch has a remote/PR, ask before `git push --force-with-lease`. Never use plain `--force`.
- **Prove the result.** The final tree hash MUST equal the backup's. If `git diff <backup>` is non-empty, STOP and investigate — do not proceed or "fix it up."
- **Confirm the slice plan with the user before resetting.** Don't guess the grouping. Ask.

## Process

### 1. Analyze the existing history (read-only)

Gather the full picture before proposing anything:

```bash
git log --oneline <base>..HEAD          # base is usually main/master
git diff --stat <base>...HEAD           # net change set
# Per-commit file stats, in order:
for c in $(git rev-list --reverse <base>..HEAD); do
  echo "=== $(git show -s --format='%h %s' $c) ==="
  git show --stat --format='' $c
done
```

Identify:
- **Empty commits** (0 files changed) — these get dropped.
- **Fixup commits** — later commits that patch files introduced by earlier ones. They fold into the slice that owns the file.
- **File ownership** — which logical concern each file belongs to. The clean case is when *each file's final state belongs to exactly one slice* — then you can reslice purely by pathspec. If a single file's changes span multiple concerns, you need `git add -p` (interactive hunk staging) for that file; call this out explicitly.
- **Commits touching multiple slices** — split them across the right slices (one file's half here, another's half there).

### 2. Propose slices and confirm with the user

Present a table: slice # → conventional commit subject → files → which original commits fold in. Order slices by **build dependency** (generated types / shared primitives before the components that import them; components before the code that wires them) so each commit can build independently.

Use `AskUserQuestion` to confirm decisions that are genuinely the user's call:
- **Slice granularity** — how many slices, where boundaries fall.
- **Test placement** — tests as a dedicated final slice, or folded into the feature slices they cover.
- **Mechanism** — prefer **soft reset + restage** (below). Interactive rebase is more fragile when fixups span file boundaries; only use it if the user prefers it.

### 3. Back up

```bash
BR=$(git rev-parse --abbrev-ref HEAD)
git branch "${BR}-backup"
test "$(git rev-parse HEAD)" = "$(git rev-parse ${BR}-backup)" && echo "OK: backup == HEAD"
```

### 4. Soft reset and reslice (recommended mechanism)

```bash
git reset --soft <base>     # branch ref moves to base; full final tree stays staged
git restore --staged .      # unstage all; working tree is still byte-identical to original HEAD
```

Then, for each slice in dependency order:

```bash
git add <pathspecs for this slice ONLY>
git status --short          # verify ONLY the intended files are staged
git commit -m "$(cat <<'EOF'
type(scope): subject
<body explaining why>
EOF
)"
```

Commit message rules (follow the `commit` skill):
- Conventional format; imperative mood; explain WHY in the body.
- **Reuse the best rationale from the original commit messages** — they often already contain good explanations worth preserving.
- **No AI attribution** of any kind (no `Co-Authored-By: Claude`, no "Generated with" footer).

### 5. Verify (all must pass)

```bash
BK="${BR}-backup"
git status --short                                  # MUST be empty (clean tree)
git log --oneline <base>..HEAD                      # the expected slices, in order
git diff "$BK" --stat                               # MUST be empty — the exact-match proof
test "$(git rev-parse HEAD^{tree})" = "$(git rev-parse ${BK}^{tree})" \
  && echo "OK: trees identical" || echo "MISMATCH — STOP"
```

Then run the project's gates (e.g. `npm run verify`, lint/type-check, the relevant tests). Optionally check out each commit and run the build to confirm per-commit buildability.

### 6. Wrap up

- Report the before/after, the exact-match proof, and test results.
- Keep the backup branch until the rewritten branch is confirmed merged; mention it can be deleted then.
- If a remote/PR exists, ask before `git push --force-with-lease`.

## Rollback

If anything looks wrong at any point:

```bash
git reset --hard "${BR}-backup"   # restores the original branch exactly
```
