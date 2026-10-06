# elite — Experience Design System

`elite` is the brand mark on the product; **Experience** is the system. It is a mobile-first
design system for a restaurant discovery and curation app: people record verified visits,
curate places, and read a place's **Experience DNA** — a hexagonal radar built from what
diners actually mention. The tone is editorial and intimate: Playfair Display over Poppins,
one violet accent, near-black and warm off-white, gold reserved for axis labels.

Two things define this system and must never be blurred:

1. **Two parallel colour systems.** Light and Dark are separate systems, implemented in Figma
   as `Elite / Color` modes and here as `:root` (Light) and `[data-theme="dark"]`. A dark screen
   is never a light screen repainted with leftover hex; many components ship as explicit
   Light/Dark twins (`NavigationBar` / `NavigationBarLight`).
2. **Two mutually exclusive surface treatments.** **Flat** (opaque fill, 1px border, soft drop
   shadow) and **Glass** (translucent fill + stroke + background blur). Pick one per instance.
   Glass is allowed on coherent glass-mode flows, on full-bleed media chrome (Discovery,
   Restro Stories), and on chips/buttons sitting on a flat restaurant card — nowhere else.

## Sources

- **Figma file (attached as `Experience DNA.fig`)** — the ground truth for components, tokens
  and screens. Pages: `Initial Draft` (product screens, light + dark), `Foundations`
  (`461:1721` — Button, Chip, Card, Input, Badge, Elite Tokens), `Experience DNA` (`784:7149`).
  Referenced in the file's own notes as [Experience Quality](https://www.figma.com/design/DvkkRmdpmdi4AovFW0fkDb/Experience-Quality)
  (Foundations `461:1721`, Experience DNA `784:7149`). Variable collections: `Elite / Primitives`,
  `Elite / Color` (Light/Dark), `Elite / Spacing`, `Elite / Radius`, plus two ungrouped sets.
- **`uploads/design.md`** — the author's agent-readable record of the same system (tokens,
  component recipes, do's and don'ts). Where it and the .fig agree, both are quoted below.
- A web surface (`explorex.co.in`) appears as a single exploratory frame in the file. It is not
  built out here — there is not enough of it in the source to recreate honestly.

## Content fundamentals

Copy is warm, specific, lowercase-friendly, and never salesy. It talks about places and people,
not features.

- **Voice:** second person for actions ("Ask Elara for the perfect spot..."), first person plural
  only in DNA explainer copy ("we LOVE all shapes"). No exclamation marks in UI.
- **Casing:** sentence case for headings and body ("Choose your vibe", "Find community curated
  setting for any mood"). ALL CAPS only for micro-labels — `LATEST` (gold, 9px, letter-spacing
  0.224px) and axis names on the radar (`SERVICE`, `FOOD`, `VALUE`). Restaurant card one-liners
  are set in Playfair uppercase with 0.5px tracking ("IT’S PERFECT FOR FRIENDS AND FA...").
- **Numbers are evidence, not scores:** "2.4k+ Diner Served", "97% said Worth It",
  "+4.2% vs last week". Percentages on the radar are mention-weighted character, never a rating.
- **Recommendation is binary and separate:** "Worth It" / "Not recommended". Never "rating",
  "grade", "high DNA" or "perfect shape".
- **Emoji:** not used in product copy. The only emoji in the file live inside the iOS keyboard
  component (system content). Unicode glyphs are not used as icons.
- **Vibes vocabulary:** Recommended, Date Night, Fine Dining, Rooftops, Secret, Brunches, Mixology.
- **Placeholders read like invitations:** "Ask Elara for the perfect spot..." — three dots, lowercase tail.

## Visual foundations

**Colour.** One violet accent carries the system: `#745AEB` in Light, `#A394F3` in Dark (lighter
for contrast on dark surfaces). Canvas is `#F9F9FA` / `#0A0A0C`; surfaces `#FFFFFF` /
`#1A172A` with `#272241` as elevated. Neutrals run `gray-25 #F9F9FF` → `gray-950 #0A0A0C`.
Gold (`#D4AF37`, `#F2CA50`) is for DNA axis labels, the location pill and the `LATEST` tick —
never a glow that implies rank. Semantic: success `#6DE3A6`, warning gold, error `#FF2D55`.
Recommendation ink is muted and unusual on purpose: `#3C4E45` worth it, `#5E2B5A` not worth it.

