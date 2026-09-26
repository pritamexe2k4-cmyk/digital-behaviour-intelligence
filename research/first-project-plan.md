# First project plan — real mobile app-usage data

**Date:** 2026-09-26 · Source research: [mobile-app-usage-datasets.md](mobile-app-usage-datasets.md) · Data: [README → Datasets](../README.md#datasets)

## Project 1 (start here): Telefónica Mobile Phone Use Dataset

**Why this one first:** it is the only open dataset found with **real per-app screen (foreground) time plus mood self-reports** (valence/arousal). Small enough to handle on a laptop: 310 MB zip, 342 people, ~4 weeks each.

**Reuses the DBI pipeline:** events → sessions → features → segments (→ prediction), same as `src/data` → `src/features` → `src/models`.

### ~1-week plan

| Day(s) | Step | Output |
|---|---|---|
| 1–2 | **Person-day feature table** from foreground-app + screen events: total screen time, per-app-category minutes, unlocks, sessions (count, mean length), late-night use (e.g. 00:00–05:00 minutes) | `person_day` table (one row per participant per day) |
| 3 | **EDA**: top apps by time, time-of-day profiles, heavy vs light users | notebook + charts |
| 4 | **Cluster users into usage types** (scaled per-user aggregates → k-means / GMM, silhouette, profile each cluster) | segment labels + descriptions |
| 5–6 | **Predict self-reported mood from the day's phone behaviour**: simple baseline (mean / linear or logistic) → gradient boosting; per-participant split to avoid leakage; feature importance (permutation / SHAP) | model card + error analysis |
| 7 | **Ship**: clean GitHub repo (README, results), optional **Streamlit dashboard** (user segments, daily profile, mood-vs-usage) | public repo / demo |

Notes: app → category mapping needs to be built (Play Store categories); country not verified (Telefónica Research study, possibly Spain) — do not claim a country.

## Project 2 (next): Carat Top-1000 — multi-year, India vs rest of world

- Use Carat (2014–2018, 1,000 users, MCC + timezone) for **long-term drift** and **app-category mix**.
- Compare **India (MCC 404/405/406) vs other countries** on *relative* category mix — first count how many Indian users are actually in the top-1000 subset.
- Carat samples are battery-change snapshots, not true screen time: anchor **absolute hours** to **DataReportal Digital 2026** aggregate country figures (e.g. https://datareportal.com/reports/digital-2026-india) and label that layer as aggregate/survey-based.
- 6.4 GB zipped JSON → chunked reading or Spark (carat-project/carat-dataset-tools).

## In parallel
- Request **DiversityOne** (India + 7 countries, per-app logs) — see [README → DiversityOne](../README.md#diversityone-univ-of-trento--wenet--request-only-not-downloaded).
- LSApp (7 MB) is the quick fallback for prototyping sessionisation / next-app prediction.
