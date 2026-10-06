---
version: alpha
name: Experience
description: Mobile design system for Experience (Figma file Experience Quality). Two color systems (Light, Dark) and two mutually exclusive surface treatments (Flat, Glass). Experience DNA is the place-character radar, also Light/Dark via Elite / Color. Source of truth in Figma variables and components; this file is the agent-readable record.
colors:
  primary: "#745AEB"
  on-primary: "#FFFFFF"
  primary-container: "#C9BEFF"
  on-primary-container: "#0A0A0C"
  inverse-primary: "#A394F3"
  secondary: "#8E8E93"
  on-secondary: "#FFFFFF"
  tertiary: "#D4AF37"
  on-tertiary: "#0A0A0C"
  error: "#FF2D55"
  on-error: "#FFFFFF"
  success: "#6DE3A6"
  on-success: "#0A0A0C"
  warning: "#D4AF37"
  on-warning: "#0A0A0C"
  white: "#FFFFFF"
  black: "#000000"
  purple-300: "#C9BEFF"
  purple-400: "#A394F3"
  purple-500: "#745AEB"
  purple-600: "#6D5CFF"
  gray-25: "#F9F9FF"
  gray-50: "#F9F9FA"
  gray-200: "#EAE6F4"
  gray-400: "#C7C7CC"
  gray-500: "#8E8E93"
  gray-600: "#474555"
  gray-700: "#1F1F1F"
  gray-800: "#272241"
  gray-900: "#1A172A"
  gray-950: "#0A0A0C"
  gold-400: "#F2CA50"
  gold-500: "#D4AF37"
  dna-title-light: "#5847A5"
  dna-title-dark: "#A394F3"
  dna-axis-light: "#EBA82B"
  dna-fill-core: "#B2A2FF"
  dna-grid-light: "#EAE6F4"
  dna-grid-dark: "#272241"
  reco-worth: "#3C4E45"
  reco-not-worth: "#5E2B5A"
  green-300: "#53EB8D"
  green-400: "#6DE3A6"
  red-500: "#FF2D55"
  red-800: "#A3001B"
  light-canvas: "#F9F9FA"
  light-surface: "#FFFFFF"
  light-surface-elevated: "#FFFFFF"
  light-muted: "#EAE6F4"
  light-inverse: "#0A0A0C"
  light-on-surface: "#0A0A0C"
  light-on-surface-variant: "#8E8E93"
  light-on-disabled: "#C7C7CC"
  light-outline: "#EAE6F4"
  light-accent: "#745AEB"
  light-accent-strong: "#6D5CFF"
  light-scrim: "#00000059"
  light-glass-fill: "#FFFFFF29"
  light-glass-fill-strong: "#FFFFFF5C"
  light-glass-stroke: "#FFFFFF8F"
  light-glass-highlight: "#FFFFFFA6"
  light-glass-text: "#0A0A0C"
  dark-canvas: "#0A0A0C"
  dark-surface: "#1A172A"
  dark-surface-elevated: "#272241"
  dark-muted: "#272241"
  dark-inverse: "#F9F9FA"
  dark-on-surface: "#F9F9FA"
  dark-on-surface-variant: "#C7C7CC"
  dark-on-disabled: "#474555"
  dark-outline: "#1F1F1F"
  dark-accent: "#A394F3"
  dark-accent-strong: "#745AEB"
  dark-scrim: "#00000099"
  dark-glass-fill: "#FFFFFF1F"
  dark-glass-fill-strong: "#1A172A99"
  dark-glass-stroke: "#FFFFFF40"
  dark-glass-highlight: "#FFFFFF59"
  dark-glass-text: "#FFFFFF"
  surface: "{colors.light-surface}"
  on-surface: "{colors.light-on-surface}"
  background: "{colors.light-canvas}"
  on-background: "{colors.light-on-surface}"
  outline: "{colors.light-outline}"
  dna-title: "{colors.dna-title-light}"
  dna-axis: "{colors.dna-axis-light}"
  dna-axis-dark: "{colors.gold-400}"
  dna-percent: "{colors.primary}"
  dna-percent-dark: "{colors.purple-300}"
  dna-caption: "{colors.light-on-surface-variant}"
  dna-caption-dark: "{colors.purple-300}"
  dna-grid: "{colors.dna-grid-light}"
  dna-fill: "{colors.dna-fill-core}"
  dna-sheet: "{colors.light-canvas}"
  dna-sheet-dark: "{colors.dark-surface}"
  dna-ring: "{colors.gold-500}"
  dna-ring-dark: "{colors.gold-400}"
