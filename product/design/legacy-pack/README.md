# Design pack — Elite / Explorex

> **Legacy (July 2026).** This pack was written for the older `explorexinc/elite-app` codebase. It sat at
> the repo root until the Sept 2026 restructure. The current source of truth is Claude Design
> (`../claude-design/`, `../mockups/`). Keep this pack as reference for the marketing and pay-bill frames only.

Hand this folder to design when extending the product UI.

| Doc | Purpose |
|---|---|
| [DESIGN.md](./DESIGN.md) | Design system: color, type, spacing, components, **dark theme**, perceived performance |
| [COMPONENT_EXTENSION.md](./COMPONENT_EXTENSION.md) | Checklist + brief template for **new** components |
| [references/INDEX.md](./references/INDEX.md) | Screenshot library mapped to components |

Tokens in this pack match the Flutter source under `elite-app/elite-core/lib/themes/`.  
Dark mode: semantic tokens exist; follow DESIGN.md §7 to make runtime live (gradients, assets, toggle wiring).
