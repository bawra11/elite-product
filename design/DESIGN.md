# Elite / Explorex Design System

> Source of truth for product UI. Rebuilt from the live Flutter app tokens (`elite-core/themes`) and production screens. Use this when designing **new or extended components**.

**Related docs**
- [Component Extension Guide](./COMPONENT_EXTENSION.md) — checklist for shipping new components
- [Visual References Index](./references/INDEX.md) — annotated screenshots
- Dark theme + perceived performance: §§7–8 below

**Code mirrors**
- Colors: `elite-core/lib/themes/constants/app_colors.dart`
- Semantic colors: `page_colors.dart`, `text_colors.dart`, `label_colors.dart`, `icon_colors.dart`, `stroke_colors.dart`
- Type: `custom_text_styles.dart` (Poppins)
- Gradients: `gradients.dart`
- Buttons: `CustomButtonWidget` + `ButtonType` / `ButtonSize`

---

## 1. Brand & product surfaces

| Surface | Role | Primary accent |
|---|---|---|
| **Explorex Elite App** | Discovery, live table status, restaurant cards, pay-at-venue | **Violet** `#745AEB` |
| **Elite Digital Dining (DD)** | In-venue menu, cart, pay bill, waiter request | **Indigo** `#3D54FF` |
| **Elite membership** | Upsell, tier discounts, membership cards | Violet gradients + green success |

Tagline tone (marketing): *“At Explorex we believe Experience is everything!”*

Logo wordmark: lowercase **elite** (custom display treatment). Partner badge script: **Oooh Baby** (Google Font) for “Signature Partner”.

---

## 2. Color system

All palettes use shades **50 → 1100** (light → dark). Prefer semantic tokens (`PageColors`, `TextColors`, `LabelColors`) over raw shades in product UI.

### 2.1 Brand scales (light theme defaults)

#### Violet (Elite / Explorex primary)

| Token | Hex | Use |
|---|---|---|
| `Violet.50` | `#F1EFFF` | Soft washes, selected live-table bg |
| `Violet.100` | `#E4E0FF` | Chip / tint backgrounds |
| `Violet.200` | `#CDC2FF` | Soft accents |
| `Violet.400` | `#8A72F7` | Mid accents |
| `Violet.500` | `#745AEB` | **Brand primary** (headers, filter chips, progress) |
| `Violet.600` | `#694BF9` | Strong accent |
| `Violet.700` | `#5C3EEA` | Pressed / emphasis |
| `Violet.900` | `#3D2A99` | Deep brand text |
| `Violet.1100` | `#201941` | Near-black violet |

#### Indigo (DD primary actions)

| Token | Hex | Use |
|---|---|---|
| `Indigo.100` | `#E5E8FF` | Soft indigo fill |
| `Indigo.500` | `#6083FE` | Soft primary |
| `Indigo.600` | `#3D54FF` | **Primary CTA** (Add, Pay Bill, View Cart) |
| `Indigo.700` | `#2F44E1` | Pressed |
| `Indigo.800` | `#283BCF` | Strong links |

#### Supporting scales

| Family | Key shade | Hex | Use |
|---|---|---|---|
| Grey | 50 / 100 / 600 / 900 / 1100 | `#FFF` / `#F0F0F4` / `#8A8D97` / `#303236` / `#161616` | Surfaces, borders, body, titles, ink |
| Green | 100 / 600 / 700 | `#E2FEE5` / `#00A61A` / `#008515` | Success, open, unlocked tier, available |
| Yellow | 100 / 600 / 700 | `#FFF6D4` / `#FFD027` / `#F5BF00` | Discounts, stars, “filling fast”, join CTA |
| Red | 100 / 600 | `#FAE0E0` / `#D01D1D` | Error, spicy, running hot, non-veg |
| Orange | 100 / 600 | `#FCE9D8` / `#EC7910` | Warnings, mushroom tag |
| Blue | 100 / 600 | `#E0F1FF` / `#008EFF` | Bestseller, dairy tags |
| Purple | 100 / 600 | `#F5E9FF` / `#8F00FF` | Alcohol / special accents |
| Aqua | 100 / 700 | `#E4FDF9` / `#09C9A7` | Soya / cool accents |
| Pink | signature | `#AB41BF` | Signature Partner label |
| Violet signature | — | `#384BAC` | Alternate partner script |