typography:
  display-hero:
    fontFamily: Playfair Display
    fontSize: 32px
    fontWeight: "400"
    lineHeight: 40px
  display-title:
    fontFamily: Playfair Display
    fontSize: 24px
    fontWeight: "400"
    lineHeight: 32px
  display-subtitle:
    fontFamily: Playfair Display
    fontSize: 20px
    fontWeight: "400"
    lineHeight: 28px
  headline-lg:
    fontFamily: Poppins
    fontSize: 22px
    fontWeight: "600"
    lineHeight: 28px
  headline-md:
    fontFamily: Poppins
    fontSize: 17px
    fontWeight: "600"
    lineHeight: 22px
  body-md:
    fontFamily: Poppins
    fontSize: 14px
    fontWeight: "400"
    lineHeight: 20px
  body-sm:
    fontFamily: Poppins
    fontSize: 13px
    fontWeight: "400"
    lineHeight: 18px
  label-md:
    fontFamily: Poppins
    fontSize: 13px
    fontWeight: "500"
    lineHeight: 18px
  label-sm:
    fontFamily: Poppins
    fontSize: 12px
    fontWeight: "500"
    lineHeight: 16px
  caption:
    fontFamily: Poppins
    fontSize: 11px
    fontWeight: "400"
    lineHeight: 14px
  button:
    fontFamily: Poppins
    fontSize: 15px
    fontWeight: "600"
    lineHeight: 20px
  dna-title:
    fontFamily: Playfair
    fontSize: 32px
    fontWeight: 900
    lineHeight: 40px
  dna-tagline:
    fontFamily: Poppins
    fontSize: 15px
    fontWeight: 300
    lineHeight: 22px
  dna-axis:
    fontFamily: Poppins
    fontSize: 11px
    fontWeight: 300
    lineHeight: 12px
  dna-percent:
    fontFamily: Poppins
    fontSize: 11px
    fontWeight: 700
    lineHeight: 12px
  dna-body:
    fontFamily: Poppins
    fontSize: 8px
    fontWeight: 400
    lineHeight: 16px
rounded:
  sm: 12px
  md: 16px
  lg: 20px
  xl: 36px
  full: 9999px
