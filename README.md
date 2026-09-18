# Digital Behaviour Intelligence

Raw user activity events → behavioural profiles → usage segments → temporal change → future engagement (Increasing / Stable / Declining) → prioritised users with explanations.

**Status:** Designing & building / Phase 1 — docs + light stubs. Dataset locked (Option A). Next: ingest + data quality; full train after ingest notebooks exist.

Case study: social / product-usage intelligence — **not** an addiction predictor, **not** a recommender.

## Pipeline

1. **Behaviour profiling** — frequency, recency, intensity, diversity, consistency, trend
2. **Segmentation** — scale + cluster; interpret clusters after fitting
3. **Change detection** — historical vs recent → STABLE / INCREASING / DECLINING / SHIFT
4. **Future engagement** — supervised → Increasing / Stable / Declining
5. **Prioritise** — ranked users + feature / segment / change drivers

## Dataset (locked)

Kaggle: [juliasavlepova/mindfulness-app-synthetic-user-behavior-dataset](https://www.kaggle.com/datasets/juliasavlepova/mindfulness-app-synthetic-user-behavior-dataset)

Tables: Users + Sessions + Events. Place downloads in `data/raw/` (gitignored). See [docs/DATASETS.md](docs/DATASETS.md).

## Stack

Python · Pandas · NumPy · scikit-learn · modular `src/` (optional Streamlit or FastAPI UI later)

## Getting started

```bash
git clone https://github.com/pritamexe2k4-cmyk/digital-behaviour-intelligence.git
cd digital-behaviour-intelligence
python -m venv .venv && source .venv/bin/activate
# add deps as ingest notebooks land; package layout under src/
```

## Project layout

```
docs/           # product, architecture, datasets, build plan
research/       # living log
src/
  data/         # loaders, DQ (stubs)
  features/     # profiling (stubs)
  models/       # cluster, change, predict (stubs)
  app/          # UI / API (stubs)
```

## Docs

| Doc | Purpose |
| --- | --- |
| [docs/PRODUCT.md](docs/PRODUCT.md) | Product story |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | End-to-end pipeline |
| [docs/BUILD_PLAN.md](docs/BUILD_PLAN.md) | Milestones |
| [docs/DATASETS.md](docs/DATASETS.md) | Dataset notes |

Brum (voice RAG) is a separate repo — keep classical ML behaviour work here.

## License

None yet — portfolio case study.
