# Project Name

Brief description of your React project.

## Working With Claude

- **Branch**: `refactor/react-migration`
- **Commit prefix**: `[migration]`
- **Language**: TypeScript / JavaScript

## Conventions

- Functional components only (no class components)
- Use hooks instead of HOCs
- Named exports preferred over default exports
- One component per file
- CSS modules or styled-components (specify your preference)

## Roadmap

### Phase 1 - Setup
- [ ] Add TypeScript config if missing (`tsconfig.json`)
- [ ] Create shared types in `src/types/index.ts`
- [ ] Update import aliases in config

### Phase 2 - Convert class components to functional
- [ ] Convert `src/components/App.tsx` to functional component
- [ ] Convert `src/components/Layout.tsx` to functional component
- [ ] Convert remaining class components in `src/components/`

### Phase 3 - Replace HOCs with hooks
- [ ] Replace `withAuth` HOC with `useAuth` hook
- [ ] Replace `withRouter` usage with `useRouter`/`useNavigate`
- [ ] Remove unused HOC files

### Phase 4 - Modernize state management
- [ ] Replace local state patterns with hooks
- [ ] Extract shared logic into custom hooks in `src/hooks/`
- [ ] Clean up prop drilling with context where appropriate

### Phase 5 - Cleanup
- [ ] Remove unused dependencies from `package.json`
- [ ] Remove dead code and unused imports
- [ ] Verify all tests pass
