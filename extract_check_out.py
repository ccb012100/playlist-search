#!/usr/bin/env python3

import csv
from pathlib import Path


def main() -> None:
	script_dir = Path(__file__).resolve().parent
	input_file = script_dir / "albums" / "all_albums_sorted.tsv"
	output_file = script_dir / "albums" / "check_out.txt"

	lines = []

	with input_file.open("r", encoding="utf-8", newline="") as f:
		reader = csv.DictReader(f, delimiter="\t", quoting=csv.QUOTE_NONE)

		for row in reader:
			playlist = (row.get("playlist") or "").strip()
			if "check out" not in playlist.lower():
				continue

			artists = (row.get("artists") or "").strip()
			album = (row.get("album") or "").strip()
			if not artists or not album:
				continue

			lines.append(f"{artists} - {album}")

	with output_file.open("w", encoding="utf-8") as f:
		for line in lines:
			f.write(line + "\n")

	print(f"Wrote {len(lines)} records to {output_file}")


if __name__ == "__main__":
	main()
