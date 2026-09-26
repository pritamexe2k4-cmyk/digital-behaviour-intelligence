# Research log — Digital Behaviour Intelligence

**Started:** 2026-09-06

## Direction

- Case study: Instagram-style digital **product usage** (not addiction)
- One pipeline: profile → segment → change → predict → priority
- Skills: Pandas, NumPy, sklearn, EDA, FE, error analysis, modular app
- Dataset: **LOCKED Option A** — Kaggle `juliasavlepova/mindfulness-app-synthetic-user-behavior-dataset` (Users+Sessions+Events)

## Session notes

- 2026-09-06: Researchy briefed Spider; repo + docs pack created; Brum stays separate.

- 2026-09-06: Preetam locked Option A; B/C deferred; next = ingest + DQ plan/notebooks before full train.

- 2026-09-26: Researched real mobile app-usage / screen-time datasets → [mobile-app-usage-datasets.md](mobile-app-usage-datasets.md). Downloaded Telefónica Mobile Phone Use, LSApp, Tsinghua App Usage into `data/raw/` and started the 6.4 GB Carat Top-1000 download (resumable via `scripts/download_datasets.ps1 -Only carat`) (gitignored; see [README → Datasets](../README.md#datasets)); DiversityOne is request-only. Real data added as the real-data option alongside Option A. First project plan → [first-project-plan.md](first-project-plan.md) (Telefónica first, Carat second).