**Type.** Playfair Display Regular for display (32/40, 24/32, 20/28) and for restaurant card
one-liners; Poppins for everything else (SemiBold 22/17 titles, Regular 14/13 body, Medium 13/12
labels, Regular 11 caption, SemiBold 15 buttons). The `elite` wordmark is Poppins SemiBold 32
with −1.6px letter-spacing in accent violet. DNA uses a tighter set: Playfair Black 32/40 title,
Poppins Light 15/22 tagline, Light 11/12 axis, Bold 11/12 percent, Regular 8/16 explainer.
SF Pro appears only in status bars; Inter and Hanken Grotesk appear in older draft frames and
are not part of new work.

**Spacing & layout.** Frames are 390 × 884. Gutter 20px (some feed screens run a 16px content
inset). 4px rhythm, 8px common step; related blocks 12–16px apart, section breaks 24–32px.
Buttons hug content at a fixed 48px height with 20px horizontal padding; chips 32px with 12px;
cards 16px internal padding. Nav bar is fixed at y=804 (80px tall), status bar fixed at the top,
top app bar fixed under it at y=62 (64px) — the middle scrolls.

**Backgrounds & imagery.** Screens are flat canvas; media is full-bleed photography of dim
interiors, plated food and street frontage — warm, low-light, slightly desaturated, no grain
overlay and no illustration. Media always carries a protection gradient
(`linear-gradient(0deg, rgba(0,0,0,0.5), rgba(0,0,0,0))`) before glass chrome sits on it. Vibe
circles are 80px photos at 80% opacity under the same gradient with a white star glyph on top.
There are no repeating patterns or textures.

**Corners.** Inputs 12, cards 16 (restaurant cards included), sheets and hero tiles 20, large
media masks and the Explore search bar up to 36, buttons and chips full pill. Explore result
rows are 14 — the file's value, deliberately not 16. Never mix 12 and 16 radii in one list.

**Depth.** Flat: `0 1px 2px rgba(0,0,0,0.08)` low, `0 4px 12px rgba(0,0,0,0.12)` card, plus
`surface` → `surface-elevated` → `muted` layering. Glass: blur 12 for chips/controls, 20 for
media chrome, 40 for sheets over media, always with a 1px glass stroke and often an inset
highlight (`inset 0 0.5px 0 rgba(255,255,255,0.28)`). Cards commonly use an inset hairline
instead of a border: `inset 0 0 0 1px rgba(116,90,235,0.1216)` in Light,
`inset 0 0 0 1px rgba(255,255,255,0.0784)` in Dark.

**Transparency.** Used for tinted fills as much as glass: violet at 12% for search bars, chips
and follow pills; gold at 10% for the location pill; white at 12–16% for media chrome.

**States.** Primary pressed goes to `#6D5CFF` (accent-strong), disabled to `muted` fill with
`gray-600` label. Selected chips fill with accent and flip the label to white. Hover is not a
first-class state in a mobile system — treat it as the pressed colour at lower intensity; press
is colour change, never scale.

**Motion.** The .fig carries no motion specs, but the brand ships **11 Lottie animations**
(`assets/animations/`) for loading, transaction feedback and empty/illustrative states — see
"Animated icons" below. For UI transitions keep it short and unshowy (120–200ms, ease-out) for
sheet entry, accordion disclosure and mode switching; no bounce, no parallax. Lottie carries the
expressive motion; CSS carries the functional motion.

## Iconography

Three distinct icon languages ship with this brand — keep them apart:

