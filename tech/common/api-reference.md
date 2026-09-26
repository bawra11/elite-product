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
- The feed mixes post types: `FEED_POST_TYPE_EXPERIENCE` and `FEED_POST_TYPE_CURATION` both
  come back. feed_svc (stage) also reads an optional top-level `post_types` list
  (`["FEED_POST_TYPE_CURATION"]`) to filter server-side; not yet exercised on stage.
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
- experience: `payload.experience.restaurant_id`, `title` and `body` are all required;
- curation: `title` required; at most **15** `members`, each with a `restaurant_id`, no
  duplicates; a published curation needs at least one. `position` is reassigned from order;
- every media needs a non-INVALID `media_type` and a `raw_media_url.file_path`.

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

> Only `HELPFUL` and `NONE` appear in either capture. The app sends
> `FEED_POST_REACTION_UNHELPFUL` for "Not helpful", which is **still unconfirmed** (docs/issues.md M6).

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
`details.restaurant_tags` (`lib/data/dtos/restaurant_parser.dart`). **This is the only
restaurant data stage serves today**, so the app's restaurant directory is built from it.

`price` and `discount_percentage` are fixed-point: `discount_percentage: 40000` → 40 % (÷1000).
The `price` scale is unconfirmed (docs/issues.md M10).

---

## 21. Delete feed post

> **BE security gap:** feed_svc's `DeleteFeedPostByUUID` does not check that the caller wrote
> the post, so any signed-in diner can delete any post. Only offer delete on the diner's own posts,
> and get BE to add an author check.

```
DELETE /v1/feed_posts/{uuid}
Authorization: $ACCESS_TOKEN
```

`200` → `{"status": true}` (soft delete).

> **BE bug (observed 2026-09-25):** both posts the capture deleted (`40cb0d4f-…`, `7886e378-…`)
> still come back from §2 with `post_status: FEED_POST_STATUS_PUBLISHED`. Soft-deleted posts
> must be excluded from feed search.

---

## Already on stage: endpoints the dine-in app (`origin/main`) uses

Checked 2026-09-25 against `origin/main` @ `b971951` (`lib/core/constants/api_endpoints.dart`).
The public ones were confirmed live on stage (HTTP 200 with `x-api-token`, no JWT). These close
several gaps below without new BE work. Note that they speak **proto3 JSON** (`dd/v1/...`), not the
feed service's shapes, so each needs its own DTO.

| Gap in Elite | Endpoint on stage | Method | Auth | Verified live |
|---|---|---|---|---|
| OTP request | `/dd/v1/authentication/otps` (`GenerateOtpRequest`, WhatsApp, purpose LOGIN) | POST | none | code only |
| OTP verify → tokens | `/dd/v1/login/otp` (`ValidateOtpRequest`) → `DDUserLoginWithOtpResponse` | PUT | none | code only |
| First-time sign-up | `/dd/v1/register/otp` (`otp_validation_attempt_uuid` + first/last name, phone, dob) | POST | none | code only |
| WhatsApp magic-link login | `/dd/v1/whatsapp/login` (`uuid`) | PUT | none | code only |
| Update the diner (name, dob, gender, avatar) | `/dd/v1/users/current` (`UserDto`) | **PATCH** | JWT | code only |
| Avatar upload URL | `/dd/v1/users/current/file_upload` then S3 PUT | PUT | JWT | code only |
| Restaurant by id | `/dd/v1/public/restaurant_catalog/restaurants/{id}` (and non-public) | GET | public / JWT | **yes**: CTB, with details and galleries |
| Restaurant search | `/dd/v1/public/restaurant_catalog/restaurants/search` (and non-public), `page_request` + `request[]` incl. `user_location` | PUT | public / JWT | **yes**: 5 Bengaluru results |
| Live Menu | `/dd/v1/public/restaurant_catalog/restaurants/{id}/live_menus` (and non-public), then dishes via `/dd/v1/public/restaurant_catalog/dish_menus/search` (`menu_ids`, `restaurant_ids`, `x-restaurant-id` headers) | GET, PUT | public / JWT | **yes**: CTB's menus |
| Discovery filters and sorts | `/dd/v1/elite_discovery_configs` | GET | public / JWT | **yes** |
| Diner's visits (for verified experiences) | `/dd/v1/users/orders/histories` (`page_request`, `restaurant_ids`) | PUT | JWT | code only |
| Bill line items (dish tags) | `/dd/v1/orders/{orderId}/invoice` (`x-account-id`, `x-franchise-id`, `x-restaurant-id`) | GET | JWT | code only |
| Pay a bill | `/dd/v1/orders/{id}/payments/appsdk/init`, `…/payments/sdk/verify` | — | JWT | code only |

