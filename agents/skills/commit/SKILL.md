---
name: commit
description: Use this skill when creating git commits to ensure proper conventional commit format and clean, professional commit messages
---

# Commit Skill

Use this skill when creating git commits to ensure they follow best practices. This skill is for straightforward, single-commit scenarios.

## Commit Message Format

**Use conventional commit format:**

```txt
<type>(<scope>): <description>

[optional body explaining why, not what]
```

**Valid types:**

- `feat`: New feature
- `fix`: Bug fix
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `docs`: Documentation changes
- `test`: Adding or updating tests
- `chore`: Maintenance tasks, dependency updates
- `style`: Code style/formatting changes
- `ci`: CI/CD configuration changes
- `build`: Build system or external dependency changes

## Critical Rules

**Commit messages must be:**

- Professional and tool-agnostic
- Focused on WHAT changed and WHY
- Written as if by a human developer

## Process

### 1. Before Committing

Run these commands in parallel:

- `git status` - See all untracked and modified files
- `git diff` - See staged changes (if any)
- `git diff HEAD` - See all uncommitted changes
- `git log -5 --oneline` - Check recent commit message style

### 2. Analyze Changes

- Identify what changed and why
- Determine appropriate commit type (feat, fix, refactor, etc.)
- Choose relevant scope (file, module, or component name)
- Keep commits atomic (one logical change per commit)

### 3. Craft Commit Message

**Format:**

```txt
type(scope): brief description in present tense

Optional body paragraph explaining WHY this change was made.
Focus on motivation and context, not implementation details.
```

**Guidelines:**

- Description: lowercase, imperative mood ("add" not "added")
- Max 72 characters for first line
- Body: explain reasoning, trade-offs, or context
- Don't describe WHAT changed (code shows that)
- Match the repository's existing commit style

### 4. Stage and Commit

```bash
git add [specific files]
git commit -m "$(cat <<'EOF'
type(scope): description

Optional body explaining why.
EOF
)"
```

**IMPORTANT:** Use HEREDOC format for multi-line commit messages to preserve formatting.

## Examples

### Good Commits

```txt
feat(auth): add JWT token refresh mechanism

Implements automatic token refresh to improve user experience
and reduce re-authentication frequency.
```

```txt
fix(api): handle null response in user lookup

Prevents runtime error when API returns unexpected null values.
```

```txt
refactor(database): extract connection pool logic

Improves testability and allows connection pool configuration
to be centralized.
```

### Bad Commits (DON'T DO THIS)

```txt
❌ feat(auth): add JWT token refresh
```

```txt
❌ Update files
```

```txt
❌ WIP: stuff
```

## Atomic Commit Principles

- **One logical change per commit**: Don't mix bug fixes with feature additions
- **Keep tests with code**: Include test changes in the same commit as the code they test
- **Include related docs**: Update documentation in the same commit as code changes
- **Maintain working state**: Each commit should leave the codebase in a working state
- **Group functional additions**: Database schema + code using it = one commit

## When to Use an Atomic Commit Command Instead

Use an available atomic commit command instead of this skill when:

- You have multiple unrelated changes to separate into multiple commits
- You need interactive approval for each commit
- You want to analyze and group changes across many files
- The commit workflow needs explicit human oversight