spacing:
  0: 0px
  xs: 4px
  sm: 8px
  md: 12px
  lg: 16px
  xl: 20px
  2xl: 24px
  3xl: 32px
  4xl: 40px
  screen-gutter: 20px
  button-height: 48px
  chip-height: 32px
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    typography: "{typography.button}"
    rounded: "{rounded.full}"
    height: 48px
    padding: 20px
  button-primary-pressed:
    backgroundColor: "{colors.purple-600}"
    textColor: "{colors.on-primary}"
  button-primary-disabled:
    backgroundColor: "{colors.gray-200}"
    textColor: "{colors.gray-600}"
  button-secondary:
    backgroundColor: "{colors.light-surface}"
    textColor: "{colors.light-on-surface}"
    typography: "{typography.button}"
    rounded: "{rounded.full}"
    height: 48px
    padding: 20px
  button-ghost:
    backgroundColor: "{colors.light-canvas}"
    textColor: "{colors.purple-600}"
    typography: "{typography.button}"
    rounded: "{rounded.full}"
    height: 48px
  button-glass:
    backgroundColor: "{colors.light-glass-fill-strong}"
    textColor: "{colors.light-glass-text}"
    typography: "{typography.button}"
    rounded: "{rounded.full}"
    height: 48px
    padding: 20px
  button-glass-dark:
    backgroundColor: "{colors.dark-glass-fill-strong}"
    textColor: "{colors.dark-glass-text}"
    typography: "{typography.button}"
    rounded: "{rounded.full}"
    height: 48px
    padding: 20px
  chip-flat:
    backgroundColor: "{colors.light-muted}"
    textColor: "{colors.light-on-surface}"
    typography: "{typography.label-sm}"
    rounded: "{rounded.full}"
    height: 32px
    padding: 12px
  chip-flat-selected:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    typography: "{typography.label-sm}"
    rounded: "{rounded.full}"
    height: 32px
  chip-glass:
    backgroundColor: "{colors.light-glass-fill}"
    textColor: "{colors.light-glass-text}"
    typography: "{typography.label-sm}"
    rounded: "{rounded.full}"
    height: 32px
    padding: 12px
  chip-glass-dark:
    backgroundColor: "{colors.dark-glass-fill-strong}"
    textColor: "{colors.dark-glass-text}"
    typography: "{typography.label-sm}"
    rounded: "{rounded.full}"
    height: 32px
  badge-success:
    backgroundColor: "{colors.success}"
    textColor: "{colors.on-success}"
    typography: "{typography.label-sm}"
    rounded: "{rounded.full}"
    padding: 8px
  badge-warning:
    backgroundColor: "{colors.warning}"
    textColor: "{colors.on-warning}"
    typography: "{typography.label-sm}"
    rounded: "{rounded.full}"
    padding: 8px
  badge-error:
    backgroundColor: "{colors.error}"
    textColor: "{colors.on-error}"
    typography: "{typography.label-sm}"
    rounded: "{rounded.full}"
    padding: 8px
  card-flat:
    backgroundColor: "{colors.light-surface}"
    textColor: "{colors.light-on-surface}"
    rounded: "{rounded.md}"
    padding: 16px
  card-flat-dark:
    backgroundColor: "{colors.dark-surface}"
    textColor: "{colors.dark-on-surface}"
    rounded: "{rounded.md}"
    padding: 16px
  card-restaurant:
    backgroundColor: "{colors.light-surface-elevated}"
    textColor: "{colors.light-on-surface}"
    rounded: "{rounded.md}"
    padding: 16px
  card-restaurant-dark:
    backgroundColor: "{colors.dark-surface-elevated}"
    textColor: "{colors.dark-on-surface}"
    rounded: "{rounded.md}"
    padding: 16px
  card-glass:
    backgroundColor: "{colors.light-glass-fill-strong}"
    textColor: "{colors.light-glass-text}"
    rounded: "{rounded.md}"
    padding: 16px
  card-glass-dark:
    backgroundColor: "{colors.dark-glass-fill-strong}"
    textColor: "{colors.dark-glass-text}"
    rounded: "{rounded.md}"
    padding: 16px
  input-field:
    backgroundColor: "{colors.light-surface}"
    textColor: "{colors.light-on-surface}"
    typography: "{typography.body-md}"
    rounded: "{rounded.sm}"
    padding: 16px
    height: 48px
  input-field-dark:
    backgroundColor: "{colors.dark-surface-elevated}"
    textColor: "{colors.dark-on-surface}"
    typography: "{typography.body-md}"
    rounded: "{rounded.sm}"
    padding: 16px
    height: 48px
  input-glass:
    backgroundColor: "{colors.light-glass-fill-strong}"
    textColor: "{colors.light-glass-text}"
    typography: "{typography.body-md}"
    rounded: "{rounded.sm}"
    padding: 16px
    height: 48px
  input-glass-dark:
    backgroundColor: "{colors.dark-glass-fill-strong}"
    textColor: "{colors.dark-glass-text}"
    typography: "{typography.body-md}"
    rounded: "{rounded.sm}"
    padding: 16px
    height: 48px
  overlay-scrim:
    backgroundColor: "{colors.light-scrim}"
  overlay-scrim-dark:
    backgroundColor: "{colors.dark-scrim}"
  dna-reco-worth:
    backgroundColor: "{colors.reco-worth}"
    textColor: "{colors.white}"
    typography: "{typography.caption}"
    rounded: "{rounded.full}"
    height: 26px
    padding: 10px
  dna-reco-not-worth:
    backgroundColor: "{colors.reco-not-worth}"
    textColor: "{colors.white}"
    typography: "{typography.caption}"
    rounded: "{rounded.full}"
    height: 26px
    padding: 10px
  dna-axis-label:
    textColor: "{colors.dna-axis}"
    typography: "{typography.dna-axis}"
  dna-axis-label-dark:
    textColor: "{colors.dna-axis-dark}"
    typography: "{typography.dna-axis}"
  dna-axis-percent:
    textColor: "{colors.dna-percent}"
    typography: "{typography.dna-percent}"
  dna-axis-percent-dark:
    textColor: "{colors.dna-percent-dark}"
    typography: "{typography.dna-percent}"
  dna-caption:
    textColor: "{colors.dna-caption}"
    typography: "{typography.dna-tagline}"
  dna-caption-dark:
    textColor: "{colors.dna-caption-dark}"
    typography: "{typography.dna-tagline}"
  exp-score:
    backgroundColor: "{colors.dark-surface}"
    textColor: "{colors.dna-ring}"
    width: 75px
    height: 71px
  exp-score-dark-ring:
    backgroundColor: "{colors.dark-surface}"
    textColor: "{colors.dna-ring-dark}"
    width: 75px
    height: 71px
  exp-score-default:
    backgroundColor: "{colors.dark-surface}"
    textColor: "{colors.dna-fill}"
    width: 46px
    height: 53px
  exp-score-small:
    backgroundColor: "{colors.dark-surface}"
    textColor: "{colors.dna-fill}"
    width: 29px
    height: 34px
  exp-score-popup:
    backgroundColor: "{colors.dna-sheet}"
    textColor: "{colors.dna-title}"
    typography: "{typography.dna-title}"
    rounded: "{rounded.lg}"
    padding: 16px
    width: 360px
    height: 363px
  exp-score-popup-dark:
    backgroundColor: "{colors.dna-sheet-dark}"
    textColor: "{colors.dna-title-dark}"
    typography: "{typography.dna-title}"
    rounded: "{rounded.lg}"
    padding: 16px
    width: 360px
    height: 363px
