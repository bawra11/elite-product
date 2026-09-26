# Dine-in pay

Dine-in is a table session. Staff open the bill on Bridge, and the diner pays that running bill. Digital Dining also has an amount-entry path: the diner types what to pay, and the tier unlock moves while they type. A waiter can still add items, so the total can change during pay.

This is not the QSR cart. Packaging charges belong to QSR.

```mermaid
flowchart TD
  entry["Place Pay bill, held reservation, table QR, or DD Pay Bill"] --> gate{Signed in?}
  gate -->|No| auth["Auth gate"]
  auth --> source
  gate -->|Yes| source{Which bill?}

  source -->|Table opened on Bridge| bill["pay-bill"]
  source -->|Typed amount| amount["Amount entry"]
  amount --> tier["Tier unlock updates while typing"]
  tier --> offer{Amount valid for an offer?}
  offer -->|No| amount
  offer -->|Yes| apply["Apply offer"]
  apply --> bill

  bill --> lines["Line items, tax, Elite convenience fee"]
  lines --> benefit["One benefit: a deal or loyalty points"]
  benefit --> member{Join Elite on this bill?}
  member -->|Yes| join["Membership order"]
  member -->|No| init
  join --> added["Elite added"]
  added --> init["Payment init"]

  init -->|Init fails| stay["Stay on the bill with an error"]
  init -->|Init ok| moved{Bill moved before capture?}
  moved -->|Yes| mismatch["pay-mismatch"]
  mismatch -->|Confirm the new total| verify
  mismatch -->|Back to the bill| bill
  moved -->|No| verify["Payment verify"]
  verify -->|Verify fails| stay
  verify -->|Verified| receipt["pay-receipt"]
  verify -->|Bill moved after capture| pending["Verification stays pending"]
  pending --> reconcile["Reconciliation, no silent settle"]

  receipt --> write["Write it now"]
  receipt --> loyalty["Loyalty"]
  receipt --> done["Done"]
  write --> narrate["create-narrate"]
```

`pay-bill`, `pay-mismatch`, and `pay-receipt` are the exported screens. Amount entry, the tier stepper, Apply Offer, and Join Elite are in the July Digital Dining frames and have no Claude Design screen id.

The itemized bill is `GET /dd/v1/orders/{orderId}/invoice`. Pay is `…/payments/appsdk/init` then `…/payments/sdk/verify`. Membership uses `elite_membership_orders` create, init, and verify. No request body for that membership order is captured.

On the bill, a deal and loyalty points cannot be combined. Tokens cannot pay a restaurant bill. The receipt moves three ledgers separately: the restaurant's points, Elite tokens, and the spent deal. A failed init or verify stays on the bill. Nothing is charged when the mismatch sheet appears before capture.
