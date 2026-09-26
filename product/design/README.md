# Design

## Source of truth: Claude Design

- **Project:** `Experience Diner App` — https://claude.ai/design/p/edec04e8-eb34-4ab7-9c61-7daa1a828a03
- **Design system:** `elite · Experience DesignSystem`
  (`_ds/elite-experience-designsystem-1d6068ae-…` inside that project)
- **Access:** through the `DesignSync` tool after `/design-login` in Claude Code.

What's here locally: `claude-design/` holds the prototype exports (see its README). `mockups/` has the
screens & flows scope, each screen mapped to its Flutter file. `legacy-pack/` is the July 2026 design pack
for the old app. The Figma file the system was built
from (`Experience DNA.fig`) is referenced by the design system but is not needed. Every
token and rule we use is in the Claude Design project.

## Where the design lives in code

`tech/codebase/elite_app/lib/core/theme/` holds the tokens, and `lib/core/ui/` holds the
widget library:

| System file | Flutter |
| --- | --- |
| `tokens/primitives.css` | `ElitePalette` (`design_tokens.dart`) |
| `tokens/color.css` + `guidelines/diner-app-additions.md` | `EliteColors.light` / `.dark` (`elite_colors.dart`), a ThemeExtension read via `context.colors` |
| `tokens/typography.css`, `tokens/fonts.css` | `EliteType`, `EliteFonts`. Poppins and Playfair Display are bundled under `assets/fonts/` (OFL) |
| `tokens/spacing.css`, `tokens/radius.css`, `tokens/elevation.css` | `EliteSpacing`, `EliteRadius`, `EliteElevation` |
| `icons/*.svg` + inline glyphs | `EliteGlyph` / `EliteIcon` (`elite_icons.dart`), extracted verbatim |
| Components (chips, glass, DNA radar/gem, buttons, sheets) | `lib/core/ui/*.dart` |

When the system changes, diff the CSS against these files and update the values in place.
Feature code never uses hex literals or ad-hoc sizes; it reads tokens.

## Rules we implemented (from the system's README, diner-app additions and audit)

- **Light and Dark are two parallel systems**, not one palette repainted. The design leads with Dark.
- **Flat vs Glass.** Pick one per surface. Glass only on media chrome, sheets over media, and chips on restaurant cards.
- **Gold is reserved** for DNA axis labels and the DNA ring, the location pill, the `LATEST` tick, the live-status dot and membership/token ornament. Eyebrows are violet.
- **Playfair only on the scale:** 32/40, 24/32, 20/28, plus 16/20 for tiles and 900 for DNA titles.
- **Radii:** 12 inputs, 14 note/tile, 16 cards, 20 heroes, 36 sheets and search bars, pill for actions.
- **Recommendation is binary** (Worth it / Not Worthy), never a rating. **DNA belongs to restaurants**: it never appears on an experience.
- **No Unicode glyphs as icons.** The `◆` bullet is a 9px vector diamond (`DiamondNote`).
- **Motion:** 120–200ms ease-out for functional motion. Press feedback is a colour/opacity change, never a scale. The only scale is the reaction "tap pop".

## Known gaps in the design import

- **The design export is truncated.** The connector caps reads at 256 KB. `Experience Diner App.dc.html` is about 50 screens and comes back cut off inside Explore. Combining the three exports recovered 41 screens. The following never came through: **Profile, curator profile, deals, loyalty, membership, token store**, and the bottom nav bar markup. The Profile tab was therefore composed from system components against the product brief.
- **Photos weren't imported.** `img/*` are larger than the transfer cap. The app uses real stage media (CTB's gallery) for demo content, and tonal placeholders where media is missing.
- **Tab structure follows the product journal**, not the design. Home · Experience · Create · Curation · Profile, styled with the design's nav treatment. The design's own nav is Home · Explore · Discovery · Profile. Decided 2026-09-22. Discovery is not a destination: that UI is the story viewer opened from the circular bubbles on Home (2026-09-26).
