# Elite — Product Requirements

Source: founder journal, 2026-09-22. This is the canonical product brief until superseded by a newer version.

## What the app is

A community app for foodies (branded **Elite**, built on the Explorex restaurant platform). Core purpose:

1. **Discover** new and relevant restaurants.
2. Understand the **live vibe / real-time condition** — service quality, food quality, crowd.
3. Surface a simple **crowd recommendation signal**: a boolean *"worth it" / "not worth it"*, layered with AI-analyzed review context (tags, keywords, sentiment) to extract useful information automatically.

Secondary business goal: drive adoption of the existing Explorex restaurant service platform (POS/booking/membership) — this app is partly a growth/marketing surface for that platform, so deep-linking into restaurant profiles, memberships, and offers matters.

## Content model — three post types

All three live in a unified content system referred to as **posts** (see `feed_posts` API). They share a base shape (`FeedPost`) but differ by `post_type` / `payload`.

### 1. Experience (`FEED_POST_TYPE_EXPERIENCE`)
- A user's review of a restaurant visit. Core signal: `worth_it: boolean`.
- Body text is AI-enriched (`meta_data.enrichment`): sentiment, sentiment_score, tags, keywords, embedding (for similarity/search).
- **Verified experience**: when tagged to a real-world visit + bill/order number (`visit_id`, `order_id` populated, `verified: true`). Verified experiences carry extra structured tagging — dish items ordered, order details — because they're backed by a real transaction, not just a claim.
- Unverified experiences omit `visit_id`/`order_id` and `verified: false` — still valid content, just without transaction-backed proof or dish-level detail.

### 2. Curation (`FEED_POST_TYPE_CURATION`)
- A user-created **list of restaurants** with: caption (required), cover image (optional), body text (optional).
- **Brand curation**: same shape, but authored by a brand/restaurant account instead of a user. Brand curations are **promoted** content (paid/boosted placement in feed).
- Same `feed_posts` endpoints as an experience. Create body is in `tech/common/api-reference.md` §7. The title is the post's root `title`, not a field inside `payload.curation`.

### 3. Restaurant story (BE name: happening)
- Restaurant-authored post. Can include: photos, dish tags, offers, other restaurant actions/tags, and a text body.
- Functionally closer to an Instagram "post"/story from the business account.
- Product says **restaurant story**. feed_svc says **happening** (create rule: `ends_at` ≥ `starts_at`). They are the same post type, on the same `feed_posts` endpoints. No captured request body yet — see `tech/common/domain-model.md`.

> Tech note: experience and curation are both post types on stage. Restaurant stories use the BE type happening. See `tech/common/domain-model.md`.

## Reactions & social graph

- Reaction on a post: `reaction` field (not `reaction_type`), enum includes `FEED_POST_REACTION_HELPFUL`, `FEED_POST_REACTION_NONE`, `FEED_POST_REACTION_INVALID`. This is a "helpful / not helpful" style signal on the post itself, distinct from the experience's own `worth_it` boolean.
- **Follow** system: `follow_type` enum — `FOLLOW_TYPE_RESTAURANT`, `FOLLOW_TYPE_USER`, `FOLLOW_TYPE_BRAND`. Users can follow restaurants, other users, and brands.
- **Block** system: user-to-user blocking (`blocked_user_urn`).

## Onboarding — three phases

Phase boundaries matter: phase 1 is frictionless (no auth), phases 2–3 require the user to opt in.

1. **Who is the user?** — First launch. Ask only for name + username. User is immediately dropped into the Home feed to explore, unauthenticated. No gate.
2. **User's credentials** — Sign-in is phone number and OTP, or a WhatsApp magic link. No password, no email. It is *user-initiated*, triggered whenever the user tries to take an action that needs an identity (react, follow, post, etc.), not forced up front.
3. **Building initial network** — One-time tour shown immediately after first successful verification: show the user's profile, suggested establishments to follow, "create your own community" CTA, and "invite friends." Shown once, not repeated on subsequent logins.

Design implication: the app must support a **guest/anonymous session** that can browse the public feed (see `v1/public/feed_posts`, which needs only `X-API-TOKEN`, no user JWT) and a **soft upgrade path** into phases 2–3 triggered contextually.

## Navigation — 5 tabs