### 2.2 Semantic roles (always prefer these)

| Role | Light | Notes |
|---|---|---|
| Page background | `Grey.100` `#F0F0F4` | App chrome |
| Surface / card | `Grey.50` `#FFFFFF` | Cards, sheets, list rows |
| Primary text | `Grey.900` / `Grey.1100` | Titles, prices |
| Secondary text | `Grey.600` – `Grey.700` | Meta, distance, captions |
| Disabled | `Grey.200` bg + `Grey.600` text | Buttons, locked tiers |
| Primary CTA (DD) | `Indigo.600` fill, white text | Pay Bill, Add, View Cart |
| Primary brand (Elite) | `Violet.500` | Headers, discovery filters |
| Success | Green 600/700 on Green 100 | Checkmarks, unlocked |
| Danger | Red 600 on Red 100 | Errors, hot status |
| Warning | Yellow 700/800 on Yellow 100 | Filling fast, tips |

### 2.3 Label / pill pairs (`LabelColors`)

Use for status chips, dish tags, live-table status:

| Name | Text | Background |
|---|---|---|
| Green | Green 600 | Green 100 |
| Yellow | Yellow 800 | Yellow 100 |
| Red | Red 600 | Red 100 |
| Blue | Blue 600 | Blue 100 |
| Purple | Purple 600 | Purple 100 |
| Violet | Violet 600 | Violet 100 |
| Indigo | Indigo 600 | Indigo 100 |
| Orange | Orange 700 | Orange 100 |
| Grey | Grey 700 | Grey 100 |
| Aqua | Aqua 800 | Aqua 100 |

**Live table status (product copy)**

| Status key | Label | Colors |
|---|---|---|
| `available` | Calm & Cozy | Green pair |
| `fast filling` | Filling Fast | Yellow pair |
| `running hot` | Running Hot | Red pair |

### 2.4 Gradients

| Name | Stops | Use |
|---|---|---|
| `primaryGradient` / `violetGradient` | `#8974FF` → `#6143D9` | Primary gradient buttons, brand CTAs |
| `yellowGradient` | `#FCCE21` → `#F7DD7A` → `#FCCE21` | Discount badges (“upto X% off”) |
| `payBillGradient` | `#191046` → `#8069F6` → `#E6E1FF` | Pay-bill confirm / breakdown screen |
| `payBillGreenMemberShipGradient` | `#FFF` → `#D7FFCD` | Savings banner on pay bill |
| `tierDiscountMembershipstatusGradient` | `#4E35C4` → `#201941` | Membership status surfaces |
| `eliteUserGradient` | violet @ 20% → transparent | Soft header wash |
| `liveTableSelectedGradient` | `#FAF9FF` → `#E8DFFF` | Selected live-table state |
| `darkVioletGradient` | `#622DA6` → `#223289` | Dark promo blocks |
| `greenMemberShipGradient` / `redMemberShipGradient` | multi-stop | Membership card themes |

Dark variants for these (required for live dark mode) are specified in **§7.3**.

---

## 3. Typography

**Primary family:** Poppins  
**Weights shipped:** Regular (400), SemiBold (600), Bold (700)  
**Accent script:** Oooh Baby — restaurant type / Signature Partner only

### Type ramp (`CustomTextStyles`)

| Style | Size | Line height | Weight | Typical use |
|---|---|---|---|---|
| Header XL | 64 | ~1.15 | SemiBold | Marketing / rare |
| Header L | 40 | 46/40 | SemiBold | Large display |
| Header M | 32 | 38/32 | SemiBold | Screen hero amounts |
| Header S | 28 | 34/28 | SemiBold | Large section titles |
| Subheader XL → XXXS | 24 → 8 | +6px | SemiBold | Titles, buttons, chips |
| Body XXL → XXXS | 28 → 8 | +6–14px | Regular | Descriptions, meta |
| Bold XXL → XXXS | 32 → 8 | +6px | Bold | Emphasis prices / names |
| Underline / Striked | same sizes | — | Regular | Links, MRP |

**Default text color:** `TextColors.grey_900` unless on colored / dark surfaces (then white).

### Hierarchy rules

