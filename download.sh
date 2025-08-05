#!/bin/bash

# By default, we download the backup for yesterday:
# we create backups around 23:00 UTC, so a backup for today might not exist yet.
if [ "$1" == "--today" ]; then
  date_to_use=$(date '+%Y-%m-%d')
else
  date_to_use=$(date -v -1d '+%Y-%m-%d' 2>/dev/null || date -d "yesterday" '+%Y-%m-%d')
fi

url="https://pub-5200ce7fb4b64b5ea3b6b0b0f05cfcd5.r2.dev/${date_to_use}_rating.backup"
curl -o rating.backup "$url"
