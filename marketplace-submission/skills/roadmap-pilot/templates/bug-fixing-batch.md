# Project Name — Bug Fixing Batch

Systematic fix of known bugs and issues.

## Working With Claude

- **Branch**: `fix/batch-cleanup`
- **Commit prefix**: `[fix]`
- **Language**: (your language)

## Conventions

- Each fix must include a brief comment explaining what was wrong
- If a fix changes behavior, document the before/after
- If a fix is risky, add a `// FIXED: <description>` comment
- Do NOT fix adjacent code that isn't broken — only fix the reported issue
- If a bug requires a test to prevent regression, add the test in the same task

## Roadmap

### Phase 1 - Critical Bugs (P0)
- [ ] Fix crash when `userData` is null in `src/screens/Profile.tsx:45`
- [ ] Fix infinite loop in `usePolling` hook when network is offline
- [ ] Fix race condition in `src/services/auth.ts` token refresh

### Phase 2 - High Priority Bugs (P1)
- [ ] Fix incorrect total calculation in `src/utils/cart.ts` (rounding error)
- [ ] Fix navigation stack not resetting after logout
- [ ] Fix date picker showing wrong timezone in `src/components/DatePicker.tsx`
- [ ] Fix memory leak in `src/hooks/useWebSocket.ts` (missing cleanup)

### Phase 3 - Medium Priority Bugs (P2)
- [ ] Fix search not debouncing in `src/components/SearchBar.tsx`
- [ ] Fix pagination resetting when filters change in `src/screens/List.tsx`
- [ ] Fix toast notifications stacking infinitely
- [ ] Fix image upload failing silently for files > 5MB

### Phase 4 - Low Priority / Polish (P3)
- [ ] Fix flickering during route transitions
- [ ] Fix keyboard dismissal on Android form screens
- [ ] Fix inconsistent loading spinner placement across screens
- [ ] Fix broken deep link for `/product/:id` route

### Phase 5 - Regression Tests
- [ ] Add test for null userData crash (Phase 1)
- [ ] Add test for token refresh race condition (Phase 1)
- [ ] Add test for cart total rounding (Phase 2)
- [ ] Run full test suite, verify no regressions
