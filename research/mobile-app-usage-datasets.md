# Mobile app usage / screen time datasets: research report
*For Preetam. Compiled 26 Sep 2026 (IST). Every link below was checked from the box on this date (HTTP status noted where relevant). All numbers come from the source pages. The only exception is marked "(my count)": I downloaded that file and counted it myself.*

**Bottom line:** No public dataset gives per-user daily phone time by app with country labels for India and the rest of the world. Four real datasets come closest and can be downloaded without an access request. The best one to request is DiversityOne. It includes Indian students, but access needs an institutional request. The Kaggle "screen time" sets that people use most are synthetic.

---

## Top picks (ranked by size, then quality)

### 1. Carat Top 1000 Users Long-Term App Usage Dataset (University of Helsinki)
- **Link:** https://www.cs.helsinki.fi/group/carat/data-sharing/
- **Direct file:** https://www.cs.helsinki.fi/group/carat/data-sharing/carat-data-top1k-users-2014-to-2018-08-25.zip (HTTP 200, **6,375,824,106 bytes ≈ 6.4 GB**). The zip password is printed on the page.
- **Who / year:** Carat project, University of Helsinki (with UC Berkeley). The data runs from 2014 to Aug 2018. Cite Oliner et al., SenSys 2013.
- **Size (as stated):** The top 1,000 users ranked by how long they used Carat since 2014. The page says there are "18,146,042 time series records spanning 4.65 years for the longest duration users, and over 2 years even for the 1000th." The records come from "over 100 countries, and 315 timezones." Only the top 10,000 apps are included.
- **Granularity:** Event-sampled snapshots. The app took a sample each time the battery level changed by 1%. Each sample has uuid, timestamp, batteryLevel, batteryStatus, **timeZone**, **mobileCountryCode (MCC)**, and a list of apps, each with a `processName` (Android package) and `priority` (foreground/background etc.). The download also includes device model and OS history, and an app → Google Play category map.
- **Per-app breakdown:** Yes, by package name, with Google Play categories.
- **Country:** Yes, indirectly, from MCC and timezone. India's MCCs are 404, 405 and 406. The related Carat paper (MobileHCI'18, "The Hidden Image of Mobile Apps") says that in its larger 25,323-user subset "The majority are based in the USA, with strong user bases also in Finland, India, Germany, and the UK." **I did not check how many Indian users are in the top-1000 subset.** Count the MCCs before committing to it.
- **Access / licence:** Open download, research use only. Commercial use is prohibited, as is any attempt to re-identify users.
- **Real or synthetic:** Real (crowdsourced volunteers).
- **Caveats:** This is *not* true screen time. Samples happen only when the battery changes by 1% and are uploaded only when the user opens Carat, so data is sparse and has gaps. Per-app minutes can only be estimated from how often an app appears in the foreground. Users lean energy-conscious and tech-savvy. Android only. The data is old (2014–2018). The archive is large and the JSON needs Spark or chunked reading; see github.com/carat-project/carat-dataset-tools.
- **Good for:** Long-term drift and seasonality in app mix, comparing app-category mix across countries, user embeddings and clustering over years, churn and app adoption and abandonment.

