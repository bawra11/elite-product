# Reserve and pay

Both start from a place and both need a signed-in diner. Guests hit the auth gate and come back to the same step.

```mermaid
flowchart TD
  place["place-profile"] --> reserveTap["Reserve"]
  place --> payTap["Pay bill"]

  reserveTap --> gateR{Signed in?}
  gateR -->|No| authR["Auth gate"]
  authR --> reserve
  gateR -->|Yes| reserve["reserve"]
  reserve --> held["reserve-confirm"]
  held --> place

  payTap --> gateP{Signed in?}
  gateP -->|No| authP["Auth gate"]
  authP --> bill
  gateP -->|Yes| bill["pay-bill"]
  bill --> changed{Bill changed while paying?}
  changed -->|Yes| mismatch["pay-mismatch, same screen"]
  mismatch --> bill
  changed -->|No| paid["Payment verified"]
  paid --> receipt["pay-receipt"]
  receipt --> place
```

Reserve has no captured endpoint. Pay uses the stage payment init and verify routes from dine-in `main`. If either call fails, the screen stays on the bill with an error state, not a fake receipt.
