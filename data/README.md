# data/

Raw datasets live in `data/raw/<dataset>/` and are **gitignored** (only the README files are tracked).
Reproduce the downloads with:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\download_datasets.ps1            # all (Carat is ~6.4 GB)
powershell -ExecutionPolicy Bypass -File scripts\download_datasets.ps1 -Only lsapp,tsinghua,telefonica
```

(`scripts/download_datasets.sh` does the same on Linux/macOS.) Full research notes: [research/mobile-app-usage-datasets.md](../research/mobile-app-usage-datasets.md).

| Dataset | Local path | Download size | Real / synthetic | Access |
|---|---|---|---|---|
| Mobile Phone Use Dataset (Telefónica) | `data/raw/telefonica_mobile_phone_use/` | 310,938,979 B zip (`mpud.zip`) | Real | Open |
| LSApp | `data/raw/lsapp/` | 7,329,439 B (`lsapp.tsv.gz`, tar) → 178,930,494 B `lsapp.tsv` | Real | Open |
| Tsinghua App Usage | `data/raw/tsinghua_app_usage/` | 25,363,073 B `App_usage_trace.rar` (+ 3 small .rar) | Real | Open |
| Carat Top 1000 Users | `data/raw/carat_top1000/` | 6,375,824,106 B zip (password-protected) | Real | Open |
| DiversityOne | `data/raw/diversityone/` | — (not downloaded) | Real | **Request only** |
| Mindfulness App Synthetic (Option A) | `data/raw/` (Kaggle download) | see Kaggle | **Synthetic** | Open (Kaggle) |

All real datasets are **research use only**: cite the papers below, no commercial use, no re-identification attempts.

---

## Mobile Phone Use Dataset (Pielot et al., Telefónica Research)
- **Source:** https://sites.google.com/view/mobile-phone-use-dataset → Google Drive file `1tQA1jKm1qHIuwO-llNHSjwJrRc4teyI2` (`mpud.zip`). Mirror: IEEE DataPort CRAWDAD `telefonica/mobilephoneuse`.
- **Citation:** M. Pielot, B. Cardoso, K. Katevas, J. Serrà, A. Matic, N. Oliver. *Beyond Interruptibility: Predicting Opportune Moments to Engage Mobile Phone Users.* UbiComp / IMWUT 2017.
- **Content:** 342 participants, ~4 weeks (summer 2016), one CSV per participant; 25 sensors incl. app-in-foreground, screen on/off/unlock, notifications, semantic location, activity, ambient noise; frequent valence/arousal self-reports; Big-5, boredom proneness, PHQ-8 for some.
- **Format:** zip of CSVs. **Terms:** public anonymised release; cite the paper.
- **Why:** only open dataset here with real per-app foreground time **and** mood self-reports → first project ([research/first-project-plan.md](../research/first-project-plan.md)).

## LSApp (Aliannejadi et al.)
- **Source:** https://github.com/aliannejadi/LSApp (`lsapp.tsv.gz`). Also IEEE DataPort DOI 10.21227/w17r-xx75.
- **Citation:** M. Aliannejadi, H. Zamani, F. Crestani, W. B. Croft. *Context-aware Target Apps Selection and Recommendation for Enhancing Personal Mobile Assistants.* ACM TOIS 2021.
- **Content:** 292 users; open/close/interaction events with `session_id`, 87 app names, 2017-09-09 → 2018-05-17; 3,658,589 rows (our count).
- **Format:** despite the `.gz` name the file is a **tar.gz**; `tar xzf lsapp.tsv.gz` → `lsapp.tsv` (TSV). **Terms:** no licence file; research use with citation.

## Tsinghua App Usage Dataset (Yu et al., FIB Lab)
- **Source:** https://fi.ee.tsinghua.edu.cn/appusage/ — `App_usage_trace.rar`, `App2Category.rar`, `Categorys.rar`, `base_poi.rar`.
- **Citation:** D. Yu, Y. Li, F. Xu, P. Zhang, V. Kostakos. *Smartphone App Usage Prediction Using Points of Interest.* IMWUT 2018. Must name "Tsinghua App Usage Dataset".
- **Content:** 1,000 users, 1 week (Apr 2016), one large Chinese city; user, timestamp, base station, app ID, traffic bytes; 2,000 apps in 20 categories. Apps identified from **network traffic**, not foreground screen time.
- **Format:** RAR (needs 7-Zip/WinRAR/`unrar`; left unextracted). **Terms:** research only, no commercial use, no re-identification.

## Carat Top 1000 Users Long-Term App Usage Dataset (Univ. of Helsinki)
- **Source:** https://www.cs.helsinki.fi/group/carat/data-sharing/ — `carat-data-top1k-users-2014-to-2018-08-25.zip`.
- **Citation:** A. J. Oliner, A. P. Iyer, I. Stoica, E. Lagerspetz, S. Tarkoma. *Carat: Collaborative Energy Diagnosis for Mobile Devices.* SenSys 2013. Must name "Carat Top 1000 Users Long-Term App Usage Dataset".
- **Content:** 1,000 longest-running Carat users, 2014 → Aug 2018, 18,146,042 records, 100+ countries (MCC + timezone; India = MCC 404/405/406); battery-change–triggered samples listing running apps with foreground/background priority; top 10,000 apps; Play-category map.
- **Format:** password-protected zip of JSON; the password is printed on the source page (a local copy is kept in `data/raw/carat_top1000/password.txt`, gitignored). Tools: github.com/carat-project/carat-dataset-tools.
- **Terms:** research only; commercial use prohibited; no re-identification.
- **Caveat:** sparse snapshots, not true screen time — use for relative category mix / long-term drift.

## DiversityOne (Univ. of Trento / WeNet) — request only
- See [raw/diversityone/README.md](raw/diversityone/README.md). 782 students, 8 countries incl. India, 4 weeks, running apps every 5 s. Not downloaded.

## Mindfulness App Synthetic User Behavior Dataset (Option A, synthetic)
- Kaggle `juliasavlepova/mindfulness-app-synthetic-user-behavior-dataset` — see [docs/DATASETS.md](../docs/DATASETS.md). **Synthetic**; kept as the original pipeline dataset.
