# Elite

Product repo for the Elite app (Explorex's diner feed & social product):
[`bawra11/elite-product`](https://github.com/bawra11/elite-product). The code lives in git submodules.

```
Elite/
  product/
    design/
      claude-design/  — Claude Design prototype exports (source of truth)
      mockups/        — screens & flows scope of the prototype, mapped to Flutter files
      legacy-pack/    — pre-Sept 2026 design pack (old app), kept for reference
    detail-flows/     — frontend flowcharts for the diner app
    business/         — product requirements, feature specs
  tech/
    codebase/         — code, one submodule per repo
      elite_app/      — Flutter app (read-write)
      BE/             — backend repos (READ-ONLY, see below)
    common/           — cross-codebase tech context: API reference, domain model, architecture
```

## Submodules

| Path | Repository | Branch | Access |
| --- | --- | --- | --- |
| `tech/codebase/elite_app` | explorexinc/elite | `phase01` | read-write |
| `tech/codebase/BE/customer_gateway` | explorexinc/customer_gateway | `stage` | read-only |
| `tech/codebase/BE/feed_svc` | explorexinc/feed_svc | `stage` | read-only |
| `tech/codebase/BE/restaurant_catalog_svc` | explorexinc/restaurant_catalog_svc | `stage` | read-only |
| `tech/codebase/BE/protos` | explorexinc/protos | `main` | read-only |
| `tech/codebase/BE/protos_dart` | explorexinc/protos_dart | `main` | read-only |

```bash
git clone --recurse-submodules git@github.com:bawra11/elite-product.git Elite
# lock the BE repos against pushes (local config, run once per clone)
git -C Elite submodule foreach --quiet 'case $sm_path in tech/codebase/BE/*) git remote set-url --push origin READ_ONLY__BE_repos_are_not_pushed_from_Elite;; esac'
```

## Working here

- **BE is read-only.** Claude's file tools are denied under `tech/codebase/BE/` (`.claude/settings.json`),
  and the push hook blocks `git push` from there. Pull to refresh; record contract drift in `tech/common/`.
- **Before pushing this repo, run `/context-sync`** (`.claude/skills/context-sync/`). It refreshes the context
  docs, commits, stamps HEAD and pushes. `.claude/hooks/guard-push.sh` blocks a push of an unsynced HEAD.
- QA agents: `/diner-qa` (eight personas on iPhone 17 and elite_pixel), `/sim-qa` (iOS simulator), `/web-qa` (Chrome).

Current focus: active development and testing of the Flutter frontend
(`tech/codebase/elite_app`) against the existing stage backend documented in
`tech/common/api-reference.md`.

Start here:
1. [`product/business/product-requirements.md`](product/business/product-requirements.md) — what the app is and does.
2. [`product/design/mockups/README.md`](product/design/mockups/README.md) — every designed screen and where it's built.
3. [`product/detail-flows/README.md`](product/detail-flows/README.md) — frontend flowcharts for those screens.
4. [`tech/common/architecture.md`](tech/common/architecture.md) — how the codebase is structured.
5. [`tech/codebase/elite_app/README.md`](tech/codebase/elite_app/README.md) — running the app.
