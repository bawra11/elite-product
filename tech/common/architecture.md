# Architecture decisions

## Stack

- **Flutter** (managed via **FVM**, pinned per-project — see `.fvmrc` in the codebase folder, run `fvm flutter ...` instead of bare `flutter ...` so everyone on the project uses the same SDK version).
- **State management:** BLoC (`flutter_bloc`), event-driven, one Bloc/Cubit per feature-slice, not per-screen — a screen composed of several independent widgets (e.g. Home = feed list + reaction state + follow suggestions) gets several Blocs, not one god-Bloc.
- **DI:** `get_it`, hand-registered in `lib/core/di/injection.dart` (~6 singletons doesn't justify a codegen step). `injectable` was tried and dropped — its analyzer constraint conflicted with `bloc_test`'s. Revisit only once the manual registration file gets unwieldy, and pick versions that actually resolve together.
- **Networking:** `dio` (interceptors for auth header injection, refresh-token rotation, retry) + `retrofit` (codegen typed clients) over the raw curl reference in `api-reference.md`.
- **Routing:** `go_router` — declarative, supports the guest→authenticated redirect logic onboarding needs (see product-requirements.md phase 1–3) and deep links into restaurant/post detail from push notifications later.
- **Local storage/secure storage:** `flutter_secure_storage` for tokens (Keychain/Keystore-backed), `hive` (or `drift` if relational queries end up needed for offline feed caching) for everything else — never store JWTs in plain SharedPreferences.
- **Codegen:** `freezed` + `json_serializable` for immutable entities/DTOs and union types (e.g. `FeedPost.payload` is a natural `freezed` union over post_type).
- **Analytics:** Firebase Analytics through `FirebaseAnalyticsService`. The PRD §43 events live in `EliteAnalyticsEvents` and are fired with `analyticsTrack`. Impressions use `TrackImpression`, which logs once per mount when the widget is half on screen.
- **Animations:** `flutter_animate` for micro-interactions (reaction taps, list item entrance, tab transitions) layered on top of standard `AnimatedContainer`/`Hero`/implicit animations — avoid hand-rolled `AnimationController` boilerplate except where a custom curve/physics is genuinely needed (e.g. a bespoke "worth it" toggle gesture).

## Layering (per feature module)

```
lib/
  core/                     # cross-cutting: theme, routing, network client, storage, DI, error types
    theme/
      design_tokens.dart    # SINGLE SOURCE OF TRUTH for color/type/spacing/motion — swap here when Figma lands
      app_theme.dart
    network/
    storage/
    di/
    router/
  features/
    onboarding/             # phase 1-3 flows
    home/
    experience/             # tab 2 (experience-only feed) + create-experience flow
    curation/                # tab 4 + create-curation flow
    profile/
    feed_shared/             # widgets/blocs shared by home/experience/curation lists (the "post card")
    auth/                    # phone + OTP, session, token refresh
    restaurant_detail/
    pay/                     # Place Pay (typed amount; not dine-in / QSR)
    follows_blocks/
  domain/
    entities/                # freezed classes mirroring domain-model.md
    repositories/            # abstract interfaces — feature blocs depend on these, not on dio directly
  data/
    dtos/                    # json_serializable wire types, mapped to domain entities
    repositories_impl/
    datasources/             # remote (retrofit clients) + local (hive/secure storage)
```

Each `features/<x>/` follows `presentation/ (widgets, blocs) `— feature Blocs consume
`domain/repositories` interfaces only, never `data/` directly, so a post type whose
payload is not captured yet (happening / restaurant story — see domain-model.md) can
be built against a mock `repositories_impl` and swapped to the real one without
touching UI/Bloc code. Experience and curation already have stage payloads.

## Why feature-slice Blocs, not one global app state

The home feed mixes heterogeneous content (experiences, curations, stories, promoted
brand content) with independent async lifecycles (reacting to a post shouldn't
re-fetch the whole list; following a restaurant from a suggestion card shouldn't touch
feed pagination state). Slicing by concern keeps rebuild scope tight, which matters given
the animation-heavy requirement — a narrowly-scoped Bloc means `BlocBuilder` can wrap a
single card, not the whole list, so reaction micro-animations stay cheap.

## Guest → authenticated session

Per `product-requirements.md`'s 3-phase onboarding: `go_router` redirect logic gates
routes that require identity (create, my/new/edit curations, wallet, `/place-pay/:restaurantId`, Live Vibe)
behind a lightweight "identity required" check, not a global auth wall — the public feed
route stays reachable without a session, and Live Menu stays open to guests. Inline actions (react, follow, save, reserve, pay)
still call `requireVerified` at the tap. `AuthBloc` exposes a session state (`guest` /
`phase1Named` / `authenticated`) that the router redirect reads.

The auth flow is a bottom sheet, never a route (2026-10-12): gate → number → code → verified →
profile or tour all run in one `AuthSheetRoute` over the screen the diner is on, opened only
through `showAuthGate`. There is no `/auth` route. `requireVerified` waits on a ticket the auth
flow closes, not on a pushed route's result: signing in refreshes the router, and go_router
rebuilds a pushed route on a refresh, which orphaned the awaited push (the action never
resumed after the gate).

Every endpoint path lives in `lib/core/network/api_endpoints.dart` with its `§n` ref to
`api-reference.md`; nothing else spells a path. Search (Home's CTA and the Search screen) is the
gateway's unified search (§25), one request across dishes, places, people and the feed.

The handle (api-reference.md §28) is checked live on the name screen while the diner is still a guest, and is
kept on the device until the first sign-in. `SessionCubit.syncHandle` runs after every sign-in and for a session
restored at launch. The account's username on BE wins; a handle that only the device has is claimed with
`PUT /v1/users/current/username`; a failed call is retried on the next sign-in or launch. When a taken
handle leads to "Already have an account? Sign in", the name screen finishes naming only after the auth sheet
closes. Finishing it earlier would let the router redirect move the route out from under the sheet. Diners
appear as their picture and `@username` wherever they show beside their picture (display name when they
have none).

The diner's own publishes and deletes go out on `FeedChanges` (announced by the feed
repository). Home, its curation rail and My curations listen, so a new post is on Profile at
once and a deleted curation leaves every list. Hive keeps auth state only. Curation drafts,
private lists and a just-published curation are held for the app session (stage has no
draft or "my posts" endpoint). Profile's experiences and curations are the feed search
by `author_urn` (api-reference.md §3), re-read from stage on each landing, on returning to
the foreground, and on pull-to-refresh; a failed read keeps what is shown. Each tab is its own request
by `post_types` with its own cursor (`AuthorPostsCubit`), paging on scroll; another diner's
profile reads both tabs the same way when it opens. A place profile's Experiences tab is the same
paged list by `restaurant_id` (`PostListCubit`, `feed_shared`), drawn as the design's feed cards
without the place strip or place photo. Edit on posts stays hidden until customer_gateway exposes feed_svc's
`UpdateFeedPost` (api-reference.md "Still absent").
Follow is hidden on the diner's own account, and the Block CTA is hidden everywhere for now.

Place profile's sticky bar is Reserve Table + Place Pay. Order-at-table is the top-right
icon (scan with no visit, cart with one). Creating a curation pops back to the origin
screen; My curations is only the destination when that is where Curate started. The nav bar's +
follows the tab: on Experience or Curation it opens that flow directly; on Home or Profile it
opens the Share something sheet.

## Insights, Tokens and Amplify (2026-10-15)

A place's Worth It score, its trend and its Experience DNA are BE's daily insights on §24
profile metadata, read beside every catalog place read. The app draws them (score chip, trend
card with a range menu and scrubbable chart, the DNA gem and sheet) and computes none of them.
Elite Tokens live on user_svc (§26): `WalletCubit` reads balance, Status XP, the ledger and the
earn policy, and every earn amount in the UI comes from that policy. Amplify (§27) is a sheet
from an experience's detail or the Published step (`AmplifyCubit`); it checks the balance
before buying and reuses one idempotency key per sheet and tier.

Where BE has no data the screen shows the literal FE/NA, never a stand-in; the open list for BE
is the "Still absent" table in `api-reference.md`.

## Testing

- `bloc_test` for Bloc unit tests (given the event-driven architecture, this is where most
  business-logic coverage should live).
- `mocktail` for repository/datasource mocks.
- Golden tests (`golden_toolkit` or built-in) for the shared feed card widget given how
  much visual/motion polish it carries — regressions here are easy to miss in normal
  widget tests.
- Integration tests (`integration_test` package) for the three onboarding phases end-to-end
  against a mock server, since that flow is the highest-stakes first-run experience.
