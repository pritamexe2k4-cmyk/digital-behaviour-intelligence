#!/usr/bin/env bash
# Download the real mobile app-usage datasets into data/raw/ (gitignored).
# Usage: scripts/download_datasets.sh [telefonica] [lsapp] [tsinghua] [carat]   (default: all)
# Resumable (curl -C -). DiversityOne is request-only: see README.md > Datasets > DiversityOne
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"; RAW="$ROOT/data/raw"
WANT="${*:-telefonica lsapp tsinghua carat}"

get() { # url dest [expected_bytes]
  mkdir -p "$(dirname "$2")"
  if [[ -n "${3:-}" && -f "$2" && "$(wc -c <"$2" | tr -d ' ')" == "$3" ]]; then echo "OK (already): $2"; return; fi
  echo "Downloading $1 -> $2"
  curl -L --fail --retry 5 --retry-delay 10 -C - -o "$2" "$1"
  if [[ -n "${3:-}" ]]; then s=$(wc -c <"$2" | tr -d ' '); [[ "$s" == "$3" ]] || { echo "Size mismatch $2: $s != $3" >&2; exit 1; }; fi
}

for d in $WANT; do case "$d" in
  telefonica) get "https://drive.usercontent.google.com/download?id=1tQA1jKm1qHIuwO-llNHSjwJrRc4teyI2&export=download&confirm=t" \
                  "$RAW/telefonica_mobile_phone_use/mpud.zip" 310938979 ;;
  lsapp) if [[ -f "$RAW/lsapp/lsapp.tsv" && "$(wc -c <"$RAW/lsapp/lsapp.tsv" | tr -d ' ')" == 178930494 ]]; then echo "OK (already extracted): $RAW/lsapp/lsapp.tsv"
         else get "https://github.com/aliannejadi/LSApp/raw/main/lsapp.tsv.gz" "$RAW/lsapp/lsapp.tsv.gz" 7329439
              (cd "$RAW/lsapp" && tar xzf lsapp.tsv.gz); fi ;;   # really a tar.gz -> lsapp.tsv
  tsinghua) b=https://fi.ee.tsinghua.edu.cn/appusage
            get "$b/App_usage_trace.rar" "$RAW/tsinghua_app_usage/App_usage_trace.rar" 25363073
            for f in App2Category.rar Categorys.rar base_poi.rar; do get "$b/$f" "$RAW/tsinghua_app_usage/$f"; done ;;
  carat) get "https://www.cs.helsinki.fi/group/carat/data-sharing/carat-data-top1k-users-2014-to-2018-08-25.zip" \
             "$RAW/carat_top1000/carat-data-top1k-users-2014-to-2018-08-25.zip" 6375824106 ;;
  *) echo "unknown dataset: $d" >&2; exit 1 ;;
esac; done
