# Project Name

Brief description of your Python project.

## Working With Claude

- **Branch**: `refactor/typing`
- **Commit prefix**: `[typing]`
- **Language**: Python 3.10+

## Conventions

- Use native type hints (PEP 604: `X | Y` instead of `Union[X, Y]`)
- Use `from __future__ import annotations` for forward references
- Shared types in `src/types.py` or `src/models/`
- Use `TypedDict` for dictionary shapes, `dataclass` for entities
- Use `Protocol` for duck typing instead of ABC where possible
- Preserve existing logic — only add type annotations

## Roadmap

### Phase 1 - Foundation
- [ ] Create `src/types.py` with shared type aliases and TypedDicts
- [ ] Add `py.typed` marker file for PEP 561 compliance
- [ ] Configure `mypy` in `pyproject.toml` (or `mypy.ini`)

### Phase 2 - Models / Entities
- [ ] Type `src/models/user.py`
- [ ] Type `src/models/product.py`
- [ ] Type remaining files in `src/models/`

### Phase 3 - Services / Business logic
- [ ] Type `src/services/auth.py`
- [ ] Type `src/services/api_client.py`
- [ ] Type remaining files in `src/services/`

### Phase 4 - API / Routes
- [ ] Type `src/routes/users.py`
- [ ] Type `src/routes/products.py`
- [ ] Type remaining files in `src/routes/`

### Phase 5 - Utilities
- [ ] Type `src/utils/helpers.py`
- [ ] Type `src/utils/validators.py`
- [ ] Type remaining files in `src/utils/`
