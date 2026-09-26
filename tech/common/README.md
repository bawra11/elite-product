# tech/common

Cross-cutting technical context that isn't specific to any one codebase folder.

- [`api-reference.md`](./api-reference.md) — stage BE curl reference (endpoints, auth, gotchas).
- [`domain-model.md`](./domain-model.md) — entity definitions the Flutter domain layer should mirror, including unconfirmed/BE-pending entities.
- [`architecture.md`](./architecture.md) — stack choices and layering for the Flutter codebase.
- [`doc-audit.md`](./doc-audit.md) — 2026-09-26 documentation audit (code branches were not reachable).
- [`../codebase/BE/README.md`](../codebase/BE/README.md) — backend repos (customer_gateway, feed_svc, restaurant_catalog_svc, protos, protos_dart): how they fit together.

Keep this folder as the place BE contract changes land first — update `api-reference.md`
and `domain-model.md` before changing the Dart domain layer (endpoint paths then go in
`elite_app/lib/core/network/api_endpoints.dart`, the only place the app spells a path), so the docs stay the source
of truth rather than drifting from whatever the code happens to do.
