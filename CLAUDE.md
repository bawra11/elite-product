# Elite workspace

This root folder is the product repo `git@github.com:bawra11/elite-product.git`. Every repo under
`tech/codebase/` is a git submodule with its own history and remote. See `README.md` for the table.

- **`tech/codebase/BE/**` is read-only.** Read, search and `git pull` only. No edits, commits or pushes,
  and `tech/codebase/BE/README.md` is included. Record BE contract drift in `tech/common/`.
- All other folders are fully writable. `tech/codebase/elite_app` has its own `CLAUDE.md`. Commit there
  first, then stage the new submodule pointer here.
- **Before any push of this repo, run the `context-sync` skill.** The push hook refuses otherwise.
- Designed screens and flows: `product/design/mockups/README.md`. Frontend flowcharts: `product/detail-flows/`.
- Multi-diner QA: `/diner-qa` (`.cursor/skills/diner-qa/SKILL.md`). Relay OTP; do not walk the catalog yourself.
