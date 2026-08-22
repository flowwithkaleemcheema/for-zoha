#!/usr/bin/env bash
# Wraps the artifact body (field-for-zoha.html) into a standalone page for
# GitHub Pages. field-for-zoha.html stays the single source of truth: Claude
# publishes it as an Artifact, this script publishes it as a website.
#
#   ./build.sh                                  # relative preview image path
#   ./build.sh https://you.github.io/for-zoha/  # absolute, for link previews
set -euo pipefail
cd "$(dirname "$0")"

BASE="${1:-}"
OG_IMAGE=""
[ -f preview.jpg ] && OG_IMAGE="${BASE}preview.jpg"

{
cat <<HEAD
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="color-scheme" content="dark">
<meta name="theme-color" content="#0C0E18">

<!-- Personal page. Reachable by anyone with the link, but kept out of search
     results. Delete these two lines (and robots.txt) to allow indexing. -->
<meta name="robots" content="noindex, nofollow">

<meta name="description" content="I couldn't send you flowers. So I grew you a field.">
<meta property="og:type" content="website">
<meta property="og:title" content="A Field for Zoha">
<meta property="og:description" content="I couldn't send you flowers. So I grew you a field.">
HEAD
[ -n "$OG_IMAGE" ] && printf '<meta property="og:image" content="%s">\n<meta name="twitter:card" content="summary_large_image">\n' "$OG_IMAGE"
[ -z "$OG_IMAGE" ] && printf '<meta name="twitter:card" content="summary">\n'
cat <<'HEAD2'
<link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>&#127803;</text></svg>">
<style>*,*::before,*::after{box-sizing:border-box}body{margin:0}img,svg{display:block;max-width:100%}</style>
</head>
<body>
HEAD2
cat field-for-zoha.html
cat <<'FOOT'
</body>
</html>
FOOT
} > index.html

printf 'built index.html (%s bytes)\n' "$(wc -c < index.html | tr -d ' ')"
