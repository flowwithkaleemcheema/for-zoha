#!/usr/bin/env bash
# Wraps each artifact body into a standalone page for GitHub Pages. The body
# files stay the single source of truth: Claude publishes them as Artifacts,
# this script publishes them as a website.
#
#   field-for-zoha.html  ->  index.html            (the sunflower field)
#   birthday.html        ->  birthday/index.html   (her birthday, 1 November)
#
#   ./build.sh                                  # relative preview image path
#   ./build.sh https://you.github.io/for-zoha/  # absolute, for link previews
set -euo pipefail
cd "$(dirname "$0")"

BASE="${1:-}"

# wrap <source> <output> <og:title> <description> <theme-color> <favicon-entity> [preview-image]
wrap() {
  local src="$1" out="$2" title="$3" desc="$4" theme="$5" icon="$6" image="${7:-}"
  mkdir -p "$(dirname "$out")"
  {
  cat <<HEAD
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="color-scheme" content="dark">
<meta name="theme-color" content="$theme">

<!-- Personal page. Reachable by anyone with the link, but kept out of search
     results. Delete these two lines (and robots.txt) to allow indexing. -->
<meta name="robots" content="noindex, nofollow">

<meta name="description" content="$desc">
<meta property="og:type" content="website">
<meta property="og:title" content="$title">
<meta property="og:description" content="$desc">
HEAD
  [ -n "$image" ] && printf '<meta property="og:image" content="%s">\n<meta name="twitter:card" content="summary_large_image">\n' "$image"
  [ -z "$image" ] && printf '<meta name="twitter:card" content="summary">\n'
  cat <<HEAD2
<link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>$icon</text></svg>">
<style>*,*::before,*::after{box-sizing:border-box}body{margin:0}img,svg{display:block;max-width:100%}</style>
</head>
<body>
HEAD2
  cat "$src"
  cat <<'FOOT'
</body>
</html>
FOOT
  } > "$out"
  printf 'built %s (%s bytes)\n' "$out" "$(wc -c < "$out" | tr -d ' ')"
}

FIELD_IMAGE=""
[ -f preview.jpg ] && FIELD_IMAGE="${BASE}preview.jpg"
BDAY_IMAGE=""
[ -f birthday/preview.jpg ] && BDAY_IMAGE="${BASE}birthday/preview.jpg"

wrap field-for-zoha.html index.html \
  "A Field for Zoha" \
  "I couldn't send you flowers. So I grew you a field." \
  "#0C0E18" "&#127803;" "$FIELD_IMAGE"

wrap birthday.html birthday/index.html \
  "Happy birthday, Zoha" \
  "The moon on your birthday is exactly half lit. Come outside." \
  "#070A1C" "&#127769;" "$BDAY_IMAGE"