1. **Figma line icons** (`assets/icons/`) — single-colour, light geometric stroke (~2px at 24px),
   extracted from the .fig: nav glyphs (`nav-home`, `nav-explore`, `nav-discover`, `nav-profile`
   plus active states), `search-ask` (the Ask Elara sparkle), `action-back`, `action-filter`,
   `action-close`, `badge-check`, `restaurant-identity`, `inner-circle`, `vector-3`, `vector-4`
   (location pin). Use these for chrome and controls. Symbol glyphs are code:
   `components/icons/icon-data.js` carries `ArrowUpRight`, `AttachFile`, `SwapHoriz` and
   `StatusBarIPhone`; render with `<Icon name="ArrowUpRight" size={24}/>` — they paint with
   `currentColor`.
2. **Amenity icons** (`assets/icons/amenities/`, 18 WebP) — filled two-tone glyphs in the brand
   violet + teal pair: `air_conditioner`, `restaurant_wifi`, `valet_parking`,
   `restaurant_car_parking`, `outdoor_seating`, `roof_top_seating`, `pure_veg`, `eat_green`,
   `restaurant_serves_alcohol`, `hookah`, `smoking_rooms`, `dance_floor`, `pet_friendly`,
   `family_friendly_environment`, `accessible_for_disabled`, `work_friendly`, `cost_for_two`,
   `location_icon`. Use only for place facts on a place profile — never as UI controls.
3. **3D / utility icons** (`assets/icons/ui/`) — rendered glossy objects for money, membership and
   reactions: `wallet`, `piggy_bank_savings`, `discount_on_bill_percentage`, `medal`,
   `medal_emoji`, `party_emoji`, `rocket_emoji`, `question_mark`, `tier_discount_green_tick`,
   `tier_discount_white_tick`, `tier_discount_lock`, `ads_color`, `ads_black`, `WhatsApp`, plus
   `wallet.svg` and `elite_verified.svg` as real vectors. These carry their own palette — don't
   recolour them, and don't mix them into a line-icon row.

There is **no icon font** and no CDN icon set. Emoji-styled art (`medal_emoji`, `party_emoji`,
`rocket_emoji`) exists as image assets — that is not licence to type emoji into copy.
`assets/vector-flutter/` holds 21 `.svg.vec` files (compiled Flutter vector-graphics: the elite
logo, star, divider, verified mark, calendar day glyphs, social icons, `be_an_elite`,
`highlight_tag_icon`, `restaurant_leading_icon`, `wallet`). They are the app's runtime format and
**cannot render in HTML** — kept for the mobile build; ask for `.svg` originals if a web surface
needs them.

## Brand marks

`elite` has a real custom display wordmark — a high-contrast serif with a sparkle over the final
`e`. Files in `assets/brand/`:

- `elite_logo_transparent.webp` — white lockup, for violet or photographic backgrounds.
- `elite_black.webp` / `elite_black.png` — near-black lockup for light surfaces.
- `elite_by_explorex.webp` — the endorsed lockup (elite by ✕ explorex) on brand violet.
- `elite_app_logo.png`, `Splash_logo.png`, `Splash_logo_1.png`, `splash_branding.png` — app icon
  and splash artwork (violet gradient, white lockup, subtle wave motif bottom-right).
- `explorexLogo.png`, `explorex_icon.png`, `explorex_brand_experience.webp` — the parent brand.
- `elite_diamond.png`, `elite_king.png` — tier ornaments. `app_store.png`, `play_store.png`,
  `india_code.png` — third-party marks; use unmodified.

The .fig's own screens set the word `elite` typographically (Poppins SemiBold 32 / −1.6px in
accent violet) rather than placing the logo file — both are legitimate; prefer the real asset for
splash, membership and marketing surfaces, and the type treatment inside the app's top bar where
the .fig uses it.

### Badges, illustrations, backgrounds

- `assets/badges/` — `elite_premium_badge`, `restaurant_classic_membership`,
  `restaurant_signature_membership`, `rest_member_badge`, `agg_spotlight_tag`, `discounts_tag`,
  `agg_exp_score`, `mmenbership`.
- `assets/illustrations/` — one 3D illustration per empty surface (`search_empty_state`,
  `no_results_found`, `no_menus_available`, `all_orders_empty_state`, `pay_bill_empty_state`,
  `service_unavailable`, `wallet_missed_savings`), promo banners (`live_menu_banner`,
  `vibe_check_banner`, `elite_membership_banner`), and feature art (`skip_the_queue`,
  `joining_gift`, `live_table_view`). The empty states sit on a pale skeleton-list backdrop —
  place them on canvas, not inside a card.
