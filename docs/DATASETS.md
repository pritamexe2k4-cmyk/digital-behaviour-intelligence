# Datasets — WAIT for Preetam lock

**Avoid:** pre-aggregated Instagram “1 row per user / ~57 columns” tables — they skip the event→profile interview story.

## Preferred candidates (Researchy 2026-09-06)

### A — Mindfulness App Synthetic User Behavior (preferred social-product analogue)
- Kaggle: `juliasavlepova/...` (Mindfulness App Synthetic User Behavior)
- **Users + Sessions + Events** = true event-level + multi-table joins
- Digital product usage; map event names to social-like taxonomy in docs if needed

### B — eCommerce events (strong RFM / scale)
- Kaggle: `mkechinov` ecommerce-events / multi-category
- Large real event logs (view / cart / purchase)
- Frame as digital product behaviour; excellent session/RFM features
- Slightly less “social” themed

### C — Hybrid later
- Users metadata + event logs + time-window outcomes (Option B multi-source) if schemas compatible

## Also noted (secondary)

- Simulated Social Media Interaction (Kaggle `aaidoudi/...`)
- HF FreeSyntheticWebEvents50M (huge — sample only)
- SURGE: event-*centric social* (posts about news) — **weaker** fit for per-user **product usage**

## Lock gate

No full training / final feature freeze until Preetam picks **A**, **B**, or **C**.
