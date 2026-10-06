# Additions from the Diner app build

Changes folded back into the system after auditing the 50-screen Diner prototype against it.
Where the built design and the earlier spec disagreed, the built design won — these are shipped
values, not proposals.

## Colour

Light surfaces were re-tuned so a full screen of cards does not glare. `tokens/color.css` `:root`
now carries canvas `#F0EEF6`, surface `#FAF9FC`, muted `#E3DFEE`, outline `#DED9EB`,
on-surface-variant `#6E6B7C`, on-disabled `#B4B0C0`. Do not raise these back to white.

Eleven tokens that the app relied on but the system never named are now defined in both modes:

| Token | Purpose |
| --- | --- |
| `--pattern` | backdrop lattice / outline motif stroke |
| `--bloom` | soft radial violet bloom behind a headline |
| `--nav-bg`, `--nav-border`, `--nav-idle` | translucent navigation bar over content |
| `--row`, `--row-stroke` | flat feed rows that are not cards |
| `--pos`, `--pos-bg`, `--neg`, `--neg-bg` | binary recommendation ink (worth it / not) |

There is no `gray-*` custom property in this system. The gray-25→gray-950 ramp in the guide is
documentation prose; the shipped names are `--on-surface-variant`, `--text-secondary`,
`--on-disabled`. Reference those.

## Backdrop patterns — now sanctioned

The earlier rule ("no repeating patterns or textures") is relaxed. Repeating patterns are allowed,
in `--pattern` and `--bloom` only, on **pre-auth and marketing surfaces** (landing, entry, tutorial
and membership screens) and to break monotony on an otherwise empty screen. Three approved forms:

1. **Dot lattice** — `radial-gradient(circle at 1px 1px, var(--pattern) 1.1px, transparent 0)`,
   `background-size: 24px 24px`, always faded out with a `linear-gradient` to canvas so it never
   reaches the content edge.
2. **Violet bloom** — a 360px `radial-gradient` circle of `--bloom`, bled off one corner.
3. **Concentric DNA hex outline** — the hex mark at `stroke: var(--pattern)`, `stroke-width: .55`,
   oversized and bled off a corner.

Never behind a card, a media image, or a dense feed. One pattern per screen, plus the bloom.

## Gold — tightened

Gold (`#D4AF37`, `#F2CA50`, `--dna-axis`, `--dna-ring`) is for **DNA axis labels, the DNA ring, the
location pill, the `LATEST` tick, and membership / Amplify ornament** — nothing else. Eyebrow
labels, section kickers, spot counts and bullet marks use `--accent`. Gold must never read as rank.

## Iconography

Unicode glyphs are still not icons. The note-card bullet that shipped as a gold `◆` character is now
a 9px vector diamond filled `var(--accent)` — the DNA gem silhouette at bullet scale.

## Type — three sizes named

The Playfair scale is 32/40, 24/32, 20/28 as before, plus:

- `--type-display-tile` 16/20 — titles on small media tiles (150×190 and smaller).
- `--type-display-subtitle-tight` 20/20 — 20px display set solid in compact list rows.
- `--type-dna-title-compact` 900 20/28 — the DNA panel title inside a card, where 32/40 will not fit.
- `--type-wordmark` 700 32/40, `-1.6px`, `--accent` — the `elite` mark, lowercase and bold.
- `--type-wordmark-bar` 700 23/28, `-1.15px`, `--accent` — the same mark inside the app top bar,
  where 32px will not fit a 36px row. Both are lowercase; neither is ever title-cased.

Display numerals (balances, totals, prices) sit at 32/40 like any other hero — they are not licensed
to run larger. The 34, 36 and 38px figures that shipped have been brought back to 32.

## Radius

`--radius-sheet` and `--radius-search` are both 36. `--radius-note` 14 is a real container radius
for note cards, date chips, list tiles and small media tiles.

## Cards

The app's card treatment is a 1px `--outline` border plus the flat drop shadow, in both modes. This
supersedes the inset-hairline recipe for cards in the Diner surfaces; the inset hairline remains
correct for restaurant cards carrying glass chips.

## Colour token layer — consolidated

Every colour now has exactly one canonical declaration; semantic names reference it with `var()`
instead of repeating a hex. 123 duplicated literals became 264 references across
`primitives.css`, `color.css` and `components/core/fig-tokens.css`. Computed values are unchanged.

