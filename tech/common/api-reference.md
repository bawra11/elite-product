# Elite Diner Feed & Social — Stage API Reference

> Source: BE-generated curl reference, captured **2026-09-23 17:54:18 UTC** (supersedes the
> 2026-09-06 capture). Section numbers **match BE's doc** (§1–21) so the two can be read side by
> side; `lib/core/network/api_endpoints.dart` cites them. This is a snapshot, not a live
> contract, so re-pull from BE whenever endpoints change.
>
> The `users/current` response (§20) is trimmed here: the shape is documented once, not
> repeated per membership. JWTs, embedding vectors and the public API token are redacted.

**Base URL:** `https://api-stage.explorex.co.in/customer_gateway`

## Auth notes

- `Authorization` header uses the **raw JWT**, no `Bearer` prefix.
- Required headers on every call: `x-app-name`, `x-app-version`.
- The public feed additionally needs `X-API-TOKEN`. **The value lives only in
  `config/*.json`** (gitignored). It was pasted into earlier versions of this doc and the BE
  capture, so treat it as leaked and rotate it (docs/issues.md S4).
- Reaction body field is `reaction` (not `reaction_type`).
- Create with media: §4 file_uploads → §5 PUT bytes to `pre_signed_url` → §6/§7 create with
  `medias[].raw_media_url.file_path`.

```bash
export REFRESH_TOKEN='<your refresh token>'
export ACCESS_TOKEN=$(curl -sS -X POST "$BASE/dd/v1/auth_tokens/refresh" \
  -H 'Content-Type: application/json' -H 'x-app-name: elite-app-android' -H 'x-app-version: 1.0.0' \
  -d "{\"refresh_token\":\"$REFRESH_TOKEN\"}" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['response']['access_token'])")
```

---

## 1. Refresh token

```
POST /dd/v1/auth_tokens/refresh
{"refresh_token":"$REFRESH_TOKEN"}
```

`200` → `{"response": {"access_token": "<JWT>", "refresh_token": "<JWT>"}}`

The refresh token **rotates on every use**. Always persist the new one.

---

## 2. Search feed (public)

Anonymous home browse. `X-API-TOKEN`, no diner JWT.

```
PUT /v1/public/feed_posts
X-API-TOKEN: <X-API-TOKEN>

{"page_request":{"page":0,"size":5},
 "request":[
   {"key":"user_location","value":{"latitude":12.9716,"longitude":77.5946}},
   {"key":"visibility_tags","value":["ALL"]}
 ]}
```

`200` → `{ posts: FeedPost[], page_response: {total: "12", has_next_page}, next_cursor }`

- `viewer_reaction` is always `FEED_POST_REACTION_INVALID` here (no viewer identity).
- The feed mixes post types. `FEED_POST_TYPE_EXPERIENCE` and `FEED_POST_TYPE_CURATION` both
  come back. A restaurant story is the same feed with `FEED_POST_TYPE_HAPPENING` and a
  `payload.happening` of `{restaurant_id, starts_at, ends_at}` (no sample in this capture).
  feed_svc (stage) reads an optional top-level `post_types` list
  (`["FEED_POST_TYPE_HAPPENING"]`, `["FEED_POST_TYPE_CURATION"]`) to filter
  server-side. The curation tab sends `page_request.size` 10, `cursor: ""`,
  and that `post_types` list — not a `request` key named `post_type`.
  The Home stories rail does not use this search; it uses §23.
- `next_cursor` is an opaque base64 string. Send it back as the **top-level `cursor`** field,
  beside `page_request` (feed_svc reads `req.GetCursor()`; `PageRequest` has only `page`/`size`).
  An undecodable cursor is a 400 (`feed_svc_6`).
- Both `user_location` and a non-empty `visibility_tags` are required (400 `feed_svc_4` otherwise).
  `size: 0` means 10.

### FeedPost shape

