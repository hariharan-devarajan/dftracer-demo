#!/bin/bash

FOLDER="/p/lustre5/haridev/new-log-1"

for file in "$FOLDER"/*.gz; do
    if [[ -f "$file" ]]; then
        gunzip -c "$file" > "${file%.gz}" 2>/dev/null || true
    fi
done


function extract_duration() {
    local name="$1"
    local cat="$2"
    if [ -z "$cat" ]; then
        cat="$name"
    fi
    gzip -dc *.gz | grep "\"$cat\":\"$name\"" | LC_ALL=C sed 's/[^[:print:]\r\t]//g' | jq -R -c "fromjson?" | jq -c '"\(.pid) \(.dur)"' |  awk '{dur[$1]+=$2} END{max=0; for(p in dur) if(dur[p]>max) max=dur[p]; print max/1000000 " seconds"}'
}


# Overall
extract_duration "ai_root"
extract_duration "train"
extract_duration "epoch"

# Checkpointing
extract_duration "restart"
extract_duration "capture"

# Compute
extract_duration "fetch.block"
extract_duration "compute"
extract_duration "backward"
extract_duration "forward"

# I/O
extract_duration "fetch.iter"
extract_duration "item"
extract_duration "POSIX" "cat"


