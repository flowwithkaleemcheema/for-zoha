#!/usr/bin/env bash
# Creates the GitHub repo, pushes, and turns on GitHub Pages.
# Run `gh auth login` first — that step needs you, not a script.
#
#   ./publish.sh            # repo named "for-zoha"
#   ./publish.sh some-name  # repo named "some-name"
set -euo pipefail
cd "$(dirname "$0")"

REPO="${1:-for-zoha}"

if ! gh auth status >/dev/null 2>&1; then
  echo "Not signed in to GitHub yet. Run this first:" >&2
  echo "    gh auth login" >&2
  exit 1
fi

OWNER=$(gh api user -q .login)
URL="https://$OWNER.github.io/$REPO/"

if gh repo view "$OWNER/$REPO" >/dev/null 2>&1; then
  echo "Repo already exists, pushing to it."
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/$OWNER/$REPO.git"
  git push -u origin main
else
  gh repo create "$REPO" --public --source=. --remote=origin --push \
    --description "An interactive apology, grown one sunflower at a time."
fi

# now that the final URL is known, rebuild so link previews resolve absolutely
./build.sh "$URL"
if ! git diff --quiet -- index.html; then
  git add index.html
  git commit -q -m "Absolute URLs for link previews"
  git push -q
fi

# enable Pages; harmless if it is already on
gh api -X POST "repos/$OWNER/$REPO/pages" --input - >/dev/null 2>&1 \
  <<< '{"source":{"branch":"main","path":"/"}}' \
  || echo "(Pages was already enabled, or needs turning on under Settings > Pages)"

echo
echo "  Repo:  https://github.com/$OWNER/$REPO"
echo "  Live:  $URL"
echo
echo "The first build takes a minute or two before the link works."
