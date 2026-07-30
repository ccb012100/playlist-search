#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INPUT_FILE="$SCRIPT_DIR/albums/all_albums_sorted.tsv"
OUTPUT_FILE="$SCRIPT_DIR/albums/listen.tsv"

# Keep rows whose playlist value does NOT contain any blocked text.
awk -F'\t' '
BEGIN {
    blocked[1] = "starred"
    blocked[2] = "songs to slowly lose your mind in isolation to"
    blocked[3] = "christmas"
    blocked[4] = "weekend mix"
    blocked[5] = "budew"
    blocked[6] = "oh lawd she chugging"
    blocked[7] = "ms. rachel"
    blocked[8] = "peppa pig"
    blocked_count = 8
}
NR == 1 {
    print
    next
}
{
    playlist = tolower($6)
    for (i = 1; i <= blocked_count; i++) {
        if (index(playlist, blocked[i]) > 0) {
            next
        }
    }
    print
}
' "$INPUT_FILE" > "$OUTPUT_FILE"

echo "Wrote filtered rows to: $OUTPUT_FILE"