---

## Brand & Style

Experience is a curation and discovery product. The UI should feel editorial and intimate: Playfair Display for titles, Poppins for UI, and a single violet accent (`#745AEB` / `#A394F3`) against near-black and warm off-white.

There are **two independent color systems** — Light and Dark — implemented in Figma as Color collection modes, not as one palette with ad-hoc overrides.

There are **two surface treatments** that never mix as a general language:

1. **Flat** — opaque fills, 1px borders, soft drop shadows. Default for tutorials, auth forms, Home lists, Explore lists, and restaurant cards.
2. **Glass** — translucent fill + stroke + background blur. Used only as a coherent glass-mode screen/flow, or in the two exceptions below.

**Allowed glass exceptions (not mixed language):**

- **Media overlay:** Discovery, Restro Stories, and similar full-bleed media scrollers use glass chrome so controls stay readable while the background media stays visible.
- **Restaurant card chips:** Restaurant cards stay **flat**. Glass is allowed **only** on chips/buttons sitting on that flat card — never on the card surface itself.

Do not sprinkle glass cards onto otherwise flat screens. Do not convert Discovery media chrome to flat cards.

Experience DNA is the character of a place, not a rating. The radar is built from diner mentions. Service, Food, and Value always show. Other axes unlock when enough people talk about them. A lopsided shape can still be worth the visit. Recommendation (worth it / not worth it) is a separate chip. Gold is for axis labels and DNA name in copy. Never use gold as a score glow that implies rank.

