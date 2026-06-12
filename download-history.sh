#!/bin/bash

# Download backups for the past 10 days (starting from yesterday by default)
# Use --include-today to start from today instead of yesterday

if [ "$1" == "--include-today" ]; then
  start_offset=0
else
  # Start from yesterday since today's backup might not exist yet
  start_offset=1
fi

base_url="https://pub-5200ce7fb4b64b5ea3b6b0b0f05cfcd5.r2.dev"

for i in $(seq $start_offset $((start_offset + 9))); do
  # macOS uses -v, Linux uses -d
  date_to_use=$(date -v -${i}d '+%Y-%m-%d' 2>/dev/null || date -d "$i days ago" '+%Y-%m-%d')
  filename="${date_to_use}_rating.backup"
  url="${base_url}/${filename}"

  echo "Downloading ${filename}..."
  curl -f -o "$filename" "$url"

  if [ $? -eq 0 ]; then
    echo "  Success: ${filename}"
  else
    echo "  Failed: ${filename} (might not exist)"
  fi
done

echo "Done."
