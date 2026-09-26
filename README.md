# Digital Behaviour Intelligence (DBI)

Pipeline concept: raw user activity events → behavioural profiles → usage segments → temporal change → future engagement (Increasing / Stable / Declining) → prioritised users with explanations.

**Not** an addiction predictor. **Not** a recommender.

## Why

Classical ML case study for product-usage / social behaviour analytics — entity-level features, clustering, change detection, and supervised engagement labels — with modular `src/` layout.

## Stack

Python · Pandas · NumPy · scikit-learn · modular `src/` (optional Streamlit / FastAPI UI later)

## Dataset (locked, synthetic)

Kaggle: [mindfulness-app-synthetic-user-behavior-dataset](https://www.kaggle.com/datasets/juliasavlepova/mindfulness-app-synthetic-user-behavior-dataset)

Place downloads in `data/raw/` (gitignored). See [Datasets](#datasets).

**Real datasets now available (2026-09-26):** real mobile app-usage datasets have been added as the real-data option alongside Option A — see **Datasets** below.

## Datasets

Raw files live in `data/raw/<dataset>/` and are **gitignored** (nothing under `data/raw/` is tracked). Reproduce the downloads with:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\download_datasets.ps1            # all (Carat is ~6.4 GB)
powershell -ExecutionPolicy Bypass -File scripts\download_datasets.ps1 -Only lsapp,tsinghua,telefonica
powershell -ExecutionPolicy Bypass -File scripts\download_datasets.ps1 -Only carat   # resumable: re-run to continue
```

Per-dataset flags: `-Only telefonica`, `-Only lsapp`, `-Only tsinghua`, `-Only carat` (combine with commas).

`scripts/download_datasets.sh` does the same on Linux/macOS. Downloads are resumable and size-checked. Research notes: [research/mobile-app-usage-datasets.md](research/mobile-app-usage-datasets.md).

| Dataset | Download size | What it has | Real / synthetic | Access | Local path |
|---|---|---|---|---|---|
| Mindfulness App Synthetic (Option A) | see Kaggle | Users + sessions + events | **Synthetic** | Open (Kaggle) | `data/raw/` |
| Mobile Phone Use (Telefónica, Pielot et al. '17) | 310,938,979 B zip (`mpud.zip`) | 342 people, ~4 weeks, foreground apps, screen/unlock, notifications, **mood self-reports** | Real | Open | `data/raw/telefonica_mobile_phone_use/` |
| LSApp (Aliannejadi et al. '21) | 7,329,439 B (`lsapp.tsv.gz`, tar) → 178,930,494 B `lsapp.tsv` | 292 users, app open/close events with sessions, 87 apps | Real | Open | `data/raw/lsapp/` |
| Tsinghua App Usage (Yu et al. '18) | 25,363,073 B `App_usage_trace.rar` (+ 3 small .rar) | 1,000 users, 1 week, one Chinese city, app ID + base station + traffic | Real | Open | `data/raw/tsinghua_app_usage/` |
| Carat Top 1000 (Univ. Helsinki) | 6,375,824,106 B zip (password-protected) | 1,000 users, 2014–2018, running-app snapshots, country via MCC | Real | Open (password on site) | `data/raw/carat_top1000/` |
| DiversityOne (Univ. Trento) | — (not downloaded) | 782 students, 8 countries incl. India, per-app logs | Real | **Request only** | `data/raw/diversityone/` |

All real datasets are **research use only**: cite the papers below, no commercial use, no re-identification attempts.

**Real-data option (added 2026-09-26).** Option A stays the locked synthetic pipeline dataset; the real datasets are the real-data option. Intended use:

| Dataset | Use |
|---|---|
| Mobile Phone Use (Telefónica) | **First real project** — person-day features, usage types, mood prediction ([plan](research/first-project-plan.md)) |
| LSApp | Quick prototyping: sessions, next-app prediction |
| Tsinghua App Usage | Spatio-temporal / POI-aware modelling |
| Carat Top 1000 | Second project: long-term drift, India (MCC 404/405/406) vs other countries category mix |
| DiversityOne | Request only (not downloaded) |

Same pipeline story: events → sessions → features → segments → prediction. Synthetic Kaggle screen-time sets remain rejected (see [research](research/mobile-app-usage-datasets.md)).

**Other options considered (from the 2026-09-06 lock):**
- **B — eCommerce events:** Kaggle `mkechinov` ecommerce-events / multi-category — deferred.
- **C — Hybrid:** deferred until the A pipeline is solid.
- **Avoid:** pre-aggregated Instagram “1 row per user” tables — kills the event→profile interview story.

### Dataset details

#### Mobile Phone Use Dataset (Pielot et al., Telefónica Research)
- **Source:** https://sites.google.com/view/mobile-phone-use-dataset → Google Drive file `1tQA1jKm1qHIuwO-llNHSjwJrRc4teyI2` (`mpud.zip`). Mirror: IEEE DataPort CRAWDAD `telefonica/mobilephoneuse`.
- **Citation:** M. Pielot, B. Cardoso, K. Katevas, J. Serrà, A. Matic, N. Oliver. *Beyond Interruptibility: Predicting Opportune Moments to Engage Mobile Phone Users.* UbiComp / IMWUT 2017.
- **Content:** 342 participants, ~4 weeks (summer 2016), one CSV per participant; 25 sensors incl. app-in-foreground, screen on/off/unlock, notifications, semantic location, activity, ambient noise; frequent valence/arousal self-reports; Big-5, boredom proneness, PHQ-8 for some.
- **Format:** zip of CSVs. **Terms:** public anonymised release; cite the paper.
- **Why:** only open dataset here with real per-app foreground time **and** mood self-reports → first project ([research/first-project-plan.md](research/first-project-plan.md)).

#### LSApp (Aliannejadi et al.)
- **Source:** https://github.com/aliannejadi/LSApp (`lsapp.tsv.gz`). Also IEEE DataPort DOI 10.21227/w17r-xx75.
- **Citation:** M. Aliannejadi, H. Zamani, F. Crestani, W. B. Croft. *Context-aware Target Apps Selection and Recommendation for Enhancing Personal Mobile Assistants.* ACM TOIS 2021.
- **Content:** 292 users; open/close/interaction events with `session_id`, 87 app names, 2017-09-09 → 2018-05-17; 3,658,589 rows (our count).
- **Format:** despite the `.gz` name the file is a **tar.gz** (7,329,439 bytes); `tar xzf lsapp.tsv.gz` → `lsapp.tsv` (TSV, 178,930,494 bytes). The script skips the download if `lsapp.tsv` is already present, so the `.gz` can be deleted after extraction. **Terms:** no licence file; research use with citation.

#### Tsinghua App Usage Dataset (Yu et al., FIB Lab)
- **Source:** https://fi.ee.tsinghua.edu.cn/appusage/ — `App_usage_trace.rar`, `App2Category.rar`, `Categorys.rar`, `base_poi.rar`.
- **Citation:** D. Yu, Y. Li, F. Xu, P. Zhang, V. Kostakos. *Smartphone App Usage Prediction Using Points of Interest.* IMWUT 2018. Must name "Tsinghua App Usage Dataset".
- **Content:** 1,000 users, 1 week (Apr 2016), one large Chinese city; user, timestamp, base station, app ID, traffic bytes; 2,000 apps in 20 categories. Apps identified from **network traffic**, not foreground screen time.
- **Format:** RAR (extract with 7-Zip / WinRAR / `unrar`; left unextracted). **Terms:** research only, no commercial use, no re-identification.

#### Carat Top 1000 Users Long-Term App Usage Dataset (Univ. of Helsinki)
- **Source:** https://www.cs.helsinki.fi/group/carat/data-sharing/ — `carat-data-top1k-users-2014-to-2018-08-25.zip`.
- **Citation:** A. J. Oliner, A. P. Iyer, I. Stoica, E. Lagerspetz, S. Tarkoma. *Carat: Collaborative Energy Diagnosis for Mobile Devices.* SenSys 2013. Must name "Carat Top 1000 Users Long-Term App Usage Dataset".
- **Content:** 1,000 longest-running Carat users, 2014 → Aug 2018, 18,146,042 records, 100+ countries (MCC + timezone; India = MCC 404/405/406); battery-change–triggered samples listing running apps with foreground/background priority; top 10,000 apps; Play-category map.
- **Format:** password-protected zip of JSON; the password is printed on the source page (a local copy is kept in `data/raw/carat_top1000/password.txt`, gitignored). Download is resumable: re-run `scripts\download_datasets.ps1 -Only carat`. Tools: github.com/carat-project/carat-dataset-tools.
- **Terms:** research only; commercial use prohibited; no re-identification.
- **Caveat:** sparse snapshots, not true screen time — use for relative category mix / long-term drift.

#### DiversityOne (Univ. of Trento / WeNet) — request only (not downloaded)
- **What:** 782 college students in 8 countries (China, Denmark, **India** [Amrita Vishwa Vidyapeetham], Italy, Mexico, Mongolia, Paraguay, UK), 4 weeks, 26 sensor types, 350K+ self-reports. The app-usage bundle includes *Running Applications* sampled every 5 s, notifications, music playback, headset status. The only dataset found with per-app logs for Indian users alongside other countries, collected the same way.
- **Links:** project https://datascientia.eu/projects/diversityone/ · docs https://datascientiafoundation.github.io/docs/LivePeople/papers/diversityone.html · paper (IMWUT) https://arxiv.org/abs/2502.03347
- **How to request:**
  1. Open the project/docs page above and follow the data-access (request) procedure.
  2. You need an **institutional email**, a short **research proposal** (e.g. "per-app usage patterns and mood, India vs other countries") and the **bundle identifier** of the app-usage bundle you want.
  3. Approved users receive **Parquet** files. Redistribution is not allowed — keep them under `data/raw/diversityone/` (gitignored).
- **Note:** independent researchers may not qualify on their own; an academic affiliation or collaborator helps.

#### Mindfulness App Synthetic User Behavior Dataset (Option A, synthetic)
- Kaggle [`juliasavlepova/mindfulness-app-synthetic-user-behavior-dataset`](https://www.kaggle.com/datasets/juliasavlepova/mindfulness-app-synthetic-user-behavior-dataset) — see "Dataset (locked, synthetic)" above. **Synthetic**; kept as the original pipeline dataset (locked 2026-09-06).
- Event-level: **Users + Sessions + Events** (multi-table joins); primary source for DBI.
- Framing: digital **product usage** case study (social-media transferable story) — **not** addiction prediction.
- Local download: `data/raw/` under this repo (gitignored) or Desktop `digital-behaviour-intelligence/data/raw/`.

## Research

- [research/research.md](research/research.md) — living log
- [research/mobile-app-usage-datasets.md](research/mobile-app-usage-datasets.md) — survey of real vs synthetic app-usage / screen-time datasets
- [research/first-project-plan.md](research/first-project-plan.md) — first project (Telefónica: usage types + mood prediction), then Carat (India vs world)

## Run

```bash
git clone https://github.com/pritamexe2k4-cmyk/digital-behaviour-intelligence.git
cd digital-behaviour-intelligence
python -m venv .venv && source .venv/bin/activate
# Add deps as ingest notebooks land; package layout under src/
```

## Layout

```
data/raw/       # datasets (gitignored)
docs/           # product, architecture, datasets, build plan
research/       # living log + dataset research + project plan
scripts/        # download_datasets.ps1 / .sh
src/
  data/         # loaders, DQ (stubs)
  features/     # profiling (stubs)
  models/       # cluster, change, predict (stubs)
  app/          # UI / API (stubs)
```

## Status

**Designing & building / Phase 1** — docs + light stubs. Dataset locked. Next: ingest + data quality; full training after ingest notebooks exist.

## License

None yet — portfolio case study.
