# Claude Design import: Experience Diner App

Pulled 2026-09-22 from https://claude.ai/design/p/edec04e8-eb34-4ab7-9c61-7daa1a828a03.

| File | What it is | Complete? |
| --- | --- | --- |
| `Experience Diner App.dc.html` | The main prototype, **post-audit** (tokens bound, Playfair normalised, gold pulled back) | Truncated at 256 KB, inside the Explore screen. Contains auth ×7, tutorial ×4, Home, Ask Elara |
| `Experience Diner App standalone.dc.html` | Compact **pre-audit** export | Truncated after the token wallet. Contains 41 screens: auth, tutorial, Home, search, Explore, Discovery, curation/experience/story detail, place profile, DNA sheet, Live Vibe/Menu, dish page, create flow ×7, reserve ×2, pay ×3, my curations, new curation, add restaurants, wallet |
| `Experience Diner App export.dc.html` | Pre-audit export with the legacy grid Home | Truncated |

When reading screens, prefer the main (post-audit) file wherever it covers a screen. For the
others, use the standalone export and apply the audit rules listed in `../README.md`.

Screens that are missing from every export (no local copy): **Profile, curator profile, deals,
loyalty, membership, token store**. If someone splits the prototype into smaller files in
Claude Design, each piece stays under the connector's 256 KB cap and can be pulled whole.

The token CSS, the design-system README, `guidelines/diner-app-additions.md` and
`Design system audit.md` were read in full. Their values live in
`tech/codebase/elite_app/lib/core/theme/` rather than as file copies here.
