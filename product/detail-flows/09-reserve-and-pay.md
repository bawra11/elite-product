# Reserve, and which pay path

Reserve and pay both start from a place, and both need a signed-in diner. Pay then splits by service. Dine-in is a table bill. QSR is a cart.

```mermaid
flowchart TD
  place["place-profile"] --> reserveTap["Reserve"]
  place --> payTap["Pay"]

  reserveTap --> gateR{Signed in?}
  gateR -->|No| authR["Auth gate"]
  authR --> reserve
  gateR -->|Yes| reserve["reserve"]
  reserve --> held["reserve-confirm"]
  held --> open["I'm at the table"]
  open --> dine["Dine-in pay"]
  held --> mismatch["Table mismatch report"]

  payTap --> gateP{Signed in?}
  gateP -->|No| authP["Auth gate"]
  authP --> mode
  gateP -->|Yes| mode{Restaurant service?}
  mode -->|Dine-in| dine
  mode -->|QSR| qsr["QSR pay"]
```

Reserve has no captured endpoint. The two pay paths are [dine-in](./11-dine-in-pay.md) and [QSR](./12-qsr-pay.md). A failed payment stays on the bill or the cart. It does not show a receipt.
