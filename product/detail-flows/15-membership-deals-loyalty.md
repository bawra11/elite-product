# Membership, deals, and loyalty

A dine-in bill can take one benefit, and it can sell Elite membership before pay. Deals, loyalty, and membership are linked from the place and the receipt. None of those three screens was exported. The token wallet is a different ledger and does have a screen.

```mermaid
flowchart TD
  place["place-profile"] --> deals["Deals"]
  place --> loyalty["Loyalty"]
  place --> memberCard["Membership"]

  bill["pay-bill"] --> benefit{One benefit}
  benefit -->|Deal| dealOn["Deal applied"]
  benefit -->|Points| pointsOn["Loyalty points applied"]
  dealOn --> locked["The other benefit stays off for this bill"]
  pointsOn --> locked

  bill --> upsell{Already an Elite member?}
  upsell -->|No| join["Join Elite on the bill"]
  join --> order["elite_membership_orders create, init, verify"]
  order -->|Verified| added["Elite added"]
  order -->|Failed| bill
  upsell -->|Yes| added
  added --> pay["Continue dine-in pay"]
  locked --> pay

  receipt["pay-receipt"] --> ledgers["Points, tokens, and the deal move separately"]
  ledgers --> loyalty
  ledgers --> wallet["wallet"]
```

Membership purchase is the gateway's `elite_membership_orders` create, init, and verify. No request body is captured. Profile already shows `elite_membership` and `restaurant_memberships`. Deals and loyalty have no captured read or redeem route, so those screens stay empty until they do.
