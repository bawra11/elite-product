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
- Both `user_location` and a non-empty `visibility_tags` are required (400 `feed_svc_4` otherwise),
  unless the request has `author_urn` (below). `size: 0` means 10.

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


**By author (profiles).** A `request` key `author_urn` (a string:
`urn:explorex:users|restaurants|brands:{uuid}`) lists that author's published **public** posts, and needs neither `user_location` nor `visibility_tags` (feed_svc `stage`,
`61fec56`). `post_types` and the `cursor` still apply. Both Profiles use it, one request per tab, each
with its own list and `cursor` (nothing is filtered on the device): Experiences sends
`["FEED_POST_TYPE_EXPERIENCE"]`, Curations `["FEED_POST_TYPE_CURATION"]`, 20 a page, and the
visible tab asks for its next page on scroll. Own Profile's Curations reads up to 5 pages at once
to merge them with this session's drafts. Private posts never come back, so a private curation shows only on the device that saved it.

```bash
curl -sS -X PUT "$BASE/v1/feed_posts" \
  -H 'Content-Type: application/json' -H 'x-app-name: elite-app-ios' -H 'x-app-version: 1.0.0' \
  -H "Authorization: $ACCESS_TOKEN" \
  -d '{"page_request":{"page":0,"size":20},"cursor":"","post_types":["FEED_POST_TYPE_EXPERIENCE"],
       "request":[{"key":"author_urn","value":"urn:explorex:users:42a571e6-3eaf-4876-97c4-e2851334ba49"}]}'
```

**By restaurant (place profile).** A `request` key `restaurant_id` (the bare uuid, or
`urn:explorex:restaurants:{uuid}`) lists the public posts that tag that place: an experience's
`payload.experience.restaurant_id` or a curation member's (feed_svc `stage`, `13b63c1`). The place
profile's Experiences grid sends it with `["FEED_POST_TYPE_EXPERIENCE"]`, 20 a page, and pages on
scroll with its own `cursor`; the device filters by neither type nor place (it only hides blocked
diners). Both listing keys are ranked by score unless the request carries a `sort_param`, which
orders by `published_at`; the app sends none.

```bash
curl -sS -X PUT "$BASE/v1/feed_posts" \
  -H 'Content-Type: application/json' -H 'x-app-name: elite-app-ios' -H 'x-app-version: 1.0.0' \
  -H "Authorization: $ACCESS_TOKEN" \
  -d '{"page_request":{"page":0,"size":20},"cursor":"","post_types":["FEED_POST_TYPE_EXPERIENCE"],
       "request":[{"key":"restaurant_id","value":"45e971cd-f86b-4894-a5ce-32403af36629"}]}'
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

`PUT /v2/feed_posts/file_uploads` (customer_gateway `2779031`, 2026-10-22; feed_svc `21e28d5`) is the same
call, with object names stored under `az/` (Azure). `PUT /dd/v2/users/current/file_upload` does the same for
the profile photo (gateway `b3b39cb`). The app still calls the v1 routes.

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

## 24. Profile metadata (user, restaurant, brand)

Added 2026-10-08 (customer_gateway `feat/profile-metadata-routes` @ `fe6ac0a`, protos `8bc7853`,
protos_dart `a0dbc6e`). The app calls all three (protos_dart `v0.34.25`): user for Profile (own
counts) and the diner's public profile, brand for the brand profile, and restaurant (since
2026-10-11) for the place profile's counts strip, its `Experiences · n` and a cover fallback.

```
GET /v1/public/users/{user_uuid}/profile_metadata          X-API-TOKEN
GET /v1/public/restaurants/{restaurant_id}/profile_metadata X-API-TOKEN
GET /v1/public/brands/{uuid}/profile_metadata              X-API-TOKEN
GET /v1/users/{user_uuid}/profile_metadata                 JWT
GET /v1/restaurants/{restaurant_id}/profile_metadata       JWT
GET /v1/brands/{uuid}/profile_metadata                     JWT
```

`200` → `{"response": <*ProfileMetadata>}` (`Get*ProfileMetadataResponse`). All three verified live on
stage 2026-10-11. The public routes also accept the `X-API-TOKEN` header (not only basic auth). An
unknown id is `400` `{"service":"user_svc_v2","description":"record not found"}`. Sample:

```json
{"response":{"uuid":"300169b3-…","display_name":"Abhijit Ghosh",
 "display_image":{"file_path":"…/a385e3ba-….jpeg","preview_url":"https://static.stage.explorex.co.in/…"},
 "experience_count":16,"verified_experience_count":6,"worth_it_count":13,"helpful_count":0,
 "unhelpful_count":0,"impression_count":0,"follower_count":1,"following_count":7}}