Not on `main` either (still needs BE): handle availability, public profiles, posts by author,
Experience DNA, Live Vibe, reserve a table, post-type filter and cursor field, guest single post,
post update/drafts/report, trait read-back, restaurant stories, tokens and Amplify, and push
registration (`main` doesn't register push at all).

## Missing endpoints the app expects

Every item is wired in the app behind a repository interface. Until BE ships it, the app shows
an empty state or "coming soon", never demo data (see `lib/core/di/injection.dart`).

| Area | Endpoint needed | App seam today | Blocks |
|---|---|---|---|
| **Auth** | OTP request (`phone` → challenge id, code length, resend-after) | `AuthRepository.requestOtp`; stub in debug | Any sign-in on a release build |
| | OTP verify (→ access + refresh token) | `AuthRepository.verifyOtp` | Same |
| | Handle availability (`GET …?handle=`) | `AuthRepository.isHandleAvailable` (always true) | Unique handles |
| **Profile** | Update the diner (display name, handle, DOB, gender, avatar) | Naming is saved on-device only; "Save profile" does nothing | Real identity on posts; `author.display_name` is `""` everywhere |
| | Another user's public profile | — | Tapping a curator or author |
| | Posts by author (the diner's own, and others') | Profile filters Home's loaded pages | A real "My posts" list |
| | Profile analysis data | Computed from loaded posts | The "Analysis" tab |
| **Restaurants** | Restaurant by id (diner slice: name, area, cuisines, gallery, timings, tags) | `RestaurantDirectory` knows only membership restaurants | Every place row for any other restaurant shows "Restaurant" |
| | Restaurant search (text + location) | Directory search over membership restaurants | Picking a place to post about or curate |
| | Experience DNA + verified-experience count per restaurant | `RestaurantSummary.dna` null | DNA hex, "Worth it" crowd call |
| | Live Vibe (floor status), Live Menu (menu + availability) | `/restaurant/:id/vibe` and `/menu` show empty states | Live service |
| | Reserve a table, pay a bill | Toast | Transactions |
| **Feed** | A `post_type` filter on §2–3 | Client-side filter of a mixed page | Full Curation and Experience tabs; paging |
| | Confirmed cursor field for `next_cursor` | Sent as `page_request.cursor` | Infinite scroll (H2) |
| | Public single post (guest-readable §8) + share URL scheme | Guest sees only cached posts | Shared links, deep links |
| | Confirm `FEED_POST_REACTION_UNHELPFUL` | Sent as-is | "Not helpful" (M6) |
| | Update a post (`PUT /v1/feed_posts/{id}`) | Published curations are read-only | Editing a curation, fixing a typo |
| | Draft status on create/list | Drafts kept in memory on the device | Drafts across devices and restarts |
| | Report a post | — | App-store UGC requirement |
| | Exclude soft-deleted posts from §2–3 | — | §21 working (BE bug above) |
| **Create** | Diner's visits per restaurant, with verification state | Returns none, so every post is unverified | Verified experiences, dish tags |
| | Bill line items for a visit | Returns none | Dish tags |
| | Enrichment trait read-back + one correction per post | "What we read" card hidden | Axis edit |
| | Curation cover suggestions / `cover_media_id` echo | Cover copied from gallery and re-uploaded | — |
| | Google-place import (server-side place resolution) | Deferred (P2.13) | Curating non-partner places |
| **Discovery** | Curations list (with `post_type` filter or dedicated) | Filtered from the feed | Curation paging |
| | Restaurant stories (list, by id) + stories rail | Empty states | Stories |
| **Tokens** | Balance, ledger, award on publish | Card hidden / 0 awarded | Token wallet |
| | Amplify (credits, token spend, one-off payment) | "Amplify is coming soon." | Amplify |
| **Other** | Push token registration (OneSignal) | — | Notifications |
| | Location-aware ranking city list / geocode | Fixed Bengaluru lat/lng | Other cities (H6) |
