# Elite

Root project folder for the Elite app (Explorex's diner feed & social product).

```
Elite/
  product/
    design/     — design references (Figma pending — see product/design/README.md)
    business/   — product requirements, feature specs
  tech/
    codebase/   — actual app codebase(s), one folder per codebase (currently: elite_app)
    common/     — cross-codebase tech context: API reference, domain model, architecture
```

Current focus: active development and testing of the Flutter frontend
(`tech/codebase/elite_app`) against the existing stage backend documented in
`tech/common/api-reference.md`.

Start here:
1. [`product/business/product-requirements.md`](product/business/product-requirements.md) — what the app is and does.
2. [`tech/common/architecture.md`](tech/common/architecture.md) — how the codebase is structured.
3. [`tech/codebase/elite_app/README.md`](tech/codebase/elite_app/README.md) — running the app.
