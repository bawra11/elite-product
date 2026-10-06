# Experience PRD

**Status:** Draft  
**Product:** Experience (Elite)

---

## 1. What this product is

Experience is a community-first social network for foodies. Discovery starts with people and visits, not listings. Partner restaurants already sit on Elite's POS ecosystem, so a tap on someone else's meal should land on a live table action, not a dead photo.

People share a visit as an **experience**. Places earn an **Experience DNA** radar from verified mentions. A separate **Worth it / Not worth it** call is the recommendation. The two never merge into one score. There is no Elite Experience Score.

Guests still get sent to irregular places. DNA is what they are walking into.

Verified media, Live Menu, pay, reserve and directions are one loop. Loyalty, contribution status, restaurant marketing and member-hosted meetups sit on that same loop.

The line on the DNA sheet is the contract:

> we LOVE all shapes
> it's not a rating, It's character of the place

---

## 2. Problem

Star ratings squash a visit into one number. A 4.2 can mean excellent food with no parking, or average food that is easy to reach. Guests get surprised. Hosts get punished for a trait that is not a failure of hospitality.

Discovery apps flatten places into interchangeable cards. Food photos die as decoration. Thoughtful diner writing is buried. Listing marketplaces sell rank. Restaurant discounts are blanket coupons rather than first-visit, repeat, recovery or low-demand tools. Restaurants and agencies cannot close the loop from campaign to verified visit. People who want to dine as a group still collect money and pick a venue off-platform.

Elite already has the POS, Live Menu and visit proof. Leaving a dish photo unlinked to that menu is wasted friction.

---

## 3. Who it is for

**Guest (diner).** Find a place that matches the night. Know the catch. Share a visit others can trust. Use Live Menu, vibe, reserve, pay, deals, restaurant loyalty, Tokens and meetups.

**Elite Member.** Same diner, plus badge, long-form, 24-hour edit, 3 Amplifies per month, creator analytics, meetup hosting when eligible.

**Host (restaurant / outlet admin).** Run the outlet: profile, live signals, reservations, events, deals, loyalty, membership, replies, marketing, finance. Operational friction is visible on DNA. It does not cancel the recommendation.

**Waiter (Bridge).** Bridge is the waiter-side app. Floor staff run tables, Live Menu availability, Live Vibe, check-in, table QR/OTP, bill send and staff visit confirmation from Bridge. It is not the diner app and not the marketing workspace.

**Restaurant marketing admin / contributor.** Fund and run Amplify and events without full outlet-admin access.

**Agency.** Multi-outlet marketing: Master Central Balance, allocations, campaigns, ROI. Access only after Elite onboards the outlet and the Outlet Admin approves the agency.

**Curator.** Publish a named collection. Discovery treats a curation as its own full-bleed story. Every diner can also keep public or private restaurant curations.

**Meetup host.** Active Elite Member with a complete verified profile. Creates public or private dining gatherings, collects payment through Elite, settles after the event.

**Elite Admin / Finance.** Moderation, entitlements, pricing, disputes, GST, payouts, reconciliation.

Out of v1: critic accounts as a separate product, cash-withdrawable wallets, peer-to-peer Token transfer, paying restaurant bills with Tokens, collaborative wishlists, non-restaurant map pins.

---

## 4. Principles

1. DNA is character. Recommendation is a different object. There is no composite Experience Score.
2. Mentions create axes. Silence does not invent a 0% Hygiene tick.
3. Praise and friction both unlock an axis. The value encodes the mix.
4. Axis order never shuffles to make a prettier polygon.
5. Shape does not sort, badge or hide a place.
6. DNA is visit-backed. Unverified posts can exist. They never unlock or update DNA.
7. Light and Dark are two color systems. A screen is Flat or Glass, not a mix.
8. Amplify and ad spend buy labelled distribution only. They never change DNA, Worth it, verification, Trust, Helpful, Curator status or organic rank.
9. Tokens, restaurant loyalty, restaurant membership, Elite Membership and Tier Discounts are five different products. They do not convert into each other in v1.
10. Paid Tokens never buy level, Trust or DNA weight. Levels use Lifetime Earned Tokens only.
11. Social content must land on a live restaurant action in one tap when Elite has the dish and the outlet. Bridge (waiter) and POS exist to remove steps, not to sit behind a profile.

Copy words that are allowed near DNA: nature, character, aware of, we LOVE all shapes.
Copy words that are forbidden: rating, grade, high DNA, perfect shape, complete your shape, Experience Score.

---

## 5. Scope

v1 is the full Elite platform: diner app, Bridge (waiter), restaurant and agency workspaces, admin, and meetups.

### In v1

**Diner app**

- Auth: phone gate, OTP, name and handle, then progressive profile (photo, bio, interests, gender, DOB)
- Onboarding tutorials: Experience, Experience DNA, Curation, Discovery
- Home, Explore, Discovery, Profile, Invite friends
- Place profile, experience detail, restro stories detail, curation detail
- Create experience: pick place, pick visit, attach media / narrate, Worth it. Verified dish photos auto-tag to Live Menu dishes
- Experience DNA thumbnail + sheet. Worth it / Not worth it chip, independent of the radar
- Light and Dark
- Reserve table and pay bill as live commerce. Directions deep-link maps
- Ask Elara as a real concierge on the Home field, grounded in Elite data
- Live Menu, Live Vibe. Dish page with community photos and Pay, Reserve, Directions
- Diner-created public/private Curations V1 (15-restaurant cap, Google import, Verified Visited)
- Helpful, follow people and restaurants, curator profiles
- Deals, restaurant loyalty, restaurant membership (free or paid by the restaurant)
- Elite Tokens, Token Store, Lifetime Earned Token levels, ₹199 Elite Membership
- Member and one-off Amplify. Restaurant paid Amplify batches
- Restaurant events (organic + paid amplification)
- Public and private meetups, including quote marketplace

**Restaurant, agency, admin**

- Outlet operations workspace
- **Bridge** (waiter app): tables, Live Menu 86s, Live Vibe, check-in, table QR/OTP, bill send, staff visit confirm
- Marketing Workspace, agency portal, Master Central Balance, allocations, ROI
- Admin: moderation, entitlements, finance, feature flags, dispute queues

---

## 6. Experience DNA

Experience DNA is the character of a place, drawn from diner mentions. It is not a rating, rank, or reason to un-recommend. Shipping name for the kitchen axis is **Food**, not Taste.

There is no Experience Score service, snapshot or diner-facing percent of "people said worth it." Worth it is the reco chip. DNA is the radar.

### 6.1 Job

Show the nature of a place from diner mentions so a guest can walk in with eyes open. The recommendation can still stand.

### 6.2 Objects

| Object | What it is | What it is not |
| --- | --- | --- |
| DNA radar | Place-level polygon of mention-weighted traits, 0-100 per visible axis | A star rating, NPS, quality score or Experience Score |
| DNA hex thumbnail | Hex mark used on cards and heroes | A rank badge. Small Worth it variants must not replace the Reco chip |
| DNA sheet | 360×363 popup. Title, taglines, radar, reco chip, explainer | A score modal |
| Reco chip | Worth it / Not worth it | A function of Convenience or polygon roundness |

### 6.3 Mandatory axes and unlocks

Always on, **when DNA is shown:** **Service**, **Food**, **Value**.

DNA is not on every place. v1 shows the radar only if both are true:

1. Elite still recommends the place (Worth it / curated, not a buried listing).
2. The place has **100 verified experiences**.

