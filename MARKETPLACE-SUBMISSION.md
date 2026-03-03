# Submitting roadmap-pilot to the Claude Code Skills Marketplace

## Overview

This guide explains how to submit `roadmap-pilot` and `init-roadmap` to the official [anthropics/skills](https://github.com/anthropics/skills) marketplace.

## Pre-submission Checklist

- [x] SKILL.md has correct YAML frontmatter (`name`, `description`)
- [x] SKILL.md body is under 500 lines
- [x] Scripts are self-contained and executable
- [x] Templates included for quick start
- [x] LICENSE.txt added (MIT)
- [x] No hardcoded paths or secrets
- [x] Description is keyword-rich for auto-triggering

## Submission Steps

### 1. Fork the official repo

```bash
gh repo fork anthropics/skills --clone
cd skills
```

### 2. Copy the submission-ready skills

```bash
# From this repo's marketplace-submission/ directory
cp -r marketplace-submission/skills/roadmap-pilot skills/
cp -r marketplace-submission/skills/init-roadmap skills/
```

### 3. Verify the structure

```
skills/
├── roadmap-pilot/
│   ├── SKILL.md              # Main execution skill
│   ├── LICENSE.txt            # MIT license
│   ├── scripts/
│   │   ├── auto-roadmap.sh   # Autopilot loop
│   │   ├── next-task.sh      # Find next task
│   │   ├── rollback.sh       # Safe revert
│   │   └── status.sh         # Progress dashboard
│   └── templates/
│       ├── typescript-typing.md
│       ├── react-migration.md
│       ├── python-typing.md
│       ├── general-refactoring.md
│       ├── monorepo.md
│       ├── large-refactor.md
│       └── bug-fixing-batch.md
└── init-roadmap/
    ├── SKILL.md              # Planning skill
    ├── LICENSE.txt            # MIT license
    └── scripts/
        └── scan-project.sh   # Project analyzer
```

### 4. Create the PR

```bash
git checkout -b add-roadmap-pilot
git add skills/roadmap-pilot skills/init-roadmap
git commit -m "Add roadmap-pilot and init-roadmap skills"
git push -u origin add-roadmap-pilot
```

Then create a PR with this template:

---

**PR Title:** Add roadmap-pilot: incremental codebase cleanup autopilot

**PR Body:**

## Summary

Two skills for roadmap-driven incremental codebase cleanup:

- **roadmap-pilot** (`/roadmap`): Reads CLAUDE.md, executes ONE task per session, marks it done, commits, hands off. Prevents context overflow and hallucinations on large refactoring jobs.
- **init-roadmap** (`/init-roadmap`): Scans a project, interviews the user about goals, generates a phased CLAUDE.md roadmap ready for execution.

## How it works

```
/init-roadmap → CLAUDE.md → /roadmap (repeat)
 (plan once)     (contract)   (execute one task per session)
```

## What's included

| Component | Description |
|-----------|-------------|
| `roadmap-pilot/SKILL.md` | Execution skill with dry-run mode |
| `init-roadmap/SKILL.md` | Conversational planner |
| `scripts/auto-roadmap.sh` | Full autopilot loop |
| `scripts/status.sh` | Visual progress dashboard |
| `scripts/next-task.sh` | Find next task + progress |
| `scripts/rollback.sh` | Safe revert of last commit |
| `templates/` | 7 ready-to-use CLAUDE.md templates |

## Works with any cleanup

- TypeScript/Python typing
- Refactoring (extract, split, merge)
- Migration (API changes, framework upgrades)
- Renaming, restructuring, dead code removal
- Systematic batch bug fixing

## Testing

30 regression tests covering all scripts: `tests/test-scripts.sh`

## Links

- **Repo**: https://github.com/antconsales/roadmap-pilot
- **Version**: 2.2.0
- **License**: MIT

---

### 5. Monitor the PR

```bash
gh pr view --web
```

## Alternative: Direct Plugin Install

Users can also install directly from this repo without the marketplace:

```bash
/plugin marketplace add antconsales/roadmap-pilot
/plugin install roadmap-pilot
```
