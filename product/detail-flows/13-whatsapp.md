# WhatsApp promotion and review

Promotion and review are separate from sign-in. Diner sign-in is a phone OTP, which can be delivered on WhatsApp. The magic link `PUT /dd/v1/whatsapp/login` is the dine-in deep link only, not a branch on the diner phone sheet. A promotion or a review message sends only when `whatsapp_consent_given` is true. Campaign send is the Nextel refresh worker on the catalog service. No message template and no deep-link contract are captured.

```mermaid
flowchart TD
  consent{"whatsapp_consent_given?"}
  consent -->|No| noSend["No promotional or review WhatsApp"]
  consent -->|Yes| kind{Which message?}

  kind -->|Promotion| campaign["Nextel campaign"]
  campaign --> waPromo["WhatsApp promotion"]
  waPromo --> openP["Open the link"]
  openP --> dest{Destination}
  dest -->|Place| place["place-profile"]
  dest -->|Offer| deal["Deal for that place"]
  dest -->|Brand curation| cur["curation-detail"]
  place --> pay["Dine-in or QSR pay"]
  deal --> pay

  slot["Home brand-promotions slot"] --> dest

  kind -->|Review| trigger["Paid visit or verified order"]
  trigger --> waReview["WhatsApp review ask"]
  waReview --> openR["Open the link"]
  openR --> gate{Signed in?}
  gate -->|No| auth["Auth gate, then return"]
  auth --> visit
  gate -->|Yes| visit["create-visit with that order"]
  visit --> narrate["create-narrate"]
  narrate --> post["Experience post"]
  visit -->|Dismiss| stop["No post"]

  receipt["pay-receipt, Write it now"] --> narrate
```

The Home brand-promotions slot is the same offer inside the app, so a promotion does not require WhatsApp. The receipt already asks the diner to write the visit, so a review does not require WhatsApp. The WhatsApp link opens that same destination from outside. With consent off, only the in-app slot and the receipt prompt remain.
