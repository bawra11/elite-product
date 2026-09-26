# Auth

Sign-in is phone number plus OTP, or a WhatsApp magic link. There is no password. The gate opens only for an action tied to a person: react, follow, post, reserve, pay, and Profile.

The WhatsApp path has an endpoint (`PUT /dd/v1/whatsapp/login`) and no screen in the export. The diagram does not invent extra screens for it.

```mermaid
flowchart TD
  action["Identity action"] --> session{Session?}
  session -->|Authenticated| go([Do the action])
  session -->|Guest| gate["auth-gate"]
  gate -->|Keep browsing| back([Close the gate])
  gate -->|Verify my number| phone["auth-phone"]
  phone -->|Send OTP| otp["auth-otp"]
  otp -->|Change number| phone
  otp -->|Code accepted| verified["auth-verified"]
  phone -->|WhatsApp magic link| leave["Leave to WhatsApp"]
  leave --> returnLink["App opens from the link"]
  returnLink --> verified
  verified --> first{First verification on this account?}
  first -->|Yes| tour["Phase 3 tour, once"]
  first -->|No| go
  tour --> go
```

```mermaid
stateDiagram-v2
  [*] --> guest
  guest --> named: name and handle saved
  named --> authenticated: phone OTP or WhatsApp link
  authenticated --> named: session expired
  named --> guest: local name cleared
```

`guest` can open the public feed. `named` is phase 1 on this device, still without a JWT. `authenticated` holds the access token and the rotated refresh token in secure storage.
