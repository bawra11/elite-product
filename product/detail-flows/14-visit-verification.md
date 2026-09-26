# Visit verification

A verified experience is tied to a real visit and order. `create-visit` shows three states. The ways to attach a missing visit have no screen of their own.

```mermaid
flowchart TD
  place["create-place"] --> visit["create-visit"]
  visit --> pick{Which row?}
  pick -->|Paid through Elite and reconciled on Bridge| strong["Verified"]
  pick -->|Bill photo still matching| ocr["Pending, bill OCR"]
  pick -->|Visit not listed| missing["I don't see my visit"]

  missing --> qr["Scan the table QR"]
  missing --> waiter["Waiter confirms on Bridge"]
  missing --> skip["Post without a visit"]

  qr --> matched{Order attached?}
  waiter --> matched
  matched -->|Yes| strong
  matched -->|Not yet| ocr
  ocr --> narrate["create-narrate"]
  strong --> narrate
  skip --> unverified["Unverified post still publishes"]
  unverified --> narrate

  narrate --> tagged{Verified order?}
  tagged -->|Yes| dishes["Dish tags from the invoice"]
  tagged -->|No| plain["No dish tags, and it does not feed DNA"]
```

The visit list is `PUT /dd/v1/users/orders/histories`. Dish lines are `GET /dd/v1/orders/{orderId}/invoice`. Every captured experience still has an empty `visit_id` and `order_id`. An unverified post is allowed. It does not feed restaurant DNA and it does not auto-tag dishes.