Below that gate, or if the place is not recommended: hide the hex and the sheet. Do not show an empty triangle as a tease.

When DNA is shown and extras have not unlocked yet, render the triangle with “Early DNA, still filling in.”

v1 shows **at most 6 axes**. Unlock order, same rules (praise and friction both count):

1. **Vibe**
2. **Presentation**
3. **Convenience** (Location + Wait, renamed. Parking, last mile and queue talk live here.)

Hygiene, Seating, Accessibility and any further extras stay off the consumer radar until later. If they would unlock, they wait. Do not grow a 7th side in v1.

Closed catalog. Free text does not mint a new axis name. Production never ships placeholder axis names.

Canonical ring, clockwise from 12 o’clock, with **Value parked at 11 o’clock**. Service stays at the top. Locked properties are omitted, not greyed. Relative order of visible axes never rearranges.

| Order | Property | Mandatory | Typical mention themes |
| --- | --- | --- | --- |
| 1 (12 o’clock) | Service | Yes | Staff, pace, attentiveness, recovery |
| 2 | Food | Yes | Flavour, dishes, consistency, kitchen |
| 3 | Vibe | No | Room energy, crowd, music, occasion feel |
| 4 | Presentation | No | Plating, look of the dish, table reset as visual |
| 5 | Convenience | No | Reach, parking, last mile, wait, queue |
| 11 o’clock | Value | Yes | Price-to-quality, portion vs bill. Not the Worth it chip |

Place-profile tiles labelled VIBE or Ambience are entry points (crowd, gallery), not extra radar axes. If Vibe is unlocked on DNA, do not also invent an Ambience axis. Highlight chips such as Car Parking stay amenities. Convenience is how diners talk about getting there and waiting.

### 6.4 Axis value

For an unlocked or mandatory property:

- Take mention polarity and intensity in the active window.
- Map to 0-100. High = described as a strength or ease. Low = described as friction.
- Mandatory axes with thin evidence still render. Prefer a cautious mid value plus an early-signal state over hiding Service.
- A low Convenience score is “plan for this,” not “don’t go.”

Percentages are mention-weighted character. 85% Food means food is a strong, consistent part of how this place is described. It is not 4.3/5 food.

Only **verified** experiences update DNA. Unverified posts are ignored by the DNA pipeline.

### 6.5 Unlock rules

| Rule | Spec |
| --- | --- |
| Mandatory | Service, Food, Value always render when DNA is shown |
| Unlock | Distinct **verified** experiences mentioning the property ≥ N, and more than one diner |
| Cap | At most 6 visible axes in v1. Further catalog hits stay off the radar |
| Hidden until unlock | No ghost axes on the consumer radar |
| Stay unlocked | Axis remains after volume drops, until a decay policy exists |
| Decay | Later. Stale mentions can drift the value. Do not yank the axis overnight |

**N for extras:** **50 distinct verified experiences** or **30 unique diners**, whichever is stricter. Tune per city later. This is independent of the **100 verified experiences** gate that decides whether DNA exists at all.

### 6.6 Recommendation stays separate

DNA never:

- Caps worth-it
- Sorts Explore by roundness
- Hides a place because Convenience is 42%
- Becomes a public “87% said Worth it” score

DNA may:

- Power an opt-in guest filter later
- Power honest cards (“great food, awkward last mile”)
- Power host coaching in the restaurant workspace

The Reco chip uses `reco-worth` / `reco-not-worth`. It is not derived from any axis. Place-level reco is Elite’s call, not a computed average displayed as a score.

### 6.7 Surfaces

- **Place profile:** primary. Hex in the hero. Tap opens the DNA sheet. Sheet can sit on the scroll or as a modal. Same component.
- **Visit / experience cards:** small hex. Worth it chip may sit beside it on Explore and Create Experience lists.
- **Curation / discovery:** thumbnail only if the hex stays readable. Otherwise a short character line. Do not put the full sheet on a full-bleed Discovery card.
- **Create experience, select visit:** hex on each prior visit at that place so the diner sees the place’s DNA while attaching this visit.
- **Restaurant workspace:** mention samples and axis context for the outlet. Hosts cannot overwrite an axis.

### 6.8 Sheet copy (must appear)

Title: `Experience DNA` in Playfair Black, purple (`dna-title`), never gold.

Taglines on the sheet:

- `we LOVE all shapes`
- `it's not a rating, It's character of the place`

Near the chart, one of:

- `It's just some attributes to be aware of.`
- `The shape is the nature of the place, not a verdict.`

If an axis is low and the place is still recommended:

- `Recommended, plan for [parking / last mile / wait].`

### 6.9 Visual rules

- Gold is axis names and DNA-in-copy. Gold is not a score glow.
- Polygon fill is `dna-fill`. Inner glow is character, not rank. Do not round the polygon into a circle.
- Light and Dark via color modes. Do not duplicate Light component sets.
- **No number in the radar center.** Glow only. No composite DNA score.

### 6.10 How DNA is computed (v1 pipeline)

1. Diner creates an experience. If it is linked to a verified visit, it is eligible for DNA.
2. Composer infers which catalog properties were mentioned, direction (ease vs friction), and intensity.
3. Place-level counters update **only** from verified experiences that pass moderation.
4. If a non-mandatory property crosses N across more than one diner, the axis appears, up to the 6-axis cap.
5. Axis values normalise to 0-100 for the active window.
6. Worth-it stays on its own model. No score snapshot.
7. After the experience is posted, the diner may edit inferred axes **once for that visit**. Not during compose. Not again later.

Hosts cannot overwrite an axis. They can see mention samples in the restaurant workspace.

---

## 7. Consumer surfaces

Mobile frame is 390×884. Nav: Home, Explore, Create (+), Discovery, Profile.

### 7.1 Tutorials

Four screens, Dark and Light. Skip is allowed. Pagination 01-04.

| Screen | Job | Body |
| --- | --- | --- |
| Experience | What an experience is | A visit you lived, not a review you typed. Photo or video, then a Worth it / Not worth it call. |
| Experience DNA | What the radar is | Service, Food, and Value always show. Vibe, Presentation, and Convenience appear when enough people mention them. Max 6 sides. We LOVE all shapes. |
| Curation | What a collection is | A named list of places worth the trip. Follow a curator. Save the list. |
| Discovery | How you browse | Full-bleed stories of curations, experiences, and restro stories. |

Tutorial copy uses **Food**, not Taste. Cap the teaching radar at 6 sides.

### 7.2 Auth

Order:

1. Phone gate (sheet over photography, Glass). OTP or approved OTP-less. Unique mobile. Rate-limit failures.
2. Name and handle.
3. Progressive completion: photo, bio, interests, gender (including Prefer not to say), date of birth. Completeness can show 30% then 100%.

Phone is the identity. No email/password login.

Browse is not blocked on optional fields. Gated benefits explain why data is requested. DOB validation rejects impossible or future dates. Gender and DOB are stored with consent metadata. Privacy controls cover DOB/gender visibility, follower visibility and meetup profile exposure.

### 7.3 Home

Home is Flat. Do not glass the list.

Default hierarchy (server-configurable):

- City, notifications, profile, universal search
- **Ask Elara** field: “Ask Elara for the perfect spot…” This is the concierge entry, not a dead search skin
- Curators to Follow story rail (circular profiles). Optional restaurant **event** ads in that rail, labelled Event / Promoted Event, density cap 1 after every 5-7 curator tiles
- Occasion chips: All, Date night, Crowd favourites, …
- One personalised hero
- Fresh experiences near you
- Editorial collections and place cards with Worth it + DNA hex
- Value for You: deals, loyalty, expiring value
- What’s Live: Live Vibe, Live Menu, availability
- Restaurant events nearby
- Explore Curations with View All
- From people you follow / continue your dining journey
- Contextual Elite Membership prompt. Not a permanent dominant banner

