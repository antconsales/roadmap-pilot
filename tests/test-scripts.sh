#!/bin/bash
# test-scripts.sh - Regression test suite for roadmap-pilot scripts
# Usage: ./tests/test-scripts.sh
#
# Tests next-task.sh, status.sh, and scan-project.sh against various
# CLAUDE.md formats to ensure correct behavior.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
NEXT_TASK="$PROJECT_DIR/.claude/skills/roadmap-pilot/scripts/next-task.sh"
STATUS="$PROJECT_DIR/.claude/skills/roadmap-pilot/scripts/status.sh"
SCAN="$PROJECT_DIR/.claude/skills/init-roadmap/scripts/scan-project.sh"

PASS=0
FAIL=0
TESTS=0

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

assert_contains() {
  local label="$1"
  local output="$2"
  local expected="$3"
  TESTS=$((TESTS + 1))

  if echo "$output" | grep -q "$expected"; then
    PASS=$((PASS + 1))
    printf "  ${GREEN}PASS${NC}  %s\n" "$label"
  else
    FAIL=$((FAIL + 1))
    printf "  ${RED}FAIL${NC}  %s\n" "$label"
    printf "        Expected to contain: %s\n" "$expected"
    printf "        Got: %s\n" "$output"
  fi
}

assert_not_contains() {
  local label="$1"
  local output="$2"
  local unexpected="$3"
  TESTS=$((TESTS + 1))

  if echo "$output" | grep -q "$unexpected"; then
    FAIL=$((FAIL + 1))
    printf "  ${RED}FAIL${NC}  %s\n" "$label"
    printf "        Should NOT contain: %s\n" "$unexpected"
  else
    PASS=$((PASS + 1))
    printf "  ${GREEN}PASS${NC}  %s\n" "$label"
  fi
}

assert_exit_code() {
  local label="$1"
  local actual="$2"
  local expected="$3"
  TESTS=$((TESTS + 1))

  if [ "$actual" -eq "$expected" ]; then
    PASS=$((PASS + 1))
    printf "  ${GREEN}PASS${NC}  %s\n" "$label"
  else
    FAIL=$((FAIL + 1))
    printf "  ${RED}FAIL${NC}  %s\n" "$label"
    printf "        Expected exit code %d, got %d\n" "$expected" "$actual"
  fi
}

TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

echo ""
echo -e "${BOLD}═══════════════════════════════════════════${NC}"
echo -e "${BOLD}  ROADMAP PILOT — Test Suite${NC}"
echo -e "${BOLD}═══════════════════════════════════════════${NC}"
echo ""

# ─────────────────────────────────────────
# TEST GROUP 1: next-task.sh
# ─────────────────────────────────────────
echo -e "${YELLOW}▸ next-task.sh${NC}"

# Test 1.1: Missing file
OUTPUT=$($NEXT_TASK "$TMP_DIR/nonexistent.md" 2>&1 || true)
assert_contains "Missing file returns ERROR" "$OUTPUT" "ERROR"

# Test 1.2: Simple roadmap
cat > "$TMP_DIR/simple.md" << 'EOF'
## Roadmap

### Phase 1
- [x] Done task
- [ ] Next task
- [ ] Future task
EOF
OUTPUT=$($NEXT_TASK "$TMP_DIR/simple.md")
assert_contains "Finds next task" "$OUTPUT" "NEXT_TASK=Next task"
assert_contains "Shows correct progress" "$OUTPUT" "PROGRESS=1/3"

# Test 1.3: All tasks done
cat > "$TMP_DIR/done.md" << 'EOF'
## Roadmap

- [x] Task 1
- [x] Task 2
EOF
OUTPUT=$($NEXT_TASK "$TMP_DIR/done.md" 2>&1 || true)
assert_contains "All done returns DONE" "$OUTPUT" "DONE"

# Test 1.4: Checkboxes outside Roadmap section (THE CRITICAL TEST)
cat > "$TMP_DIR/mixed.md" << 'EOF'
## Roadmap

### Phase 1
- [x] Completed roadmap task
- [x] Another completed task

## Test Flows

### QA Tests
- [ ] Manual test 1
- [ ] Manual test 2
- [ ] Manual test 3
EOF
OUTPUT=$($NEXT_TASK "$TMP_DIR/mixed.md" 2>&1 || true)
assert_contains "All roadmap tasks done (ignoring QA)" "$OUTPUT" "DONE"
assert_not_contains "Does not find QA tasks" "$OUTPUT" "Manual test"

# Test 1.5: Mixed with unchecked roadmap + QA
cat > "$TMP_DIR/mixed2.md" << 'EOF'
## Roadmap

### Phase 1
- [x] Done task
- [ ] Real roadmap task

## Test Flows

- [ ] QA test that should be ignored
EOF
OUTPUT=$($NEXT_TASK "$TMP_DIR/mixed2.md")
assert_contains "Finds roadmap task, not QA" "$OUTPUT" "NEXT_TASK=Real roadmap task"
assert_contains "Progress counts roadmap only" "$OUTPUT" "PROGRESS=1/2"

# Test 1.6: No Roadmap section
cat > "$TMP_DIR/noroadmap.md" << 'EOF'
# My Project

Just some notes.

## Notes
- [ ] Something
EOF
OUTPUT=$($NEXT_TASK "$TMP_DIR/noroadmap.md" 2>&1 || true)
assert_contains "No roadmap section returns ERROR" "$OUTPUT" "ERROR"

# Test 1.7: Roadmap at end of file (no section after it)
cat > "$TMP_DIR/roadmap-eof.md" << 'EOF'
# Project

## Context
Some context here.

## Roadmap

