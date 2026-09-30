# Frontend flows

Detailed flowcharts for the Elite diner app. These follow the product brief and the decisions through 2026-10-01, and they use screen ids from `product/design/mockups/README.md` where a screen exists.

The prototype's own `flows` array was cut off in the design export. Where a step has no screen, the diagram says so.

| Flow | File |
| --- | --- |
| How the flows connect | [00-map.md](./00-map.md) |
| First launch, tutorial, network tour | [01-onboarding.md](./01-onboarding.md) |
| Phone OTP identity gate | [02-auth.md](./02-auth.md) |
| Home feed and story bubbles | [03-home.md](./03-home.md) |
| Experience and Curation tabs | [04-feeds.md](./04-feeds.md) |
| Create an experience | [05-create-experience.md](./05-create-experience.md) |
| Create and edit a curation | [06-curation.md](./06-curation.md) |
| Post detail, reactions, author actions | [07-post-detail.md](./07-post-detail.md) |
| Place, DNA, live vibe, live menu | [08-place.md](./08-place.md) |
| Reserve, Place Pay, order at table | [09-reserve-and-pay.md](./09-reserve-and-pay.md) |
| Profile, follow, block | [10-profile-and-social.md](./10-profile-and-social.md) |
| Dine-in pay | [11-dine-in-pay.md](./11-dine-in-pay.md) |
| QSR pay | [12-qsr-pay.md](./12-qsr-pay.md) |
| WhatsApp promotion and review | [13-whatsapp.md](./13-whatsapp.md) |
| Visit verification | [14-visit-verification.md](./14-visit-verification.md) |
| Membership, deals, loyalty | [15-membership-deals-loyalty.md](./15-membership-deals-loyalty.md) |
| Waiter, reorder, table mismatch | [16-in-venue.md](./16-in-venue.md) |

## Rules these diagrams use

- Five tabs: Home, Experience, Create, Curation, Profile.
- Home mixes experiences, curations, and restaurant stories. Experience and Curation are that list filtered by post type.
- A restaurant story is the product name for the backend type happening.
- The circular bubbles at the top of Home open a Discovery-like story viewer. That viewer can contain curations or restaurant stories, not only experiences. Discovery is not a tab.
- General diner sign-in is phone number plus OTP (WhatsApp may deliver the OTP). The diner phone sheet has no magic-link branch. The WhatsApp magic link is a sign-in method, and it is the forced (preferred) sign-in for dine-in and paid-QSR, so BE can use WhatsApp's customer-service window to message the user on WhatsApp. No password. The gate starts only when an action needs an identity. Live Menu is open to guests. Live Vibe needs sign-in. The basic user profile view is not gated, but any private information or analytics on the profile is gated behind sign-in. The OTP is 6 digits for now. That length is the current value from the OTP provider and may change, so clients must not hard-code it.
- Delete and edit show only for the author.
- Experience DNA is a working assumption: restaurant only, after 100 verified experiences, never on an experience.
- Missing data is an empty state.

## Scenarios beyond the five tabs

- **Place Pay.** From the place profile: enter a bill amount, then a payment screen, then confirmation, and a visit is added. This is not dine-in pay and not QSR pay.
- **Order at table.** A table QR deep link, or the place screen's top-right icon (scan when there is no running order, cart when there is). Not a choice on Reserve.
- **Dine-in pay.** A Bridge table bill, or a typed amount on Digital Dining. The total can move while the diner pays.
- **QSR pay.** A cart plus the restaurant's packaging-charge rule. SkipQ uses a `skip_q_users` session. No live table bill.
- **WhatsApp promotion.** A Nextel campaign, only with WhatsApp consent. The link opens a place, an offer, or a brand curation. Home's brand-promotions slot is the same offer inside the app.
- **WhatsApp review.** After a paid or verified visit, again only with consent. The link opens create for that order. The receipt's "Write it now" is the same step inside the app.
- **Visit verification.** A reconciled Elite payment, a bill photo still matching, a table QR, a waiter confirm on Bridge, or an unverified post.
- **Membership, deals, loyalty.** One benefit on a dine-in bill, Elite join before pay, and three separate ledgers on the receipt.
- **Waiter request, reorder, table mismatch.** Digital Dining's in-venue bar, plus the report on a held reservation.

The diner phone sheet stays OTP-only. The WhatsApp magic link is the forced (preferred) sign-in for dine-in and paid-QSR, so BE can use WhatsApp's customer-service window. It is not the promotion or review message.

## Later, not a contradiction

- Ask Elara (`elara`) will be added later. It is in the prototype and is not a current tab.
- Explore is the same as search (`explore-landing`, `explore-search`). It is in product; it is not a fifth-tab replacement.
- Home brief modules (highlights, followed experiences, brand curation suggestions, place suggestions, brand promotions) will render in a later pass. They stay as slots. They are not a reason to delete the mixed Home list.
- The July 2026 legacy pack (cart, star rating, Home / Menu / Pay Bill nav) is not this app.