### 7.4 Explore

Two layers:

1. Explore landing: search, collections (Hidden Gems, Date Night, and similar), place rows with Worth it + hex.
2. Explore search: query, filters, **Worth it Experiences** grouping. **Not worth it** places appear in a separate de-emphasised section. They are not hidden and not mixed into the default Worth it list.

Default ranking is curation + worth-it + recency/relevance. **Not** polygon roundness. Avoid over-concentration of a few outlets. Reason-for-recommendation copy is allowed.

Search must support place name, area, dish/cuisine, occasion and collection. Occasion chips on Home should land here with the same filter applied.

### 7.5 Discovery

Three full-bleed types, Glass chrome over media:

| Type | Example | Card job |
| --- | --- | --- |
| Curation | Tokyo's Midnight Sanctuaries | Named collection, curator, Follow + Save, count of spots |
| Experience | A diner’s visit | Media, caption, curator/diner, place |
| Restro stories | Place-authored story | Same chrome, place as the author |

Hotkeys sit on the right. Discovery Card is glass-on-media. Nav bar remains.

Tapping through goes to Curation detail, Experience detail, or Restro Stories detail. Dish tags on experience cards are tappable. They open that outlet's Live Menu dish, not a generic search.

### 7.6 Curation detail

Hero: cinematic cover, `CURATED COLLECTION`, spot count, title, Follow this curation, curator identity.

Feed: 2-up place/experience tiles (name, area, pull quote).

Official Elite curations stay a featured layer. Public diner-created curations use the same detail pattern plus last updated, ordered restaurants, Verified Visited badges, live signals, deals/loyalty, save and share. Sponsored insertions must be labelled and must not silently rewrite organic order.

### 7.7 Experience detail

