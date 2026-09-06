# Interview Talking Points

## One-liner

“I built a connected digital behaviour intelligence pipeline: event logs to user profiles, unsupervised segments, temporal change detection, and supervised engagement trajectory — with a small app that explains why a user is prioritised.”

## Concepts to own

| Topic | Say |
| --- | --- |
| Event → profile | Why aggregation choices matter (windows, rates vs counts) |
| Leakage | Don’t use future events in features for the prediction label |
| Clustering | Scale first; interpret after; no fake labels upfront |
| Change vs predict | Change = descriptive windows; predict = supervised horizon |
| Eval | Precision/recall on Declining; calibration; error slices by segment |
| Stack | Pandas groupby/merge/datetime, NumPy vectorization, sklearn Pipeline + CV |

## Demo script

1. Show raw events sample
2. One user’s feature vector
3. Cluster membership + neighbours
4. Window change arrow
5. Predicted engagement + top drivers
6. Priority list filtered to Declining

## Don’t claim

- Clinical addiction prediction
- Production Instagram-scale serving
- That unsupervised clusters were named before fitting
