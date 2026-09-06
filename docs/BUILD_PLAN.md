# Build Plan

**Gate:** Dataset lock (A/B/C) before heavy feature freeze / full train.

## Milestones

1. **Data ingest + DQ** — load tables, schema checks, null/dup rates, time range
2. **EDA** — event mix, session length, power users, sparsity
3. **Feature engineering** — profiling metrics (vectorized NumPy/Pandas)
4. **Clustering** — scale → cluster → interpret (silhouette / business read)
5. **Change detection** — dual windows → labels STABLE/INCREASING/DECLINING/SHIFT
6. **Supervised engagement** — train/val/test, CV, metrics, error analysis
7. **App** — Streamlit **or** FastAPI + simple UI: entity report + priority list
8. **Polish** — README diagram, interview checklist, sample outputs

## Parallel with Brum

Brum = voice RAG owned stack. This repo = classical ML behaviour intelligence. Keep separate.
