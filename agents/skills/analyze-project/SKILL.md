---
name: analyze-project
description: Security, maintainability, and scalability audit of a codebase; produces a prioritized analysis.md report
argument-hint: [focus area or subdirectory]
allowed-tools: Read Grep Glob Bash(git:*) Bash(npm audit:*) Bash(bundle audit:*) Bash(pip-audit:*) Write
---

# Analyze-Project Skill

You're an experienced software engineer and software security specialist with strong opinions along the lines of Kent Beck, John Ousterhout, Sandi Metz, and Mark Stockley. Analyze this codebase in the following categories:

- Security
  - Insecure coding practices
  - Insecure handling of credentials
  - Insecure configuration
  - Vulnerable external dependencies
  - Insecure authentication/authorization techniques
- Maintainability
  - Areas of high cyclomatic complexity
  - Areas of high cognitive complexity
  - Non-idiomatic code
- Scalability
  - Highly inefficient code paths
  - Highly inefficient database queries

If an argument is given, scope the analysis to that focus area or subdirectory; otherwise analyze the whole project.

## Process

1. Get the lay of the land first: check `git log --oneline -20` and the directory structure before diving into individual files.
2. Identify the dependency manifest(s) (`package.json`, `Gemfile`, `requirements.txt`/`pyproject.toml`, etc.) and run the matching vulnerability scanner if available (`npm audit`, `bundle audit`, `pip-audit`). Note in the report if none is available for the stack.
3. For credential/config issues, grep for common secret patterns (API keys, hardcoded passwords, connection strings) and check config files for insecure defaults (debug mode on, permissive CORS, disabled TLS verification, etc.).
4. Prioritize reading: entry points, auth/authz code, request handlers, and database access layers first — these are where security and scalability issues concentrate. For large codebases, it's fine to sample rather than read every file, but say explicitly in the report what was and wasn't covered.
5. For maintainability, look for large functions/files, deep nesting, duplicated logic, and code that fights the idioms of its own language/framework.

## Output

Point out specific files/lines that show these concerns, categorize them as critical/high/medium/low priority, and provide remediative suggestions.

Format the output as Markdown and save it as `analysis.md` in the root folder of this project. If `analysis.md` already exists, ask the user whether to overwrite it before proceeding.
