# roadmap-pilot

> Roadmap-driven autopilot for Claude Code. Plan it, then execute it. One task per session, zero hallucinations.

<!-- Badges -->
![Version](https://img.shields.io/badge/version-2.0.0-blue)
![Claude Code](https://img.shields.io/badge/Claude%20Code-plugin-blueviolet)
![License](https://img.shields.io/badge/license-MIT-green)

<!-- DEMO GIF: Replace this with an actual recording -->
<!-- ![Demo](./assets/demo.gif) -->
<!-- To record: use `asciinema rec` or `terminalizer`, show /init-roadmap → /roadmap flow -->

## The Problem

Claude Code is powerful but forgets everything between sessions. Large refactoring tasks cause context overflow and hallucinations. Manual tracking in CLAUDE.md works but is tedious.

## The Solution

Two skills that split the work:

```
/init-roadmap          CLAUDE.md           /roadmap
 (architect)    →→→    (contract)    →→→    (builder)
  scan project,        phases,              read next task,
  interview user,      conventions,         execute ONE,
  generate plan        checklist            commit, handoff
```

| Skill | Role | Mode | Trigger |
|-------|------|------|---------|
| `init-roadmap` | Architect | Conversational | `/init-roadmap` |
| `roadmap-pilot` | Builder | Deterministic | `/roadmap` |

## Quick Start

### 1. Install

**As a plugin (recommended):**
```
/plugin marketplace add antonioconsales/roadmap-pilot
/plugin install roadmap-pilot
```

**Or copy manually:**
```bash
cp -r .claude/ /your-project/.claude/
```

### 2. Plan (once)

```
/init-roadmap
```

Claude scans your project, asks targeted questions, generates a phased roadmap in `CLAUDE.md`.

### 3. Execute (repeat)

```
/roadmap
```

Claude reads `CLAUDE.md`, executes ONE task, marks it done, commits, hands off.

### 4. Autopilot (optional)

```bash
.claude/skills/roadmap-pilot/scripts/auto-roadmap.sh
```

Runs `claude -p` in a loop. Each call = fresh session. Stops when done or stuck.

## Scripts

| Script | What it does |
|--------|-------------|
| `status.sh` | Visual progress dashboard with bars per phase |
| `next-task.sh` | Shows next task and progress count |
| `auto-roadmap.sh` | Full autopilot loop |
| `rollback.sh` | Safely reverts the last roadmap commit |
| `scan-project.sh` | Analyzes project structure (used by init-roadmap) |

### Progress Dashboard

```bash
.claude/skills/roadmap-pilot/scripts/status.sh CLAUDE.md
```

```
  ROADMAP PROGRESS
  ─────────────────────────────────────────────

  Phase 1 - Shared Types      ████████████████████ 3/3 (100%)
  Phase 2 - Core Utilities     ████████░░░░░░░░░░░░ 2/5 (40%)
  Phase 3 - Components         ░░░░░░░░░░░░░░░░░░░░ 0/8 (0%)
  ─────────────────────────────────────────────

  TOTAL                        ██████░░░░░░░░░░░░░░ 5/16 (31%)

  Next: Type `src/utils/validators.ts`
```

### Rollback

```bash
# Preview what would be reverted
.claude/skills/roadmap-pilot/scripts/rollback.sh --dry-run

# Actually revert
.claude/skills/roadmap-pilot/scripts/rollback.sh
```

## Templates

Don't want to start from scratch? Use a template as your `CLAUDE.md`:

| Template | Use case |
|----------|----------|
| `templates/typescript-typing.md` | Add types to a TS project |
| `templates/react-migration.md` | Modernize React (class → hooks, HOCs → hooks) |
| `templates/python-typing.md` | Add type hints to Python |
| `templates/general-refactoring.md` | Generic cleanup and restructuring |

```bash
cp templates/typescript-typing.md /your-project/CLAUDE.md
# Edit to match your project, then run /roadmap
```

Or let `/init-roadmap` generate a custom one from scratch.

## What init-roadmap produces

A `CLAUDE.md` like this:

```markdown
# MyApp

E-commerce frontend built with Next.js and TypeScript.

## Working With Claude
- **Branch**: `refactor/typing-cleanup`
- **Commit prefix**: `[typing]`

## Conventions
- Shared types in `src/types/`
- Use `type` instead of `interface`

## Roadmap

### Phase 1 - Shared Types
- [x] Create `src/types/api.ts` with API response types
- [x] Create `src/types/models.ts` with domain model types

### Phase 2 - Core Utilities
- [ ] Type `src/utils/formatters.ts`
- [ ] Type `src/utils/validators.ts`
```

## Rules Enforced

### init-roadmap (planning)
- Only plans, never executes
- Never modifies source code
- Shows full output before saving
- Only references files it has actually scanned

### roadmap-pilot (execution)
- **ONE task per session** — no exceptions
- **Never changes logic** — behavior stays identical
- **Never pushes to remote** — local commits only
- **Never skips hooks** — no `--no-verify`
- **Reads before editing** — never edits blind
- **Commits CLAUDE.md with code** — progress always tracked

## Works With Any Cleanup

Not just TypeScript typing. Works with:

- Type annotations (TS, Python, Go)
- Refactoring (extract, split, merge)
- Renaming (variables, files, directories)
- Migration (API changes, framework upgrades)
- Restructuring (move, reorganize)
- Cleanup (dead code, unused imports)

**Principle: plan once, execute incrementally, one task per session.**

## Project Structure

```
roadmap-pilot/
├── .claude/
│   ├── settings.json              # Hooks for reliable activation
│   └── skills/
│       ├── init-roadmap/          # Planning skill
│       │   ├── SKILL.md
│       │   └── scripts/
│       │       └── scan-project.sh
│       └── roadmap-pilot/         # Execution skill
│           ├── SKILL.md
│           └── scripts/
│               ├── auto-roadmap.sh
│               ├── next-task.sh
│               ├── rollback.sh
│               └── status.sh
├── templates/                     # Ready-to-use CLAUDE.md templates
│   ├── typescript-typing.md
│   ├── react-migration.md
│   ├── python-typing.md
│   └── general-refactoring.md
├── marketplace.json               # Plugin marketplace manifest
├── plugin.json                    # Plugin metadata
└── README.md
```

## License

MIT
