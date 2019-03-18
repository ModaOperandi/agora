#!/bin/bash
filelist=""
for filename in ./recommendations/*.md; do
    filename="${filename/.md/}"
    filename="${filename/.\/recommendations\//}"
    python ./bin/make-csv.py "./recommendations/$filename.md" > "./csv/$filename.csv"
    if [ "$filelist" != "" ]; then
        filelist="$filelist;"
    fi
    filelist="$filelist./recommendations/$filename.md"
done
python ./bin/make-csv.py "$filelist" > "./csv/all.csv"
