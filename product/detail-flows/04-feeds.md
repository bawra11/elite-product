# Experience and Curation tabs

Both tabs use the Home list. The only difference is the post type filter.

```mermaid
flowchart TD
  bar["Tab bar"] --> expTab["Experience tab"]
  bar --> curTab["Curation tab"]

  expTab --> expList["Same list as Home, experiences only"]
  curTab --> curList["Same list as Home, curations only"]

  expList --> tap{Tap target?}
  tap -->|Reaction| inline["Helpful or Not helpful, stay on the list"]
  tap -->|Card| expDetail["experience-detail"]

  curList --> tap2{Tap target?}
  tap2 -->|Reaction| inline2["Helpful or Not helpful, stay on the list"]
  tap2 -->|Card| curDetail["curation-detail"]

  expList --> empty["Empty state when the filter returns nothing"]
  curList --> empty
```

The prototype screen `curation-feed` is not the Curation tab. The tab is the filtered Home list. `curation-feed` is export-only and not a product destination.
