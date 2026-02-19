# roadmap-pilot

Roadmap-driven autopilot for Claude Code. One task per session, zero hallucinations.

## What it does

This skill reads a `## Roadmap` checklist from your project's `CLAUDE.md`, finds the next unchecked task, executes it, marks it done, commits, and tells you to open a new session. Rinse and repeat until the roadmap is complete.

## Why

- **Prevents context overflow**: one task per session keeps Claude focused
- **Anti-hallucination**: strict rules about reading files before editing
- **Incremental progress**: every task is committed separately, easy to review and revert
- **Works with any cleanup**: typing, refactoring, renaming, extracting, migrating

## Installation

Copy the `.claude/skills/roadmap-pilot/` folder into your project:

```bash
cp -r .claude/skills/roadmap-pilot /your-project/.claude/skills/
```

Or clone this repo and symlink:

```bash
git clone https://github.com/your-user/roadmap-pilot.git
ln -s $(pwd)/roadmap-pilot/.claude/skills/roadmap-pilot /your-project/.claude/skills/roadmap-pilot
```

## Setup

1. Make sure your project has a `CLAUDE.md` at the root
2. Add a `## Roadmap` section with checklist items:

```markdown
## Roadmap

### Phase 1 - Core cleanup
- [ ] Type `src/utils/helpers.ts`
- [ ] Extract shared types to `src/types/index.ts`
- [ ] Rename `getData` to `fetchUserProfile` in `src/api/users.ts`

### Phase 2 - Components
- [ ] Type `src/components/Header.tsx`
- [ ] Type `src/components/Footer.tsx`
```

3. (Optional) Specify a working branch in `CLAUDE.md`:

```markdown
## Working With Claude
- Branch: `refactor/cleanup`
- Commit prefix: `[cleanup]`
```

## Usage

Open Claude Code in your project and type:

```
/roadmap
```

Or say any of these:
- "continua la roadmap"
- "next task"
- "roadmap"

Claude will:
1. Read your `CLAUDE.md`
2. Find the next `- [ ]` task
3. Execute it (one task only)
4. Mark it `- [x]`
5. Commit everything
6. Tell you to open a new session

Repeat until the roadmap is complete.

## Helper script

The `scripts/next-task.sh` script can be used standalone to check progress:

```bash
./scripts/next-task.sh path/to/CLAUDE.md
```

Output:
```
NEXT_TASK_LINE=15
NEXT_TASK=Type `src/utils/helpers.ts`
PROGRESS=3/12
```

## Rules enforced by the skill

- **ONE task per session** - no exceptions
- **Never changes logic** - only types, names, structure
- **Never pushes to remote** - local commits only
- **Never skips hooks** - no `--no-verify`
- **Reads before editing** - never edits blind
- **Commits CLAUDE.md with code** - progress is always tracked
- **Hands off cleanly** - tells you exactly what to do next

## License

MIT
