# Project Name

Brief description of your TypeScript project.

## Working With Claude

- **Branch**: `refactor/typing`
- **Commit prefix**: `[typing]`
- **Language**: TypeScript

## Conventions

- Use `type` instead of `interface` for object shapes
- Shared types location: `src/types/index.ts`
- Never use `any` — use `unknown` if truly uncertain, then narrow
- Preserve existing logic — only add/change type annotations
- Import types from the shared location, do NOT create local aliases

## Roadmap

### Phase 1 - Foundation (shared types)
- [ ] Create `src/types/index.ts` with shared domain types
- [ ] Create `src/types/api.ts` with API request/response types
- [ ] Create `src/types/components.ts` with shared prop types

### Phase 2 - Core utilities
- [ ] Type `src/utils/formatters.ts`
- [ ] Type `src/utils/validators.ts`
- [ ] Type `src/utils/helpers.ts`

### Phase 3 - Services / API layer
- [ ] Type `src/services/api-client.ts`
- [ ] Type `src/services/auth.ts`
- [ ] Type remaining files in `src/services/`

### Phase 4 - Components
- [ ] Type `src/components/Header.tsx`
- [ ] Type `src/components/Footer.tsx`
- [ ] Type remaining files in `src/components/`

### Phase 5 - Pages / Routes
- [ ] Type `src/pages/index.tsx`
- [ ] Type remaining files in `src/pages/`
