# Datasets

## LOCKED (2026-09-06) — Option A

**Mindfulness App Synthetic User Behavior Dataset**  
Kaggle: [`juliasavlepova/mindfulness-app-synthetic-user-behavior-dataset`](https://www.kaggle.com/datasets/juliasavlepova/mindfulness-app-synthetic-user-behavior-dataset)

- Event-level: **Users + Sessions + Events** (multi-table joins)
- Primary source for Digital Behaviour Intelligence
- Framing: digital **product usage** case study (social-media transferable story) — **not** addiction prediction
- Local download (once pulled): prefer `data/raw/` under this repo (gitignored) or Desktop `digital-behaviour-intelligence/data/raw/`

## Real-data option (added 2026-09-26) — real mobile app-usage datasets

Option A stays the locked synthetic pipeline dataset. These **real** datasets are now downloaded locally (`data/raw/`, gitignored) as the real-data option. Full details: [README → Dataset details](../README.md#dataset-details); research: [research/mobile-app-usage-datasets.md](../research/mobile-app-usage-datasets.md).

| Dataset | Real? | Use |
|---|---|---|
| **Mobile Phone Use (Telefónica)** — 342 people, ~4 weeks, foreground apps + mood self-reports | Real | **First real project** — person-day features, usage types, mood prediction ([plan](../research/first-project-plan.md)) |
| **LSApp** — 292 users, open/close events, 87 apps | Real | Quick prototyping: sessions, next-app prediction |
| **Tsinghua App Usage** — 1,000 users, 1 week, network-derived app usage | Real | Spatio-temporal / POI-aware modelling |
| **Carat Top 1000** — 2014–2018, country via MCC | Real | Second project: long-term drift, India (MCC 404/405/406) vs other countries category mix |
| **DiversityOne** — 8 countries incl. India | Real | Request only (not downloaded) |

Same pipeline story: events → sessions → features → segments → prediction. Synthetic Kaggle screen-time sets remain rejected (see research).

## Deferred

### B — eCommerce events
- Kaggle `mkechinov` ecommerce-events / multi-category — deferred

### C — Hybrid
- Deferred until A pipeline is solid

## Avoid

Pre-aggregated Instagram “1 row per user” tables — kills the event→profile interview story.
