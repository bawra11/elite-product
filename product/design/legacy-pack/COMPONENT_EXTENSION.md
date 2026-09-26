# Component Extension Guide

Use this when designing **new** or **extra** components for Elite / Explorex. Goal: stay consistent with production UI and make engineering reuse existing widgets.

## Before you start

1. Read [DESIGN.md](./DESIGN.md) — colors, type, spacing, existing components.
2. Search [references/INDEX.md](./references/INDEX.md) for a close sibling screen.
3. Ask: can this be a **variant** of an existing component?
   - Button → `CustomButtonWidget` (`primary` / `secondary` / `gradient` …)
   - Chip / status → `LabelColors` pill
   - Discount progress → `TierDiscountWidget`
   - Dish meta → `DishItemTag` / meat icons
   - Card → restaurant card / list row patterns

If yes, design the variant — do not invent a parallel pattern.

---

## New component checklist

### 1. Intent
- [ ] One job only (e.g. “show live table urgency”, not “card + filters + CTA”)
- [ ] Named clearly (`LiveStatusPill`, `MembershipUpsellBar`, …)
- [ ] Maps to Elite (violet) or Digital Dining (indigo) surface

### 2. Tokens
- [ ] Colors only from brand scales / semantic tokens in DESIGN.md
- [ ] Type only from Poppins ramp (`Header` / `Subheader` / `Body` / `Bold`)
- [ ] Spacing on 4pt grid; radius from documented set
- [ ] Icons: linear CustomIcons style; size 12 / 16 / 24

### 3. States (required artboards)
| State | Required? |
|---|---|
| Default | Always |
| Light + dark | Always (see DESIGN.md §7) |
| Pressed / active | Interactive only |
| Disabled | If CTA or input |
| Loading | Skeleton-shaped for screens; spinner only on the control (DESIGN.md §8) |
| Empty | If data-driven — must include recovery CTA |
| Error / warning | If failure possible — must include recovery CTA |
| Selected vs unselected | If toggle / filter |
| Locked vs unlocked | If progress / membership |

### 4. Content rules
- [ ] Title + one supporting line max in compact rows
- [ ] Prices: bold current + strikethrough MRP when discounted
- [ ] Status copy matches live-table or tier tables in DESIGN.md
- [ ] No decorative badges on hero media unless discount / favorite pattern

### 5. Layout specs to annotate
- [ ] Width behavior (hug / fill / max)
- [ ] Min height / touch target (≥ 44 for primary CTA)
- [ ] Padding, gaps, corner radius
- [ ] Safe area / sticky bottom if sticky CTA
- [ ] Dark overlay vs solid sheet if modal

### 6. Engineering hand-off note
Include a short block in the Figma cover / PR description:

```
Component: <Name>
Extends: <existing widget or "new">
Surface: Elite | Digital Dining | Shared
Tokens: Violet.500 / Indigo.600 / LabelColors.* …
Dark: uses semantic tokens + gradient/asset siblings from DESIGN.md §7
Perf: skeleton-first / optimistic UI per DESIGN.md §8
References: design/references/<path>
```

### 7. File the reference
- [ ] Export PNG/JPG of the approved frame
- [ ] Save under `design/references/marketing/` or `app-flows/`
- [ ] Add a row to `references/INDEX.md`
- [ ] Link from the ticket / PR

---

## Pattern recipes (extend these)

### Primary sticky CTA
Full-width Large button · Indigo primary (DD) or Violet gradient (Elite) · optional caption under label · sits above bottom nav / home indicator.

### Soft promo banner
Full-bleed strip · success green gradient or membership violet · leading icon · title + helper · trailing chevron · tappable.

### List row with trailing action
Thumb (12–16r or circle) · title · meta grey · pills · trailing icon (heart / chevron). Hairline divider between rows in DD.

### Modal sheet
White · top radius 24–32 · drag handle · centered brand mark if offer · body · T&C link · CTA.

### Progress unlock
Stepper or circular % · green for achieved · grey + lock for pending · helper “Add ₹X & unlock Y% OFF”.

---

## Review gate (design + eng)

Reject / revise if:
- New hex outside the documented scales
- New font family (except approved script for partner badges)
- Button that is not one of `ButtonType` variants without a documented exception
- Status color that conflicts with Calm & Cozy / Filling Fast / Running Hot
- Component that duplicates restaurant card / tier stepper / dish tag with different visual language
- Light-only delivery with no dark artboard
- Full-screen spinner where a skeleton is possible
- Light lavender / white gradient footers proposed for dark pay-bill surfaces

---

## Template: component brief (copy into ticket)

```markdown
### Component brief
**Name:**
**Surface:** Elite | DD | Shared
**Problem:**
**User action:**
**Closest existing component:**
**States needed:**
**Content examples:**
**Reference frame:** design/references/...
**Out of scope:**
```
