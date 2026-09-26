# Waiter, reorder, and table mismatch

Digital Dining's in-venue bar is Home, Menu, Re-order or All Orders, Pay Bill, and Waiter Req. Pay is the dine-in or QSR diagram. These three are the rest. None has a Claude Design screen, and none has a captured endpoint.

```mermaid
flowchart TD
  venue["In the venue"] --> waiter["Waiter request"]
  waiter --> sent["Request sent"]
  sent --> venue

  venue --> history["All orders"]
  history --> again["Reorder"]
  again --> mode{Service?}
  mode -->|QSR| qsr["QSR cart"]
  mode -->|Dine-in| table{"Open table bill?"}
  table -->|Yes| dine["Add onto that bill"]
  table -->|No| qsr

  held["reserve-confirm"] --> seated{Seated in the booked section?}
  seated -->|Yes| open["I'm at the table, open bill"]
  seated -->|No| report["Report a table mismatch"]
  report --> held
  open --> dinePay["Dine-in pay"]
```

A held table lasts 30 minutes past the slot. Parties above 6 are confirmed by the outlet rather than held automatically. A terrace hold can take an advance that is adjusted against the bill. Those rules sit on `reserve` and `reserve-confirm`. The report action on the held screen has nowhere to submit yet.