1. **One bold title** per card/row; meta stays Grey 600–700 Regular.
2. **Prices:** Bold for current; strikethrough Grey for MRP.
3. **Currency:** Prefer `₹` with Indian formatting; large amounts can use Header/Bold L–M.
4. Do not invent new font sizes outside this ramp without engineering + design sign-off.

---

## 4. Layout, spacing & shape

### Spacing scale (preferred)

`4 · 8 · 12 · 16 · 20 · 24 · 32`

| Context | Value |
|---|---|
| Screen horizontal padding | 16–20 |
| Card internal padding | 12–16 |
| List row gap | 12–16 |
| Section gap | 20–24 |
| Icon–label gap | 4–8 |
| Button icon–text | 12 |

### Corner radius

| Element | Radius |
|---|---|
| Standard buttons | 8 (small size: 4) |
| Cards / sheets content | 16–20 |
| Restaurant discovery card | 16 |
| Bottom sheets (top) | ~24–32 |
| Pills / filter chips / tags | 100 (full pill) or 8–12 |
| Avatars (live status list) | circle |
| Thumbnails (search list) | ~12 |
| Progress bar | 24 |

### Elevation

| Token | Spec |
|---|---|
| Card shadow | `Grey.1100` @ 10% opacity, blur 28 |
| Primary button shadow | `Indigo.600` @ 8%, offset `(0, 12)`, blur 12 |
| DD bottom nav | Solid near-black, no shadow needed |

Prefer flat list rows with **hairline Grey 200 dividers** inside Digital Dining menus.

---

## 5. Iconography

- **Style:** Thin linear / custom icon font (`CustomIcons`) for chrome; filled for status (check, star, heart filled).
- **Sizes:** 12 (tags), 16 (default UI), 18–20 (filters), 24 (nav).
- **Colors:** `IconColors` semantic set — match text role; never hardcode random greys.
- Dietary: green square (veg), red triangle (non-veg), standard India food markers.

---

## 6. Core components

### 6.1 Buttons (`CustomButtonWidget`)

| Type | Appearance | When |
|---|---|---|
| `primary` | Indigo 600 fill, white text, soft shadow | Main CTA |
| `secondary` | White/surface + Indigo border & text | Add, secondary |
| `tertiary` | Surface fill | Low emphasis |
| `ghost` | No chrome | Text/icon only |
| `gradient` | `primaryGradient`, white text | Elite CTAs (“Get the Elite App”, Pay Bill brand) |

| Size | Height | Radius |
|---|---|---|
| Large | 44 | 8 |
| Medium | 32 | 8 |
| Small | 24 | 4 |

**States:** Default · Pressed · Loading (spinner) · Disabled (`Grey.200` + `Grey.600` text).  
**Patterns:** Full-width sticky bottom CTA; optional secondary caption under label (e.g. discount note on Pay Bill).

### 6.2 Filter chips

- Horizontal scroll row under violet / indigo headers.
- Pill shape; translucent light-on-purple in Elite discovery; outlined grey in DD menu (VEG / NON VEG).
- May include leading icon + trailing chevron (“Sort by”).

### 6.3 Status / tag pills

- Height ~24–28; horizontal padding 8–12; pill radius.
- Always use **LabelColors** pairs.
- Dish tags: Bestseller, Chef Special, Spicy, Alcohol, Vegan, allergens, etc. (see enum `DishItemTag`).
- Unavailable items: force Grey label pair.

### 6.4 Restaurant discovery card

Reference: `references/marketing/04-restaurant-discovery-cards.png`

- Image-led card, radius 16.
- Top-left: yellow gradient discount badge.
- Top-right: circular favorite (heart outline / filled red).
- Bottom image overlay: black gradient → white name, price level (`₹`), distance, categories.
- Below: “Experience score” + progress bar (violet/yellow) + numeric score + info icon.

### 6.5 Restaurant list row

Reference: `references/marketing/03-search-results-filters.png`, `06-live-status-list.png`

- Square or circular thumb + name + distance/area + tag pills + optional favorite.
- Live status: Calm & Cozy / Filling Fast / Running Hot + rating pill (star).

### 6.6 Tier discount stepper

Reference: `references/marketing/01-tier-discount-sheet.png`, `05-rewards-offer-modal.png`, `app-flows/01-pay-bill-amount-entry-flow.jpg`

