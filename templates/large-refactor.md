# Project Name

Brief description of your project.

## Working With Claude

- **Branch**: `refactor/major-cleanup`
- **Commit prefix**: `[refactor]`
- **Language**: (your language)

## Conventions

- (List the target architecture here)
- (List naming conventions, import rules, etc.)
- Document the "before" and "after" state for each major change

## Roadmap

### Phase 1 - Preparation (non-breaking)
- [ ] Create target directory structure (e.g., `src/features/`, `src/shared/`)
- [ ] Create shared type definitions in `src/shared/types/`
- [ ] Create shared utility barrel exports in `src/shared/utils/`
- [ ] Add path aliases in config (tsconfig, webpack, etc.)

### Phase 2 - Extract Shared Code (non-breaking)
- [ ] Extract shared constants to `src/shared/constants.ts`
- [ ] Extract shared hooks to `src/shared/hooks/`
- [ ] Extract shared components to `src/shared/components/`
- [ ] Update imports in consuming files (keep old files as re-exports)

### Phase 3 - Feature Module: [FeatureA] (isolated risk)
- [ ] Move `src/old-path/featureA-component.tsx` to `src/features/featureA/`
- [ ] Move `src/old-path/featureA-utils.ts` to `src/features/featureA/`
- [ ] Create `src/features/featureA/index.ts` barrel export
- [ ] Update all imports of FeatureA
- [ ] Remove old re-export files for FeatureA

### Phase 4 - Feature Module: [FeatureB] (isolated risk)
- [ ] Move `src/old-path/featureB-component.tsx` to `src/features/featureB/`
- [ ] Move `src/old-path/featureB-utils.ts` to `src/features/featureB/`
- [ ] Create `src/features/featureB/index.ts` barrel export
- [ ] Update all imports of FeatureB
- [ ] Remove old re-export files for FeatureB

### Phase 5 - Split Large Files (medium risk)
- [ ] Split `src/utils/megaHelper.ts` (800+ lines) into focused modules
- [ ] Split `src/components/GodComponent.tsx` into sub-components
- [ ] Extract inline styles/logic into separate files

### Phase 6 - Dead Code Removal (low risk)
- [ ] Remove unused exports (run `ts-prune` or equivalent)
- [ ] Remove unused dependencies from `package.json`
- [ ] Remove commented-out code blocks
- [ ] Remove empty/placeholder files

### Phase 7 - Verification
- [ ] Run full test suite, fix any failures
- [ ] Run linter, fix any new warnings
- [ ] Run build, verify no errors
- [ ] Verify no circular dependencies (run `madge --circular`)
