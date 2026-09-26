# Reserve, Place Pay, and order at table

Reserve, Place Pay, and order-at-table all start from a place, and all need a signed-in diner. They stay three different paths.

Reserve Table shows only reserve. Order-at-table is not a choice on that entry.

Place Pay is not dine-in pay and not QSR pay: the diner types a bill amount, then a payment screen, then confirmation, and a visit is added.

Order at table is a table-QR deep link, or the place top-bar icon (scan when there is no running order, cart when there is).

```mermaid
flowchart TD
  place["place-profile"] --> reserveTap["Reserve Table"]
  place --> payTap["Place Pay"]
  place --> orderIcon{"Running order?"}
  deep["Table QR deep link"] --> dineIn["Order at table"]

  reserveTap --> gateR{Signed in?}
  gateR -->|No| authR["Auth gate"]
  authR --> reserve
  gateR -->|Yes| reserve["reserve"]
  reserve --> held["reserve-confirm"]
  held --> open["I'm at the table"]
  open --> dinePay["Dine-in pay"]
  held --> mismatch["Table mismatch report"]

  payTap --> gateP{Signed in?}
  gateP -->|No| authP["Auth gate"]
  authP --> amount
  gateP -->|Yes| amount["Enter bill amount"]
  amount --> payScreen["Payment screen"]
  payScreen --> visitApi{Visit-from-amount API?}
  visitApi -->|No| stay["Unwired. No fake success"]
  visitApi -->|Yes| confirm["Confirmation and visit"]

  orderIcon -->|No| scan["Top-bar scan"]
  orderIcon -->|Yes| cart["Top-bar cart"]
  scan --> gateO{Signed in?}
  gateO -->|No| authO["Auth gate"]
  authO --> dineIn
  gateO -->|Yes| dineIn
  cart --> running["View running order"]
```

Reserve has no captured endpoint. Place Pay does not share a path with [dine-in](./11-dine-in-pay.md) or [QSR](./12-qsr-pay.md). A failed payment stays on the bill, the cart, or the Place Pay amount screen. It does not show a receipt.
