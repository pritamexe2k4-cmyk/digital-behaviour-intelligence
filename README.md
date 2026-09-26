# Digital Behaviour Intelligence (DBI)

Pipeline concept: raw user activity events → behavioural profiles → usage segments → temporal change → future engagement (Increasing / Stable / Declining) → prioritised users with explanations.

**Not** an addiction predictor. **Not** a recommender.

## Why

Classical ML case study for product-usage / social behaviour analytics — entity-level features, clustering, change detection, and supervised engagement labels — with modular `src/` layout.

## Stack

Python · Pandas · NumPy · scikit-learn · modular `src/` (optional Streamlit / FastAPI UI later)

## Dataset (locked, synthetic)

Kaggle: [mindfulness-app-synthetic-user-behavior-dataset](https://www.kaggle.com/datasets/juliasavlepova/mindfulness-app-synthetic-user-behavior-dataset)

Place downloads in `data/raw/` (gitignored). See [docs/DATASETS.md](docs/DATASETS.md).

**Real datasets now available (2026-09-26):** real mobile app-usage datasets have been added as the real-data option alongside Option A — see **Datasets** below.

## Datasets

Raw files live in `data/raw/<dataset>/` (gitignored; only READMEs tracked). Reproduce with `powershell -ExecutionPolicy Bypass -File scripts\download_datasets.ps1` (or `scripts/download_datasets.sh`). Details, citations, terms: [data/README.md](data/README.md).

| Dataset | Size | What it has | Access | Local path |
|---|---|---|---|---|
| Mindfulness App Synthetic (Option A) | Kaggle | Synthetic users + sessions + events | Open (Kaggle) | `data/raw/` |
| Mobile Phone Use (Telefónica, Pielot et al. '17) | 310 MB zip | 342 people, ~4 weeks, foreground apps, screen/unlock, notifications, **mood self-reports** | Open | `data/raw/telefonica_mobile_phone_use/` |
| LSApp (Aliannejadi et al. '21) | 7 MB (179 MB TSV) | 292 users, app open/close events with sessions, 87 apps | Open | `data/raw/lsapp/` |
| Tsinghua App Usage (Yu et al. '18) | 25 MB rar | 1,000 users, 1 week, one Chinese city, app ID + base station + traffic | Open | `data/raw/tsinghua_app_usage/` |
| Carat Top 1000 (Univ. Helsinki) | 6.4 GB zip | 1,000 users, 2014–2018, running-app snapshots, country via MCC | Open (password on site) | `data/raw/carat_top1000/` |
| DiversityOne (Univ. Trento) | — | 782 students, 8 countries incl. India, per-app logs | Request only | `data/raw/diversityone/` |

All real datasets: research use only, cite the papers, no re-identification.

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
data/           # README + raw/ (gitignored datasets)
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