- Horizontal 3-node stepper (typical: 10% / 15% / 20%).
- **Unlocked:** Green fill + white check; connector green.
- **Locked:** Grey circle + lock icon; connector Grey 200.
- Helper copy: “₹X more to unlock flat Y% off”.
- Sheet: drag handle, Elite logo, T&C underline link (violet/indigo).

### 6.7 Bottom sheet / modal

- White surface, large top radius, centered drag handle (Grey 300 pill).
- Dim / blur content behind.
- Primary CTA full-width near bottom when action is required.

### 6.8 Menu item row (Digital Dining)

Reference: `references/marketing/07-digital-menu.png`, `app-flows/03–04`

- Left: meat icon + tags + name + description + price (+ MRP strikethrough).
- Right: dish image (radius ~8–12) with overlapping **Add** (secondary) or quantity **counter** (indigo).
- Sections: collapsible (“Recommended (N items)”).
- Floating: black “View Categories” pill; circular % progress (tier unlock); black cart promo bar + blue View Cart.

### 6.9 Quantity counter

- Pill: indigo minus / plus with white center value.
- Replaces Add after first add.

### 6.10 Pay bill

References: marketing `08`, app-flows `01–02`

- Amount entry: large centered `₹` input + system keypad; Apply Offer enabled only when valid.
- Confirm: `payBillGradient` background, payable amount (Header), Elite membership card (yellow “Join Elite Now” → green “Elite Added”), line items (+ fees / − discounts), sticky Pay Bill CTA.
- Savings banner: green gradient strip with check + chevron.

### 6.11 Bottom navigation (DD)

- Dark / near-black bar.
- Tabs: Home · Menu · Re-order / All Orders · Pay Bill · Waiter Req.
- Active: white (or gold coin for Pay Bill); inactive: muted grey.

### 6.12 Headers

| Surface | Pattern |
|---|---|
| Elite discovery | Violet header, white search field, translucent filter chips |
| Live Status | Violet header, back + title + location, PAX/Type summary + Edit |
| DD | White top bar, hamburger + elite logo + table/key badges |

---

## 7. Dark theme

Token getters in `PageColors` / `TextColors` / `IconColors` / `StrokeColors` / `LabelColors` already branch on `isDarkTheme`. Runtime wiring is incomplete in code today (`isDarkTheme` forced `false`; drawer toggle commented). Treat this section as the **spec to make dark mode live**.

### 7.1 Semantic light ↔ dark map

| Role | Light | Dark |
|---|---|---|
| Page background | `Grey.100` `#F0F0F4` | `Grey.1100` `#161616` |
| Surface / card / sheet | `Grey.50` `#FFFFFF` | `Grey.1000` `#232429` |
| Elevated / nested surface | `Grey.75` `#FAFAFB` | `Grey.900` `#303236` |
| Primary text | `Grey.900` / `Grey.1100` | `Grey.200` / `Grey.50` |
| Secondary text | `Grey.600`–`Grey.700` | `Grey.400`–`Grey.500` |
| Dividers / strokes | `Grey.200`–`Grey.300` | `Grey.800`–`Grey.900` |
| Disabled fill + text | `Grey.200` + `Grey.600` | `Grey.900` + `Grey.500` |
| Brand violet | `Violet.500` `#745AEB` | `Violet.400` `#8A72F7` |
| Brand indigo CTA | `Indigo.600` `#3D54FF` | `Indigo.500` `#6083FE` (text on fill: white) |
| Success | Green 600 on Green 100 | Green 500 fill / Green 50 text (see labels) |
| Danger | Red 600 on Red 100 | Red 500 fill / Grey 50 text |
| Warning | Yellow 800 on Yellow 100 | Yellow 500 fill / Yellow 1000 text |
| Shadows | Soft indigo/grey blur | **None** (already coded) |

**Rules**
- Invert grey roles along the scale (50 ↔ 1100, 100 ↔ 900, etc.) — do not invent new greys.
- Brighten brand accents **one step** in dark so CTAs stay legible on Grey 1100.
- Keep veg / non-veg markers; never rely on fill color alone.
- White (`Grey.50`) and black (`Grey.1100`) tokens stay absolute for on-brand / on-photo text.

### 7.2 Label pairs (dark)

