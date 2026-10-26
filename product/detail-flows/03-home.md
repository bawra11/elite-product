# Home

Home is one mixed list of three post types: experience, curation, and restaurant story. Helpful and Not helpful act on the card and do not open detail. Every other tap on a card opens detail.

At the top there is a curation row and other filtered modules (highlights, followed experiences, brand curation suggestions, place suggestions, brand promotions). Those modules come from separate calls with different arguments, not from the mixed list. The app will render unused brief-module slots in a later pass. They stay in this diagram.

The circular bubbles at the top are the followed authors (§23). Each bubble holds all of that author's posts, which can be experiences, curations or restaurant stories, and opens the story viewer in the Discovery UI. It plays like Instagram (2026-10-25): a photo for 1.5 s and a video for its length. A tap on the left third goes back and anywhere else goes on, crossing authors at either end. Holding pauses, a swipe across changes author, and a swipe down closes. A bubble watched through greys and moves to the end, and seen state stays on the device. Discovery is not a tab and not a separate feed.

The feed is ranked from a location: the device's position when permission is already given, else the listed city nearest the IP location (2026-10-26). Home never asks for location on open. "Use my location" in the location sheet asks.

```mermaid
flowchart TD
  home["home-list"] --> bubbles["Circular bubbles"]
  home --> modules["Curation row and other modules"]
  home --> feed["Mixed feed: experience, curation, restaurant story"]

  bubbles --> viewer["Story viewer, Discovery UI"]
  viewer --> story["story-detail when the bubble is a restaurant story"]
  viewer --> curFromRing["curation-detail when the bubble is a curation"]
  viewer --> place["place-profile"]
  viewer --> home

  modules --> curFromRing
  modules --> place
  modules --> later["Unused brief-module slots, future render"]

  feed --> card{What was tapped?}
  card -->|Helpful or Not helpful| react["Update reaction in place"]
  react --> ident{Signed in?}
  ident -->|No| gate["Auth gate, then return"]
  ident -->|Yes| home
  gate --> home

  card -->|Experience card body| exp["experience-detail"]
  card -->|Curation card body| cur["curation-detail"]
  card -->|Restaurant story card body| story
  card -->|Place| place
```

Empty, offline, and error states stay on Home. They do not swap in demo cards.

The brand-promotions slot, once rendered, opens the same place, offer, or brand curation as a WhatsApp promotion.