Figma: [Experience Quality](https://www.figma.com/design/DvkkRmdpmdi4AovFW0fkDb/Experience-Quality) · Foundations `461:1721` · Experience DNA `784:7149`. Collections: `Elite / Primitives`, `Elite / Color` (Light/Dark), `Elite / Spacing`, `Elite / Radius`.

## Colors

Light and Dark are **two systems**. Switch the Figma `Elite / Color` mode (`Light` `458:2` / `Dark` `458:1`) on a frame; do not restyle with leftover hex.

Figma semantic aliases map to the tokens below: `bg/muted` → muted, `bg/glass-strong` → glass-fill-strong, `bg/scrim` → scrim, `bg/accent` → accent, `border/glass` → glass-stroke, `border/outline` → outline, `text/glass` → glass-text, `text/disabled` → on-disabled.

**Light system** (Color mode Light → aliases to Primitives):

- **Canvas (`light-canvas` / `#F9F9FA`):** Screen background.
- **Surface (`light-surface` / `#FFFFFF`):** Flat cards, sheets, inputs.
- **On-surface (`light-on-surface` / `#0A0A0C`):** Primary text.
- **Secondary (`light-on-surface-variant` / `#8E8E93`):** Captions, meta.
- **Accent (`light-accent` / `#745AEB`):** Primary actions, selected chips.
- **Glass (`light-glass-fill` `#FFFFFF29`, stroke `#FFFFFF8F`):** Overlay and chip recipes only.

**Dark system** (Color mode Dark):

- **Canvas (`dark-canvas` / `#0A0A0C`).**
- **Surface (`dark-surface` / `#1A172A`), elevated (`dark-surface-elevated` / `#272241`).**
- **On-surface (`dark-on-surface` / `#F9F9FA`).**
- **Accent (`dark-accent` / `#A394F3`)** — lighter violet for contrast on dark surfaces.
- **Glass (`dark-glass-fill` `#FFFFFF1F`, strong `#1A172A99`).**

**Shared primitives** live in Figma collection `Elite / Primitives` (single Value mode): purple (including `color/purple/600`), gray, gold/yellow, green, red, glass fills/strokes, scrim. Semantic Color tokens alias these; never duplicate raw hex on components.

Success `#6DE3A6` / `#53EB8D`, warning gold, error `#FF2D55` are semantic in both modes.

**Experience DNA** (Color mode Light `458:2` / Dark `458:1`). Switch the frame mode. Do not duplicate Light components.

- **Title (`dna-title` / `#5847A5` Light, `#A394F3` Dark):** Playfair Black lockup "Experience DNA". Purple, not gold.
- **Axis (`dna-axis` / `#EBA82B` Light, `#F2CA50` Dark):** Property names on the radar (Service, Food, Value).
- **Percent (`dna-percent`):** Bold Poppins on each axis. Mention-weighted character, not stars.
- **Fill (`dna-fill` / `#B2A2FF`):** Polygon core. Radial glow is character, not rank.
- **Grid (`dna-grid` / `#EAE6F4` Light, `#272241` Dark):** Concentric hex strokes.
- **Sheet (`dna-sheet`):** Popup surface. Light canvas / dark surface.
- **Reco (`reco-worth` `#3C4E45`, `reco-not-worth` `#5E2B5A`):** Independent of polygon roundness. A low Location axis is not this chip.

## Typography

Product type is **Playfair Display** for display titles and **Poppins** (Regular / Medium / SemiBold) for UI. Status bars may use SF Pro; do not introduce Inter as a third UI family on new work.

- **Display:** Playfair Regular 32 / 24 / 20 for editorial headings (tutorials, auth, place names).
- **Titles:** Poppins SemiBold 22 and 17 for screen and card titles.
- **Body:** Poppins Regular 14 and 13.
- **Labels / chips:** Poppins Medium 13 and 12.
- **Buttons:** Poppins SemiBold 15, 48px control height.

Figma text styles: `Type/Display/*`, `Type/Title/*`, `Type/Body/*`, `Type/Label/*`, `Type/Caption`, `Type/Button`.

**Experience DNA** uses a tighter set. Playfair Black for the DNA title. Poppins Light / Regular / Bold for explanation.

- **dna-title:** Playfair Black 32 / 40. The words "Experience DNA" only.
- **dna-tagline:** Poppins Light 15 / 22. "we LOVE all shapes", "it's not a rating".
- **dna-axis:** Poppins Light 11 / 12, gold.
- **dna-percent:** Poppins Bold 11 / 12, purple.
- **dna-body:** Poppins Regular 8 / 16. Explainer copy on the popup sheet.

Do not introduce a composite DNA score type. The 68% mark in some mocks is not a product rating. Do not ship it as a headline number.

## Layout & Spacing

Mobile frames are **390 × 884**. Horizontal gutter is 20px. Rhythm is a **4px** scale (`spacing/1` = 4) with 8px as the common step.

- Stack related blocks with 12–16px gaps.
- Section breaks 24–32px.
- Buttons hug content horizontally, fixed 48px height, 20px horizontal padding.
- Chips 32px height, 12px horizontal padding.
- Cards 16px internal padding.

Figma collection `Elite / Spacing` (`space/xs`–`space/4xl`, plus `space/screen-gutter`, `space/button-height`, `space/chip-height`).

## Elevation & Depth

**Flat mode** uses opacity and shadow, not blur:

- Low: drop shadow y:1 blur:2 at 8% black (`Elevation/Flat/Low`).
- Card: y:4 blur:12 at 12% black (`Elevation/Flat/Card`).
- Hierarchy also via `surface` vs `surface-elevated` vs `muted`.

**Glass mode** uses refraction, not drop-shadow hierarchy:

- Chip / control: background blur **12** (`Glass/Chip`, `glass/blur/chip`).
- Media overlay chrome: blur **20** (`Glass/Overlay`).
- Sheets over media: blur **40** (`Glass/Sheet`).
- Always pair blur with `color/glass/fill` (or fill-strong) and a 1px `color/glass/stroke`.

Do not stack a glass card on a flat list to “add depth.” If the screen is flat, elevate with Flat/Card shadow only.

**Experience DNA** uses inner glow on the polygon (`dna-fill`), not drop shadow as rank. Hex mark Large uses existing glow styles for the ring. Gold on the hex is outline, not a trophy. The popup sheet uses Flat/Card shadow like other sheets.

## Shapes

Corners are pill-forward for actions and moderately rounded for containers.

- **Buttons and chips:** `rounded.full` (9999).
- **Inputs:** `rounded.sm` (12px).
- **Cards (including restaurant):** `rounded.md` (16px). Home hero tiles may use 18–20px (`rounded.lg`).
- **Large media masks / map sheets:** up to `rounded.xl` (36px).

Figma collection `Elite / Radius` (`radius/sm` 12, `md` 16, `lg` 20, `xl` 36). Do not mix 2px hairline radii with 16px cards on the same screen except for hairline dividers.

Reco chips are `rounded.full`. DNA popup sheet is `rounded.lg` (20px). The radar itself is hexagonal. Do not round the polygon into a circle to make it nicer.

## Components

Figma component sets live on the **Foundations** page (`Button`, `Chip`, `Card`, `Input`, `Badge`). Variant axis `Style=Flat | Glass` is exclusive: pick one per instance. Restaurant cards use `Kind=Restaurant` (always flat); place `Chip` `Style=Glass` on top, never change the card to Glass.

### Buttons

`Button` — Style × Kind (Primary / Secondary / Ghost) × State (Default / Pressed / Disabled). Primary is solid accent in both Flat and Glass screens (legibility). Secondary Flat is opaque surface + outline. Secondary Glass uses glass fill, stroke, and Chip blur. Ghost is text-only. Label is a TEXT property.

Use Glass buttons only on glass-mode flows, media overlays, or as actions on a flat restaurant card.

### Chips

`Chip` — Style × State (Default / Selected). **Glass chips on restaurant cards are the only chip-on-card exception.** Do not glass-ify other card types with this pattern unless the file already uses it.

### Cards

`Card` — Kind=Flat | Restaurant | Glass.

- Flat / Restaurant: opaque surface, border, Flat/Card shadow. Restaurant copy documents that chips on it may be glass.
- Glass: glass fill + Overlay blur. **Only** on coherent glass screens — never Kind=Glass for a restaurant.

### Inputs

`Input` — Style (Flat / Glass), 48px, `rounded.sm` (12px), body-md placeholder. Flat uses opaque `bg/surface` + `border/outline`. Bind to Light/Dark color modes. Glass uses `bg/glass-strong` and exists only inside glass-mode sheets (auth sheet over photo), not on flat OTP/profile screens.

### Badges

`Badge` — Tone Success / Warning / Error. Pill (`rounded.full`), label-sm. Success `#6DE3A6`, Warning gold `#D4AF37`, Error `#FF2D55`. Use on flat lists and cards; do not restyle as glass.

### Overlays

Auth sheets over photography and Discovery / Restro Stories chrome use glass fill-strong + Sheet/Overlay blur + scrim. Keep the underlying media visible.

### Experience DNA

Product copy lives in `docs/experience-dna.md`. Visual source: Figma page Experience DNA (`784:7149`). Bind to `dna/*` and `reco/*` variables. Light and Dark are Color modes on the frame.

**Exp Score** (`173:985`) is the hex thumbnail. Size Large / Default / Small. Count 6 is the hex mark. Small also has Worth it / Not worth it / reco variants that must not replace the Reco Chip on a profile. The polygon fill is `dna-fill`. Ring stroke is `dna-ring`. Do not sort or badge by how round the polygon looks.

**Exp Score Popup** Dark `400:1537`, Light `490:6247`. 360 × 363 sheet. Title "Experience DNA" uses `dna-title` + `dna-title` type. Axis labels use DNA Axis Label. Caption near the chart is one of: "It's just some attributes to be aware of." / "The shape is the nature of the place, not a verdict." Locked axes stay hidden. Never render them as 0%.

**DNA Reco Chip** (`784:7242`) Tone=Worth it | Not worth it. Pill, 26px, `reco-worth` / `reco-not-worth`, inverse label. Independent of DNA shape. Do not derive this chip from a low axis.

**DNA Axis Label** (`785:7174`) Layout=Inline | Percent first | Name first. Percent uses `dna-percent`. Name uses `dna-axis`. TEXT properties Percent and Name. Service stays at 12 o'clock. Value sits at 11 o'clock. Order never shuffles for aesthetics.

## Do's and Don'ts

- Do switch Light vs Dark via the Color variable mode on the screen frame.
- Don't restyle Dark by painting leftover Light hex values.
- Do keep a screen **either** Flat **or** Glass as a coherent treatment.
- Don't put glass chrome on a flat screen as decoration.
- Do use glass on Discovery, Restro Stories, and other full-bleed media so UI stays readable over video/photos.
- Don't flatten Discovery or Restro Stories overlays into solid cards.
- Do keep restaurant cards flat; glass only the chips/buttons on that card.
- Don't make the restaurant card itself glass.
- Don't sprinkle glass chips onto unrelated flat card types.
- Do bind fills, strokes, radius, and gap to Figma variables; keep Playfair + Poppins.
- Don't mix Inter as a third UI font on new components (existing screens may still contain Inter; prefer Poppins on replacement).
- Do use 48px primary buttons and 32px chips for touch targets.
- Don't mix 12px and 16px card radii in the same list without intent.
- Do treat Experience DNA as character. Copy may say nature, aware of, we LOVE all shapes.
- Don't call it a rating, grade, "high DNA", or "perfect shape."
- Do keep worth-it / not-worth-it as Reco Chip, separate from the radar.
- Don't sort Explore by polygon roundness or hide a place because Location is 42%.
- Do hide locked axes. Silence does not invent a 0% Hygiene tick.
- Don't use gold as a score glow. Gold is axis labels and DNA name in body copy. The title lockup is purple.
- Do switch DNA Light / Dark via Elite / Color on the frame.
- Don't duplicate Exp Score or Popup into extra Light component sets.
