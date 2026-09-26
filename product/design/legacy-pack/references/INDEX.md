# Visual references index

Annotated production / marketing frames used to rebuild the design system. Pair with [DESIGN.md](../DESIGN.md).

## Marketing / product surfaces

| File | Screen | Components to study |
|---|---|---|
| [marketing/01-tier-discount-sheet.png](./marketing/01-tier-discount-sheet.png) | Tier discount bottom sheet | Sheet, Elite logo, 3-step unlock stepper, T&C link |
| [marketing/02-restaurant-profile-live-table.png](./marketing/02-restaurant-profile-live-table.png) | Restaurant profile | Hero, partner script badge, Open Now, Recommend, Pay Bill, Live Table Status banner |
| [marketing/03-search-results-filters.png](./marketing/03-search-results-filters.png) | Search results | Violet header, search field, filter chips, list rows + category pills |
| [marketing/04-restaurant-discovery-cards.png](./marketing/04-restaurant-discovery-cards.png) | Discovery feed | Image cards, yellow % OFF badge, favorite, experience score bar |
| [marketing/05-rewards-offer-modal.png](./marketing/05-rewards-offer-modal.png) | Rewards / offer modal | Sheet + gradient CTA “Get the Elite App”, tier progress |
| [marketing/06-live-status-list.png](./marketing/06-live-status-list.png) | Live Status | Violet header, PAX summary, status pills (Calm / Filling / Hot), rating, favorite |
| [marketing/07-digital-menu.png](./marketing/07-digital-menu.png) | Digital menu | Category tiles, dietary chips, menu rows, Add, floating categories, bottom nav |
| [marketing/08-pay-bill-checkout.png](./marketing/08-pay-bill-checkout.png) | Pay Bill | Savings banner, orders table, taxes, sticky Pay Bill CTA, bottom nav |

## App flows (device captures)

| File | Flow | Components to study |
|---|---|---|
| [app-flows/01-pay-bill-amount-entry-flow.jpg](./app-flows/01-pay-bill-amount-entry-flow.jpg) | Enter amount → apply offer | Amount input, keypad, tier stepper states, Apply Offer enabled/disabled, Elite join vs added |
| [app-flows/02-pay-bill-membership-upsell.jpg](./app-flows/02-pay-bill-membership-upsell.jpg) | Membership upsell on bill | Green savings strip, Elite Premium card, fee notice bar, orders summary, Pay Bill nav |
| [app-flows/03-menu-items-with-tags.jpg](./app-flows/03-menu-items-with-tags.jpg) | Menu + tags | VEG/NON VEG filters, dish tags, Add vs counter, % unlock FAB, View Categories, cart bar |
| [app-flows/04-menu-items-add-cart.jpg](./app-flows/04-menu-items-add-cart.jpg) | Menu add to cart | Same chrome; recommended / bestseller / alcohol / spicy tags |

## Dark theme references

When dark artboards ship, add a `dark/` folder (or suffix `-dark` on filenames) and list them here. Until then, follow [DESIGN.md §7](../DESIGN.md) for light↔dark token and gradient specs.

## How to add a reference

1. Export the approved frame (PNG preferred for UI; JPG OK for multi-screen boards). Prefer **light + dark** pairs for product UI.
2. Place under `marketing/` (hero/marketing comps) or `app-flows/` (multi-step / device).
3. Name: `NN-short-kebab-name.ext` (next number in folder); use `-dark` suffix for dark pairs.
4. Add a row to the table above with components called out.
5. Mention the path in the component brief / engineering ticket.

## Optional video

Raw capture at repo root: `2026-07-16 03.31.23.mp4` (motion / flow reference). Move into `app-flows/` if you want it versioned with the rest of the pack.
