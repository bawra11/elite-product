# Place

Place profile is open to guests. Reserve and pay ask for identity. DNA opens only when the restaurant has more than 100 verified experiences. Below that, the sheet is not offered.

```mermaid
flowchart TD
  entry["Place row, card, or story"] --> place["place-profile"]

  place --> dnaCheck{"At least 100 verified experiences?"}
  dnaCheck -->|Yes| dna["dna-sheet"]
  dnaCheck -->|No| noDna["No DNA control"]
  dna --> place

  place --> vibe["live-vibe"]
  vibe --> emptyVibe["Empty state when live vibe has no endpoint"]

  place --> menu["live-menu"]
  menu --> dish["dish-detail"]
  dish --> place

  place --> reserve["reserve"]
  place --> pay["pay-bill"]
  place --> follow["Follow restaurant"]
  follow --> gate{Signed in?}
  gate -->|No| auth["Auth gate"]
  gate -->|Yes| saved["Follow saved"]

  place --> stories["Stories count"]
  stories --> story["story-detail"]
```

Live vibe is one of the three core purposes. No live-vibe endpoint is in the captured lists, so the screen stays an empty state rather than demo content.
