# Mockups: Claude Design screens & flows scope

The screen and flow scope of the Claude Design prototype **"Diner app · UX flows v1"**
(project `Experience Diner App`, https://claude.ai/design/p/edec04e8-eb34-4ab7-9c61-7daa1a828a03).
The prototype source files live in [`../claude-design/`](../claude-design/). This page is the index of
what they cover and where each screen lives in the Flutter app.

- **Screen id** is the prototype's `data-screen` id. It's also the `data-go` target, so it's stable to
  refer to in tickets.
- **Label** is the prototype's `data-screen-label`.
- **Source** says which local export holds the screen. `main` = `Experience Diner App.dc.html` (post-audit,
  preferred), `sa` = `… standalone.dc.html` (pre-audit; apply the audit rules in `../README.md`).
- **Flutter** is the implementing file under `tech/codebase/elite_app/lib/features/`.

The prototype's own flow grouping (its `flows` array) sits past the 256 KB export cutoff. The flow
groups below were rebuilt from the screen ids, and they follow the prototype's rail order.

## 1 · Auth (7)

| Screen id | Label | Source | Flutter |
| --- | --- | --- | --- |
| `auth-phone` | Phone gate | main | `auth/…/auth_flow_screen.dart` |
| `auth-otp` | OTP | main | `auth/…/auth_flow_screen.dart` |
| `auth-name` | Landing name and handle | main | `onboarding/…/name_screen.dart` |
| `auth-gate` | Auth gate sheet | main | `auth/…/auth_flow_screen.dart` |
| `auth-verified` | Verified | main | `auth/…/verified_views.dart` |
| `auth-profile-30` | Profile 30 percent | main | `auth/…/verified_views.dart` |
| `auth-profile-100` | Profile complete | main | `auth/…/verified_views.dart` |

## 2 · Tutorial (4)

| Screen id | Label | Source | Flutter |
| --- | --- | --- | --- |
| `tut-1` | Tutorial 1 Experience | main | `onboarding/…/tutorial_screen.dart` |
| `tut-2` | Tutorial 2 Experience DNA | main | `onboarding/…/tutorial_screen.dart` |
| `tut-3` | Tutorial 3 Curation | main | `onboarding/…/tutorial_screen.dart` |
| `tut-4` | Tutorial 4 Discovery | main | `onboarding/…/tutorial_screen.dart` |

## 3 · Home & search (4)

| Screen id | Label | Source | Flutter |
| --- | --- | --- | --- |
| `home-list` | Home | main | `home/…/home_screen.dart` |
| `home` | Home · grid (legacy) | main | superseded by `home-list` |
| `elara` | Ask Elara | main | `elara/…/elara_screen.dart` |
| `search` | Universal search | sa | `explore/…/search_screen.dart` |

## 4 · Explore & Discovery (4)

| Screen id | Label | Source | Flutter |
| --- | --- | --- | --- |
| `explore-landing` | Explore landing | main (cut off) / sa | `explore/…/explore_screen.dart` |
| `explore-search` | Explore search results | sa | `explore/…/explore_results_screen.dart` |
| `discovery` | Discovery feed | sa | UI reused as the Home story viewer (`story-view` from the circular bubbles). Not a tab or a feed. |
| `curation-feed` | Curation Feed View | export only | not built |

## 5 · Content detail (3)

| Screen id | Label | Source | Flutter |
| --- | --- | --- | --- |
| `curation-detail` | Curation detail | sa | `curation/…/curation_detail_screen.dart` |
| `experience-detail` | Experience detail | sa | `feed_shared/…/post_detail_screen.dart` |
| `story-detail` | Restro story | sa | `feed_shared/…/story_detail_screen.dart` |

## 6 · Place (5)

| Screen id | Label | Source | Flutter |
| --- | --- | --- | --- |
| `place-profile` | Place profile | sa | `restaurant_detail/…/restaurant_detail_screen.dart` |
| `dna-sheet` | DNA sheet | sa | `restaurant_detail/…/dna_sheet.dart` |
| `live-vibe` | Live Vibe | sa | `live/…/live_vibe_screen.dart` |
| `live-menu` | Live Menu | sa | `live/…/live_menu_screen.dart` |
| `dish-detail` | Dish page | sa | `live/…/dish_detail_screen.dart` |

## 7 · Create experience (7)

| Screen id | Label | Source | Flutter |
| --- | --- | --- | --- |
| `create-place` | Create step 1 select place | sa | `create_post/…/place_step.dart` |
| `create-visit` | Create step 2 select visit | sa | `create_post/…/visit_step.dart` |
| `create-narrate` | Create step 3 narrate | sa | `create_post/…/narrate_step.dart` |
| `create-curation-pick` | Add to curation | sa | `curation/…/save_to_curation_sheet.dart` |
| `create-success` | Published | sa | `create_post/…/published_step.dart` |
| `create-amplify` | Amplify prompt | sa | `create_post/…/amplify_sheet.dart` |
| `create-axis-edit` | Edit inferred axes | sa | `create_post/…/axis_edit_screen.dart` |

## 8 · Reserve (2)

| Screen id | Label | Source | Flutter |
| --- | --- | --- | --- |
| `reserve` | Reserve table | sa | `reserve/…/reserve_screen.dart` |
| `reserve-confirm` | Reservation held | sa | `reserve/…/reservation_held_screen.dart` |

## 9 · Pay (3)

| Screen id | Label | Source | Flutter |
| --- | --- | --- | --- |
| `pay-bill` | Pay bill | sa | `pay/…/pay_bill_screen.dart` |
| `pay-mismatch` | Bill changed | sa | `pay/…/pay_bill_screen.dart` (state) |
| `pay-receipt` | Receipt | sa | `pay/…/receipt_screen.dart` |
| (not exported) | Place Pay (typed amount) | none | `pay/…/place_pay_screen.dart` |

## 10 · Curations (3)

| Screen id | Label | Source | Flutter |
| --- | --- | --- | --- |
| `my-curations` | My curations | sa | `curation/…/my_curations_screen.dart` |
| `curation-new` | New curation | sa | `curation/…/new_curation_screen.dart` |
| `curation-add` | Add restaurants | sa | `curation/…/curation_editor_screen.dart` |

## 11 · Wallet & membership

| Screen id | Label | Source | Flutter |
| --- | --- | --- | --- |
| `wallet` | Token wallet | sa | `wallet/…/wallet_screen.dart` |
| (not exported) | Profile | none | `profile/…/profile_screen.dart`, composed from system components |
| (not exported) | Curator profile, deals, loyalty, membership, token store | none | not built |

## Out of the prototype, decided in the app

The tab bar follows the product journal (Home · Experience · Create · Curation · Profile) and not the
prototype's Home · Explore · Discovery · Profile. Discovery is removed as a destination; that UI is the
story viewer for the circular bubbles on Home (2026-09-26). Explore is search. Place Pay is a typed-amount
path from the place profile, not `pay-bill`. See `../README.md`.

## Keeping this current

`/context-sync` refreshes this table before every push of the product repo. When a new Claude
Design pull lands in `../claude-design/`, add its screens here first, then build them.
