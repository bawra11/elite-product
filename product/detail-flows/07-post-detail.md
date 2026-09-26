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

  actions --> confirmDel["Confirm delete"]
  confirmDel --> del["DELETE the post"]
  del -->|Fails| stay["Stay on detail with an error"]
  actions --> editExp["Experience: existing create flow"]
  actions --> editCur["Curation: existing edit route"]

  exp --> place["place-profile"]
  exp --> dish["dish-detail from a tagged dish"]
  cur --> place
  story --> place
  story --> menu["live-menu"]
```

DNA is not drawn on an experience. The pre-audit export still links a DNA gem from `experience-detail`. The product rule is restaurant-only.

Not helpful is shown in the product. The wire value is `FEED_POST_REACTION_UNHELPFUL`. `FEED_POST_REACTION_INVALID` means there is no viewer. It is not a third button.

Delete is `DELETE /v1/feed_posts/{uuid}` and is wired for the author. Guests and other diners do not see it. Edit on a curation opens the existing curation editor. Edit on an experience reuses the create-experience flow; there is still no captured `PUT /v1/feed_posts/{uuid}` to persist an in-place edit.
