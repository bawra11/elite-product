# App map

Guest browsing stays open. An identity action opens the auth gate, then returns to the thing the diner tapped.

Home is a mixed list of experiences, curations, and restaurant stories. A curation row and other filtered modules sit at the top. Those modules come from separate calls with different arguments, not from the mixed list. The app will render the unused brief-module slots later.

Story bubbles open a Discovery-like viewer that can contain curations or restaurant stories, not only experiences.

Place Pay is its own path. Dine-in pay and QSR pay stay separate. Order at table is a deep link or the place top-bar icon, not a Reserve choice.

The diner phone sheet is OTP only. A WhatsApp magic link is the dine-in deep link, not a branch on that sheet.

```mermaid
flowchart TD
  launch([Open app]) --> known{Named on this device?}
  known -->|No| onboard["Phase 1 name and tutorial"]
  known -->|Yes| home["Home"]
  onboard --> home

  home --> bubbles["Story bubbles"]
  home --> modules["Curation row and other modules"]
  home --> card["Mixed feed card"]
  home --> tabs["Tab bar"]

  bubbles --> viewer["Story viewer, Discovery UI"]
  modules --> detail["Post or place detail"]
  card --> detail

  tabs --> home
  tabs --> exp["Experience tab"]
  tabs --> create["Create sheet"]
  tabs --> cur["Curation tab"]
  tabs --> profile["Profile"]

  exp --> detail
  cur --> detail
  create --> expFlow["Create experience"]
  create --> curFlow["Create curation"]

  detail --> place["Place profile"]
  place --> dna["DNA sheet"]
  place --> vibe["Live vibe"]
  place --> menu["Live menu"]
  menu --> dish["Dish"]
  place --> reserve["Reserve only"]
  place --> placePay["Place Pay"]
  place --> orderIcon["Top-bar scan or cart"]
  orderIcon --> dineIn["Order at table"]

  placePay --> amount["Enter bill amount"]
  amount --> payScreen["Payment screen"]
  payScreen --> confirm["Confirmation and visit"]

  detail --> react["Helpful or not helpful"]
  detail --> follow["Follow"]
  profile --> follow

  react --> gate{Signed in?}
  follow --> gate
  expFlow --> gate
  curFlow --> gate
  reserve --> gate
  placePay --> gate
  dineIn --> gate
  profile --> gate

  gate -->|Yes| back["Continue the action"]
  gate -->|No| auth["Phone OTP"]
  auth --> tour{First verification?}
  tour -->|Yes| phase3["Network tour, once"]
  tour -->|No| back
  phase3 --> back
```
