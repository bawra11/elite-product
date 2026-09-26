# Onboarding

Phase 1 does not ask for a phone number. The tutorial runs once, before Home. Each tutorial slide in the prototype can skip to Home.

```mermaid
flowchart TD
  start([First launch]) --> name["auth-name: name and handle"]
  name --> t1["tut-1 Experience"]
  t1 --> t2["tut-2 Experience DNA"]
  t2 --> t3["tut-3 Curation"]
  t3 --> t4["tut-4 Discovery"]
  t4 --> home["home-list"]
  t1 -->|Skip| home
  t2 -->|Skip| home
  t3 -->|Skip| home
  t4 -->|Skip| home
```

After Home, the diner is a named guest. Browsing, place profiles, and reading experiences stay open.

## Phase 3, after the first successful sign-in

No screen in the design export covers this tour. It is shown once, not on later logins.

```mermaid
flowchart TD
  verified["auth-verified"] --> tour["Network tour"]
  tour --> showProfile["Show the diner profile"]
  showProfile --> suggest["Suggested establishments to follow"]
  suggest --> community["Create your own community"]
  community --> invite["Invite friends"]
  invite --> done([Return to the action that asked for identity])
  verified -->|Complete profile instead| p30["auth-profile-30"]
  p30 --> p100["auth-profile-100"]
  p100 --> done
```
