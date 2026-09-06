# Digital Behaviour Intelligence

**One-liner:** Raw user activity events → behavioural profiles → usage segments → temporal change → future engagement (Increasing / Stable / Declining) → prioritised users with explanations.

**Repo:** https://github.com/pritamexe2k4-cmyk/digital-behaviour-intelligence  
**Status:** Docs + light stubs · **dataset not locked** (waiting A/B/C) · full train pipelines not started.

Case study: social-media / Instagram-style **digital product usage** intelligence — **not** an addiction predictor, **not** a recommender.

---

## Pipeline (one connected system)

1. **Behaviour Profiling** — event → user features (frequency, recency, intensity, diversity, consistency, trend)
2. **Segmentation** — scale + cluster; interpret clusters after (no invented labels first)
3. **Change Detection** — historical vs recent windows → STABLE / INCREASING / DECLINING / SHIFT
4. **Future Engagement Prediction** — supervised → Increasing / Stable / Declining
5. **Prioritise** — ranked users + explanations (feature / segment / change drivers)

## Stack

Pandas · NumPy · scikit-learn · EDA · feature engineering · modular app (entity report + Streamlit or FastAPI + simple UI)

## Docs

| Doc | Purpose |
| --- | --- |
| [docs/PRODUCT.md](docs/PRODUCT.md) | Product story, use / non-use |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | End-to-end pipeline |
| [docs/DATASETS.md](docs/DATASETS.md) | Candidates A/B/C — **await lock** |
| [docs/BUILD_PLAN.md](docs/BUILD_PLAN.md) | Milestones |
| [docs/INTERVIEW.md](docs/INTERVIEW.md) | Talking points |
| [research/research.md](research/research.md) | Living log |

## Related

Brum (voice RAG) is a **separate** repo — do not mix.

## License

Private build / portfolio case study — license TBD.
