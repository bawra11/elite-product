# Design system audit — Experience Diner App

Audited against the **elite / Experience** system guide. Grouped by severity. Nothing changed yet.

---

## P1 — Structural

**1. The design system bundle is not loaded.**
The DC has no `_ds/…` stylesheet links and no `_ds_bundle.js`. Every token is a hardcoded hex with a
`var(--x, #fallback)` of our own invention (`--on`, `--on-var`, `--outline`, `--muted`), so the file is
visually *similar* to the system but not *bound* to it. Consequence: Light/Dark don't come from
`Elite / Color` modes, and the shipped fonts (`tokens/fonts.css`) aren't the ones rendering.

**2. Components are hand-rolled where the system ships them.**
StatusBar, NavigationBar(+Light), ExpScore family, DiscoveryCard(+Light), DishItemAccordion,
VerifiedExperienceContainer, ActivityRings, Chip, Button, Input, Keyboard — all exist as built
components with Light twins; all are re-drawn from scratch here. Geometry drifts from the source
(e.g. our own hex mask instead of `ExpScoreSmall*`).

**3. Repeating background patterns are out of system.**
"Screens are flat canvas… There are no repeating patterns or textures." The landing/auth screens carry
a 24px dot lattice, a violet bloom and a concentric hex outline. This was our addition, and it is the
single clearest contradiction of the guide. Options: remove, or keep only on pre-auth marketing
surfaces and drop from in-app screens.

---

## P2 — Foundations drift

**4. Gold is over-used.** Gold is reserved for DNA axis labels, the location pill and the `LATEST`
tick. Here it labels generic eyebrows on many screens: `01 · EXPERIENCE`, `02 · EXPERIENCE DNA`,
`03 · CURATION`, `04 · DISCOVERY`, `CURATED COLLECTION · 9 SPOTS`, `9 SPOTS`, `6 SPOTS · DINER MADE`,
and the session dot in the prototype rail. Recommend violet or `on-variant` for eyebrows, gold only
where the guide allows.