```json
{
  "uuid": "64fefc45-…",
  "created_at": "1790185801829",            // epoch ms, as a string
  "published_at": "1790185801829",
  "created_by_urn": "urn:explorex:users:42a5…",
  "author_urn": "urn:explorex:users:42a5…",
  "author": {
    "type": "FEED_POST_AUTHOR_TYPE_USER",
    "uuid": "urn:explorex:users:42a5…",     // a URN despite the name
    "display_name": "",                      // empty on every stage sample
    "display_image": null
  },
  "caption_text": "…", "title": "…", "body": "…",
  "post_status": "FEED_POST_STATUS_PUBLISHED",
  "feed_visibility": "FEED_VISIBILITY_PUBLIC",
  "visibility_tags": ["ALL"],
  "post_type": "FEED_POST_TYPE_EXPERIENCE",
  "payload": { "experience": { … } } | { "curation": { … } },
  "medias": [FeedMedia],
  "meta_data": {                             // null on a freshly created post (§6–7)
    "associated_geo_shapes": [], "impression_count": 0, "bottom_bar_action": null,
    "helpful_count": 0, "unhelpful_count": 0,
    "enrichment": {
      "sentiment": "FEED_POST_SENTIMENT_NEUTRAL", "sentiment_score": 0.5,
      "tags": ["…"], "keywords": ["…"],
      "analyzed_at": "1790185802985", "enriched_at": "1790185802985",
      "embedding": ["<768 floats>"]          // never carry past the data layer
    }
  },
  "viewer_reaction": "FEED_POST_REACTION_NONE",
  "viewer_follows_author": false
}
```

`payload.experience`: `{restaurant_id, worth_it, verified, visit_id: "", order_id: ""}`.
`visit_id`/`order_id` are empty on every sample.

`payload.curation`: `{cover_media_id: "", city: "Bangalore", members: [{restaurant_id, position}]}`.
The curation's title is the post's root `title`.

`FeedMedia`:
```json
{
  "uuid": "1a3b2d3b-…", "post_id": "40cb0d4f-…",
  "media_type": "UPLOAD_FILE_TYPE_JPEG",
  "media_url":     {"file_path": "explorex_feed_media/users/{user}/{id}/raw.jpeg",
                    "preview_url": "https://static.stage.explorex.co.in/explorex_feed_media/…/raw.jpeg"},
  "raw_media_url": {"file_path": "…", "preview_url": "…"},
  "sort_index": 0,
  "meta_data": null | {"media_height": 0, "media_width": 0, "duration_in_seconds": 0, "thumbnail_url": null}
}
```

---

## 3. Search home feed (private)

Same request and response as §2, authenticated (`Authorization: $ACCESS_TOKEN`, no
`X-API-TOKEN`). `viewer_reaction` is the viewer's (`FEED_POST_REACTION_NONE` when unset).

```
PUT /v1/feed_posts
```

---

## 23. Follow feed grouped by author (stories rail)

Signed-in only. One group per followed author (user, restaurant, or brand), authors ordered by
their newest post, each group's `posts` best-first. The Home stories rail renders one bubble
per group. Guests have no call. At most 10 authors; `page_request.size` above 10 is treated as 10.

```
PUT /v1/feed_posts/following/grouped_by_author
{"page_request":{"page":0,"size":10},"cursor":""}
```

`200` → `{ groups: [{ author: FeedPostAuthor, posts: FeedPost[] }], next_cursor }`

`cursor` is opaque. Empty is the first page. An undecodable cursor is a 400.

---

## 4. File upload URL

Step 1 of attaching media.

```
PUT /v1/feed_posts/file_uploads
{"file_type":"UPLOAD_FILE_TYPE_JPEG"}
```

