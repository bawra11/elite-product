# Frontend flows

Detailed flowcharts for the Elite diner app. These follow the product brief and the decisions through 2026-09-26, and they use screen ids from `product/design/mockups/README.md` where a screen exists.

The prototype's own `flows` array was cut off in the design export. Where a step has no screen, the diagram says so.

| Flow | File |
| --- | --- |
| How the flows connect | [00-map.md](./00-map.md) |
| First launch, tutorial, network tour | [01-onboarding.md](./01-onboarding.md) |
| Phone OTP, WhatsApp magic link, identity gate | [02-auth.md](./02-auth.md) |
| Home feed and story bubbles | [03-home.md](./03-home.md) |
| Experience and Curation tabs | [04-feeds.md](./04-feeds.md) |
| Create an experience | [05-create-experience.md](./05-create-experience.md) |
| Create and edit a curation | [06-curation.md](./06-curation.md) |
| Post detail, reactions, author actions | [07-post-detail.md](./07-post-detail.md) |
| Place, DNA, live vibe, live menu | [08-place.md](./08-place.md) |
| Reserve and pay | [09-reserve-and-pay.md](./09-reserve-and-pay.md) |
| Profile, follow, block | [10-profile-and-social.md](./10-profile-and-social.md) |

## Rules these diagrams use

- Five tabs: Home, Experience, Create, Curation, Profile.
- Home mixes experiences, curations, and restaurant stories. Experience and Curation are that list filtered by post type.
- A restaurant story is the product name for the backend type happening.
- The circular bubbles at the top of Home open the story viewer. That viewer reuses the Discovery UI. Discovery is not a tab.
- Sign-in is phone number plus OTP, or a WhatsApp magic link. No password. It starts only when an action needs an identity.
- Delete and edit show only for the author.
- Experience DNA is a working assumption: restaurant only, after 100 verified experiences, never on an experience.
- Missing data is an empty state.

## Not a current product flow

- Ask Elara (`elara`) is in the prototype and is not in the product brief.
- Explore (`explore-landing`, `explore-search`) is a later-phase candidate, not a tab.
- The July 2026 legacy pack (cart, star rating, Home / Menu / Pay Bill nav) is not this app.
