#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INPUT_FILE="$SCRIPT_DIR/albums/all_albums_sorted.tsv"
OUTPUT_FILE="$SCRIPT_DIR/albums/check_out_detailed.tsv"

# Reset output file.
: > "$OUTPUT_FILE"

# Preserve the header row.
head -n 1 "$INPUT_FILE" > "$OUTPUT_FILE"

# Append rows where the playlist column contains "check out" (case-insensitive).
tail -n +2 "$INPUT_FILE" | awk -F'\t' 'tolower($6) ~ /check out/' >> "$OUTPUT_FILE"

echo "Wrote filtered rows to: $OUTPUT_FILE"