`201` →
```json
{
  "pre_signed_url": "https://explorex-nb-stage-public.s3.ap-south-1.amazonaws.com/explorex_feed_media/users/{user}/{id}/raw.jpeg?X-Amz-…&X-Amz-Expires=300&X-Amz-SignedHeaders=content-type%3Bhost…",
  "url": {
    "file_path": "explorex_feed_media/users/{user}/{id}/raw.jpeg",
    "preview_url": "https://static.stage.explorex.co.in/explorex_feed_media/users/{user}/{id}/raw.jpeg"
  }
}
```

The URL expires in **300 s**, so request it right before uploading and never cache it.
Observed file types: `UPLOAD_FILE_TYPE_JPEG`, `UPLOAD_FILE_TYPE_MP4`.

## 5. Upload media bytes to `pre_signed_url`

Step 2. Straight to S3, not through the gateway. `Content-Type` must match the signed
header (`image/jpeg`). Send no auth or app headers.

```bash
curl -sS -X PUT "$PRE_SIGNED_URL" -H 'Content-Type: image/jpeg' --data-binary @./feed_test.jpg
```

`200`, empty body. Then use §4's `url.file_path` in the create call.

---

## 6. Create experience (with medias)

feed_svc validates every create (`pkg/domain/payload/validate.go`, after trimming), returning
400 `feed_svc_5` with the reason:
- experience: `payload.experience.restaurant_id` **or** `payload.experience.place_id` (a Google
  place id from §22), `title` and `body` are all required;
- curation: `title` required; at most **15** `members`, each with a `restaurant_id` or a
  `place_id`, no duplicates (keyed by restaurant id, else `place:<place_id>`); a published
  curation needs at least one. `position` is reassigned from order;