- `assets/backgrounds/` — `home_bg` (violet ray burst), `membership_bg` (violet rounded plate),
  `get_app_bg` (dark blue wash), `gradient` / `gradient_search_bar` (mesh washes),
  `search_bar` (plate), `table_service_bg`, `discover_motif`, `profile_pic_placeholder`.

Note the illustration and 3D-icon sets run brighter and bluer than the .fig's violet/gold
palette. That is the shipped app's art direction; don't recolour it, but keep chrome and type on
the token palette so the two read as foreground and artwork.
### Animated icons (Lottie)

JSON in `assets/animations/`, played with `lottie-web` (`renderer: 'svg'`). Sizes are the source
compositions — scale to the slot, don't re-time them.

| File | Comp | Size / fps | Use |
| --- | --- | --- | --- |
| `loader.json` | Loading 05 | 600² · 29.97 | Primary in-screen loading spinner |
| `bouncing_dots_loader.json` | loader | 600² · 29.97 | Inline / button-level waiting |
| `payment_success.json` | HDFC Success | 512² · 60 | Payment confirmed |
| `payment_failed.json` | Failed | 1920×1080 · 29.97 | Payment declined |
| `elite_checked_animation.json` | ConfettiAnimation | 1920×1080 · 25 | Verified / celebratory confirm |
| `rupee_coin.json` | Clipped | 300² · 54.07 | Money and reward moments |
| `savings.json` | 2-Composition | 1000² · 54.07 | Savings / value illustration |
| `queue.json` | 2-Composition | 1000² · 54.07 | Waitlist and queue states |
| `menus.json` | 2-Composition | 1000² · 54.07 | Menu / dish empty state |
| `vibe.json` | 2-Composition | 1000² · 54.07 | Vibe discovery illustration |
| `table_service_animation.json` | trans sqr animation 2 | 300² · 54.07 | Table service / dining flow |

Four of these (`savings`, `queue`, `menus`, `vibe`) embed bitmap layers and are ~1.2 MB each —
lazy-load them; don't ship them in a critical bundle. Loop the loaders; play the feedback ones
once and hold the last frame.

- The app mark is `assets/logo.svg` (`home_app_logo` from the Figma nav bar) with
  `assets/logo-alt.svg` for dark chrome. There is no separate wordmark asset: the word `elite`
  is set in Poppins SemiBold 32 / −1.6px in accent violet.

## Components (100 built)

Grouped by concern; `*Light` twins are the Light-system counterparts of the same family.

**`components/core/`** — Badge, Button, Card, Chip, Input

**`components/dna/`** — DNAAxisLabel, DNARecoChip, ExpScore, ExpScoreLight, ExpScorePopupDark,
ExpScorePopupLight, and the file's individually named hex/popup symbols: ExpScoreDefault3,
ExpScoreDefault4, ExpScoreDefault9, ExpScoreDefault10, ExpScoreLarge3, ExpScoreLarge4,
ExpScoreLarge5, ExpScoreLarge6, ExpScoreLarge7, ExpScoreSmall3, ExpScoreSmall5, ExpScoreSmall7,
ExpScoreSmall8, ExpScoreSmall9, ExpScoreSmall10, ExpScoreLightDefault3, ExpScoreLightDefault4,
ExpScoreLightDefault9, ExpScoreLightDefault10, ExpScoreLightLarge3, ExpScoreLightLarge4,
ExpScoreLightLarge5, ExpScoreLightLarge7, ExpScoreLightSmall3, ExpScoreLightSmall5,
ExpScoreLightSmall7, ExpScoreLightSmall8, ExpScoreLightSmall9, ExpScoreLightSmall10,
ExpScorePopup3, ExpScorePopup4, ExpScorePopup5, ExpScorePopup6, ExpScorePopup7,
ExpScorePopupScore7, ExpScorePopupScore8, ExpScorePopupLight3, ExpScorePopupLight4,
ExpScorePopupLight5, ExpScorePopupLight6, ExpScorePopupLight7

