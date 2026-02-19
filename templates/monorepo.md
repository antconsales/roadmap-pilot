# Project Name (Monorepo)

Monorepo managed with [Turborepo/Nx/Lerna/pnpm workspaces].

## Working With Claude

- **Branch**: `refactor/cleanup`
- **Commit prefix**: `[cleanup]`
- **Language**: TypeScript
- **Focus package**: `packages/core` (change to your target package)

## Conventions

- Shared types in `packages/shared/src/types/`
- Each package has its own `tsconfig.json` extending root
- Import between packages via package name, not relative paths
- Changes to shared packages require checking consumers

## Roadmap

### Phase 1 - Shared Package (`packages/shared`)
- [ ] Create `packages/shared/src/types/index.ts` with domain types
- [ ] Create `packages/shared/src/types/api.ts` with API types
- [ ] Type `packages/shared/src/utils/helpers.ts`
- [ ] Type remaining files in `packages/shared/src/`

### Phase 2 - Core Package (`packages/core`)
- [ ] Type `packages/core/src/services/auth.ts`
- [ ] Type `packages/core/src/services/api-client.ts`
- [ ] Type remaining files in `packages/core/src/services/`
- [ ] Type remaining files in `packages/core/src/utils/`

### Phase 3 - Web App (`apps/web`)
- [ ] Type `apps/web/src/components/Header.tsx`
- [ ] Type `apps/web/src/components/Footer.tsx`
- [ ] Type remaining files in `apps/web/src/components/`
- [ ] Type remaining files in `apps/web/src/pages/`

### Phase 4 - Mobile App (`apps/mobile`)
- [ ] Type `apps/mobile/src/screens/Home.tsx`
- [ ] Type remaining files in `apps/mobile/src/screens/`
- [ ] Type remaining files in `apps/mobile/src/components/`

### Phase 5 - Cross-Package Cleanup
- [ ] Remove duplicate types across packages (consolidate in shared)
- [ ] Update all cross-package imports to use shared types
- [ ] Verify `turbo build` / `nx build` passes for all packages
