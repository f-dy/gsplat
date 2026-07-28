# `all-open-prs-integration` — integration branch

**This branch is a derived artifact, not a place for original development.**
It is upstream `main` at a pinned base commit with a set of open pull requests
merged on top. Every *code* change traces to one of the PRs listed below; the
only non-PR commit is the one that adds this manifest and
`scripts/build-integration.sh`. Regenerate the branch with that script.

- Upstream: <https://github.com/nerfstudio-project/gsplat>
- Fork: <https://github.com/f-dy/gsplat>
- Base: `main` @ `2b902ff1` ("Add GPU test CI workflow with JIT and AOT jobs", #1004)

## Included PRs (in merge order)

| PR | Title | Source branch | Head |
|----|-------|---------------|------|
| [#1039](https://github.com/nerfstudio-project/gsplat/pull/1039) | Add FULL_OPENCV & radial-fisheye COLMAP models; fix fisheye principal point | `f-dy:full-opencv-camera` | `bf22779` |
| [#1036](https://github.com/nerfstudio-project/gsplat/pull/1036) | Record antialiased mode as a `SplatRenderMode` PLY comment (and honor it in the viewer) | `f-dy:splatrendermode-ply-comment` | `b97413d` |
| [#977](https://github.com/nerfstudio-project/gsplat/pull/977) | EWA pinhole: orientation-preserving clamp for off-frustum elongated Gaussians | `f-dy:ewa-pinhole-orientation-fix` | `c5427de` |

## Provenance

Because the branch is built purely by merging the PRs above, git history is the
source of truth:

```bash
git log --merges --first-parent --oneline 2b902ff1..all-open-prs-integration
```

shows exactly one merge per PR, each referencing the PR number and URL.

## Regenerate

```bash
./scripts/build-integration.sh
```

This recreates `all-open-prs-integration` from the pinned base by merging each PR
ref. Confirm the code tree is unchanged before force-pushing:

```bash
git diff --stat <old-tip> all-open-prs-integration -- ':!INTEGRATION.md' ':!scripts/build-integration.sh'
```
