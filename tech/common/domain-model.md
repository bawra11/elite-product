# Domain model

Derived from `api-reference.md` + the product brief. This is the vocabulary the Flutter
codebase's domain layer should mirror — entity names here should match Dart class names
in `lib/domain/entities/`.

## Confirmed entities (backed by observed API responses)

### `FeedPost`
Base shape for everything in the feed (`v1/feed_posts`, `v1/public/feed_posts`).
Experience and curation are both confirmed post types. A restaurant story is the
product name for the BE type happening; that payload is not in the capture yet.
Delete and edit render only when the signed-in diner's URN matches `author_urn`
(fallback `created_by_urn`). The gateway does not enforce that on delete.

| Field | Type | Notes |
|---|---|---|
| `uuid` | string | |
| `created_at`, `published_at` | string (epoch ms, as string) | |
| `created_by_urn`, `author_urn` | string (URN) | |
| `author` | `Author` | `{type, uuid, display_name, display_image}` |
| `caption_text` | string | |
| `post_status` | enum | `FEED_POST_STATUS_PUBLISHED`, ... |
| `medias` | `FeedMedia[]` | see api-reference.md §2 — image at `media_url.preview_url` (fallback `raw_media_url.preview_url`), ordered by `sort_index` |
| `visibility_tags` | string[] | e.g. `["ALL"]` |
| `feed_visibility` | enum | `FEED_VISIBILITY_PUBLIC`, `FEED_VISIBILITY_INVALID` (seen on a malformed/incomplete sample — treat as "not yet publishable", don't render) |
| `meta_data` | `FeedPostMetaData` | see below |
| `post_type` | enum | `FEED_POST_TYPE_EXPERIENCE` and `FEED_POST_TYPE_CURATION` confirmed. Happening is the BE name for a restaurant story; enum spelling is not in the capture |
| `payload` | oneof by `post_type` | `{experience: ExperiencePayload}` and `{curation: CurationPayload}` confirmed |
| `title`, `body` | string | can be empty strings on draft/incomplete posts |
| `viewer_reaction` | enum | `FEED_POST_REACTION_HELPFUL` \| `FEED_POST_REACTION_NONE` \| `FEED_POST_REACTION_INVALID` (INVALID = no viewer identity, i.e. anonymous) |
| `viewer_follows_author` | bool | |

### `FeedPostMetaData`
| Field | Type | Notes |
|---|---|---|
| `associated_geo_shapes` | array | unconfirmed shape |
| `impression_count` | number | |
| `bottom_bar_action` | nullable | unconfirmed shape — likely a CTA descriptor |
| `enrichment` | `Enrichment?` | **nullable** — null when AI enrichment hasn't run yet/failed. UI must handle null (don't show tag chips) |
| `helpful_count`, `unhelpful_count` | number | |

### `Enrichment`
| Field | Type | Notes |
|---|---|---|
| `sentiment` | enum | `FEED_POST_SENTIMENT_POSITIVE` \| `NEUTRAL` \| `NEGATIVE` |
| `sentiment_score` | number | -1.0..1.0 observed range |
| `tags` | string[] | e.g. `["food","pricing","view"]` — free-ish taxonomy, treat as display chips |
| `keywords` | string[] | extracted phrases |
| `embedding` | float[] | 768-dim, **never render or log in full** — used server-side for similarity search only; client should treat as opaque/drop it if present |
| `analyzed_at`, `enriched_at` | string (epoch ms) | |

### `ExperiencePayload` (`payload.experience`)
| Field | Type | Notes |
|---|---|---|
| `restaurant_id` | string | |
| `worth_it` | bool | **the core crowd-recommendation signal** |
| `verified` | bool | true when backed by a real visit/order |
| `visit_id` | string | empty string when unverified (not null — check for `""`) |
| `order_id` | string | empty string when unverified |

> When `verified: true`, expect additional dish-item/order-detail tagging per the product
> brief — **no populated example exists in this capture**. Model the domain entity with an
> optional `verifiedDetails` field now, backfill its shape once BE ships a real example.

### `CurationPayload` (`payload.curation`)

Confirmed in `api-reference.md` §2 and §7. Same create endpoint as an experience (`POST /v1/feed_posts`).

| Field | Type | Notes |
|---|---|---|
| `city` | string | e.g. `"Bangalore"` |
| `cover_media_id` | string | comes back `""` even when a media is attached; the app uses the first media as the cover |
| `members` | array | `{restaurant_id, position}`, unique restaurants, cap 15 (feed_svc create rule) |

The curation title is the post root `title`, not a field on this payload. Brand curation is the same payload with a brand/restaurant author. `promoted` is a product field and is not in the capture.

### `DinerProfile` (`dd/v1/users/current` → `response`)
Full field list in `api-reference.md` §20. For the diner-facing app, the fields that matter:

