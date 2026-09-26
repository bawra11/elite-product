# Home

Home is one list of experiences, curations, and restaurant stories. Helpful and Not helpful act on the card and do not open detail. Every other tap on a card opens detail.

The circular bubbles at the top open the story viewer. That viewer is the Discovery UI. Discovery is not a tab and not a separate feed.

```mermaid
flowchart TD
  home["home-list"] --> bubbles["Circular bubbles"]
  home --> feed["Mixed feed"]

  bubbles --> viewer["Story viewer, Discovery UI"]
  viewer --> story["story-detail when the bubble is a restaurant story"]
  viewer --> place["place-profile"]
  viewer --> home

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

Modules named in the brief (highlights, followed experiences, brand curation suggestions, place suggestions, brand promotions) are slots in this list. The export does not show them as separate screens. The brand-promotions slot opens the same place, offer, or brand curation as a WhatsApp promotion.