```

Fields:

- `UserProfileMetadata`: `uuid`, `display_name`, `display_image`, plus totals over the diner's
  published public experiences: `experience_count`, `verified_experience_count`,
  `worth_it_count`, `helpful_count`, `unhelpful_count`, `impression_count`; and live
  `follower_count`, `following_count` (following spans users, restaurants and brands).
- `RestaurantProfileMetadata`: `uuid`, `display_name`, `display_image`, `logo`, `account_id`,
  `franchise_id`, plus its own happenings (`happening_count`, `helpful_count`,
  `unhelpful_count`, `impression_count`), experiences that name it (`experience_about_count`,
  `experience_about_impression_count`), curations that include it (`curation_about_count`), and
  live `follower_count`.
- `BrandProfileMetadata`: `uuid`, `display_name`, `display_image`, `curation_count`,
  `happening_count`, `helpful_count`, `unhelpful_count`, `impression_count`, live `follower_count`.

Follower/following counts are read from Redis on each call, not stored on the row. Restaurants and
brands are followees only, so they have no following count. Counts are `uint32`; proto3 JSON
renders them as numbers, unlike the string counts of §13 and §15, and omits zeros.

Since protos `3fe8e2c5` / protos_dart `v0.34.32` (2026-10-14), `UserProfileMetadata` also carries the
public social-ladder badge: `status_level`, `status_tier` (`UserStatusTier`) and `status_tier_name`
(e.g. "Tastemaker II"). Exact Status XP is never on this response; it's on §26 for the diner only. The
public diner profile's Level pill reads `status_level`.

Since protos `581e3904` + `84395a77` / protos_dart `v0.34.35`–`v0.34.36` (2026-10-15; customer_gateway
`471aed4` and restaurant_catalog_svc `d72d04b7` only bump protos), `RestaurantProfileMetadata` also carries
the daily insights explorex-data-tools writes (IST): `worth_it` (`WorthItDto`: `score` 0–100,
`score_date`, `recommend_count`, `not_recommend_count`, `decaying`), `worth_it_trend` (`WorthItTrendDto`:
`direction`, `delta` = today − yesterday in points, `reason`, `points[]` of `{date, score}`, oldest first,
up to 90 days), `experience_dna` (`ExperienceDnaDto`: `available` once 3 axes are eligible, `axes[]` of
`{axis, mentions, positive, percent, eligible}`; axes SERVICE, FOOD, HYGIENE, AMBIENCE, VIBE, VALUE; an axis is
eligible at 3+ mentions), and `outlet_avg_bill_90d` (paise) with its `_sample_size` / `_as_of_date`. The app
(protos_dart `v0.34.37`) reads §24 beside every catalog place read (`RemoteDiscoveryRepository.restaurant`)
and treats a place as unscored with no `score_date`, no trend points, or DNA not `available`.

Captured live 2026-10-15 (public route, `X-API-TOKEN` + `x-app-name: elite-app-ios` + `x-app-version`; any
other `x-app-name` is `403`). CBB2 `45e971cd-…`: `worth_it {score: 5, recommend_count: 13,
not_recommend_count: 3, decaying: true}`, trend `FALLING`, `delta: 0`, reason "declining due to inactivity",
45 points; DNA `available` with 5 eligible axes (HYGIENE 0 mentions); `outlet_avg_bill_90d: "21836"` paise
(int64, so a JSON string) over 14 bills. Unscored places send `worth_it`/`worth_it_trend`/`experience_dna`
as `null` and `outlet_avg_bill_90d: "0"` with an empty `_as_of_date`. User §24 now also sends
`curation_count`.

The app shows: `curation_count` as the Profile Curations cell and the public profile's "public lists";
`outlet_avg_bill_90d` as `₹n avg bill` on the place title line (left out at 0); `direction` as
"Rising" / "Falling" when `delta` is 0.

**BE drift (2026-10-15):** `worth_it.score` doesn't match its own counts. CBB2 scores 5 with 13 of 16
recommending, so the place shows "95% said Not worth it". La Casa and The Bier Library score 0 with 1
recommend and 0 not. Decay seems to drive the score toward 0, while the app (and the design) read `score`
as the share of diners who said Worth it. BE needs to confirm what `score` is. `direction: FALLING` with
`delta: 0` is also unexplained.

---

## 26. Elite Token wallet (diner)

Added 2026-10-14 (customer_gateway `686e438`, `pkg/handlers/user_token_wallet.go`; protos `3fe8e2c5`;
protos_dart `v0.34.32`). user_svc owns the wallet and every amount. The app calls the four reads
below (`RemoteWalletRepository`). It doesn't call debit: the only spend SKUs are Amplify tiers, and
Amplify goes through feed_svc's routes (§27). All private, JWT (raw, no `Bearer`).
All four answer `403` without a JWT on stage (deployed; an unknown path is `404`). Bodies not yet
captured live with a diner token.

```
GET  /v1/token_wallet                          → GetUserTokenWalletByUserIdResponse
GET  /v1/token_wallet/transactions?page=0&size=20  → SearchUserTokenWalletTransactionsResponse
GET  /v1/token_wallet/earn_policy              → GetUserTokenWalletEarnPolicyResponse
GET  /v1/token_wallet/transaction_item_rates   → GetAllUserTokenWalletTransactionItemRatesResponse
POST /v1/token_wallet/debit                    DebitUserTokenWalletRequest (user_id set by the gateway)
```

`page`/`size` default to 0/20 when both are absent. Each body is `{"response": …}`; the ledger adds
`page_response` (`total`, `has_next_page`).

- `UserTokenWalletDto`: `token_balance`, `status`, and Status XP for the diner's own profile only:
  `status_xp` (lifetime confirmed earn), `status_level`, `status_tier`, `status_tier_name`,
  `xp_into_level`, `xp_to_next_level`. **Assumed:** `xp_to_next_level` is XP still needed (not the
  band size); the bar is `into / (into + to_next)`. No BE doc pins this yet.
- `UserTokenWalletTransactionDto`: `amount`, `remaining` (unspent part of a CREDIT lot; FIFO spend and
  expiry), `transaction_type` (CREDIT / DEBIT), `transaction_item`, `reference_urn`, `description`,
  `created_at`, `expires_at` (epoch ms), `counts_to_lifetime`.
- `UserTokenWalletEarnPolicyDto`: `categories[]` (`transaction_item`, `amount`; the Elite-payment
  formula uses `percent`, `cap`, `min_bill_amount` in ₹ with `amount` 0), `earn_title_min_runes`,
  `earn_body_min_runes`, `earn_unverified_max_rolling_7d`, `earn_unverified_max_month`,
  `earn_curation_max_month`, `earn_curation_min_members`, `earn_curation_min_experiences`,
  `earn_token_expiry_ms`. The UI never hard-codes an amount; it reads this.
- `UserTokenWalletTransactionItemRateDto`: `transaction_item`, `transaction_item_rate` (the spend
  catalogue: `SPEND_AMPLIFY_QUICK` / `_MOMENTUM` / `_SPOTLIGHT`).

Credits land as available balance at once (no pending state), so the app has no Pending figure. There
is no Token store or top-up route, and no purchased/bonus lots.

Drift from the app's earlier design model: the app's curation reward rule (title, description, cover,
`CurationDraft.rewardSpots` = 5 places) predates the policy; user_svc's rule is
`earn_curation_min_members` places and `earn_curation_min_experiences` experiences, capped
`earn_curation_max_month`. The app shows the policy's amount but still checks its own rule. Unverified
caps (`max_rolling_7d`, `max_month`) are user_svc-side, so the published screen shows what a post
qualifies for, not whether this month's cap is spent.

---

## 27. Elite Amplify (diner)

Added 2026-10-15 (customer_gateway PR #139; placement in feed_svc PRs #22–#24; protos_dart
`v0.34.32`, `feedsvc.v1`). Any signed-in diner can sponsor (buy) an Amplify on any public
**experience**, their own or someone else's. Buying debits the Token wallet (§26) at once. Amplify
buys labelled extra distribution only. All private, JWT (raw, no `Bearer`). Captured live on stage
2026-10-15 with the static stage OTP phone. The app calls these through `RemoteAmplifyRepository`.

```
GET  /v1/feed_posts/{feed_post_id}/amplify/eligibility  → GetAmplifyEligibilityResponse
POST /v1/feed_posts/{feed_post_id}/amplify               CreateAmplifyRequest → CreateAmplifyResponse
GET  /v1/amplifications/{uuid}                           → AmplificationDto
PUT  /v1/amplifications/search                           ListAmplifiesRequest → ListAmplifiesResponse
POST /v1/amplifications/{uuid}/stop                      → AmplificationDto (state STOPPED)
```

Bodies are bare (no `{"response": …}` wrapper). Create wraps its answer as `{"amplification": …}`; GET
answers the bare DTO. Stop's success body is not captured yet (BE says it is the DTO; the app reads
either shape). Stopping an amplification that already stopped answers `400`.

- Eligibility: `eligible`, `reason_codes[]` (`NOT_FOUND` · `NOT_EXPERIENCE` · `NOT_PUBLIC` ·
  `QUEUE_FULL`), `queue_depth`, and `tiers[]` (`AmplifyTierInfo`: `tier`, `token_price`,
  `duration_days`, `target_impressions`, `available`, `unavailable_reason`). Tiers are always listed,
  even when not eligible. Stage today: Quick 150 / 3 days / 250 · Momentum 350 / 7 / 750 ·
  Spotlight 700 / 14 / 2000. The UI reads these, never hard-codes them.
- Create body: `{"tier": "AMPLIFY_TIER_QUICK", "idempotency_key": "…"}`. The same key returns the same
  amplification, so the app keeps one key per sheet and tier and reuses it on retry.
- `AmplificationDto`: `uuid`, `feed_post_id`, `sponsor_user_id`, `author_urn`, `tier`, `state`
  (`SCHEDULED` = queued behind a live one, max 3 per post · `ACTIVE` · `PAUSED` · `COMPLETED` · `STOPPED`
  · `TERMINATED`), `token_price`, `target_impressions`, `delivered_impressions`, `start_at`, `end_at`,
  `original_end_at` (epoch ms), `extension_count`, `queue_position`, `restaurant_id`,
  `idempotency_key`, `created_at`, `end_reason` (`"stopped"` after a stop).
- Search body: one of `{"as_sponsor": true}` (my purchases), `{"as_author": true}` (Amplifies on my
  posts), `{"feed_post_id": "…"}` (every sponsor's, on that post); optional `page_request`. The app
  reads `feed_post_id` and keeps the rows whose `sponsor_user_id` is the wallet's `user_id`. Profile's
  `This month` card sends `as_sponsor` and counts the rows whose `created_at` is in this calendar month
  (first page only; no date filter on the request).
- Placement (§2, §3, §23 and the public follow feed): every 5 cards are 3 organic + 2 amplified;
  amplified posts carry `FeedPostDto.amplification_id` + `amplify_sponsor`. Organic results exclude
  ACTIVE amplified posts. The app does not label amplified feed cards yet.

**BE drift:** buying with too few Tokens answers **HTTP 500** `{"service": "user_svc_v2", "code":
"30", "description": "insufficient Elite Token balance"}`, not a 4xx. The app checks the balance before
buying and treats a 500 from create as a failed buy.

---

## 25. Unified search

customer_gateway `GlobalSearchHandler` (PR #132; catalog global dish search #579–#581). One query
across six verticals, one section per vertical. The app's Search screen and Home's search CTA use it
(`GlobalSearchRemoteDataSource`); guests use the public route.

```
PUT /v1/search            JWT
PUT /v1/public/search     X-API-TOKEN (+ x-app-name / x-app-version)