### Phase 1
- [x] Task A
- [ ] Task B
- [ ] Task C
EOF
OUTPUT=$($NEXT_TASK "$TMP_DIR/roadmap-eof.md")
assert_contains "Roadmap at EOF works" "$OUTPUT" "NEXT_TASK=Task B"
assert_contains "EOF progress correct" "$OUTPUT" "PROGRESS=1/3"

# Test 1.8: Complex real-world CLAUDE.md (Genius Flow pattern)
cat > "$TMP_DIR/genius.md" << 'EOF'
# Genius Flow Cleanup

## Project Context
React Native app.

## Conventions
- Use shared types from `genius/shared/types.ts`

## Roadmap — Current Status

### Phase 1 — Shared Types
- [x] Create shared types file
- [x] Type navigationHandlers.ts
- [x] Type modalHandlers.ts
- [ ] Type remaining files in CurrentPlanningScreenGenius/
- [ ] Type remaining files in YourPlanScreenGenius/

### Phase 2 — Remove Duplication
- [ ] Extract shared thunk
- [ ] Unify day mapping

### Phase 3 — Split Handlers
- [ ] Split createNavigationHandlers
- [ ] Split createConfirmHandler

## Test Flows (QA Checklist)

### Base Plan
- [ ] New plan from scratch
- [ ] Applica ad altri giorni

### Modify Existing
- [ ] View existing plan
- [ ] Edit with exceptions

## Working With Claude
- Branch: `genius/cleanup`
- Prefix: `[genius]`
EOF
OUTPUT=$($NEXT_TASK "$TMP_DIR/genius.md")
assert_contains "Genius: finds roadmap task" "$OUTPUT" "Type remaining files in CurrentPlanningScreenGenius/"
assert_contains "Genius: correct progress" "$OUTPUT" "PROGRESS=3/9"
assert_not_contains "Genius: ignores QA section" "$OUTPUT" "New plan from scratch"

echo ""

# ─────────────────────────────────────────
# TEST GROUP 2: status.sh
# ─────────────────────────────────────────
echo -e "${YELLOW}▸ status.sh${NC}"

# Test 2.1: Missing file
OUTPUT=$($STATUS "$TMP_DIR/nonexistent.md" 2>&1 || true)
assert_contains "Missing file returns ERROR" "$OUTPUT" "ERROR"

# Test 2.2: Simple roadmap shows phases
OUTPUT=$($STATUS "$TMP_DIR/simple.md" 2>&1)
assert_contains "Shows phase header" "$OUTPUT" "Phase 1"
assert_contains "Shows TOTAL" "$OUTPUT" "TOTAL"

# Test 2.3: Ignores QA section in status
OUTPUT=$($STATUS "$TMP_DIR/mixed.md" 2>&1)
assert_not_contains "Status ignores QA phases" "$OUTPUT" "QA Tests"
assert_contains "Status shows only roadmap total" "$OUTPUT" "2/2"

# Test 2.4: Genius-style complex file
OUTPUT=$($STATUS "$TMP_DIR/genius.md" 2>&1)
assert_contains "Genius status shows Phase 1" "$OUTPUT" "Phase 1"
assert_contains "Genius status shows Phase 3" "$OUTPUT" "Phase 3"
assert_not_contains "Genius status ignores Base Plan" "$OUTPUT" "Base Plan"
assert_not_contains "Genius status ignores Modify Existing" "$OUTPUT" "Modify Existing"

# Test 2.5: No roadmap section
OUTPUT=$($STATUS "$TMP_DIR/noroadmap.md" 2>&1 || true)
assert_contains "No roadmap returns ERROR" "$OUTPUT" "ERROR"

echo ""

# ─────────────────────────────────────────
# TEST GROUP 3: scan-project.sh
# ─────────────────────────────────────────
echo -e "${YELLOW}▸ scan-project.sh${NC}"

# Test 3.1: Scan our own project
OUTPUT=$($SCAN "$PROJECT_DIR" 2>&1)
assert_contains "Scan detects project name" "$OUTPUT" "roadmap-pilot"
assert_contains "Scan detects git" "$OUTPUT" "GIT=true"
assert_contains "Scan shows structure" "$OUTPUT" "STRUCTURE"

# Test 3.2: Scan nonexistent directory
OUTPUT=$($SCAN "$TMP_DIR/nope" 2>&1 || true)
assert_contains "Nonexistent dir returns ERROR" "$OUTPUT" "ERROR"

# Test 3.3: Scan detects CLAUDE.md status
mkdir -p "$TMP_DIR/fake-project"
cat > "$TMP_DIR/fake-project/CLAUDE.md" << 'EOF'
## Roadmap
- [x] Done
- [ ] Todo
EOF
OUTPUT=$($SCAN "$TMP_DIR/fake-project" 2>&1)
assert_contains "Scan detects CLAUDE.md exists" "$OUTPUT" "EXISTS=true"
assert_contains "Scan detects roadmap section" "$OUTPUT" "HAS_ROADMAP=true"

echo ""

# ─────────────────────────────────────────
# RESULTS
# ─────────────────────────────────────────
echo -e "${BOLD}═══════════════════════════════════════════${NC}"
if [ "$FAIL" -eq 0 ]; then
  echo -e "${GREEN}  ALL TESTS PASSED: ${PASS}/${TESTS}${NC}"
else
  echo -e "${RED}  FAILURES: ${FAIL}/${TESTS} tests failed${NC}"
  echo -e "${GREEN}  PASSED: ${PASS}/${TESTS}${NC}"
fi
echo -e "${BOLD}═══════════════════════════════════════════${NC}"
echo ""

exit "$FAIL"
