# Digital Behaviour Intelligence (DBI)

Pipeline concept: raw user activity events → behavioural profiles → usage segments → temporal change → future engagement (Increasing / Stable / Declining) → prioritised users with explanations.

**Not** an addiction predictor. **Not** a recommender.

## Why

Classical ML case study for product-usage / social behaviour analytics — entity-level features, clustering, change detection, and supervised engagement labels — with modular `src/` layout.

## Stack

Python · Pandas · NumPy · scikit-learn · modular `src/` (optional Streamlit / FastAPI UI later)

## Dataset (locked)

Kaggle: [mindfulness-app-synthetic-user-behavior-dataset](https://www.kaggle.com/datasets/juliasavlepova/mindfulness-app-synthetic-user-behavior-dataset)

Place downloads in `data/raw/` (gitignored). See [docs/DATASETS.md](docs/DATASETS.md).

## Run

```bash
git clone https://github.com/pritamexe2k4-cmyk/digital-behaviour-intelligence.git
cd digital-behaviour-intelligence
python -m venv .venv && source .venv/bin/activate
# Add deps as ingest notebooks land; package layout under src/
```

## Layout

```
docs/           # product, architecture, datasets, build plan
research/       # living log
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
