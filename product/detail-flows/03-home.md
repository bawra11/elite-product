# Home

Home is one mixed list of three post types: experience, curation, and restaurant story. Helpful and Not helpful act on the card and do not open detail. Every other tap on a card opens detail.

At the top there is a curation row and other filtered modules (highlights, followed experiences, brand curation suggestions, place suggestions, brand promotions). Those modules come from separate calls with different arguments, not from the mixed list. The app will render unused brief-module slots in a later pass. They stay in this diagram.

The circular bubbles at the top open a Discovery-like story viewer. That viewer can contain curations or restaurant stories, not only experiences. Discovery is not a tab and not a separate feed.

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
