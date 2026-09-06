# Architecture

```
Raw events (user_id, ts, event_type, ...)
        │
        ▼
 Behaviour Profiling (Pandas/NumPy)
   frequency · recency · intensity · diversity · consistency · trend
        │
        ▼
 Segmentation (sklearn Pipeline: Scale → Cluster)
   interpret clusters AFTER fitting
        │
        ▼
 Change Detection (window compare)
   historical vs recent → % deltas → STABLE / INCREASING / DECLINING / SHIFT
        │
        ▼
 Future Engagement (supervised)
   features → Increasing / Stable / Declining
        │
        ▼
 Priority + Explanations
   score users · surface drivers · entity report / dashboard
```

## Planned layout (stubs OK now)

```
digital-behaviour-intelligence/
  docs/
  research/
  src/
    data/          # loaders, DQ
    features/      # profiling
    models/        # cluster, change, predict
    app/           # Streamlit or FastAPI + UI
  notebooks/       # optional EDA
  README.md
```

## Design rules

- Event-level input preferred (joins across Users/Sessions/Events OK)
- sklearn `Pipeline` + CV for supervised stage
- Error analysis after predict (who we miss and why)
- Modular: profiling outputs feed segment, change, and predict — shared feature store in memory/parquet
