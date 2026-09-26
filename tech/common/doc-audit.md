# Product documentation audit

Date: 2026-09-26. Method: Graphify index of the product docs (38 files, 1,062 nodes, 1,791 edges, 60 communities) plus a direct read of the files the graph flagged. `graphify-out/` is local and gitignored. Query with `~/.local/bin/graphify query "…"`.

## Branch map requested

| Tree | Branch |
| --- | --- |
| This repo, `protos`, `protos_dart` | `main` |
| `elite_app` | `phase01` |
| `customer_gateway`, `feed_svc`, `restaurant_catalog_svc` | `stage` |

## Blocker: code was not audited

Submodule working trees are empty. This environment's GitHub credential gets 404 from every `explorexinc/*` repo, so the branch tips could not be fetched or indexed. Recorded gitlinks, not verified against those branches:

| Path | Pinned SHA |
| --- | --- |
| `tech/codebase/elite_app` | `860c745a868d60aaa51ceaca37b1d486a04d9585` |
| `tech/codebase/BE/customer_gateway` | `1980d2c4e7e1d4ad8ba7df5b9f3ba108fea5d858` |
| `tech/codebase/BE/feed_svc` | `efb22a2e4b2d13c557bfec45b93aa74c4d1f77c3` |
| `tech/codebase/BE/restaurant_catalog_svc` | `f2f91ce62eb00de9469fe1b8131e48db1e8fb1c9` |
| `tech/codebase/BE/protos` | `439dda67b60382aabb967b33d50b0c22decdb4c7` |
| `tech/codebase/BE/protos_dart` | `edd25cf2454c512f55f3c70b23458488607ba12a` |

Flutter paths in `product/design/mockups/README.md` and Dart types in `tech/common/` are claims. They were not checked against `phase01`.

## High: docs disagree with each other

1. **Curation is both live and unconfirmed.** `tech/common/api-reference.md` §2 says the stage feed returns `FEED_POST_TYPE_EXPERIENCE` and `FEED_POST_TYPE_CURATION`, and §7 shows a create-curation body. `tech/common/domain-model.md` still says the only populated type is experience and that `Curation` is unconfirmed. `product/business/product-requirements.md` still says curation is not in the sampled API. The graph marks `payload.curation` → `Unconfirmed Curation entity` as ambiguous.

2. **Phase 2 auth is number-only in the decision log and password-based everywhere else.** Decision 2026-09-22 in the product brief: phone number once, no password. `tech/common/architecture.md` still describes `auth/` as OTP/password. `tech/common/domain-model.md` still lists phase 2 as OTP plus password set.

3. **`FEED_POST_REACTION_UNHELPFUL` is sent and unconfirmed.** The product decision shows Helpful and Not helpful. The API reference only captured `HELPFUL` and `NONE`, says the app sends `UNHELPFUL`, and points at `docs/issues.md` M6. That file is not in the repo. Same for M10 (price scale) and S4 (leaked public API token).

4. **`api-reference.md` has two endpoint tables that read as opposites.** "Already on stage" (checked 2026-09-25 against dine-in `origin/main` @ `b971951`) lists OTP, restaurant-by-id, search, live menu, and pay as existing. "Missing endpoints the app expects" still lists those Elite seams as stubs. Both can be true if dine-in `main` has the routes and Elite `phase01` does not call them yet. The doc does not say that split clearly, and the check was against `origin/main`, not `phase01`.

5. **Restaurant story vs happening.** The product brief's third post type is a restaurant story, marked unconfirmed. `tech/codebase/BE/README.md` describes feed_svc create rules for experience, curation, and happening. No restaurant-story sample is in the API reference. The graph leaves `Restaurant story` → `Happening post type` ambiguous.

6. **Delete has no author check, and soft-delete still appears in search.** Recorded in the API reference §21 and the BE readme: `DeleteFeedPostByUUID` does not check the author, and two deleted posts (2026-09-25) still returned as `FEED_POST_STATUS_PUBLISHED`.

7. **Protos pin drift, documented only.** BE readme: gateway on `protos_go` v0.33.59, catalog on v0.33.40. Not re-checked; the Go modules are not in this checkout.

## Design export coverage

All three Claude Design HTML files are cut at 256 KB.

| Export | Screens found | Cutoff |
| --- | --- | --- |
| `Experience Diner App.dc.html` (post-audit, prefer this) | 15: auth ×7, tutorial ×4, `home`, `home-list`, `elara`, `explore-landing` | Inside Explore (`backdrop-filter`) |
| `Experience Diner App standalone.dc.html` | 41, including search, create, reserve, pay, curations, wallet. No `home-list`, no `curation-feed` | Inside the token wallet |
| `Experience Diner App export.dc.html` | 19, including `curation-feed`, discovery, and the three detail screens. No `home-list` | Inside `story-detail` |

`curation-feed` exists only in the export file. The mockup index correctly marks it not built. Profile, curator profile, deals, loyalty, membership, and token store are in none of the three files. The mockup index matches that.

The July 2026 legacy pack is a different product: bottom nav is Home / Menu / Pay Bill / Reorder / Waiter, with bill amount, tier discounts, and a cart. It is labeled legacy in its README. Do not treat those screens as the current Elite spec (Home · Experience · Create · Curation · Profile, binary worth-it, no star rating).

## Still to verify once the repos are readable

On `phase01`: mockup Flutter paths, whether the app sends `FEED_POST_REACTION_UNHELPFUL`, whether create uses `payload.curation`, whether the cursor is top-level or `page_request.cursor`, and whether auth is number-only or still password/stub OTP.

On `stage`: author check in `DeleteFeedPostByUUID`, whether search hides soft-deleted posts, and whether happening is the restaurant-story wire type.

On `main`: `protos` vs `protos_dart` commit alignment, and the gateway/catalog `protos_go` versions.
