# QSR pay

QSR is counter service. The restaurant `qsr` config names a floor area and a packaging-charge rule: an upper limit, a fixed amount, or no limit. The diner builds a cart and pays that cart. There is no Bridge table session, so a waiter cannot add an item while payment is in progress, and the dine-in mismatch sheet does not apply.

SkipQ is the QSR app on the same gateway (`skip_q_routes.go`). Its session is a `skip_q_users` identity, not a diner user. The Claude Design export has no SkipQ, cart, or order-status screen.

```mermaid
flowchart TD
  entry["QSR place or SkipQ QR"] --> app{Which app?}
  app -->|Elite, at a QSR place| diner["Diner session"]
  app -->|SkipQ| skip["skip_q_users session"]
  diner --> gate{Signed in?}
  skip --> gate
  gate -->|No| auth["Auth gate"]
  auth --> menu
  gate -->|Yes| menu["Menu"]

  menu --> add["Add items"]
  add --> cart["Cart"]
  cart --> pack["Packaging charge from the qsr rule"]
  pack --> edit{Change the cart?}
  edit -->|Yes| menu
  edit -->|No| init["Payment init"]
  init -->|Init fails| cartErr["Stay on the cart with an error"]
  init -->|Init ok| verify["Payment verify"]
  verify -->|Verify fails| cartErr
  verify -->|Verified| status["Order status"]
  status --> receipt["Receipt"]
  receipt --> review["Review prompt"]
  receipt --> done["Done"]
  review --> visit["create-visit for this order"]
```

Order status uses the QSR status gradient. The status names are not in the captured docs. SkipQ payment routes are not in the captured endpoint list. The only written payment routes are the dine-in init and verify paths, and those are table-order routes.

Digital Dining's cart chrome (Add, quantity, View Cart) is the cart this flow uses. Reorder lands back on this cart when the restaurant is QSR.