Two name collisions were resolved and must not be reintroduced:

- `--gray-900` is the palette near-black `#1A172A`. Figma's own `#1E1E1E` is now
  `--fig-gray-900` — a different colour with a different job (icon default).
- `--dna-axis` / `--dna-ring` are declared **only** in `tokens/color.css`. `fig-tokens.css`
  no longer redeclares them; it used to win the cascade and force the dark gold into Light.

`--dna-axis` in Light is `#8A6A16`, not `#F2CA50`. Gold as **text on a light canvas** needs the
dark value (4.8:1 against canvas); `#F2CA50` on `#F9F9FA` measured 2.1:1 and was unreadable.
Keep the roles apart: `--dna-axis` is gold ink, `--dna-ring` is a gold fill sitting under dark text.

## Components the app drew and the system did not have

Recipes as shipped. All use inline values from the token set above.

**Experience card** (Explore results, Home rail, 2-up grid at 172px or grid `1fr 1fr`).
Media 124–152px; radius 16; surface fill with 1px `--outline`. On the media, top-left, a
22px glass pill (`rgba(10,10,12,.5)`, blur 12, 1px `rgba(255,255,255,.24)`) carrying the author
initial **and name**; top-right the **Follow** chip in `--accent` at 18% on a .4 border. Below the
media: timestamp, then the Worth It / Not Worth chip pushed right (`--pos` / `--neg` at 18% on a
.5 border), then the one-liner in Playfair 13/18, uppercase, `.5px` tracking, clamped to 2 lines.
The recommendation chip never sits on the media — that space is identity and follow.

**Offer banner carousel** (place profile). 290×132 media cards, radius 16, snapping
(`scroll-snap-type: x mandatory` + `scroll-snap-align: start`), gap 11. Eyebrow chip top-left on a
92%-opaque token fill with `#0A0A0C` text; Playfair 19/24 headline and an 10.5px forward hint over a
`rgba(10,10,12,.2)→.88` gradient. Each banner forwards to a real destination — Live Menu, a
category, or a dish — never to a dead "details" row. Page dots track scroll position.

**Vote row** (experience detail). Helpful and Not helpful are **both present**, as two `flex:1`
pills on `--muted`, 44px tall, 12.5px/600 with `white-space: nowrap`; the positive carries the
count, the negative does not. Trailing paperclip and share buttons are 44px, not 52 — at 350px of
content width the label wraps otherwise.

**Two-page DNA sheet.** 360px sheet, radius 20, two horizontally snapping pages with dots.
Page 1 is title + `it's not a rating` + the radar at 308px + nothing else. Page 2 is the gem in a
50px radial-violet disc, the title, both taglines, then the explainer prose at 11.5/17.
The radar's base hexagon is a **gold glow**, not an outline: `--dna-ring` stroke at 1.5 through a
`feGaussianBlur stdDeviation="5"` merged twice under the source, drawn *above* the inner grid
rings. Data vertices carry 3.4px white dots. The same treatment applies to the tutorial radar.

**Bottom-sheet family** (Add to curation, New curation, Add restaurants). One idiom, since any of
them can be the entry point: scrim `--scrim`; sheet radius 24 top only; a 40×4 handle at 40%;
title 600 20/100%; subtitle 400 13/130% `--on-surface-variant`; body rows 72px on `--muted` at
radius 20, selected state `inset 0 0 0 1.5px var(--accent)`; one 49px primary action at radius 20 in
`--accent-strong`. Search inside a sheet keeps `--radius-search` 36.

**Amplify pill.** 32px glass pill (`rgba(255,255,255,.14)`, blur 20) with the sparkle glyph, top-right
of any surface showing a publishable item — feed slide, dish page. It is an author action, so it
never appears on another diner's card.

**Vibe circle.** 80px photo at 80% opacity under a `rgba(0,0,0,.5)→0` gradient with a white glyph
centred, label 11px below, 84px column. Explore landing and the searching state both keep the rail
visible so the filter set never disappears mid-query.

## Experience DNA belongs to restaurants

DNA is generated from diners' sentiment about a **restaurant**. The gem and the radar appear on
place profiles, restro stories (top-right, beside the author badge) and restaurant cards. They do
**not** appear on an experience — not in the experience feed rail, not on experience detail. An
experience carries Worth it / Not worth it, which is one diner's call for one visit.