**`components/content/`** — DiscoveryCard, DiscoveryCardLight, DishDetailPopup,
DishDetailPopupLight, DishItemAccordion, DishItemAccordionLight, and the hex marks those cards
instance: ExpScoreDefault5, ExpScoreDefault7, ExpScoreSmall4, ExpScoreLightDefault5,
ExpScoreLightDefault7, ExpScoreLightSmall4

**`components/experience/`** — ExperienceSource, ExperienceSourceLight,
ExperienceTrendAccordion, ExperienceTrendAccordionLight, VerifiedExperienceContainer,
VerifiedExperienceContainerLight

**`components/app/`** — ActivityRings, NavigationBar, NavigationBarLight, StatusBar,
StatusBarLight, StepperNav, StepperNavLight, ToggleSwitchSection, ToggleSwitchSectionLight

**`components/actions/`** — AttachFile, HotKeyButtons, HotKeyButtonsLight

**`components/keyboard/`** — Keyboard, KeysIPhone, KeysIPhoneSpace, NumberPad, Autocorrection,
BackgroundKeyboard, BottomButtons, EmojiTabs, SearchEmoji, Suggestion,
KeyboardLayoutsIPhoneLowercase, KeyboardLayoutsIPhoneUppercase, KeyboardLayoutsIPhoneEmail,
KeyboardLayoutsIPhoneNumberic, KeyboardLayoutsIPhonePunctuation, KeyboardLayoutsIPhoneURL,
KeyboardLayoutsIPhoneWebSearch

**`components/icons/`** — Icon (wrapper over `icon-data.js`)

### Intentional additions

- **`Icon`** — a thin wrapper so the file's symbol glyphs can be used by name. The glyph data is
  extracted from the source; only the wrapper is new.

## Index

- `styles.css` — the single entry point consumers link. `@import`s only.
- `tokens/` — `fonts.css`, `primitives.css`, `color.css` (Light `:root` + Dark `[data-theme]`),
  `typography.css`, `spacing.css`, `radius.css`, `elevation.css`.
- `components/core/fig-tokens.css` — all 183 Figma Variables across all modes, generated.
- `components/<group>/` — components with `.d.ts` contracts, `.prompt.md` usage notes and one
  `@dsCard` HTML per directory.
- `guidelines/` — 24 foundation specimen cards (Colors, Type, Spacing, Brand).
- `ui_kits/elite-mobile/` — the mobile app recreation: Home, Explore, Discovery, Place profile,
  Light and Dark side by side. See its `README.md`.
- `templates/elite-mobile-screen/` — a 390×884 screen scaffold (status bar, `elite` top bar, nav
  bar) in both systems, for starting a new screen.
- `assets/` — `brand/` (logos, splash, store marks), `icons/` (line SVGs) with
  `icons/amenities/` and `icons/ui/`, `badges/`, `illustrations/`, `backgrounds/`, `images/`
  (photography from the .fig), `animations/` (11 Lottie JSON), `vector-flutter/` (21 `.svg.vec`).
- `thumbnail.html` — homepage tile. `SKILL.md` — portable skill front matter.
- `uploads/design.md` — the author's original system record.

## Caveats

- **Fonts are substituted.** The .fig ships no binaries, so Playfair Display and Poppins load
  from Google Fonts; Playfair Black maps to Playfair Display 900. SF Pro (status bars, keyboard)
  falls back to the system stack. Upload the real faces to replace them.
- `ExperienceTrendAccordion` and its Light twin have an approximated chart area fill (the source
  vector had no decodable geometry).
- **`.svg.vec` files don't render on the web** — 21 brand vectors (including the master
  `elite_logo`, social icons and calendar glyphs) exist only in Flutter's compiled format.
- The .fig ships no logo file; the uploaded asset library does, so the brand-mark guidance above
  follows the uploaded lockups.
- The `Ungrouped` and `Variable collection` Figma sets (Material-style scheme leftovers) are
  shipped in `fig-tokens.css` for completeness but are not part of the `Elite / *` semantic system.
