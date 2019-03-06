#!/bin/bash
filelist=""
for filename in ./recommendations/*.md; do
    filename="${filename/.md/}"
    filename="${filename/.\/recommendations\//}"
    ./bin/make-csv.sh "./recommendations/$filename.md" > "./csv/$filename.csv"
    if [ "$filelist" != "" ]; then
        filelist="$filelist;"
    fi
    filelist="$filelist./recommendations/$filename.md"
done
./bin/make-csv.sh "$filelist" > "./csv/all.csv"
