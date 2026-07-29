#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INPUT_FILE="$SCRIPT_DIR/albums/all_albums.tsv"
OUTPUT_FILE="$SCRIPT_DIR/albums/starred_albums.tsv"

# Reset output file.
: > "$OUTPUT_FILE"

# Preserve the header row.
head -n 1 "$INPUT_FILE" > "$OUTPUT_FILE"

# Append rows where the playlist column starts with "Starred".
tail -n +2 "$INPUT_FILE" | awk -F'\t' '$6 ~ /^Starred/' >> "$OUTPUT_FILE"

echo "Wrote filtered rows to: $OUTPUT_FILE"
