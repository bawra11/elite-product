# Place

Place profile is open to guests. Live Menu is open to guests. Live Vibe needs sign-in. Reserve, Place Pay, and order-at-table ask for identity. DNA opens only when the restaurant has more than 100 verified experiences. Below that, the sheet is not offered.

Place Pay is a different flow from dine-in pay and from QSR pay. Do not collapse them.

Reserve Table shows only the reserve option. Order-at-table is not a choice on that entry.

Order at table starts from a table-QR deep link, or from the top-right icon on the place screen: a scan icon when there is no running order, a cart icon when there is (opens the running order). That dine-in sign-in is the WhatsApp magic link.

```mermaid
flowchart TD
  entry["Place row, card, or story"] --> place["place-profile"]

  place --> dnaCheck{"At least 100 verified experiences?"}
  dnaCheck -->|Yes| dna["dna-sheet"]
  dnaCheck -->|No| noDna["No DNA control"]
  dna --> place

  place --> vibeGate{Signed in?}
  vibeGate -->|No| vibeAuth["Auth gate"]
  vibeAuth --> vibe["live-vibe"]
  vibeGate -->|Yes| vibe
  vibe --> emptyVibe["Empty state when live vibe has no endpoint"]

  place --> menu["live-menu, open to guests"]
  menu --> dish["dish-detail"]
  dish --> place

  place --> reserve["Reserve Table, reserve only"]
  place --> placePay["Place Pay"]
  place --> topIcon{"Running order?"}
  topIcon -->|No| scan["Top-bar scan icon"]
  topIcon -->|Yes| cart["Top-bar cart icon"]
  scan --> dineIn["Order at table"]
  cart --> running["View running order"]
  deep["Table QR deep link"] --> dineIn

  placePay --> amount["Enter bill amount"]
  amount --> payUi["Payment screen"]
  payUi --> wired{Visit-from-amount API?}
  wired -->|No| unwired["Stay here. Payment and visit stay unwired"]
  wired -->|Yes| confirm["Confirmation"]
  confirm --> visit["Visit added"]

  place --> follow["Follow restaurant"]
  follow --> gate{Signed in?}
  gate -->|No| auth["Auth gate"]
  gate -->|Yes| saved["Follow saved"]

  place --> stories["Stories count"]
  stories --> story["story-detail"]
```

Live vibe is one of the three core purposes. No live-vibe endpoint is in the captured lists, so the screen stays an empty state rather than demo content.

No captured diner-app API creates a visit from a typed bill amount. Place Pay is implemented through amount entry and a payment screen. It does not call dine-in pay, does not fake a successful payment, and does not add a visit until that API exists.