| Name | Dark text | Dark background |
|---|---|---|
| Green | Green 50 | Green 500 |
| Yellow | Yellow 1000 | Yellow 500 |
| Red | Grey 50 | Red 500 |
| Blue | Grey 50 | Blue 500 |
| Purple | Grey 50 | Purple 400 |
| Violet | Violet 100 | Violet 600 |
| Indigo | Indigo 600 | Indigo 600 (solid chip) |
| Orange | Orange 700 | Orange 700 |
| Grey | Grey 50 | Grey 700 |
| Aqua | Aqua 1000 | Aqua 400 |

Live-table copy unchanged: Calm & Cozy / Filling Fast / Running Hot — only colors flip via the pairs above.

### 7.3 Gradients — dark variants (spec)

Light gradients in `gradients.dart` are hardcoded. Until code adds theme-aware getters, design + eng use these **suggested dark stops** (derived from Violet / Grey / Green scales):

| Token | Light (current) | Dark (suggested) |
|---|---|---|
| `primaryGradient` / `violetGradient` | `#8974FF` → `#6143D9` | `Violet.400` `#8A72F7` → `Violet.700` `#5C3EEA` |
| `eliteUserGradient` | violet @ 20% → 0 | Same hue @ **12%** → 0 (less glow) |
| `yellowGradient` | gold multi-stop | **Keep** — badges stay high-contrast on dark cards |
| `pinkGradient` | `#F23464` → `#CF173F` | **Keep** or soften end to `Pink.900` `#D51C45` |
| `payBillGreenMemberShipGradient` | `#FFF` → `#D7FFCD` | `Grey.1000` `#232429` → `Green.1000` `#04320B` (optional mid `Green.800` @ 40%) |
| `payBillGradient` | `#191046` → `#8069F6` → `#E6E1FF` | `#191046` → `#694BF9` → `Violet.1100` `#201941` → `Grey.1100` `#161616` (no light lavender footer) |
| `liveTableSelectedGradient` | `#FAF9FF` → `#E8DFFF` | `Violet.1100` `#201941` → `Violet.1000` `#2D2165` |
| `darkVioletGradient` | `#622DA6` → `#223289` | **Keep** |
| `tierDiscountMembershipstatusGradient` | `#4E35C4` → `#201941` | **Keep** |
| membership green / red | multi-stop | Slightly deepen mid stops toward `*.800`; keep readable white text |
| QSR status gradients | already dark→bright | **Keep** |

### 7.4 Bitmap / motif assets (dark)

Provide `_dark` siblings (or theme-aware asset resolution):

| Asset | Dark direction |
|---|---|
| `home_bg.webp` | Flat `Grey.1100` base + soft `Violet.1100` radial wash (no bright lavender) |
| `gradient_search_bar.webp` | `Violet.900` → `Violet.1000` bar; white/translucent field |
| `discover_motif.png` | Muted `Violet.400` @ ~40% opacity on transparent |

Until assets ship, temporary fallback: solid `PageColors.background` / `PageColors.violet_100` — never leave light purple bitmaps on dark screens.

### 7.5 Chrome patterns in dark

| Surface | Dark treatment |
|---|---|
| Elite discovery header | `Violet.700`–`Violet.900` fill; chips at white @ 12–16% opacity |
| DD top bar | `Grey.1000` surface; logo inverted/light; badges `Grey.900` fill |
| DD bottom nav | Keep near-black; active white / gold coin; inactive `Grey.500` |
| Bottom sheets | `Grey.1000` surface; drag handle `Grey.700`; same radii as light |
| Primary CTA | Indigo/Violet fill per surface; **no** drop shadow |
| Tier stepper | Unlocked: Green 500 check; locked: `Grey.700` ring + lock; connector `Grey.800` |

### 7.6 Runtime go-live checklist

**Engineering (unblock dark)**
1. Restore persisted `isDarkTheme` from `darkThemeBox` (fallback: system brightness).
2. Fix `AppCubit.toggleDarkMode` to emit the **new** value and sync the global used by color getters.
3. Rebuild `ThemeData` / root when mode changes; uncomment drawer “Dark mode” toggle.
4. Replace const gradients with theme-aware getters matching §7.3.
5. Resolve dark bitmaps per §7.4.

