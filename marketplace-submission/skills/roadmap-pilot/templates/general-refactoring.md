# Project Name

Brief description of your project.

## Working With Claude

- **Branch**: `refactor/cleanup`
- **Commit prefix**: `[refactor]`
- **Language**: (your language)

## Conventions

- (Add your project's naming conventions here)
- (Add your import/module conventions here)
- (Add your testing conventions here)

## Roadmap

### Phase 1 - Structure
- [ ] Move shared utilities to `src/utils/`
- [ ] Move shared types/interfaces to `src/types/`
- [ ] Update all imports to reflect new structure

### Phase 2 - Extract and deduplicate
- [ ] Extract duplicated logic from `FileA` and `FileB` into shared utility
- [ ] Remove dead code in `src/legacy/`
- [ ] Consolidate similar helper functions

### Phase 3 - Rename for clarity
- [ ] Rename `getData()` to `fetchUserProfile()` in `src/api/users`
- [ ] Rename `handleStuff()` to `processPayment()` in `src/services/payment`
- [ ] Rename ambiguous variable names in `src/utils/helpers`

### Phase 4 - Modernize
- [ ] Replace callbacks with async/await in `src/services/`
- [ ] Replace deprecated API calls
- [ ] Update error handling patterns

### Phase 5 - Cleanup
- [ ] Remove unused imports across all files
- [ ] Remove commented-out code
- [ ] Verify all tests pass