- a `place_id` with no `restaurant_id` is resolved by feed_svc before validation
  (restaurant_catalog `EnsureRestaurantsFromGooglePlaces`, not exposed to the diner); the created
  post and §8 come back with `restaurant_id` filled. The app sends exactly one of the two
  (feed_svc PR #17, protos #1142, 2026-10-01);
- every media needs a non-INVALID `media_type` and a `raw_media_url.file_path`.
- `payload.experience.dishes[]` (`ExperienceDish`, protos `068f3af2`): dish tags from the body.
  The app sends `dish_menu_id`, `dish_menu_entry_id`, `name` and `text_start`/`text_end` (Unicode
  code-point offsets of the `@name` in `body`, end exclusive), only on a verified visit, from the
  order's KOT lines. feed_svc looks each up on the restaurant's menu (400 "tagged dish is not on
  the menu" otherwise; needs `restaurant_id`) and fills `dish_id`, `description`, `meat_category`,
  `image_path` (`pkg/svc/feed_experience_dish.go`).

```
POST /v1/feed_posts

{"caption_text":"…","title":"…","body":"…",
 "post_type":"FEED_POST_TYPE_EXPERIENCE",
 "post_status":"FEED_POST_STATUS_PUBLISHED",
 "feed_visibility":"FEED_VISIBILITY_PUBLIC",
 "visibility_tags":["ALL"],
 "payload":{"experience":{"restaurant_id":"45e971cd-…","worth_it":true,"verified":false}},
 "medias":[{"media_type":"UPLOAD_FILE_TYPE_JPEG",
            "raw_media_url":{"file_path":"explorex_feed_media/users/{user}/{id}/raw.jpeg"},
            "sort_index":0}]}
```

`200` → the created `FeedPost`, with **`meta_data: null`** and each media's `meta_data: null`.
Enrichment is filled in asynchronously (~1–15 s later). `viewer_reaction` comes back
`INVALID` here even though the call is authenticated.

## 7. Create curation (with medias)

Same endpoint and media pattern. **`title` is on the post root, not inside
`payload.curation`.**

```
POST /v1/feed_posts

{"caption_text":"…","title":"…",
 "post_type":"FEED_POST_TYPE_CURATION", "post_status":"FEED_POST_STATUS_PUBLISHED",
 "feed_visibility":"FEED_VISIBILITY_PUBLIC", "visibility_tags":["ALL"],
 "payload":{"curation":{"city":"Bangalore",
                        "members":[{"restaurant_id":"45e971cd-…","position":0}]}},
 "medias":[…]}
```

`200` → the created `FeedPost`. `payload.curation.cover_media_id` comes back `""` even when a
media is attached, so the app uses the first media as the cover.

---

## 8. Get feed post

```
GET /v1/feed_posts/{uuid}
Authorization: $ACCESS_TOKEN
```

`200` → a single `FeedPost`. It requires a JWT, so there's no guest single-post read.

## 9. Set reaction (helpful)

```
PUT /v1/feed_posts/{uuid}/reaction
{"post_id":"{uuid}","reaction":"FEED_POST_REACTION_HELPFUL"}
```

`200` → `{"helpful_count": 1, "unhelpful_count": 0, "viewer_reaction": "FEED_POST_REACTION_HELPFUL"}`

## 10. Set reaction (none)

Same endpoint, `"reaction":"FEED_POST_REACTION_NONE"` clears the viewer's reaction.

> `FEED_POST_REACTION_UNHELPFUL` is the confirmed wire value for "Not helpful" (2026-10-01).
> The captures in this file still only show `HELPFUL` and `NONE`.

---

## 11. Follow

```
PUT /v1/follows
{"followee_id":"{uuid}","follow_type":"FOLLOW_TYPE_RESTAURANT"}
```

`follow_type`: `FOLLOW_TYPE_RESTAURANT` | `FOLLOW_TYPE_USER` | `FOLLOW_TYPE_BRAND`.
`200` → `{"status": true}`

## 12. List following

```
GET /v1/follows/following?follow_type=FOLLOW_TYPE_RESTAURANT&page=0&size=20
```

`200` → `{following: [{followee_id, follow_type, created_at}], page_response}`

## 13. Following count

```
GET /v1/follows/following_count?follow_type=FOLLOW_TYPE_RESTAURANT
```

`200` → `{"count": "1"}`. The count is a **string**.

## 14. Get followers

```
GET /v1/follows/{followee_uuid}/followers?follow_type=FOLLOW_TYPE_RESTAURANT&page=0&size=20
```

`200` → `{followers: [{follower_urn, created_at}], page_response}`

## 15. Follower count

```
GET /v1/follows/{followee_uuid}/follower_count?follow_type=FOLLOW_TYPE_RESTAURANT
```

`200` → `{"count": "1"}`

## 16. Unfollow

```
POST /v1/follows/unfollow
{"followee_id":"{uuid}","follow_type":"FOLLOW_TYPE_RESTAURANT"}
```

`200` → `{"status": true}`

---

## 17. Block user

```
PUT /v1/blocks
{"blocked_user_urn":"urn:explorex:users:{uuid}"}
```

`blocked_user_urn` must be a user URN. `200` → `{"status": true}`

## 18. List blocked users

```
GET /v1/blocks?page=0&size=20
```

`200` → `{blocked_users: [{blocked_user_urn, created_at}], page_response}`

## 19. Unblock user

```
POST /v1/blocks/unblock
{"blocked_user_urn":"urn:explorex:users:{uuid}"}
```

`200` → `{"status": true}`

---

## 20. Get current user

```
GET /dd/v1/users/current
Authorization: $ACCESS_TOKEN
```

`200` → `{response: DinerProfile}`: by far the largest response. It inlines full restaurant,
membership and gallery objects for every `restaurant_memberships` entry.

```json
{
  "response": {
    "first_name": "Pritam", "last_name": "Khan3", "gender": "MALE", "dob": "1995-01-07",
    "status": "STATUS_ACTIVE",
    "dp_url": "https://static.stage.explorex.co.in/{user}/{id}.jpeg",
    "uuid": "42a571e6-…", "urn": "urn:explorex:users:42a571e6-…",
    "overall_visit_count": "0", "overall_transaction_count": "344",
    "firebase_user_id": "…", "phone_number": "+91…", "razorpay_id": "cust_…",
    "whatsapp_consent_given": true, "pep_member": true,
    "elite_membership": {
      "member": true, "uuid": "…", "user_id": "…",
      "valid_from": "1729187618000", "valid_till": "1792259618000",
      "source": "ELITE_MEMBERSHIP_SOURCE_DD", "source_urn": "urn:explorex:orders:…"
    },
    "restaurant_memberships": [
      {
        "uuid": "…", "valid_from": "…", "valid_till": "…",
        "source": "RESTAURANT_MEMBERSHIP_SOURCE_DD", "account_id": "…", "membership_id": "…",
        "membership_details": {
          "name": "Gotham City Membership", "price": "5000000", "discount_percentage": 40000,
          "card_image_url": {"file_path": "…", "preview_url": "…"},
          "card_text_color_theme": "MEMBERSHIP_CARD_COLOR_THEME_WHITE",
          "status": "STATUS_ACTIVE", "uuid": "…",
          "restaurant_ids": ["…"],
          "restaurants": [ "<full Restaurant object, see below>" ],
          "applicable_dish_types": ["DISH_ITEM_TYPE_FOOD", "…"],
          "applicable_categories": [{"dish_item_type": "…", "display_name": "food"}]
        }
      }
    ]
  }
}
```

A `Restaurant` has ~150 fields, mostly POS concerns (KOT printing, tax templates, payment
modes, telegram alerts). The diner app reads only `uuid`, `name`, `area`, `city`,
`description`, `logo_picture_url`, `galleries[]`, `elite_gallery.*`, `details.cuisines` and
`details.restaurant_tags` (`lib/data/dtos/restaurant_parser.dart`). The app's restaurant
directory starts from these membership restaurants and reads any other id from the restaurant
catalog (`…/restaurant_catalog/restaurants/{id}`, same shape under `response`).

`price` and `discount_percentage` are fixed-point: `discount_percentage: 40000` → 40 % (÷1000).
The `price` scale is unconfirmed (docs/issues.md M10).

---

## 21. Delete feed post

Show **delete** and **edit** only when the signed-in diner is the author (`author_urn`, else
`created_by_urn`). feed_svc's `DeleteFeedPostByUUID` does not check the author, so the app
must hide both actions from everyone else. There is still no captured edit route
(`PUT /v1/feed_posts/{uuid}`).

```
DELETE /v1/feed_posts/{uuid}
Authorization: $ACCESS_TOKEN
```

`200` → `{"status": true}` (soft delete).

> **BE bug (observed 2026-09-25):** both posts the capture deleted (`40cb0d4f-…`, `7886e378-…`)
> still come back from §2 with `post_status: FEED_POST_STATUS_PUBLISHED`. Soft-deleted posts
> must be excluded from feed search.

---

## 22. Composer restaurant search

Added 2026-10-01 (customer_gateway PR #128, restaurant_catalog_svc `composer_restaurant.go`).
Private (JWT) only; there is no public route.

```
PUT /dd/v1/restaurant_catalog/restaurants/composer_search
Authorization: $ACCESS_TOKEN

{"query":"Kake Di Hatti Indiranagar",
 "user_location":{"latitude":12.9716,"longitude":77.5946},
 "page_size":20}
```

`200` → `ComposerRestaurantSearchResponse`: `{"hits":[ComposerRestaurantHit…]}` with
`uuid`, `place_id`, `name`, `address`, `latitude`, `longitude`, `image` (FileUrl), `source`
(`COMPOSER_RESTAURANT_SOURCE_CATALOG` / `_GOOGLE`), `profile_meta` (catalog hits only:
`uuid`, `display_name`, `display_image`, `logo`).

- A query under 3 characters returns no hits (catalog included). `page_size` defaults to 10,
  max 20. `user_location` only biases (20 km catalog filter, Google location bias); omit it when
  unknown.
- Catalog first. Google Places is called only when the catalog returns fewer than 5 hits. A
  Google place that matches a catalog row by name within 150 m comes back as that catalog hit
  (with the place id). Other Google hits have an empty `uuid`, a `place_id`, no image.
- Post for a Google hit with its `place_id` (§6–7); for a catalog hit with its `restaurant_id`.
- Not yet captured live in this doc (no sample response pulled; shapes from protos v0.33.84).

---

## Phase01 endpoint set

phase01 calls the union of two lists. This environment cannot read `explorexinc/elite`
(`main` or `phase01` both 404), so the union is taken from the documents below, and the
app tree was not changed.

1. Elite feed and social routes in §1–21 (the stage curl capture).
2. Dine-in routes recorded 2026-09-25 from `origin/main` @ `b971951`
   (`lib/core/constants/api_endpoints.dart`). The public ones returned HTTP 200 on stage
   with `x-api-token`. They speak proto3 JSON (`dd/v1/...`), so each needs its own DTO.

General diner sign-in on phase01 is phone number + OTP (`POST /dd/v1/authentication/otps`, `PUT /dd/v1/login/otp`). The WhatsApp magic link (`PUT /dd/v1/whatsapp/login`) is a sign-in method, and it is the forced (preferred) sign-in for dine-in and paid-QSR, so BE can use WhatsApp's customer-service window to message the user on WhatsApp. It is not a general diner sign-in option. No password route. The OTP is 6 digits for now. That length is the current value from the OTP provider and may change, so clients must not hard-code it.

| Source | Endpoint | Method | Auth |
|---|---|---|---|
| §1 | `/dd/v1/auth_tokens/refresh` | POST | refresh token |
| §2 | `/v1/public/feed_posts` | PUT | `X-API-TOKEN` |
| §3 | `/v1/feed_posts` (search) | PUT | JWT |
| §23 | `/v1/feed_posts/following/grouped_by_author` | PUT | JWT |
| §4 | `/v1/feed_posts/file_uploads` | PUT | JWT |
| §6–7 | `/v1/feed_posts` (create experience or curation) | POST | JWT |
| §8 | `/v1/feed_posts/{uuid}` | GET | JWT |
| §9–10 | `/v1/feed_posts/{uuid}/reaction` | PUT | JWT |
| §11 | `/v1/follows` | PUT | JWT |
| §12 | `/v1/follows/following` | GET | JWT |
| §13 | `/v1/follows/following_count` | GET | JWT |
| §14 | `/v1/follows/{followee_uuid}/followers` | GET | JWT |
| §15 | `/v1/follows/{followee_uuid}/follower_count` | GET | JWT |
| §16 | `/v1/follows/unfollow` | POST | JWT |
| §17 | `/v1/blocks` | PUT | JWT |
| §18 | `/v1/blocks` | GET | JWT |
| §19 | `/v1/blocks/unblock` | POST | JWT |
| §20 | `/dd/v1/users/current` | GET | JWT |
| §21 | `/v1/feed_posts/{uuid}` | DELETE | JWT, author only in the UI |
| §22 | `/dd/v1/restaurant_catalog/restaurants/composer_search` | PUT | JWT |
| main | `/dd/v1/authentication/otps` | POST | none |
| main | `/dd/v1/login/otp` | PUT | none |
| main | `/dd/v1/register/otp` | POST | none |
| main | `/dd/v1/whatsapp/login` | PUT | none |
| main | `/dd/v1/users/current` | PATCH | JWT |
| main | `/dd/v1/users/current/file_upload` | PUT | JWT |
| main | `/dd/v1/public/restaurant_catalog/restaurants/{id}` | GET | public / JWT |
| main | `/dd/v1/public/restaurant_catalog/restaurants/search` | PUT | public / JWT |
| main | `/dd/v1/public/restaurant_catalog/restaurants/{id}/live_menus` | GET | public / JWT |
| main | `/dd/v1/public/restaurant_catalog/dish_menus/search` | PUT | public / JWT |
| main | `/dd/v1/elite_discovery_configs` | GET | public / JWT |
| main | `/dd/v1/users/orders/histories` | PUT | JWT |
| main | `/dd/v1/orders/{orderId}/invoice` | GET | JWT |
| main | `/dd/v1/orders/{id}/payments/appsdk/init`, `…/payments/sdk/verify` | — | JWT |

Restaurant search (gateway `SearchRestaurantV2`) needs `page_request` and a `user_location`
(`{latitude, longitude}`) param; `search_text` is a name prefix match. It is geo-boxed and returns
only Elite-member restaurants as the slim `RestaurantDtoV2` (`uuid`, `name`, `display_name`,
`google_sub_locality`, `image`, `elite_listing_gallery`, no cuisines or city), under `response[]`.

Order history (`/dd/v1/users/orders/histories`) takes `page_request` and an optional
`restaurant_ids[]` filter; order_svc answers 400 to any `page_request.size` over 10, so page through it.

Feed search sends `post_types` and `cursor` as top-level fields (§2), not inside `page_request`.
Experience and curation are both created on `POST /v1/feed_posts`. A restaurant story is a
happening on those same routes. The Home stories rail is §23 (one bubble per followed author).

## Still absent from both documented lists

Not in §1–21 and not in dine-in `main` @ `b971951`. The app shows an empty state or
"coming soon" for these, never demo data (`lib/core/di/injection.dart`).

A server flag for the phase 3 tour is not a gap. The tour-seen flag stays on the device, and a reinstall may show the tour again (2026-10-01). No field is named for one. Repeating `PUT /v1/follows` or `PUT /v1/feed_posts/{uuid}/reaction` is not known to be safe. Duplicates are tolerated for now (2026-10-01).

| Area | What's missing | App seam today |
|---|---|---|
| Auth | Handle availability | Pending from BE (2026-10-01). The handle issue is expected to go away once it ships. `AuthRepository.isHandleAvailable` (always true). No path captured |
| Profile | Another user's public profile | — |
| Profile | Posts by author | Profile filters Home's loaded pages |
| Profile | Analysis metrics | Computed from loaded posts |
| Restaurants | Experience DNA + verified-experience count | `RestaurantSummary.dna` null |
| Restaurants | Live Vibe | `/restaurant/:id/vibe` empty |
| Restaurants | Reserve a table | Toast |
| Feed | Guest-readable single post | `GET` §8 requires a JWT |
| Feed | Edit route (`PUT /v1/feed_posts/{uuid}`) | Edit hidden except for the author, and the route is not captured |
| Feed | Drafts, report-post | Guests get no server drafts (2026-10-01). Signed-in server drafts come later. In-memory drafts; no report. No draft route captured |
| Feed | Search must hide soft-deleted posts | §21 bug |
| Create | Happening / restaurant-story sample body | No happening create sample; the stories rail is §23 |
| Create | Enrichment trait read-back | "What we read" card hidden |
| Create | `cover_media_id` echo, Google-place import | Cover re-uploaded; non-partner places deferred |
| Create | Bill-photo (OCR) visit verification; a partner flag on `ComposerRestaurantHit` | Google and non-partner picks show "Upload your bill · FE/NA"; partner = catalog hit |
| Create | `image` on Google `ComposerRestaurantHit`s (catalog fetches the Places photo only at ensure/create time) | The app reads the photo itself from Places API (New) with `google_places_api_key` (`GooglePlacePhotos`): one Place Details call per Google hit per session |
| Tokens | Balance, ledger, Amplify | Wallet card hidden; "Amplify is coming soon." |
| Other | Push registration, city list / geocode | No push; fixed Bengaluru lat/lng |