### 2. Mobile Phone Use Dataset (Pielot et al., Telefónica Research)
- **Link:** https://sites.google.com/view/mobile-phone-use-dataset (HTTP 200). The page says "Download: zip (310 MB)" and links to Google Drive: https://drive.google.com/file/d/1tQA1jKm1qHIuwO-llNHSjwJrRc4teyI2/view (HTTP 200). It is also on IEEE DataPort as CRAWDAD telefonica/mobilephoneuse: https://ieee-dataport.org/open-access/crawdad-telefonicamobilephoneuse (HTTP 200).
- **Who / year:** Martin Pielot, Bruno Cardoso, Kleomenis Katevas, Joan Serrà, Aleksandar Matic and Nuria Oliver. Collected summer 2016. Paper: UbiComp 2017, "Beyond Interruptibility".
- **Size (as stated):** 342 participants, "several weeks" (DataPort says ca. 4 weeks). About 310 MB zip with one CSV per participant.
- **Granularity:** Event level. There are 25 sensors, including **app in foreground**, screen on/off/unlock, notifications, semantic location, activity and ambient noise. It also has frequent self-reports of emotion (valence and arousal) and, for some participants, Big-5, Boredom Proneness and PHQ-8 scores.
- **Per-app breakdown:** Yes. Foreground-app events let you rebuild per-app daily time, cross-checked against screen events.
- **Country:** Not stated on the download page. It was a Telefónica Research study, which suggests Spain, but I did not verify that.
- **Access / licence:** Public anonymised release; cite the UbiComp'17 paper. The author notes that the analysis scripts are not available. A community feature-extraction repo exists: github.com/minoskt/mpu-feature-extraction.
- **Real or synthetic:** Real.
- **Caveats:** Only about 4 weeks per person and one country. Some fields were removed for anonymisation.
- **Good for:** The best open source for **daily per-app screen time with psychological labels**. Suits mood or boredom prediction from app usage, notification response modelling, and per-user daily usage profiles.

### 3. LSApp: Large dataset of Sequential mobile App usage (Aliannejadi et al.)
- **Link:** https://github.com/aliannejadi/LSApp (HTTP 200). File: https://github.com/aliannejadi/LSApp/raw/main/lsapp.tsv.gz (HTTP 200, 7,329,439 bytes). It is also on IEEE DataPort, DOI 10.21227/w17r-xx75 (6.99 MB; login needed there).
- **Who / year:** Mohammad Aliannejadi, Hamed Zamani, Fabio Crestani and W. Bruce Croft (USI Lugano / UMass). ACM TOIS 2021. The UvA record is dated 2020-12-21.
- **Size (as stated):** 292 participants, "599,635 app usage records". MAPLE (arXiv 2309.08648) reports an average of 15 days per user.
- **(my count):** The file is actually a tar archive with a .gz name; extract it with `tar xzf`. The `lsapp.tsv` inside has **3,658,589 rows, 292 users and 87 distinct app names**. Timestamps run from **2017-09-09 to 2018-05-17**. Event types: Opened 1,673,261; Closed 1,667,014; User Interaction 313,829; Broken 4,485. The top apps are Facebook, Chrome, Messenger, Google, Twitter, Messages, Instagram and Reddit. The row count is far above the "599,635 records" the authors state, so they probably count differently (for example one open+close pair as a record). Only 87 app names appear, so the app list looks curated or limited.
- **Granularity:** Event-level open/close timestamps with session_id. That makes exact per-app durations and daily totals easy to compute.
- **Per-app breakdown:** Yes, by app name, but only for 87 apps. There are no categories, so you would need to map them yourself.
- **Country:** Not given. Participants were crowdsourced and the demographics in the README include no country.
- **Access / licence:** Open download. The GitHub API shows no licence file, so treat it as research use with citation of the TOIS paper.
- **Real or synthetic:** Real.
- **Caveats:** Small app set, about 2 weeks per user, no country, no context features beyond time.
- **Good for:** Next-app prediction (a standard benchmark alongside Tsinghua), session modelling, per-user daily per-app time series. Quick to prototype, since it is 7 MB.

### 4. Tsinghua App Usage Dataset (Yu et al., FIB Lab, Tsinghua University)
- **Link:** https://fi.ee.tsinghua.edu.cn/appusage/ (HTTP 200). Files: `App_usage_trace.rar` (HTTP 200, 25,363,073 bytes), `App2Category.rar`, `Categorys.rar` and `base_poi.rar` on the same page. Also on IEEE DataPort (26.17 MB; login needed).
- **Who / year:** Donghan Yu, Yong Li, Fengli Xu, Pengyu Zhang and Vassilis Kostakos. IMWUT/UbiComp 2018. MAPLE describes the trace as April 19–26, 2016.
- **Size (as stated):** 1,000 users, one week, "one of the biggest city of China", 2,000 identified apps, 20 app categories, 9,800 base stations, 17 POI categories. MAPLE reports more than 2.3M logs from 871 users after its own filtering.
- **Granularity:** Each record has user ID, timestamp (seconds), base-station location, app ID and traffic in bytes. Apps were **identified from HTTP network metadata**, not from foreground screen time.
- **Per-app breakdown:** Yes, as app ID mapped to 20 categories.
- **Country:** China only (one city).
- **Access / licence:** Open download, research only. Commercial use and re-identification are prohibited. You must name "Tsinghua App Usage Dataset" and cite Yu et al. 2018.
- **Real or synthetic:** Real (operator data).
- **Caveats:** It shows network activity rather than screen time (background traffic counts), covers only one week and one Chinese city, and app names are anonymised IDs.
- **Good for:** Location- and POI-aware app prediction, spatio-temporal usage modelling, graph and embedding models (AppUsage2Vec-style).

