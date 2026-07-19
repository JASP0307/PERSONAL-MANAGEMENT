#!/usr/bin/env bash
# Fetch a YouTube video's caption transcript as clean plain text on stdout.
# Usage: yt_transcript.sh <youtube-url>
set -euo pipefail

YTDLP="/home/jabner/anaconda3/envs/ml/bin/yt-dlp"
PYTHON="/home/jabner/anaconda3/envs/ml/bin/python3"

if [ $# -ne 1 ]; then
  echo "Usage: $0 <youtube-url>" >&2
  exit 1
fi

URL="$1"
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

TITLE="$("$YTDLP" --print title -- "$URL" 2>/dev/null || true)"

"$YTDLP" --skip-download --write-sub --write-auto-sub \
  --sub-langs "en.*,es.*" --sub-format vtt \
  -o "$TMPDIR/%(id)s.%(ext)s" -- "$URL" >/dev/null 2>&1 || true

VTT_FILE="$(find "$TMPDIR" -name '*.vtt' -print -quit)"

if [ -z "$VTT_FILE" ]; then
  echo "No captions available for this video (manual or auto-generated). Consider pasting notes manually instead." >&2
  exit 2
fi

echo "# ${TITLE:-Untitled video} ($URL)"
echo

"$PYTHON" - "$VTT_FILE" <<'PYEOF'
import re
import sys

path = sys.argv[1]
with open(path, encoding="utf-8") as f:
    raw = f.read()

# Drop WEBVTT header/metadata blocks and cue timing lines.
lines = raw.splitlines()
text_lines = []
timestamp_re = re.compile(r"^\d{2}:\d{2}:\d{2}\.\d{3}\s*-->")
tag_re = re.compile(r"<[^>]+>")

for line in lines:
    line = line.strip()
    if not line:
        continue
    if line.startswith("WEBVTT") or line.startswith("Kind:") or line.startswith("Language:"):
        continue
    if timestamp_re.match(line):
        continue
    if line.isdigit():
        continue
    cleaned = tag_re.sub("", line).strip()
    if cleaned:
        text_lines.append(cleaned)

# Auto-generated captions repeat overlapping rolling text; collapse consecutive duplicates.
deduped = []
for line in text_lines:
    if not deduped or deduped[-1] != line:
        deduped.append(line)

print(" ".join(deduped))
PYEOF