1. **Home** (tab 1) — default landing tab when logged in. A single feed list mixing all content types (experiences, curations, restaurant stories) plus injected dynamic modules:
   - Highlights
   - Experiences from followed users/restaurants
   - Brand curation suggestions
   - Other place suggestions
   - Brand promotions
   - (extensible slot for future modules)
   The top of Home is a row of circular bubbles. Tapping one opens the story viewer, which reuses the Discovery UI. Discovery is not its own tab or feed.
   Tapping anywhere on a feed item opens its detail view **except** the helpful/not-helpful reaction buttons, which act inline without navigating away.
2. **Experience** (tab 2) — same list UI as Home, filtered to `post_type: EXPERIENCE` only.
3. **Create** (tab 3) — not a screen, a CTA/action sheet: "create Experience" or "create Curation."
4. **Curation** (tab 4) — same list UI as Home, filtered to curations only.
5. **Profile** (tab 5) — current user's profile:
   - User details (public fields, private fields, dynamic/semi-dynamic fields e.g. membership status, visit stats)
   - Analysis (personal stats/insights — exact metrics TBD)
   - Two sub-tabs: **Experiences** and **Curations** created by this user.

## Non-negotiables

- Flutter, BLoC architecture (see `tech/common/architecture.md`).
- Production-grade stability — this is not a prototype; treat error states, offline, and empty states as first-class. Missing data shows an empty state, never demo content.
- Heavy use of micro-animations / micro-interactions — this is a differentiator, not decoration. Reactions, tab transitions, list item entry, pull-to-refresh, etc. should all feel considered.
- Secure auth + secure local storage are mandatory (JWT handling, refresh rotation — see API notes on refresh token rotation).
- Frontend is the current focus. Backend (`customer_gateway`) already exists on stage; this repo consumes it, does not reimplement it.

## Open questions / not yet specified by BE

- Happening (restaurant story) request body. The type is confirmed; a captured payload is not.
- "Analysis" tab content on profile — which metrics.
- Push notification strategy.
- Exact anonymous→authenticated session handoff (merging guest feed state into authenticated state).

Track these in `tech/common/domain-model.md` under "Unconfirmed" and revisit as BE ships more of the curl reference.

## Decisions log

- **2026-09-22 · Tabs.** We keep this brief's 5 tabs (Home · Experience · Create · Curation · Profile). The Claude Design prototype's nav (Home · Explore · Discovery · Profile) is **not** adopted. Explore is a candidate for a later phase inside Home or Search.
- **2026-09-22 · Phase 2 auth is number-only.** The design supersedes "OTP + password": *"Your number, once. No password, no email, and we won't ask again."* It is triggered only when a guest reaches into an action tied to a real person (react, follow, post, reserve, pay). Browsing, Discovery, place profiles and experiences stay open.
- **2026-09-22 · Phase 1 gains a tutorial.** After name + handle, a one-time 4-slide tutorial runs (Experience · Experience DNA · Curation · Discovery) before Home.
- **2026-09-22 · Experience DNA** (working assumption). A restaurant-level hexagonal radar of what diners mention: Service, Food and Value always, then Vibe, Presentation and Convenience when mentioned. It appears only past 100 verified experiences, is never a rating, and never appears on an individual experience.
- **2026-09-22 · Votes.** Both **Helpful** and **Not helpful** are shown on every experience (per the design). "Not helpful" assumes a `FEED_POST_REACTION_UNHELPFUL` wire value, which BE still needs to confirm.
- **2026-09-26 · Post types.** Experience and curation are both BE post types on `feed_posts`. A restaurant story is the product name for the BE type happening.
- **2026-09-26 · Auth.** Sign-in keeps phone number + OTP and the WhatsApp magic link (`PUT /dd/v1/whatsapp/login`). There is no password step.
- **2026-09-26 · Delete and edit.** The delete and edit actions are shown only when the signed-in diner is the post's author. feed_svc still does not enforce that on delete; the app must.
- **2026-09-26 · Feeds.** Home mixes experiences, curations, and restaurant stories. The Experience and Curation tabs are that same list filtered by post type.
- **2026-09-26 · Discovery.** Discovery is removed as a destination. Its UI is reused as the story viewer, opened from the circular bubbles at the top of Home.
- **2026-09-26 · Empty states.** Where data is missing, the app shows an empty state. It does not ship demo discovery content.