**Design (ship with toggle)**
1. Critical screens in Figma light + dark: Home, Search, Restaurant, Live Status, Menu, Pay Bill, Sheets.
2. Contrast pass: body text on `Grey.1000` ≥ Grey 200; CTAs use suggested brand steps.
3. Drop dark reference PNGs into `design/references/` and index them.

### 7.7 Dark do / don’t

**Do:** use semantic tokens only; reduce glow; keep status copy identical.  
**Don’t:** pure `#000` backgrounds; neon borders; light lavender pay-bill footers; shadows; new accent hues “for dark.”

---

## 8. Perceived performance & retention

Design standards that keep the product feeling fast and keep diners in-flow. (Implementation debt that fights these — e.g. artificial 1s menu delay, 400ms restaurant fetch delay — should be removed.)

| Standard | Requirement |
|---|---|
| Skeleton-first | Lists and detail screens use **content-shaped** skeletons. Full-screen spinners only for unavoidable gatekeepers (auth). Inline spinners only on the control that is waiting (Add, Pay). |
| Instant chrome | Header, nav, search, and filters paint immediately; body streams in. No designed “wait before content.” |
| Optimistic micro-feedback | Add, favorite, Join Elite, filter chips update UI **immediately**; revert only on failure. |
| Sticky savings | Tier unlock (“₹X more to unlock Y%”) stays visible (bottom bar / FAB) while browsing or paying — drives AOV and return opens. |
| Paginated load-more | Discovery appends **2–3 skeleton rows**, not a centered spinner. |
| Motion budget | 150–200ms ease for fades/sheets; no decorative delay before meaningful content; sticky headers must not thrash layout every scroll frame. |
| Dark comfort | When dark is on: lower contrast chrome, no heavy shadows, softer gradients (§7) — better late-night dining sessions. |
| Empty / error recovery | Every empty or error state has one clear CTA (Retry, Browse nearby, Scan again) — never a dead end. |
| Pay-bill live clarity | Unlocked tier + payable amount update **while typing**; user always sees progress toward the next unlock. |

---

## 9. Motion & feedback

- Stepper progress animates along connector toward next tier.
- Buttons support async loading spinner in-place.
- Favorite heart toggles outline → filled.
- Prefer short ease transitions (150–250ms); avoid decorative motion that hides status.
- Align with §8 motion budget.

---

## 10. Accessibility & content

- Contrast: primary text on light surfaces ≥ Grey 900; on dark surfaces ≥ Grey 200; white text only on Indigo/Violet 500+ or dark overlays.
- Don’t rely on color alone for dietary — always show veg/non-veg markers.
- Touch targets: prefer ≥ 44px for primary actions; chips ≥ 32px height.
- Copy: title case for CTAs (“Pay Bill”, “View Cart”); sentence case for helper lines.
- Currency and distances localized for India (`₹`, `km`).

---

## 11. Do / Don’t

**Do**
- Reuse existing tokens, button types, and label pairs.
- Match Elite (violet) vs DD (indigo) by surface.
- Deliver light **and** dark frames for new components (per §7).
- Follow perceived-performance standards in §8.
- Document every new component with states + a reference frame (see extension guide).

**Don’t**
- Introduce new primary hues (no random blues/purples outside the scale).
- Mix Inter/Roboto/system UI fonts into product screens.
- Use heavy multi-shadow cards in DD menus (prefer dividers); never shadows in dark.
- Place marketing stickers/badges over hero photos except defined discount/favorite patterns.
- Invent new live-table status colors without updating `LabelColors` + copy table above.
- Design intentional loading delays or spinner-only full screens for content that can skeletonize.

---

## 12. Hand-off package for new work

For every new component, design delivers:

1. Figma (or equivalent) using tokens from this doc  
2. All states: default / hover-or-press / disabled / loading / empty / error  
3. **Light and dark** artboards (dark per §7)  
4. Annotated spacing + radius  
5. Screenshot dropped into `design/references/` + entry in `references/INDEX.md`  
6. Engineering note: which existing widget to extend (`CustomButtonWidget`, `TierDiscountWidget`, tags, etc.)  
7. Note any gradient/asset that needs a dark sibling from §7.3–7.4  

Follow [COMPONENT_EXTENSION.md](./COMPONENT_EXTENSION.md) for the full checklist.