- **Public-ish**: `first_name`, `last_name`, `dp_url`, `uuid`
- **Private**: `phone_number`, `dob`, `razorpay_id`, `firebase_user_id`
- **Dynamic/semi-dynamic**: `overall_visit_count`, `overall_transaction_count`,
  `elite_membership`, `restaurant_memberships[]`, `pep_member`, `whatsapp_consent_given`

Do **not** model the full nested `Restaurant`/POS object tree from `restaurant_memberships[].membership_details.restaurants[]`
in the diner app's domain layer — flatten to a `RestaurantMembershipSummary` with just
what Profile needs to render (restaurant name, logo, membership card image/theme, discount %,
valid_till). The ~150-field POS `Restaurant` object is a backend-internal concern leaking
through a shared serializer; don't let it dictate the client's domain model.

### `Restaurant` (diner-app-relevant subset only)
Extract from the inlined objects in §20. Fields the diner app actually needs:

`uuid`, `name`, `nick_name`, `slug`, `logo_picture_url`, `google_locality`, `city`, `area`,
`latitude`, `longitude`, `description`, `details.cuisines[]`, `details.establishment_types[]`,
`details.cost_for_two`, `details.restaurant_tags[]`, `details.spotlight_tag`,
`details.active_elite_discount`, `galleries[]`, `elite_gallery` (menu/dish/ambience/listing
sub-galleries + `your_story_image`), `membership_status`.

Everything else in the raw object (`bill_print_info`, `kot_print_template`, `qsr`,
`enabled_order_payment_modes`, `restaurant_metadata`, tax templates, telegram alerts, etc.)
is POS/ops config — exclude from the Flutter domain model entirely.

### `Follow`, `FollowerEntry`, `BlockedUser`
Straightforward — see `api-reference.md` §11–16. Note `follow_type` is a required
discriminator on almost every follow-graph call (following, followers, counts) — the
domain layer should not offer a "list all follows regardless of type" convenience unless
BE adds one.

## Unconfirmed entities (no API sample yet)

Model these as domain entities/interfaces now (so the BLoC/repository layer has a stable
seam), but keep their data sources behind a repository interface that can be pointed at a
mock until a capture exists:

- **`RestaurantStory`** — product name for the BE post type happening. `{uuid, restaurant, photos[], dishTags[], offers[], actions[], tags[], body}`, plus `starts_at` / `ends_at` (`ends_at` ≥ `starts_at`). Same `feed_posts` routes as experience and curation. No sample body yet.
- **Onboarding phase-1** (`name` + `username` claim) is local until a profile write lands. **Phase-2** is phone number + OTP only (`POST /dd/v1/authentication/otps`, `PUT /dd/v1/login/otp`). No password.

## Numeric encoding gotchas (apply across the whole API)

- Counts (`count`, `total`) are **strings**, not numbers, in list-count endpoints.
- Timestamps are **epoch milliseconds as strings**.
- `price` and `discount_percentage` on membership objects use non-obvious fixed-point
  scaling (see api-reference.md §20) — **do not display these raw**; confirm the scale
  factor with BE, then centralize the conversion in one place (e.g. `Money` value type),
  never inline the division in a widget.

## Frontend-only entities (demo-backed until BE ships them)

Implemented in `elite_app/lib/domain/entities/discovery.dart` and
`experience_dna.dart`. They are served by `DemoDiscoveryRepository`, gated by
`AppConfig.useDemoDiscovery`. Each maps to a future endpoint behind
`DiscoveryRepository`, so screens won't change when the real API lands.

- `RestaurantSummary`: the diner-facing slice of a restaurant (name, area, cuisine, hero/logo, recommended, DNA, amenities, live vibe). Lookup by id is `GET /dd/v1/public/restaurant_catalog/restaurants/{id}` (phase01 catalog). DNA and live vibe are still missing. Feed posts carry only `restaurant_id`.
- `ExperienceDna` / `DnaAxis`: 3–6 axes, mention-weighted percentages, verified count, summary.
- `Curation` / `CurationSpot` / `CuratorSummary`: up to 15 spots; each spot has a note, verified-visited and promoted flags. The wire payload is confirmed (§7); these richer spot fields are still frontend-only.
- `RestaurantStory`: restaurant-authored happening, with media, dish tags and an offer.
- `StoryRing`: the Home stories rail.

**Reaction enum addition:** `ViewerReaction.unhelpful` ↔ `FEED_POST_REACTION_UNHELPFUL`. This is
inferred from `unhelpful_count` and must be confirmed with BE.

**Auth is phone number + OTP.** Stage already has `POST /dd/v1/authentication/otps` and
`PUT /dd/v1/login/otp` (dine-in `main`). phase01 should call those. There is no password
endpoint. Handle availability is still missing. Until phase01 is wired, debug builds use
`StubOtpAuthRepository` (any 4-digit code except `0000`, then
`--dart-define=STAGE_REFRESH_TOKEN`). Release builds use `UnavailableAuthRepository`.
