#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INPUT_FILE="$SCRIPT_DIR/albums/all_albums_sorted.tsv"
OUTPUT_FILE="$SCRIPT_DIR/albums/playlists.txt"

# Extract playlist column (excluding header), deduplicate, and sort.
tail -n +2 "$INPUT_FILE" | awk -F'\t' '{print $6}' | sort -u > "$OUTPUT_FILE"

# Print the resulting list and confirm output location.
cat "$OUTPUT_FILE"
echo "Wrote playlists to: $OUTPUT_FILE"
