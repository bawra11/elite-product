# Profile, follow, and block

The basic user profile view is not gated, but any private information or analytics on the profile is gated behind sign-in. Guests (not signed in) can see a user's name, handle, and the Experiences and Curations tabs. Stats, Elite Tokens, Analysis and Memberships stay locked until sign-in. Superseded 2026-10-01: this note does not decide which fields count as private. Superseded 2026-10-01: membership fields are not classified as private.

A guest who opens the tab sees the basic profile. "Verify my number" opens `auth-phone` for the gated parts. Analysis is analytics: the share they called Worth it, how many diners found them helpful, and their most frequent tags. With no experiences it is an empty state. Analysis is gated.

```mermaid
flowchart TD
  tab["Profile tab"] --> basic["Basic profile view"]
  basic --> details["Name and handle"]
  basic --> private["Stats, Elite Tokens, Memberships, gated"]
  basic --> analysis["Analysis, gated"]
  private --> gate{Signed in?}
  analysis --> gate
  gate -->|No| auth["auth-phone"]
  auth --> shown["Private information or analytics"]
  gate -->|Yes| shown
  shown --> metrics["Worth it share, helpful count, top tags; empty with no experiences"]

  basic --> sub{Sub-tab?}
  sub -->|Experiences| mineExp["This diner's experiences"]
  sub -->|Curations| mineCur["This diner's curations"]
  mineExp --> exp["experience-detail"]
  mineCur --> cur["curation-detail"]
  exp --> own["Author actions, because these are their posts"]
  cur --> own
```

Follow and block are identity actions. Follow can target a restaurant, a diner, or a brand. Block is diner to diner.

```mermaid
flowchart TD
  from["Profile, place, or author row"] --> choice{Action?}
  choice -->|Follow| fgate{Signed in?}
  choice -->|Unfollow| fgate
  choice -->|Block| fgate
  fgate -->|No| auth["Auth gate"]
  auth --> call
  fgate -->|Yes| call["Follow, unfollow, or block request"]
  call --> done["Row updates in place"]
```

Another diner's public profile, and a list of posts by author, are not in the captured endpoints. Tapping someone else stops at an empty state until those exist. The Profile tab itself is this diner's own profile, built from system components. It was not in the design export.
