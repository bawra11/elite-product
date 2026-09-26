# Post detail

Three detail screens. Helpful and Not helpful are on experiences. Worth it belongs to the experience payload, not to the reaction row. A restaurant story does not carry worth it.

```mermaid
flowchart TD
  card["Feed card, not the reaction control"] --> kind{Post type?}
  kind -->|Experience| exp["experience-detail"]
  kind -->|Curation| cur["curation-detail"]
  kind -->|Restaurant story, happening| story["story-detail"]

  exp --> worth["Worth it or not worth it, from the author"]
  exp --> votes["Helpful and Not helpful"]
  votes --> who{Signed in?}
  who -->|No| gate["Auth gate, then return"]
  who -->|Yes| sent["PUT reaction"]

  exp --> author{Viewer is the author?}
  cur --> author
  story --> author
  author -->|Yes| actions["Show delete and edit"]
  author -->|No| hide["Hide delete and edit"]

  actions --> del["DELETE the post"]
  actions --> editNote["Edit stays hidden until an edit route exists"]

  exp --> place["place-profile"]
  exp --> dish["dish-detail from a tagged dish"]
  cur --> place
  story --> place
  story --> menu["live-menu"]
```

DNA is not drawn on an experience. The pre-audit export still links a DNA gem from `experience-detail`. The product rule is restaurant-only.

Not helpful is shown in the product. The wire value `FEED_POST_REACTION_UNHELPFUL` is not confirmed in a capture. `FEED_POST_REACTION_INVALID` means there is no viewer. It is not a third button.