### Best dataset to request (includes India): DiversityOne (University of Trento / WeNet)
- **Links:** https://datascientia.eu/projects/diversityone/ (HTTP 200), https://datascientiafoundation.github.io/docs/LivePeople/papers/diversityone.html, paper https://arxiv.org/abs/2502.03347 (IMWUT).
- **Size (as stated):** 782 college students in **8 countries (China, Denmark, India [Amrita Vishwa Vidyapeetham], Italy, Mexico, Mongolia, Paraguay, UK)**, 4 weeks, 26 sensor types, 350K+ self-reports, plus questionnaires from 18K+ students. The app usage bundle includes **Running Applications sampled "once every 5 seconds"**, notifications, music playback and headset status.
- **Access:** **Request only.** You need an institutional email, a research proposal and the bundle identifier. Approved users get Parquet files, and redistribution is not allowed. As an independent job seeker you may not qualify; academic affiliation or a collaborator would help.
- **Why it matters:** It is the only dataset I found with per-app usage logs **for Indian users alongside other countries** collected the same way. It fits your India-vs-world goal best if you can get access.

---

## Also considered / rejected
| Dataset | Verdict |
|---|---|
| **Kaggle "Mobile Device Usage and User Behavior Dataset"** (valakhorasani) | **Synthetic.** The file notes say "generated based on simulated user behavior" and the author says it is "not a reliable source for a paper". 700 rows, no per-app breakdown. Reject. |
| **Kaggle "Indian Kids Screentime 2025"** (9,712 rows) | Reported as **synthetic** in search results and in GitHub EDA repos that use it. No per-app breakdown. Reject. |
| **Kaggle "Teen Phone Addiction and Lifestyle Survey"** and similar teen smartphone-addiction sets | Reported as **synthetic** (search summary; Kaggle pages not individually verified). No per-app breakdown. Reject. |
| Krüger et al. 2025 "Synthetic Data Generation for Screen Time and App Usage" (arXiv 2509.13892, OSF osf.io/u2h3d) | LLM-generated logs from **one** real seed user. Reject (only useful as a synthetic-vs-real comparison). |
| **Frappe** (Baltrunas et al., 2015): https://www.baltrunas.info/context-aware/frappe (zip HTTP 200, 3.37 MB); also HF `reczoo/Frappe_x1` | Real: 96,203 entries, 957 users, 4,082 apps, **80 countries**. But it records app-usage **counts** in context, not time. Research-only, no redistribution. Useful only as a side source for which apps are popular in which country. |
| **TalkingData Mobile User Demographics** (Kaggle competition) | China-only. Per a 2022 IEEE COMST survey, it has about 70K users over 1 week of app events. Events only, no durations. |
| **StudentLife** (Dartmouth) | Real but small: 48 students, 10 weeks, about 5 GB. The site timed out from the box today; the R package `studentlife` has a downloader. |
| **UbiqLog** (UCI id 369) | Real: 35 users, about 2 months, raw JSON logs. Too small. |
| **one sec PNAS 2023** (OSF https://osf.io/p4wy6/, public) | Real, but it records only **opening attempts of apps the user chose to target** (280 participants over 6 weeks in the main analysis), not full screen time. Good for an intervention or nudge side project. |
| **MobileWell400+** (Zenodo 11060596) | 409 Spanish participants, 2023, open (228 MB). Screen on/off only, **no per-app breakdown**. Zenodo returned 403 to curl but the page shows in search. |
| **PhoneStudy / Stachl et al.** (OSF kqjhr) | Raw data not public; only aggregated features. |
| **Device Analyzer** (Cambridge) | Needs a signed legal agreement. deviceanalyzer.cl.cam.ac.uk did not respond from the box. |
| **Nokia MDC** (Idiap) | Access at institution level only (Site Manager plus signed forms). |
| **SherLock** (BGU) | Full data needs a licence and the project site has been offline since about 2021. Only a small sample is on Kaggle. |
| **Mathur et al. 2017 India study** (215 Indian users, 8 months, 1.7M app events) | Paper only. I found no public data release. |
| **ABCD-EARS** (US adolescents) | Needs NIH NDA approval; not practical. |
| LiveLab (Rice), ExtraSensory | Not checked in depth. LiveLab is 2010-era with about 34 iPhone users. ExtraSensory is a sensor/activity-label dataset without per-app logs. |

## Screen-time tracker companies
- **ActionDash and StayFree** were **acquired by Sensor Tower (June 2020)**. The announcement says opted-in anonymised usage metrics feed Sensor Tower's **enterprise** products. There is no public or researcher dataset; the data reaches the public only as paid feeds and aggregate reports.
- **RescueTime** users can share their own data through Open Humans (openhumans.org/activity/rescuetime-connection). It is mainly **computer** usage, one person at a time, not a mobile dataset.
- **Opal** publishes aggregate blog reports (for example the "2023 Screen Time Report", described as based on 290,000 customers). No raw data.
- **one sec** co-published a PNAS 2023 study with open OSF data (see table above). It is the only tracker company I found with open, row-level data.
- **Forest, QualityTime, Moment, AppBlock, Screen Time Labs, BreakFree:** I found no public data releases or researcher data programmes in this pass (at most marketing statistics). Google Digital Wellbeing has no public dataset.

## The country-comparison gap
- **No open source gives India vs rest-of-world daily screen time broken down by app for each user.**
- The nearest options:
  1. **Carat**: country from MCC and per-app samples. You can compare the *relative* app and category mix for India vs other countries. You cannot get reliable absolute minutes.
  2. **DiversityOne**: India plus 7 other countries, with per-app running-app logs collected the same way. Request only, and students only.
  3. **Aggregate reports**: DataReportal/GWI "Digital 2026" country reports (India: https://datareportal.com/reports/digital-2026-india). Figures are in embedded slides and I found **no downloadable CSV**. Sensor Tower "State of India Mobile App Market 2026" says India's total annual time spent will exceed **1.3 trillion hours by 2026**; the full report needs a form. ElectronicsHub's "Average Screen Time by Country 2024" is built on DataReportal/GWI; its page returned HTTP 500 from the box today, so I did not verify its figures. These give **country-level daily hours** (mostly internet time from surveys), not per-app user data.
- **So yes, you would have to combine sources.** Use a per-user dataset for modelling. Add country-level report figures, or Carat's MCC-based category shares, for the India vs world layer. State clearly in the project that the country layer is aggregate and survey-based.

## Recommended pairing for your project
**Primary: Carat Top-1000 (scale, years, country via MCC). Behaviour and ground-truth layer: Mobile Phone Use Dataset (exact foreground-app screen time plus mood labels). Calibration: DataReportal/GWI India vs global daily mobile time.**
- Suggested project: "App-usage behaviour intelligence".
  - (a) From Mobile Phone Use or LSApp, build per-user-per-day tables of time per app and per category, then do habit segmentation, next-app prediction, and mood-from-usage models.
  - (b) From Carat, compare India (MCC 404/405/406) against other countries on category mix and long-term drift.
  - (c) Anchor absolute daily hours to DataReportal country figures.
- This follows the same pattern as your e-commerce event project (event logs → sessions → features → segments and predictions).
- In parallel, **apply for DiversityOne**. If approved, it replaces the aggregate layer with like-for-like per-app data for India vs other countries.
- If the 6.4 GB Carat archive is too heavy to start with, prototype on **LSApp (7 MB)** and switch later.
