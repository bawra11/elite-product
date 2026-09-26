# Curation

A curation is a post of type curation: a list of restaurants, with a required caption, an optional cover, and an optional body. The title is the post title, not a field inside the curation payload. Brand curations are the same shape from a brand or restaurant author, and they are promoted in the feed. The capture has no `promoted` field yet.

```mermaid
flowchart TD
  tab["Create tab"] --> sheet["Sheet: Experience or Curation"]
  sheet -->|Curation| gate{Signed in?}
  gate -->|No| auth["Auth gate"]
  auth --> mine
  gate -->|Yes| mine["my-curations"]
  mine -->|New| fresh["curation-new"]
  fresh --> add["curation-add: pick restaurants"]
  add --> save["POST feed post, type curation"]
  save --> detail["curation-detail"]
  mine -->|Open one| detail

  detail -->|Author| edit["Edit restaurants or text"]
  edit --> add
  detail -->|Anyone else| read["Read only"]
  detail --> place["place-profile of a member restaurant"]
```

From an experience, `create-curation-pick` adds that place to an existing curation or starts one. Delete and edit on the curation show only for the author.
