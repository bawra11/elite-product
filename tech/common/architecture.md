# Architecture decisions

## Stack

- **Flutter** (managed via **FVM**, pinned per-project — see `.fvmrc` in the codebase folder, run `fvm flutter ...` instead of bare `flutter ...` so everyone on the project uses the same SDK version).
- **State management:** BLoC (`flutter_bloc`), event-driven, one Bloc/Cubit per feature-slice, not per-screen — a screen composed of several independent widgets (e.g. Home = feed list + reaction state + follow suggestions) gets several Blocs, not one god-Bloc.
- **DI:** `get_it`, hand-registered in `lib/core/di/injection.dart` (~6 singletons doesn't justify a codegen step). `injectable` was tried and dropped — its analyzer constraint conflicted with `bloc_test`'s. Revisit only once the manual registration file gets unwieldy, and pick versions that actually resolve together.
- **Networking:** `dio` (interceptors for auth header injection, refresh-token rotation, retry) + `retrofit` (codegen typed clients) over the raw curl reference in `api-reference.md`.
- **Routing:** `go_router` — declarative, supports the guest→authenticated redirect logic onboarding needs (see product-requirements.md phase 1–3) and deep links into restaurant/post detail from push notifications later.
- **Local storage/secure storage:** `flutter_secure_storage` for tokens (Keychain/Keystore-backed), `hive` (or `drift` if relational queries end up needed for offline feed caching) for everything else — never store JWTs in plain SharedPreferences.
- **Codegen:** `freezed` + `json_serializable` for immutable entities/DTOs and union types (e.g. `FeedPost.payload` is a natural `freezed` union over post_type).
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
    auth/                    # phone + OTP, WhatsApp magic link, session, token refresh
    restaurant_detail/
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
routes that require identity (react, follow, create, profile) behind a lightweight
"identity required" check, not a global auth wall — the public feed route stays reachable
without a session. `AuthBloc` exposes a session state (`guest` / `phase1Named` /
`authenticated`) that the router redirect reads.

## Testing

- `bloc_test` for Bloc unit tests (given the event-driven architecture, this is where most
  business-logic coverage should live).
- `mocktail` for repository/datasource mocks.
- Golden tests (`golden_toolkit` or built-in) for the shared feed card widget given how
  much visual/motion polish it carries — regressions here are easy to miss in normal
  widget tests.
- Integration tests (`integration_test` package) for the three onboarding phases end-to-end
  against a mock server, since that flow is the highest-stakes first-run experience.