{"query":"ctb","verticals":["dishes","restaurants","users","experiences","curations","happenings"],
 "page_size":5,"user_location":{"latitude":12.97,"longitude":77.59},"visibility_tags":["ALL"]}
```

`200` → a gateway-built JSON object (no proto wraps it): `{<vertical>: {items: [...], total}}` for each
vertical asked, or `{<vertical>: {error: "…"}}` when that vertical failed on BE (the others still
answer). Items are protos: `RestaurantDtoV2`, `DishMenuDto` (with `restaurant_name`, hydrated from
Redis), `UserDto`, `FeedPostDto`. `user_location` is required for restaurants and every feed vertical.
The app parses each item on its own (a bad hit is skipped) and drops the feed `embedding`. Verified
live on stage 2026-10-15.

Since customer_gateway `534abdc` and restaurant_catalog_svc `4eb70598` (2026-10-16), dish search gets
`user_location` and only returns dishes from nearby restaurants with a live menu. The `users` section's
`UserDto` carries `username` (§28), and a query matches it (`qadiner0303` finds that diner, captured
2026-10-24).

---

## 28. Username (diner handle)

Added 2026-10-16 (customer_gateway PR #143 `256ecd8`; protos `89c31354`; protos_dart `v0.34.41`, the
app pins `v0.34.43`). Phone stays the account key; the username is an optional public handle.

```
PUT /v1/public/users/username/availability   CheckUsernameAvailabilityRequest   X-API-TOKEN
PUT /v1/users/username/availability          (same)                             JWT
PUT /v1/users/current/username               SetUsernameRequest → UserResponse  JWT (user from the JWT)
GET /v1/public/users/by_username/{username}  → UserResponse                     X-API-TOKEN
GET /v1/users/by_username/{username}         → UserResponse                     JWT
```

Availability is advisory (nothing is held). Body `{"username": "…"}`; the answer is bare
`CheckUsernameAvailabilityResponse` (no `response` wrapper): `available`, `reason`
(`USERNAME_AVAILABILITY_REASON_AVAILABLE` · `TAKEN` · `INVALID_FORMAT` · `RESERVED`) and
`normalized_username` (lowercased). Captured live on the public route 2026-10-24: `AbCd` → `abcd`
available; `admin`, `elite`, `explorex`, `support`, `root`, `null` reserved. The format BE accepts:
3–30 characters of `a-z 0-9 _ .`, a digit may lead (`1abc`, `123` are valid), no leading or
trailing `_` / `.`, no `__` or `..` (`a._b` is valid). The first claim is free; changes respect a
cooldown. The by-username lookup blanks phone, Razorpay and Firebase ids; an unknown name is **HTTP
500** `{"code": "37", "description": "user not found for username"}`, not a 404.

Where the handle comes back: `UserDto.username` (§20 `users/current`, search users, by-username) and
`UserProfileMetadata.username` (§24, and so `FeedPostAuthorDto.profile_meta.user` on every feed post
and `FollowerDto.profile_meta.user`, §29). Empty when unclaimed.

The app checks availability on the name screen (public route, debounced), claims the typed handle
right after the first sign-in when the account has none (`SessionCubit.syncHandle`), and otherwise
adopts the account's username. Diners show as their picture and `@username` (display name when they
have none); profile headers show the name with `@username` under it. The app doesn't call by-username.

---

## 29. Follower / following lists (not used by the app yet)

customer_gateway PR #142 (protos `5e90ce70`). Paged with `?page=&size=`; following also takes
`follow_type`. Bodies are bare (no `response` wrapper).

```
GET /v1/public/users/{user_uuid}/followers           X-API-TOKEN   (JWT: /v1/users/…)
GET /v1/public/users/{user_uuid}/following[?follow_type=]
GET /v1/public/users/{user_uuid}/following_count
GET /v1/public/restaurants/{restaurant_id}/followers
GET /v1/public/restaurants/{restaurant_id}/following
GET /v1/public/restaurants/{restaurant_id}/following_count
```

Captured live 2026-10-15: `{"followers": [{"follower_urn", "created_at", "user": UserProfileMetadata}]}`,
so each row carries the follower's name, image, counts and ladder badge. Profile's Followers cell still
toasts "coming soon"; this is the route a followers list would read.

## Feed moderation (feed_svc, 2026-10-15)

protos `9199c740` (#1170): feed_svc now runs async UGC moderation (text + images) before enrich and
publish. `FeedPostStatus` gains `FEED_POST_STATUS_PENDING_MODERATION` (4, not discoverable yet) and
`FEED_POST_STATUS_REJECTED` (5), and `meta_data.moderation` (`FeedPostModeration`: `decision`
ALLOW / REVIEW / HIDE, `version`, `decided_at`, text and per-asset results, `enforced`) is on the post.
Enforcement is on in stage. The app doesn't read `post_status` beyond PUBLISHED yet, so a just-created
post that is still pending, or rejected, is not told apart on Profile. Post `enrichment.tags` can also
carry moderation labels (`nsfw` seen on stage). feed_svc PR #25 / catalog `AdjustRestaurantFeedProfileCounts`
keep the §24 per-type counts in step with deletes and moderation.

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
| §24 | `/v1/public/{users,restaurants,brands}/{id}/profile_metadata` | GET | `X-API-TOKEN` |
| §24 | `/v1/{users,restaurants,brands}/{id}/profile_metadata` | GET | JWT |
| §25 | `/v1/search`, `/v1/public/search` | PUT | JWT / `X-API-TOKEN` |
| §26 | `/v1/token_wallet`, `/transactions`, `/earn_policy`, `/transaction_item_rates` | GET | JWT |
| §27 | `/v1/feed_posts/{id}/amplify[/eligibility]`, `/v1/amplifications/{search,{uuid},{uuid}/stop}` | GET/POST/PUT | JWT |
| §28 | `/v1/public/users/username/availability` | PUT | `X-API-TOKEN` |
| §28 | `/v1/users/current/username` | PUT | JWT |
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

Not in §1–29 and not in dine-in `main` @ `b971951`. The app shows an empty state or
"coming soon" for these, never demo data (`lib/core/di/injection.dart`).

A server flag for the phase 3 tour is not a gap. The tour-seen flag stays on the device, and a reinstall may show the tour again (2026-10-01). No field is named for one. Repeating `PUT /v1/follows` or `PUT /v1/feed_posts/{uuid}/reaction` is not known to be safe. Duplicates are tolerated for now (2026-10-01).

| Area | What's missing | App seam today |
|---|---|---|
| Profile | Another user's public profile beyond §24's name, image and totals (bio) | — |
| Profile | Per-month counts: verified experiences and helpful this month (§24 has lifetime totals only) | `This month` cards show FE/NA |
| Profile | Aggregated top tags (post `enrichment.tags` also carry moderation tags such as `nsfw`) | Analysis "Top tags · FE/NA" |
| Tokens | Loyalty balance; an earn category for completing the profile | FE/NA on the token card and the Verified screens |
| Restaurants | Verified-experience count (§24 has `experience_about_count`, not a verified count) | DNA correction "one mention among FE/NA" |
| Restaurants | Opening hours: `RestaurantDto.restaurant_timings` exists but is absent from the diner catalog GET | "Open till FE/NA" |
| Restaurants | Rolling 30-day experience count; diners served | Trend card "Last 30 days" and curation detail "diners served" FE/NA |
| Restaurants | Deals / offers, loyalty programme | Place benefits rows FE/NA |
| Restaurants | Live Vibe outside a live table | "No update" |
| Restaurants | Reserve a table (`booking_svc` protos exist, no gateway route) | `UnavailableReservationRepository` (FE/NA) |
| Pay | Pay at a place / the bill after a reservation | `UnavailableBillRepository` (FE/NA); the at-table pay is the real dine-in pay |
| Elara | Any assistant endpoint | `UnavailableElaraRepository` (FE/NA) |
| Feed | Guest-readable single post | `GET` §8 requires a JWT |
| Feed | Edit route. feed_svc has `UpdateFeedPost` (`4b563a4`, 2026-10-16; protos #1171), but customer_gateway exposes no route for it | Edit hidden except for the author |
| Feed | Drafts, report-post | Guests get no server drafts (2026-10-01). Signed-in server drafts come later. In-memory drafts; no report. No draft route captured |
| Feed | Search must hide soft-deleted posts | §21 bug |
| Create | Happening / restaurant-story sample body | No happening create sample; the stories rail is §23 |
| Create | Enrichment trait read-back at publish (`enrichment.experience_dna_axes` lands later, async) | "What we read" card FE/NA |
| Create | `cover_media_id` echo, Google-place import | Cover re-uploaded; non-partner places deferred |
| Create | Bill-photo (OCR) visit verification; a partner flag on `ComposerRestaurantHit` | Google and non-partner picks show "Upload your bill · FE/NA"; partner = catalog hit |
| Create | `image` on Google `ComposerRestaurantHit`s (catalog fetches the Places photo only at ensure/create time) | No image: the app doesn't call Google Places for a photo (removed 7 Oct 2026), so the hit shows the restaurant's initial until BE sends an `image` |
| Tokens | Token store / top-up | Wallet live on §26 (2026-10-14); Amplify live on §27 (2026-10-15); no Top up |
| Other | Push registration, city list / geocode | No push; fixed Bengaluru lat/lng |
