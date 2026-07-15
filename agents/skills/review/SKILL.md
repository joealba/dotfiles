---
name: review
description: Code review using the 4Cs rubric (Correctness, Completeness, Conciseness, Clarity)
argument-hint: <branch-or-ref> [-- extra instructions]
allowed-tools: Read Grep Glob Bash(git:*)
---

# Code Review

You are performing a code review using the 4Cs rubric.

## Parse Arguments

Arguments: `$ARGUMENTS`

- First argument is the branch or ref to review (e.g., `origin/rc/bridge-sync`, `HEAD~3`, a commit SHA)
- If no argument is provided, ask the user what to review
- Anything after `--` is extra instructions from the reviewer (e.g., "Pay special attention to error handling")
- Default base branch for comparison: `origin/main`.  If `origin/main` does not exist, use `origin/master`.

## Process

1. Run `git fetch` to ensure all refs are current
2. Run `git diff --stat <base>...<ref>` for the summary stats
3. Run `git diff <base>...<ref>` for the full diff
4. If the diff is large, read the changed files directly to understand full context
5. Review every file in the diff — do not skip files

## The 4Cs Rubric

Evaluate every changed area against all four dimensions. Ask questions. Trust your gut.

### Correctness (Function - Objective)
- Does code do the right thing? Verifiable? Defect-free?
- Does the change match author's intent based on the commit message?  Does the change satisfy specification (if ticket info is available)?
- How will it break? Fail gracefully or catastrophically?
- Any security concerns in the new/changed code?

### Completeness (Function - Subjective)
- Does code accomplish everything in its intended scope?
- What cases aren't handled? What is code assuming?
- Does it narrowly satisfy an incomplete specification?

### Conciseness (Form - Objective)
- Can anything be omitted without reducing other 3 Cs?
- Does the code make good use of the common idioms of the language/framework?
- Don't sacrifice clarity for conciseness

### Clarity (Form - Subjective)
- Are commits atomic?  Does every commit add value to the project -- whether that's adding an executable feature code path, restructuring the code to get ready for a near-future change, fixing a bug, or performing an upgrade?
- If a refac/refactor commit, does it truly change only structure and not behavior?
- Does code do what I thought at first glance?
- Are names misleading, or they precise enough?
- If unclear after reasonable effort: it's the code, not you

## Output Format

Structure your review exactly as follows:

### 1. Diff Stats
Start with the diff stats line (files changed, insertions, deletions) so we can verify we're looking at the same diff.

### 2. Per-Area Analysis
For each logical area of change, discuss findings across the 4Cs. Be specific — reference file paths and line numbers.

### 3. Critical Issues
List issues that must be fixed before merge. If none, say "None."

### 4. Minor Issues
List non-blocking suggestions. If none, say "None."

### 5. Questions
List questions for the author about intent, edge cases, or design choices. If none, say "None."

### 6. Summary Table
End with this table:

| Area | Correctness | Completeness | Conciseness | Clarity |
|------|-------------|--------------|-------------|---------|

Grade each area separately using A/B/C/D/F with +/- modifiers.