**5. Playfair sizes are off-scale.** System display scale is 32/40, 24/32, 20/28 (plus DNA 32/40).
In use: 32 ✓, 30/38, 28, 26/32, 25/31, 24/30 ✓, 22, 20/20, 19, 16/20, 15/20. The 30, 28, 26, 25, 22,
19 and 15 sizes are invented. Section headings ("Fresh near you", "Recommended tonight", "Value for
you", "What's live", "Explore curations") are all Playfair 22 — should be 20/28. Sheet titles at 26/32
should be 24/32.

**6. ~~`#C7C7CC` is not an Elite colour.~~ WITHDRAWN — the claim was false.** `#C7C7CC` *is* a token
value: Dark `--on-surface-variant` and Light `--on-disabled`. `#8E8E93` is likewise Light
`--on-surface-variant` and `--dna-caption`. The colour was always correct; the only real defect was
that it was written as a literal instead of resolved from the linked stylesheet. Fixed by the binding.
Note also that the palette ships **no `gray-*` custom properties** — the gray-25→gray-950 ramp is
prose in the guide, not shipped tokens — so "use a `gray-*` token" was never actionable as written.
The correct target is the semantic token (`--on-surface-variant`, `--text-secondary`, `--on-disabled`).

**7. ~~`--outline: #1F1F1F` is invented.~~ WITHDRAWN — the claim was false.** `#1F1F1F` is exactly the
Dark `--outline` token. What survives of this finding is narrower and still worth doing: cards use a
1px opaque *border* where the system's card recipe calls for an inset hairline
(`inset 0 0 0 1px rgba(255,255,255,0.0784)` Dark, `inset 0 0 0 1px rgba(116,90,235,0.1216)` Light).
That is a shadow-vs-border question, not a colour question.

**8. Radii deviations.** *(revised after verification — see below)*
- Bottom sheets: ours 36px top corners (5 instances); system says sheets = 20. Confirmed.
- Two search bars disagree: universal search is 36 ✓, Explore landing search is 12 ✗.
- 14 is used as a general-purpose radius (info cards, date chips, glass stat tiles, experience grid
  tiles, section rows — 20+ instances). In the system 14 is the Explore *result row* value only.
- OTP cells at 12 ✓, cards 16 ✓, buttons/chips pill ✓.

**9. Prototype chrome is unstyled.** The rail/sidebar around the phone uses `#0e0d12`, `#121118`,
`#23212c`, `#2e2b3a`, `#8b8896`, `#b9b6c4`, `#4e4b59`, `#5b5867` — none are tokens. Harmless as
scaffolding, but it should read as neutral shell, not near-brand.

---

## P3 — Copy and detail

**10. Brand mark casing.** "your identity on Elite" — the mark is lowercase `elite`. Two occurrences
in the auth flow.

**11. `STEP 2 OF 3` in violet caps.** ALL CAPS is allowed for micro-labels; the violet is fine.
No change needed, flagged only because it's the one caps label not covered by the guide's examples.

**12. What passes.**
- Numbers-as-evidence phrasing is correct throughout ("1.2k+ diners served", "97% said Worth It").
- Binary recommendation language is correct — no "rating", "score out of", "high DNA".
- Sentence-case headings, no emoji, no exclamation marks.
- Media protection gradients present before glass chrome sits on photography.
- Glass usage is legal where used (sheets over media at blur 40, full-bleed media chrome).
- 48px buttons, 390×884 frame, 20px gutter, status bar / nav bar anchors all hold.

---

---

## Verification pass

Re-checked every claim against the file. Result: **8 of 12 confirmed, 1 revised, 1 upgraded, 2 withdrawn.**

**Confirmed by grep**
- No `_ds/` path, no `_ds_bundle.js`, no token stylesheet anywhere in the file (finding 1).
- Bottom sheets at 36px: lines 106, 126, 180, 1269, 1648.
- Off-scale Playfair confirmed at 15, 19, 22, 25, 26, 28, 30 — roughly 30 occurrences.
  Worst case: the DNA panel title is Playfair Black **19px** (line 1156); the system specifies
  Playfair Black 32/40 for it.
- `#C7C7CC` is pervasive as body text and `#8E8E93` appears in light mode (line 2412) — but reading
  `tokens/color.css` proved both are real token values, so this is **not** a defect. See withdrawn 6.
- `--outline: #1F1F1F` is the genuine Dark token value; only the border-vs-inset-hairline treatment
  remains open. See withdrawn 7.

**Revised — finding 8.** I claimed Explore result rows were wrongly 16 and the search bar wrongly 12.
The real picture is the opposite problem: 14 is *over*-used as a house radius across 20+ unrelated
elements, and the two search bars disagree with each other (36 vs 12). Corrected above.

**Upgraded — finding 4 (gold).** Worse than first written. Beyond the eyebrows, a gold `◆` diamond
glyph is used as a bullet in roughly eight info cards (lines 747, 1042, 1132, 1387, 1442, 1547,
1676, 1718). Two problems: gold outside its three sanctioned uses, and a Unicode character standing
in for an icon — the guide states plainly that Unicode glyphs are not used as icons. The system's own
`badge-check` / line-icon set should carry these.

**New — finding 13.** The `elite` wordmark on the landing screen is `rgb(116,90,235)` at 27px with
−1.35px tracking. The spec is Poppins SemiBold **32** / **−1.6px** in accent violet. Close, but it's
the brand mark, so it should be exact — or use the real lockup asset.

---

## Work order — status

1. ~~Link the DS token stylesheets + bundle; resolve the local alias vars onto real `Elite / Color`
   variables.~~ **DONE.** All 12 stylesheets + `_ds_bundle.js` now load; the 60-value hardcoded theme
   map is replaced by six aliases (`--on`, `--on-var`, `--on-dis`, `--elevated`, `--glass`,
   `--glass-strong`) resolving to DS tokens, with `data-theme` driving the switch. Both modes verified
   unchanged visually. This also closed 6 and 7 by proving them false.
   Going the other way, the drawn light-surface tuning (`#F0EEF6` canvas, `#FAF9FC` surface,
   `#E3DFEE` muted, `#DED9EB` outline, `#6E6B7C`/`#B4B0C0` text) was written **into**
   `tokens/color.css`, along with eleven previously undocumented tokens: `--pattern`, `--bloom`,
   `--nav-bg`, `--nav-border`, `--nav-idle`, `--row`, `--row-stroke`, `--pos`, `--pos-bg`, `--neg`,
   `--neg-bg`.
2. Document the backdrop patterns in the system as sanctioned for marketing and pre-auth surfaces (3).
3. Normalise Playfair to 32/24/20 and re-check vertical rhythm (5).
4. Pull back gold to its sanctioned uses, and replace the `◆` glyph with a real icon (4).
5. Radii: raise sheets to 36 and all search bars to 36 in the system; normalise the 14px usages (8).
6. Card treatment: inset hairline instead of 1px border (7, narrowed).
7. Set the `elite` mark to lowercase bold, 32px / −1.6px (10, 13).
8. Update the DS components to match the drawn elements, and add the new elements — DNA hexes,
   step label, patterns (2, 11).

---

## Second pass — after binding (fixes applied)

Re-audited against the updated system. Everything below is now fixed in the prototype.

**Type.** 46 Playfair instances were off the scale; all now sit on 32/40, 24/32, 20/28 or 16/20.
Corrections: 38, 36, 34, 31, 30, 29 → 32/40 · 28, 27, 26, 25, 23 → 24/32 · 22, 21, 19 → 20/28 ·
17, 15 → 16/20. Three sizes earned a name in the system instead of being flattened:
`--type-display-tile` 16/20, `--type-display-subtitle-tight` 20/20, `--type-dna-title-compact`
900 20/28 (the panel title where 32/40 cannot fit).

**Gold.** 32 instances removed. Eyebrow labels and kickers (14) → `--accent`. The `◆` Unicode bullet
(18) → a 9px vector diamond in `--accent`, which also clears the "no Unicode glyphs as icons" rule.
Curator avatar rings lost their gold→violet gradient, which was the one place gold read as rank.
Also reset: the no-DNA badge, the deal card border and its "Details" link, the "Clear filter" action,
the dashed add-tag chip.
Gold **kept**, and now written into the system as its sanctioned list: DNA axis labels and ring, the
location pill, the `LATEST` tick, the live-menu warning dot, and membership / Amplify / Tokens
ornament.

**Radius.** The Explore search bar went 12 → 36 so all three search surfaces agree. Sheets stay at
36 and the system now says so (`--radius-sheet`, `--radius-search`). The 14px radius was adopted
rather than removed: `--radius-note`, documented for note cards, date chips, list tiles and small
media tiles.

**Brand mark.** Both marks are lowercase bold on the accent token: landing at 700 32px / −1.6px,
top bar at 700 23px / −1.15px (32 will not fit a 36px row). Both named in the system.

**Patterns.** Kept, and the system's "no repeating patterns" rule is replaced by a scoped permission:
`--pattern` and `--bloom` only, on pre-auth and marketing surfaces or to break monotony, in three
approved forms (dot lattice, violet bloom, concentric hex outline), never behind a card, media or a
dense feed.

**Cards.** The 1px `--outline` border was kept and the system updated to match, rather than
converting 60 cards to an inset hairline. The hairline recipe stays correct for restaurant cards
carrying glass chips.

### Still open

- The system's **component sources** (DiscoveryCard, NavigationBar, ExpScore family, StatusBar) were
  not rewritten to the drawn geometry. Tokens, type, radius and the written guidance now match the
  app; the component CSS files still carry their original values. That is the remaining half of "do
  not redraw — update the system instead."
- Dish Detail Popup, Activity Rings and Verified Experience Container still need pulling from the
  Figma component sets.
