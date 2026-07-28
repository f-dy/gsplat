#!/usr/bin/env bash
# Rebuild the `all-open-prs-integration` branch from upstream main + open PRs.
#
# This branch is a DERIVED ARTIFACT. Do not develop on it directly: add/adjust
# the PR list below and re-run this script. See INTEGRATION.md for the manifest.
#
# After rebuilding, re-apply the manifest commit (INTEGRATION.md + this script)
# and verify the code tree is unchanged before force-pushing:
#   git diff --stat <old-tip> HEAD -- ':!INTEGRATION.md' ':!scripts/build-integration.sh'
set -euo pipefail

BRANCH="all-open-prs-integration"
# Pinned upstream base (nerfstudio-project/gsplat main). Bump deliberately.
BASE="2b902ff1"                          # #1004
UPSTREAM="${UPSTREAM_REMOTE:-origin}"     # nerfstudio-project/gsplat
FORK="${FORK_REMOTE:-fork}"              # f-dy/gsplat

# PRs hosted on the f-dy fork, as "PR:branch" (merged in this order).
FORK_PRS=(
  "1039:full-opencv-camera"
  "1036:splatrendermode-ply-comment"
  "977:ewa-pinhole-orientation-fix"
)

REPO_URL="https://github.com/nerfstudio-project/gsplat/pull"

git fetch "$UPSTREAM"
git fetch "$FORK"
git checkout -B "$BRANCH" "$BASE"

for pb in "${FORK_PRS[@]}"; do
  pr="${pb%%:*}"; br="${pb##*:}"
  git fetch "$FORK" "$br"
  git merge --no-ff -m "Merge PR #${pr} (${br}) from f-dy: ${REPO_URL}/${pr}" "$FORK/$br"
done

echo "Rebuilt ${BRANCH}. PR merges:"
git --no-pager log --merges --first-parent --oneline "${BASE}..HEAD"
