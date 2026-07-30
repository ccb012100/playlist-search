#!/usr/bin/env python3

import csv
from pathlib import Path


def main() -> None:
    script_dir = Path(__file__).resolve().parent
    input_file = script_dir / "albums" / "all_albums_sorted.tsv"
    output_file = script_dir / "albums" / "artists_to_listen_to.txt"

    artists = set()

    blocked_phrases = [
        "starred",
        "songs to slowly lose your mind in isolation to",
        "christmas",
        "weekend mix",
        "budew",
        "oh lawd she chugging",
        "ms. rachel",
        "peppa pig",
    ]

    with input_file.open("r", encoding="utf-8", newline="") as f:
        reader = csv.DictReader(f, delimiter="\t", quoting=csv.QUOTE_NONE)

        for row in reader:
            playlist = (row.get("playlist") or "").strip().lower()
            if any(phrase in playlist for phrase in blocked_phrases):
                continue

            artist = (row.get("artists") or "").strip()
            if artist:
                artists.add(artist)

    sorted_artists = sorted(artists)

    with output_file.open("w", encoding="utf-8") as f:
        for artist in sorted_artists:
            f.write(artist + "\n")

    print(f"Wrote {len(sorted_artists)} artists to {output_file}")


if __name__ == "__main__":
    main()