Hero media, place name, area, DNA hex, highlight chips (Critic's Choice, Signature Dishes, Michelin Star as examples).

Body: diner caption, author, verified visit treatment, related media.

Dish tags sit on the photo and in the body. Tap a tag to open that restaurant's Live Menu dish with Pay, Reserve and Directions. Tags come from verified auto-tagging. The diner may correct them after publish.

Worth it on the visit is the diner’s call for *this* visit. Place DNA remains the aggregate. Unverified experiences show without a verification label and do not contribute to DNA. Unverified media is not auto-tagged from POS.

### 7.8 Place profile

This is the DNA home.

Hero: photography, name, area, DNA hex.

Primary actions: Follow this restaurant, and similar hotkeys.

Highlights row: amenity/credential chips (parking, outdoor seating, alcohol, …). These are **facts the place has**, not DNA axes.

Shortcut tiles: VIBE / Fast Filling, Menu / Live Menu, Ambience / View Gallery. These are v1 entry points (crowd, menu, gallery), not extra DNA axes.

DNA sheet: title, taglines, radar, reco chip, explainer.

Experience Trend accordion: v1. How mentions moved.

Feed tabs: Experiences | Stories. 2-up grid of diner media with handle and dish tags. Tags open the Live Menu dish.

Also on the profile: eligible deals, loyalty balance / membership join, Live Menu, Live Vibe, reservation, pay, restaurant events.

Sticky footer: **Reserve Table** and **Pay bill** are live v1 commerce. Directions deep-link maps.

Intro copy: short, ~50-100 characters.

Partner states: listed, Non-Ecosystem, Ecosystem. Capabilities follow entitlement, not client chrome.

### 7.9 Create experience

Create flow:

1. **Select place.** Search, recents. Hex + Worth it only if that place qualifies for DNA.
2. **Select visit.** Visits at that place, dated, with hex. CTA: "Add this experience to your visit." Also a path via recent bill or transaction.
3. **Narrate / attach.** Photo or video, caption, Worth it / Not worth it. Composer infers DNA properties from this payload. The diner does not tag DNA axes on this step.

For a **verified** experience, dish photos are auto-tagged to Live Menu items. Prefer POS bill line items when the visit has itemisation. Fill gaps with dish recognition against that outlet's live catalog. Show suggested tags. The diner can accept, remove or pick a different menu item. Do not block publish on a missed tag.

Unverified experiences get no automatic dish tags. The diner may tag manually. A manual tag still deep-links if that dish exists on Live Menu.

Experience levels:

| Level | Minimum | DNA | Tokens / Amplify |
| --- | --- | --- | --- |
| Quick signal | Worth it / Not worth it | No | No |
| Full experience | Sentiment + title/body or media | No, unless verified | Lower or standard per Token table |
| Verified experience | Full content linked to a verified visit | Yes, after moderation | Full qualifying rewards |

Verification: see §10. Unverified full experiences can publish. They never unlock or update DNA.

Limit error sheet and success sheet exist. Curation picker sheet lets the diner add the visit to a personal curation at the end.

After publish: optional Amplify prompt. Optional once-per-visit DNA axis edit and dish-tag correction. Members get a 24-hour content edit window. Regular diners follow the shorter entitlement.

AI-assisted writing is allowed for eligible diners. It may only use diner-supplied notes and sentiment. It must not invent dishes or claims. Core assistance is not silently paywalled. Extra quota may burn Tokens.

### 7.10 Profile

- Identity, completeness, member/verified badge, Elite level, Lifetime Earned Token progress
- Activity rings for experiences, curations and stories
- Counts: Curations, Experiences, Restro Stories, Check-in, followers/following
- Spendable Token balance and per-restaurant loyalty. Lifetime Earned Tokens are not spendable
- Monthly stats, own curations grid
- History: experiences, saved places, reservations, receipts, redemptions, meetups

Profile is the diner’s proof. It is not a host CRM. Public curator profile is a separate surface: bio, badges, public curations, recent experiences, recommended restaurants. Private fields and private meetups never appear there.

### 7.11 Invite

Landing plus device contact list. Growth loop. Qualifying referral Tokens follow §16. No DNA on this flow.

### 7.12 Web

**Later, after mobile:** public, mobile-width, read-only:

- `/curations` pick city
- `/curations/{city}` list
- `/curations/{city}/{slug}` detail
- `/feed/{city}` experiences

No create-experience on web in this phase.

---

## 8. Identity, consent, age and data rights

Date of birth is an identity input. It is not proof for restricted actions.

### 8.1 Age states

| State | Meaning | Allowed |
| --- | --- | --- |
| Unknown | No reliable DOB/age evidence | Non-restricted browse. No age-restricted join/purchase |
| Self-declared | DOB supplied, not independently verified | Personalisation subject to consent. Cannot unlock alcohol or age-restricted action |
| Verified adult | Approved provider confirms jurisdiction threshold | Restricted action subject to event terms |
| Verified minor | Under 18 or configured threshold | No behavioural ads or lookalikes. Restricted actions blocked. Parental-consent rules apply |
| Parent-consented minor | Guardian identity and scoped consent verified | Only consented child-safe processing. Still no targeting or adult-only access |

Alcohol-led events, brewery promotions and age-restricted meetups require verified legal-age eligibility. Self-declared DOB is insufficient.

### 8.2 Consent and rights

- Consent service stores purpose, categories, notice version, language, actor, timestamp, source and withdrawal state
- Withdrawal propagates through identity, recommendations, marketing audiences, processors and analytics
- DSAR export, correction, erasure/account closure with legal-hold exceptions
- Grievance contact published in-app
- Prefer storing age-provider assertion and reference, not document images
- Configurable retention. Baseline: registration IDs while active plus 180 days; published UGC while live then 180 days evidence after removal; marketing events 180 days then aggregate; meetup safety 365 days after completion; financial records on the statutory schedule
- No behavioural monitoring, profiling or targeted advertising for verified or reasonably suspected minors

Legal owns the DPDP effective-date and exemption matrix. The policy engine stays configurable.

---

## 9. Diner-created Curations V1

Every authenticated diner can create multiple curations. These are restaurant lists, not collaborative wishlists.

- Required: title, description, cover. Max **15 unique restaurants**
- Visibility: Public (discoverable on Home, Curations page, search, creator profile, share) or Private (owner only, never indexed)
- Add from Elite inventory, or import a restaurant not on Elite **only** via a verifiable Google restaurant entity. Store Google place id, name, address, dining place type, verification timestamp. Reject homes, landmarks, non-dining pins
- **Verified Visited** badge on an entry only when the owner has a qualifying verified visit at that exact outlet or matched external restaurant. Summary such as “6 of 10 personally visited” is allowed. Unverified entries do not inherit the badge
- Owner can add, remove, reorder, edit, switch visibility, archive or delete
- Public curations are reportable and moderatable
- Qualifying first publish (title, description, cover, ≥5 unique restaurants) can earn Tokens. Reorder, visibility change, copy or delete/repost does not re-earn
- Curations page groupings: Featured, For You, By Occasion, By Experience, Strongly Recommended by Diners, Created by Diners, From People You Follow

---

## 10. Experiences, verification and moderation

### 10.1 Verified visit ladder

Verified means Elite can audit a non-self-declared signal connecting diner, outlet and visit window. Strength may vary. Geofence, dwell or a diner claim **alone** never creates a verified experience.

Any of these can complete Create as **verified**:

| Method | Result |
| --- | --- |
| Reconciled Elite pay against a Bridge table/bill | Verified strong |
| Elite payment to mapped merchant without POS itemisation | Verified strong |
| Reservation plus check-in on Bridge | Verified strong |
| One-time table QR/OTP issued on Bridge, bound to outlet/session/table | Verified medium/strong |
| Receipt/bill OCR or bill-number match | Pending to verified |
| In-house POS / Bridge-sent bill | Verified strong |
| Waiter confirmation on Bridge | Verified lower confidence. Named staff, reason, rate-limited, reversible |

Geofence/dwell may trigger a prompt. It does not verify. Diner self-declaration can publish an **unverified** experience. It cannot claim visit-backed verification and cannot update DNA.

If every strong method fails, the diner can still post unverified. They cannot attach a verified badge or feed DNA.

### 10.2 Bill mismatch (self-checkout)

- Before confirm: refetch bill, show delta, require fresh confirm
- After confirm, before capture: void stale attempt, new idempotency key
- After capture, amount differs beyond tolerance: reconciliation exception, verification stays Pending, no silent settlement
- Timeout: escalate to finance/support. Preserve funds and evidence

### 10.3 Moderation and grievance

- Report, hide, delete, distribution limit
- Classify reports by source and reason. Rate-limit reporter abuse
- Automated pre/post-publish checks for prioritisation. Human review for consequential removal, legal disputes and appeals
- Case owner, severity, SLA, visibility, legal hold, appeal state. No unowned case
- Grievance Officer contact. 24-hour acknowledgement where applicable
- Preserve removed UGC for the evidence period, then purge unless legal hold
- Separate policy removal, author deletion, legal takedown, restaurant dispute and temporary limitation
- Author notice with reason category. Appeal path. Automated tools cannot silently rewrite sentiment or DNA
- Restaurant cannot edit diner-authored copy

---

## 11. Helpfulness and following

- One Helpful per eligible user per experience, toggleable
- Milestone notifications when diners find an experience helpful
- Follow/unfollow contributors and restaurants. Influences eligible Home modules
- Creator analytics: impressions, Helpful, profile visits, followers. Organic vs Amplify separated
- Abuse controls for reaction farms, self-reaction, coordinated engagement
- Following never exposes private identity fields

---

## 12. Live Menu, Live Vibe, reservations and pay

### 12.1 Live Menu and Vibe

- Menu outside opening hours still readable
- Availability and 86s update from Bridge (waiter app) against the POS catalog
- Diner can report incorrect items
- Vibe statuses such as Seats filling, Wait, Peak. Waiters set these on Bridge
- Search by dish name lands on the Live Menu dish plus community photos from verified tagged experiences

Every Live Menu dish is a destination, not a row. Dish page:

- Name, price, availability, description from the live catalog
- Community photos from verified experiences tagged to this dish, newest first, with diner handle
- Sticky CTAs: **Pay**, **Reserve**, **Directions**
- Pay: open Elite pay / self-checkout for this outlet. If the diner already has an open Bridge table at this outlet, add or focus this dish on that bill when POS allows. If pay is not entitled, hide Pay rather than show a dead button
- Reserve: reservation flow with this outlet pre-selected
- Directions: maps deep-link to this outlet
- If the dish is 86'd or off menu: show unavailable, disable Pay, keep Reserve and Directions

### 12.2 Reservations

- Date, time, party size. Sections where configured. Price/advance shown
- Guaranteed / sectional paid reservations where entitled
- Default 30-minute table hold
- Table mismatch dispute through the app

### 12.3 Pay and post-visit

- Eligible self-checkout with convenience fee, taxes, discount, loyalty, membership labelled separately
- Failed, pending, reversed, refunded states
- Post-visit experience prompt after successful pay or verified visit. If the bill is itemised (POS or Bridge-sent), pre-fill dish tags on that prompt
- Itemised receipt as dining memory. Line items remain the ground truth for later auto-tagging
- Token and loyalty ledgers never share one ambiguous total

### 12.4 Dish tags (verified media → Live Menu)

A dish tag links experience media to one Live Menu item at that outlet. It is not a DNA axis and not a hashtag.

| Source | When | Behaviour |
| --- | --- | --- |
| POS / Bridge bill line items | Verified visit with itemisation | Auto-suggest tags. Highest confidence |
| Dish recognition | Verified photo or video frame vs that outlet's live catalog | Auto-suggest remaining dishes. Never invent a dish not on this outlet |
| Diner pick | Any experience | Add, remove or replace a tag. Once after publish, same as DNA axis edit |
| Unverified post | No POS, no auto | Manual tag only |

Rules:

- Auto-tag only on **verified** experiences
- Multiple dishes in one photo get multiple tags
- Low-confidence matches stay off the public tag until the diner accepts
- Wrong tag: diner corrects once after publish. Restaurant can report a mismatch. They cannot silently retag diner media
- Non-ecosystem or no Live Menu: tag is a label. Tap opens the place profile, not a fake dish page
- Tappable on experience detail, Discovery cards, place-profile feed and the Live Menu dish community strip
- Composer may use dish names as Food-axis mentions. Tags do not mint new DNA axes

Same one-tap pattern everywhere we already know the outlet and the object: a tagged dish, a Live Vibe tile, a deal chip, an event. Do not dump the diner on Home to start over.

---

## 13. Value systems (do not mix)

| Product | What it is | Restriction |
| --- | --- | --- |
| Tier Discount | Immediate bill benefit. No stored balance | Cannot stack with loyalty-point redemption on the same bill |
| Restaurant Loyalty Points | Outlet ledger. 1 point = ₹1 | Only that restaurant, through Elite |
| Restaurant Membership | Outlet relationship that governs loyalty. ₹0 or restaurant-set fee | Not Elite Membership. Tokens cannot pay the fee |
| Elite Tokens | Closed-loop in-app currency. 10 Tokens = ₹1 of in-app value | Not for bills, restaurant membership or loyalty |
| Elite Membership | ₹199/month platform subscription | Does not make the diner a member of every restaurant |
| Elite Level | Lifetime confirmed Earned Tokens | Spending or expiry does not reduce it. Purchased/bonus/promo Tokens do not count |
| Trust | Credibility and safety signal | Cannot be bought |

If a restaurant issues loyalty points, it is making that diner a member of that restaurant under the plan terms.

---

## 14. Deals

Objectives: first visit, tiered spend, return visit, win-back, occasion, time/inventory, recovery, reservation-linked.

- Rules use first/repeat, visit count, last visit, spend, time, outlet, section, min bill, cap, payment/reservation, segment, usage limit
- Flat deals for Non-Ecosystem. Tiered/richer rules for Ecosystem
- Show eligibility reason, min spend, max benefit, validity, exclusions before use
- Atomic redemption. Control groups where configured
- Funding source tracked: restaurant, Elite, shared, recovery
- A Tier Discount may be open to all eligible diners or restricted to an active Restaurant Membership plan
- One transaction cannot consume a Tier Discount and loyalty points together. New points, if any, use the post-discount eligible amount

---

## 15. Restaurant loyalty and restaurant membership

### 15.1 Loyalty

- Separate ledger per diner and outlet. Immutable issue, redeem, expire, reverse, adjust
- Each restaurant sets expiry and terms. Default **365 days** after issuance if unset. Later policy changes do not rewrite existing lots unless an approved migration says so
- Show points and rupee value together (1 = ₹1)
- Checkout: eligible discount **or** loyalty redemption, not both
- Notify before material expiry
- Outlet liability reconcilable by policy version and lot
- Points are not spendable without an enrollment ID, plan version and terms-acceptance record

### 15.2 Restaurant Membership

One active plan per outlet in v1. Data model must allow future tiers without a destructive migration. Plan never carries benefits to another outlet unless a future group plan exists.

- Free plan (₹0): activates after the diner accepts current terms
- Paid plan: restaurant sets fee, billing (fixed-term or recurring), term, renewal, joining benefit, terms. Diner sees restaurant name, fee, taxes, renewal/cancellation and benefits before confirm. Payment must succeed before paid entitlements or paid-plan loyalty earning
- Elite collects the fee in INR on behalf of the restaurant. Tokens and loyalty points cannot pay it
- Benefits may include earn rate, joining points, member-only Tier Discounts, priority reservation, event perks
- When paid membership ends: paid-only benefits and new paid-plan earning stop. Existing loyalty lots remain until their own expiry
- Terms are versioned. Existing members stay on accepted terms until next renewal or an explicit migration
- No paid membership, auto-renewal or joining benefit from a loyalty event alone

---

## 16. Elite Tokens, levels and Elite Membership

### 16.1 Non-negotiable

Tokens may buy distribution and approved digital utility. They cannot buy visit verification, DNA weight, Worth it, Helpful, Trust, Curator status or organic rank.

Levels use **Lifetime Earned Tokens**: cumulative confirmed Earned Token credits from qualifying activity, less valid reversals. Spending or expiry does not reduce level. Purchased, Pack Bonus and Promotional Tokens add 0 level progress.

### 16.2 Earning (permanent rewards)

Passive login, app open, follow, Helpful vote, search, view or save earn no permanent Tokens. Those may appear only in funded, time-bound missions.

| Activity | Tokens | Rule | Default cap |
| --- | --- | --- | --- |
| Complete profile | 50 | Once, after required fields + mobile verification. Must not coerce optional consent | Once |
| Verified restaurant visit | 25 | Once per unique `verified_visit_id` | Monthly total cap |
| Pay through Elite | 1 per ₹10 net paid | Reversed on refund. No reward on Token purchases | 300/txn, 1,500/month |
| Verified full experience | 50 | One per `verified_visit_id`. Delete/repost does not re-earn | 15/month |
| Non-verified full experience | 10 | Title/body, moderation, originality | 3/month |
| Qualifying curation | 20 | First publish, ≥5 restaurants | 4/month |
| Curation quality milestone | 25 | First 10 eligible saves on a public curation | Once per curation |
| Helpful milestones | 10 then +20 | At 5 and 20 eligible Helpful | 200/month across content |
| Successful referral | 100 | New diner, first qualifying verified visit or Elite payment | 3/month |
| Verified restaurant-event attendance | 20 | Check-in confirmed, event not cancelled | 4/month |
| Paid meetup attendance | 25 | Completed, not refunded | 4/month |
| Successful meetup host | 50 | Host attended, no unresolved major dispute | 4/month |

Source caps: Elite payment 1,500; experiences/curations 400; referrals 300; events/meetups 200; Helpful 200. Standard total earned **2,000/month**. Purchased and pack-bonus excluded.

Five independently verified visits earn five rewards, including repeats at one outlet. Duplicate rewards on the same `verified_visit_id` are blocked.

### 16.3 Lots and spend

| Lot | Source | Expiry |
| --- | --- | --- |
| Purchased | Paid pack | No expiry while account active, unless legal terms require otherwise |
| Pack Bonus | Bundled with pack | 180 days |
| Earned | Qualifying activity | Pending until confirmed. Then 365 days |
| Promotional | Campaign/support | Campaign rule, shown before use |
| Pending | Unconfirmed | Not spendable |

Spend earliest-expiring eligible lot first. Within equivalent expiry: Promotional/Bonus, then Earned, Purchased last.

No cash out, P2P, resale, restaurant-bill pay, conversion to loyalty. Pending cannot be spent. Balances cannot go negative. Burn is atomic. If product activation fails after burn, restore the exact lots.

### 16.4 Token Store

| Pack | Price | Base | Bonus | Total |
| --- | --- | --- | --- | --- |
| Quick Top-up | ₹49 | 490 | 0 | 490 |
| Starter | ₹100 | 1,000 | 0 | 1,000 |
| Value | ₹250 | 2,500 | 500 | 3,000 |
| Popular | ₹500 | 5,000 | 1,500 | 6,500 |
| Power | ₹1,000 | 10,000 | 4,000 | 14,000 |

Show base and bonus separately. Packs are remotely configurable. Historical purchases keep terms at purchase time.

Surfaces: Wallet (available, Purchased, Earned, Bonus/Promo, Pending, expiring-soon), contextual top-up that returns to the interrupted flow, post-publish Amplify funding picker. v1 does not support part-cash/part-Token for one digital product.

Burns: Experience Amplify = **490 Tokens**. Optional: extra AI assistance 50-100, AI curation cover ~50, profile theme 200-500. Cosmetic burns never affect Trust or reach.

Membership Amplify credits are **not** converted to 1,470 Tokens, do not roll over, and stay a separate entitlement.

### 16.5 Elite Membership, ₹199/month

| Benefit | Behaviour |
| --- | --- |
| Verified member badge | On profile and eligible contributions while active |
| 3 Amplifies / month | Each stated at ₹49 (₹147 value). Issued once per successful billing cycle |
| 24-hour edit | Eligible experiences, 24 hours after publish |
| Long-form | Higher character limit, richer composer |
| Advanced creator analytics | Incremental Amplify reach, Helpful, followers, profile actions |
| Meetup hosting | Active member + complete verified profile + trust gates |

Handle successful, failed, pending, cancelled, refunded and grace. Entitlements are server-side. Expired members cannot start new member-only actions. Historical content stays correctly labelled.

---

## 17. Amplify

Amplify buys labelled extra distribution. It does not change DNA, Worth it, verification, Trust or organic rank.

### 17.1 Member / diner

After an eligible experience publishes:

1. Prompt: “Would you like to Amplify your experience?” Publication already succeeded. Skip is allowed.
2. Member sees remaining monthly credits and can use one. Non-member sees membership or Token/₹49 purchase.
3. Confirm consumes entitlement atomically and creates one campaign.
4. Paid impressions carry **Amplified by Member**.
5. Results separate organic from incremental.

Rules: 3 credits per paid cycle, non-transferable, no negative balance, frequency caps, pause on moderation/deletion. One-off purchase ₹49 or 490 Tokens. Default funding: unused membership credit first, then Tokens, then Store. Diner can choose.

Non-verified experiences are **not** eligible for member Amplify until Product reopens that call. Verified full experiences are.

### 17.2 Restaurant

- Eligible restaurants/agencies amplify **approved positive** experiences they did not write
- Batches start at **₹50,000 + GST**
- Label: **Promoted by Restaurant**
- Restaurant cannot edit diner copy
- Requires approval and adequate balance
- Campaign delivery, engagement and ROI reporting

---

## 18. Elara

v1 is a conversational concierge, entered from the Home Ask Elara field.

- Accept natural-language dining intent. Return only restaurants and actions grounded in Elite data. Valid entity IDs. Do not invent availability
- Use preferences, live signals, approved context, deals, availability, recent experiences, DNA character lines, reco chip. Reasons must be traceable and consent-aware
- Deep-link to place profile, Live Menu dish, reservation, deal, event or meetup. A named dish in the query opens that outlet's dish page, not a text dump. Wrong-outlet links are a defect
- Transactional help must not claim completion until the backend confirms
- Log corrections, unsupported asks and bad recommendations with PII minimised
- DNA copy rules still apply. Elara must not describe shape as a rating or rank

---

## 19. Restaurant events

Restaurant-hosted activities. Separate from member meetups.

Required content: 16:9 banner, 4:5 feed image, title, date, start time, about, organiser, terms. Recurrence: one-time, daily, weekly same day, selected weekdays. Optional: menu/CTA, ambience gallery, things to know (kids, pets, age, dress, seating, accessibility).

States: Draft, Submitted, Approved, Published, Scheduled, Active, Completed, Cancelled, Rejected.

Organic on place profile and eligible discovery. Paid amplification from Marketing Workspace or Agency. Paid exclusivity may suppress similar-event recommendations for the purchased window. Without exclusivity, similar events sit below the event page.

Paid promotion never changes DNA or organic experience ranking.

Analytics: impressions, detail, share, save, CTA, reservation/ticket, attributable visits. Organic vs amplified. Series vs occurrence. Exclusivity inventory.

Story-rail event ads must look different from a person profile and carry Event / Promoted Event disclosure. Do not show cancelled, expired, sold-out-without-waitlist or age-ineligible events.

---

## 20. Restaurant partner, marketing and agency

### 20.1 Outlet workspace

Role-based, server-side, by outlet and function.

| Workspace | Capabilities |
| --- | --- |
| Outlet operations | Profile, images, sections, Live Menu/Vibe, reservations, event delivery. Floor work runs in Bridge |
| Experience and reputation | Recent experiences, verified status, replies/recovery, DNA context, content reports. No silent axis delete |
| Deals and loyalty | Deal config within entitlement, loyalty rules, membership plan, liability, redemption |
| Marketing | Amplify, events, budgets, approvals, delivery, ROI |
| Customer activation | Segment activation via Elite/Clyro. No raw diner PII download |
| Finance | Payments, invoices, GST, balances, rewards, refunds, settlement |

Outlet Admin invites, removes and permissions users. Last-admin protection. Partner status and locked capabilities are visible. Self-upgrade is not allowed. Entitlement changes only through Elite Admin.

### 20.2 Marketing Workspace

Outlet Admin: approve marketers/agencies, spend rules, view all campaign and financial activity.
Marketing Admin: recharge/use permitted balance, launch approved products, events, reporting.
Contributor: drafts and assets. Publish/spend only if granted.

Campaign types: positive-experience Amplify, restaurant events, other approved products. States: draft, submitted, approved, live, paused, completed, rejected. Require content, dates, targeting, outlet, budget.

### 20.3 Agency portal

Elite onboards the outlet first. Agency requests linkage. Outlet Admin approves, rejects or revokes. Agency Admin cannot grant access beyond approved outlet scope. Consolidated multi-outlet dashboard. After revoke, agency loses live access. Elite/outlet/finance keep historical records.

### 20.4 Marketing money

| Balance | Purpose |
| --- | --- |
| Agency Master Central Balance | Agency recharge pool. Allocate to approved outlets. Not user-withdrawable except approved refund |
| Outlet Marketing Balance | Campaigns at that outlet |
| Promotional credit | Elite-issued. May expire. Product-restricted |
| Reserved | Held for submitted/active campaigns. Cannot reallocate until released, consumed or refunded |

Milestone rewards and Ecosystem Partner ROI where signals exist. Attribution window remains an open commercial call. Claims must not imply guaranteed revenue where Elite does not control the visit or payment signal.

---

## 21. Admin, finance and platform

- RBAC with maker-checker for finance and entitlement
- Audit every material admin action: before/after, actor, reason, timestamp, object
- Feature flags by city, platform, cohort, restaurant, partner type. Rollback without data loss
- Dispute queues: payment, campaign, loyalty, content, reservation, meetup settlement
- DNA/reco configuration and anomaly dashboards. Admins cannot silently rewrite an axis or reco without audit
- Immutable ledgers for Tokens, loyalty, marketing balances, membership fees, meetup collections
- GST, invoices, payouts, refunds, chargebacks

Non-goals that stay out: unrestricted restaurant/agency access to raw diner personal data. A generic paid listing marketplace where organic rank is purchased.

Service boundaries: identity/consent, discovery, experience/DNA, verification/pay, deals/loyalty/membership, Token wallet, Amplify/campaigns, Elara, partner/agency, meetup/quotes, admin/finance.

Instrument events for identity, discovery, experience, Amplify, Tokens, deals, loyalty, membership, events, meetups, Elara and finance. Notifications cover OTP, visit prompt, Amplify result, expiry, reservation, meetup, moderation and billing.

---

## 22. Meetups

Member-created dining gatherings. Not restaurant events.

### 22.1 Host eligibility

- Active Elite Member
- Full profile: verified mobile, name, DOB, gender, photo, approved identity verification
- Trust/level and moderation gates. Suspended or high-risk cannot create
- Manual approval for first meetup or high-risk/high-value
- No host payout until the event completes and disputes are clear

### 22.2 Create and visibility

Public: discoverable by eligible users. Private: invite, link, code or approved list only. Private details and attendee lists never leak into public discovery or curator profiles.

Meetup fields: title, description, datetime, capacity min/max, joining amount, restaurant-redeemable amount, visibility, cover. Host earnings are **not** itemised to participants. Participant UI must show **total joining price** and **amount redeemable at the restaurant**.

Draft and participant-facing preview required before publish.

### 22.3 Venue

MVP: host picks an Elite restaurant and requests confirmation. Restaurant accepts, rejects or proposes a change. Store section/table, minimum spend, package notes.

Statuses: Draft, Restaurant Requested, Confirmed, Open, Full, Completed, Cancelled.

Quote marketplace: host broadcasts date/time, party, budget, constraints to eligible restaurants. Host compares standardised quotes, asks questions, accepts terms. Track response rate and time to first quote.

### 22.4 Join, pay, settle

- Public cards: title, host, datetime, venue, price, remaining seats
- Detail: host history, inclusions, redeemable value, terms, safety notes
- One or multiple seats. Private invite accept. Waitlist
- Participant pass / QR
- Collect participant total through approved payment. Reserve seat during payment
- Do not release host payout before event completion
- Minimum-attendance deadline: cancel/refund or approved fallback
- Full/partial refund and cancellation policies. Receipts for participant and recipients
- Host chooses an allowed earning model. KYC/tax/TDS before payout. Host earnings dashboard

### 22.5 Ops and safety

- Host broadcast, reminders, venue changes
- QR or list check-in. Restaurant confirms completion
- Dietary/allergy collection with consent
- Report, block, emergency support
- Women-only, age-restricted or other gated categories. Non-self-declared age verification where required
- Host may privately flag no-show or incident
- After completion, participants rate host. Host reliability: completion, cancellation, dispute, no-show
- Participant verification tiers by category risk
- Concrete incident playbook. Liability, waiver, insurance stance remain Legal-owned open calls
- No off-platform money collection presented as Elite payment
- Non-dining events without a restaurant relationship are out of the initial meetup release

---

## 23. Primary flows

### 23.1 First session

Open app → phone → OTP → name/handle → tutorials (skippable) → Home. Gender/DOB and photo can complete later.

### 23.2 Find a place

Home occasion chip, Elara, Explore search or Discovery → place card (Worth it + hex) → place profile → optional DNA sheet → Live Menu / vibe / deal → reserve or go.

### 23.3 Share a visit

Create → place → verified method or unverified path → media + Worth it → composer infers traits and, if verified, dish tags → optional curation → success → optional Amplify.

Verified visits that pass moderation feed DNA. Verified dish tags attach to Live Menu items.

### 23.4 Read DNA

Tap hex on place, card or visit row → sheet. Low axis + Worth it chip can coexist. Copy must say the catch without unselling the place.

### 23.5 Pay and return

Reserve or walk in → waiter opens table on Bridge → pay through Elite → receipt → loyalty/membership/Tokens update → experience prompt with dish tags pre-filled when the bill is itemised.

### 23.6 Meetup

Eligible member creates meetup → restaurant confirms or quote accepted → participants pay → check-in → complete → settlement.

### 23.7 Dish photo to table action

Open a verified experience → tap tagged dish → Live Menu dish (community photos, live price/availability) → Pay, Reserve or Directions. If the diner has an open Bridge table at that outlet, Pay adds or focuses that dish on the bill.

---

## 24. Requirements

### Must

- Place radar on recommended places with ≥ 100 verified experiences. Service, Food, Value always on when shown
- At most 6 visible axes: Vibe, Presentation, Convenience unlock in that order
- Unlock from verified mention volume; fixed ring order; no placeholder axis names
- Percents per visible axis; locked axes omitted
- Reco chip independent of DNA. No Experience Score object
- Copy that DNA is not a rating
- Map mentions into a closed catalog, both polarities
- Verified ladder in §10. Unverified may publish. Unverified never updates DNA
- Distinct diners required to unlock a non-mandatory axis
- Light and Dark via color modes
- Discovery as glass-on-media; lists as Flat
- Create experience: place → proof or unverified → media + worth-it
- Explore: Worth it as the default group. Not worth it in a separate section
- Place profile including highlights, shortcut tiles, trend accordion, Reserve and Pay
- Ask Elara as grounded concierge
- Gender + DOB collected progressively. Age-restricted actions need verified adult
- Diner curations V1 with 15-cap, Google import, Verified Visited
- Helpful, follow, curator rail
- Live Menu, Live Vibe, reservations, self-checkout, bill mismatch handling
- Verified dish photos auto-tag to Live Menu. Tap opens that dish with Pay, Reserve, Directions
- Bridge is the waiter app for tables, 86s, vibe, check-in, QR/OTP and bill send
- Deals, restaurant loyalty (1 point = ₹1), restaurant membership free or paid
- Elite Tokens closed-loop, lots/expiry, Store, Lifetime Earned levels
- ₹199 membership with 3 Amplifies. Restaurant Amplify from ₹50,000 + GST
- Restaurant events, Marketing Workspace, agency portal, admin/finance
- Public/private meetups with disclosed redeemable value
- Amplify never changes DNA, Worth it or organic rank
- Child/age, consent, DSAR, UGC grievance, report-abuse protection

### Should

- Early-DNA state on the triangle
- DNA sheet from every hex, and no hex on places that do not qualify
- Once-per-visit axis edit, only after the experience is posted
- Character line on small cards when hex is unreadable
- Control groups on deals
- Token engagement experiment cohorts (earned-only vs contextual top-up vs full Store vs Store + Amplify analytics)
- Host mention samples in the restaurant workspace
- Pre-fill dish tags from an itemised Bridge/POS bill on the post-pay experience prompt

### Must not

- Feed DNA percent into worth-it as a cap
- Show locked axes as zeros
- Let one diner unlock a city-wide trait
- Show a 7th DNA axis in v1
- Put any composite number in the radar center
- Ship an Experience Score
- Use gold as a trophy glow
- Badge “complete DNA” or “highest DNA”
- Let Tokens, Amplify or ads buy DNA, Trust, Helpful or organic rank
- Mix the five value products into one wallet
- Target minors with behavioural ads
- Auto-tag unverified media
- Invent a dish tag that is not on that outlet's live catalog
- Show a dead Pay button on a dish page. Hide it if the outlet cannot take Elite pay

---

## 25. Edge cases

| Case | Handling |
| --- | --- |
| New place, under 100 verified experiences, or not recommended | No hex, no sheet. Not an empty triangle |
| One glowing or horrific Hygiene mention | Do not unlock. Hygiene is not a v1 axis |
| Only praise for food, silence on service | Service still shows, low-evidence, not 0% |
| Conflicting mentions | Blended value. Consumer See mentions is later. Hosts can see samples now |
| Spam / copied reviews | Distinct diners + moderation. Verification required for DNA |
| Value axis vs Worth it chip | Value is money/quality language. Worth it is the overall visit call. They can diverge |
| Parking or wait friction | Maps to Convenience, not a 7th axis |
| Fourth extra would unlock | Stays hidden. Cap is 6 |
| Host disputes an axis | Show mention samples. No silent delete |
| Tiny hex on a card | Character line instead of an unreadable polygon |
| Round polygons getting more taps | Flatten chrome. Strengthen “we LOVE all shapes.” Reco chip must stay visually stronger than the polygon |
| All verified methods fail | Unverified post allowed. No DNA update |
| Geofence only | Prompt, not verified |
| Bill changes after capture | Reconciliation exception. Verification Pending |
| Token burn succeeds, Amplify fails | Restore exact lots. No duplicate campaign |
| Diner buys Tokens | Wallet up. Level and Trust unchanged |
| Spend or expire Earned Tokens | Level unchanged |
| Paid restaurant membership ends | Paid benefits stop. Existing loyalty lots remain until lot expiry |
| Private curation | Never in search, Home, public profile |
| Event ad in curator rail | Must not look like a person. Must disclose Event / Promoted Event |
| Minor account | No lookalike, remarketing or behavioural campaign targeting |
| Meetup under min attendance | Cancel/refund or approved fallback. No silent keep-the-money |
| Photo matches no menu item | No public tag. Diner may pick manually. Publish still succeeds |
| Several dishes in one photo | Several tags |
| Dish 86'd after the visit | Tag remains. Dish page shows unavailable. Pay off. Reserve and Directions stay |
| No Live Menu / non-ecosystem | Tag is a label. Tap opens place profile |
| Auto-tag is wrong | Diner corrects once after publish. Restaurant reports mismatch. No silent retag |
| Open Bridge table at that outlet | Pay on the dish page adds or focuses that item on the open bill |

---

## 26. Success

**North star.** Monthly Verified Dining Relationships: unique diner-restaurant pairs completing at least one verified high-intent action in the month. Companion: 30/60/90-day Repeat Relationship Rate.

**Guests**

- Can name a place’s catch before visiting (parking, wait, noise)
- Fewer “I didn’t know” complaints after a visit
- Tap a dish in someone’s experience and reach Pay, Reserve or Directions without searching again
- Tap-through on irregular shapes stays in the same band as rounder ones
- Can go from consideration to reserve/pay/experience in one product

**Hosts**

- Read DNA as character, not a score to game
- Act on operational mentions without chasing a circle
- Run deals, loyalty, events and Amplify with reconcilable money

**Business**

- DNA sheet opens. Create-experience completion, verified and unverified, with verified share rising
- Worth-it rate that is not correlated with polygon roundness on purpose
- Amplify incremental reach without DNA or organic-rank contamination
- Token earn-to-burn and 30-day return to another meaningful contribution
- Membership using at least one benefit; M1/M3 renewal
- Deal and loyalty incrementality vs control
- Meetup completed paid seats, with settlement accuracy
- Curation creation, public save rate, verified-visit coverage on lists
- Dish-tag tap to Live Menu, then Pay / Reserve / Directions. Guardrail: false-tag rate and dead Pay buttons

**Guardrail**

If rounder shapes start getting more opens *because of the viz*, the viz has become a rating. That is a product bug. Fix chrome and copy before adding more axes.

Every growth metric needs a trust, financial or quality guardrail. Paid vs organic always split.

---

## 27. Design constraints for implementation

- Color tokens: `Elite / Primitives`, `Elite / Color`, `Elite / Spacing`, `Elite / Radius`
- Type: Playfair Display for DNA title and editorial headings. Poppins for UI. Do not add Inter on new work
- DNA type: `dna-title`, `dna-tagline`, `dna-axis`, `dna-percent`, `dna-body`
- Reco chips 26px pill. Buttons 48px. Chips 32px. Gutter 20px
- Restaurant cards stay Flat. Glass only on chips sitting on that card, or on Discovery/stories media chrome
- Promoted Event tiles in the story rail must not share the person-profile visual language

---

## 28. Decisions

Closed:

1. **Scope.** Full platform in v1: diner app, Bridge (waiter), restaurant, agency, admin, meetups.
2. **Axis names.** Service, Food, Value, Vibe, Presentation, Convenience. Food, not Taste.
3. **Always on.** Service, Food, Value. Unlock: Vibe, then Presentation, then Convenience.
4. **Cap.** Maximum 6 axes on the consumer radar in v1.
5. **Center mark.** No composite number. Glow only.
6. **Who sees DNA.** Recommended places only, after **100 verified experiences**.
7. **Visit contribution.** Composer infers. Diner may edit axes once after the experience is posted.
8. **Unlock N.** 50 distinct verified experiences or 30 unique diners, whichever is stricter.
9. **Visit proof.** Verification ladder in §10. Unverified can publish. Unverified never feeds DNA.
10. **Explore.** Not worth it appears in a separate section.
11. **Place profile.** Highlights, shortcut tiles, trend accordion, Reserve and Pay ship in v1.
12. **Web.** Later, read-only, after mobile.
13. **Elara.** Real concierge from the Home field. Grounded in Elite data. Not a dead styled search.
14. **Experience Score.** Dropped. No score service, snapshot or “87% said Worth it” object.
15. **Identity.** Gender and DOB collected progressively. Browse not blocked. Restricted actions need verified adult.
16. **Amplify / host products.** In v1. Labelled distribution only. Host dashboards in v1.
17. **Loyalty.** 1 point = ₹1. Default 365-day expiry. Delivered only through Restaurant Membership.
18. **Restaurant Membership.** Restaurant may charge ₹0 or a restaurant-defined fee. No activation without disclosed terms and, if paid, successful payment.
19. **Elite Membership.** ₹199/month, 3 Amplifies, stated at ₹49 each.
20. **Levels.** Lifetime Earned Tokens only. Spend/expiry does not reduce level. Purchased/bonus/promo never count.
21. **Meetups.** Public and private. Hosts are active Elite Members with complete verified profiles. Show total price and restaurant-redeemable amount. Do not itemise host earnings to participants.
22. **Bridge.** Waiter-side app. Tables, Live Menu 86s, Live Vibe, check-in, table QR/OTP, bill send, staff visit confirm. Not the diner app.
23. **Dish tags.** Verified experience media auto-tags to that outlet's Live Menu. Tap opens the dish with Pay, Reserve and Directions. Unverified is manual only. Do not invent dishes off catalog.

Hygiene, Wait, Seating and Accessibility are not v1 radar axes. Wait and last mile sit inside Convenience.

---

## 29. Still open

These stay commercial, legal or tuning calls. They do not block the product rules above. They do block final engineering commitment on the named subsystem.

| Decision | Why it still blocks |
| --- | --- |
| Member Amplify delivery unit (duration, qualified impressions, reach target or hybrid) | Inventory, credit value, completion |
| Restaurant ₹50,000 batch definition (count, duration, surfaces) | Campaign schema and sales fulfilment |
| Membership cancellation / grace / refund and credit expiry | Subscription lifecycle |
| Deal funding models, full stacking matrix, redemption caps | Checkout and restaurant liability |
| Loyalty policy guardrails (min/max custom expiry) | Fairness and liability |
| Event exclusivity pricing, duration, inventory | Billing and recommendation suppression |
| Final Token caps, 10 level names and Lifetime Earned thresholds | Economy tuning. Pack prices in §16 are the defaults |
| Promotional reward “Spend ₹1,00,000 / Get ₹10,000” expiry | Accounting |
| Campaign attribution window and multi-touch rule | ROI claims |
| Meetup platform fee, host earning limits, min/max price | Pricing and risk |
| Payment / fund-holding / split-settlement architecture | Legal and finance |
| Participant/host/restaurant cancellation and refund schedule | Trust flows |
| Host KYC, tax/TDS, payout thresholds | Settlement |
| Private invite security and attendee visibility options | Privacy |
| Meetup safety escalation, emergency on-call, liability/waiver/insurance | Launch gate |
| Participant enhanced-verification method for singles / women-only / elevated-risk | Safety vs privacy |
| Token Store legal/payment-channel, taxes, refund/chargeback, Purchased Token expiry | Payments |
| DPDP effective-date / exemption matrix, parental-consent provider, final retention | Child accounts and deletion jobs |
| Moderation staffing model and SLA coverage | Operating model |
| Staff-verification fallback limits | Fraud vs partner coverage |
| Migration of legacy experiences into DNA (shadow, unverified, or retro-verified) | Cutover. Unverified legacy posts must not update DNA |
