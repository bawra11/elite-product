# tech/codebase/BE

Backend repos for the Explorex platform, cloned for reference (the Elite app talks to them; we don't deploy from here).
Each folder is its own git checkout — pull inside it to refresh. `graphify-out/` in each repo is a local code graph
(git-excluded); rebuild with `graphify update .` after pulling.

| Folder | Remote | Branch | What it is |
|---|---|---|---|
| `customer_gateway` | explorexinc/customer_gateway | `stage` | HTTP→gRPC gateway for consumer apps (DD web, Elite iOS/Android, SkipQ) |
| `feed_svc` | explorexinc/feed_svc | `stage` | gRPC service for feed posts (experience / curation / happening), reactions, media uploads, home feed search |
| `restaurant_catalog_svc` | explorexinc/restaurant_catalog_svc | `stage` | gRPC service owning franchises, restaurants, menus, dishes, tables, taxes, discounts, devices |
| `protos` | explorexinc/protos | `main` | Protobuf contracts for every microservice (source of truth) |
| `protos_dart` | explorexinc/protos_dart | `main` | Generated Dart models from `protos` (CI output — never hand-edit) |

## How the pieces fit

```
Elite app (Flutter) ──HTTPS/JSON──▶ customer_gateway ──gRPC──▶ authentication_svc v2, user_svc v2,
                                     (Go, gorilla/mux)           restaurant_catalog_svc v1, order_svc v1,
                                                                 feed_svc v1, pubsub_svc v2, payment_svc v2,
                                                                 explorex_pay_svc v1
protos ──buf generate (CI on main)──▶ protos_go (Go, tagged vX.Y.Z)  ──▶ imported by every Go svc
                                 └──▶ protos_dart (Dart)             ──▶ usable by the Flutter app
                                 └──▶ swagger repo (OpenAPI)
```

Shared plumbing (middlewares, auth tokens, gateway helpers, logger, tracing) lives in the private
`github.com/explorexinc/go_commons` module, not in these repos.

## customer_gateway (stage)

- Entry: `cmd/server.go` — dials one gRPC conn per downstream svc (addresses in `config/customer_gateway_<env>.yaml`,
  stage = `*.workload-stage.svc.cluster.local:2000`), mounts everything under `/$APP_NAME` (= `/customer_gateway`).
- Routes: `pkg/routes/routes.go` (DD + Elite) and `pkg/routes/skip_q_routes.go` (SkipQ). Handlers in `pkg/handlers/*`
  are thin: decode JSON with `jsonpb` into the proto request → call gRPC → `gateway.NewEncapsulatedResponseProto`.
- Router layers (each adds middleware):
  1. **public** — requires `x-app-name` ∈ {DD web, Elite Android, Elite iOS} + `x-app-version`. OTP/login/register, token refresh, elite configs.
  2. **basicAuth** — static app tokens (`auth_tokens` in config) for public catalog/feed reads (`/dd/v1/public/...`, `/v1/public/feed_posts`).
  3. **private** — user bearer token validated via authentication_svc v2 (`tokenSupplier` in `auth_ctx_derivation_func.go`); the URN entity type must be `users` (DD/Elite) or `skip_q_users`.
  4. **restaurant-aware** — additionally requires account / franchise / restaurant ID headers.
- Elite-relevant private routes: users/current, feed_posts (CRUD, reaction, file_uploads), follows, blocks,
  elite_membership_orders (create/init/verify), explorex_pay_orders, restaurant search/details/live menus.
- Swagger at `/customer_gateway/swagger` on non-prod. `async_workers/main.go` is an empty stub.

## restaurant_catalog_svc (stage)

- Entry: `cmd/main.go` → `cmd/grpc.go` (gRPC server + interceptors that lift account/franchise/restaurant/user headers
  into ctx) → `bootstrap/bootstrap.go` wires ~60 services. Also exposes a grpc-gateway REST mirror at `/restaurant_catalog_svc`.
- Layers: `pkg/domain` (GORM entities, each with `ToDto()` → proto) → `pkg/repo` (MySQL) + `pkg/repo/nosql`
  (Elasticsearch: restaurants-v2, dish_menus, franchises, tables, wallet txns, ads) → `pkg/svc` (`restaurant_svc_server.go`
  implements the one big `RestaurantCatalogService`, ~300 RPCs).
- Storage/infra: MySQL (`db/migrations`, numbered up/down SQL), Elasticsearch search + dish-menu embeddings,
  Redis (menu caches, Lua scripts for daily stock), asynq workers on Redis (`async_workers/tasks`: CDC consumers for
  order tables, payments, ads, wallet txns, customer counts, weekly elite insights; Nextel campaign refresh),
  Quartz scheduler for menu enable/disable/expire.
- Calls out to: slug_svc, pubsub_svc, order_svc, document_svc, payment_svc v2, communication_svc, delivery_integration_svc.
- Error codes are in the 7xx range.

## feed_svc (stage)

`stage` is the live branch (47 commits ahead of `main`). Serves everything under the gateway's `/v1/feed_posts`.

- Layers as in catalog: `pkg/domain` (GORM + `ToDto`) → `pkg/repo` (MySQL) + `pkg/repo/nosql` (Elasticsearch, index
  docs in `docs/es`) → `pkg/svc` (`feed_post_svc.go` create/search/delete, `feed_post_reaction.go` on Redis,
  `feed_post_follow.go` / `feed_post_block.go` filters, `homequery/` builds the home ES query). `pkg/enrich` +
  `async_workers` run the LLM analyze/embedding job (`feed:enrich_post`). `pkg/utils/cursor` encodes the home cursor.
- **Create rules** live in `pkg/domain/payload/validate.go` (experience needs restaurant_id + title + body; curation
  ≤15 unique members; happening ends_at ≥ starts_at). Errors are `feed_svc_1..6` in `pkg/error/errors.go`.
- Search needs `user_location` and non-empty `visibility_tags`; the cursor is the top-level `cursor` field;
  `post_types` filters server-side.
- Known gap: `DeleteFeedPostByUUID` has no author check (any signed-in diner can delete any post).

## protos (main)

- One folder per service (`<svc>/<svcpkg>/v<N>/*.proto`), shared types in `core/commons/v1/commons.proto`
  (StatusResponse, SearchRequest, ExplorexTime, ...). Workspace via `buf.work.yaml`.
- Largest contracts: restaurant_catalog_svc v1 (304 RPCs), order_svc v1 (121), inventory_svc v2 (98), user_svc v2 (42).
- CI on push to `main`: `build.yaml` → Go + grpc + grpc-gateway + OpenAPI via `build.sh` → pushed to `protos_go`
  (semver tag from `semver.py`) and `swagger`; `build-dart.yaml` → `protos_dart`.
- Changing a contract = PR to `protos` → wait for the new `protos_go` tag → bump it in each Go service's `go.mod`.
  Note the drift: gateway is on protos_go v0.33.59, catalog svc on v0.33.40.

## protos_dart (main)

`lib/<svcpkg>/v<N>/*.pb.dart` etc. for every service, plus `google/api`. `README.md` records the source protos commit.
Dependencies: `protobuf ^5.1.0`, `protobuf_google`, `fixnum`.
