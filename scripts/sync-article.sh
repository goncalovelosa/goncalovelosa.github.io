#!/usr/bin/env bash
# sync-article.sh — Sync article + images from medium-content to site repo
# Usage: ./scripts/sync-article.sh <slug> [--images-only]
#
# Copies from: ~/repos/medium-content/articles/drafts/<slug>/
#   or from:   ~/repos/medium-content/articles/published/<slug>/
#
# To BOTH locations in the site repo:
#   src/content/blog/<slug>.md          (article markdown)
#   src/content/blog/<slug>/images/     (Astro reads for WebP build)
#   public/articles/<slug>/images/      (direct access / Medium import)

set -euo pipefail

SLUG="${1:?Usage: sync-article.sh <slug> [--images-only]}"
IMAGES_ONLY=false

if [[ "${2:-}" == "--images-only" ]]; then
  IMAGES_ONLY=true
fi

MEDIUM_REPO="$HOME/repos/medium-content"
SITE_REPO="$HOME/repos/goncalovelosa.github.io"

# Find the article (drafts or published)
SOURCE=""
for dir in "drafts" "published"; do
  if [[ -d "$MEDIUM_REPO/articles/$dir/$SLUG" ]]; then
    SOURCE="$MEDIUM_REPO/articles/$dir/$SLUG"
    break
  fi
done

if [[ -z "$SOURCE" ]]; then
  echo "❌ Article '$SLUG' not found in $MEDIUM_REPO/articles/{drafts,published}/"
  exit 1
fi

echo "📦 Source: $SOURCE"
echo "🎯 Target: $SITE_REPO"
echo ""

# === SYNC IMAGES to BOTH locations ===
SRC_IMAGES="$SOURCE/images"
DEST_IMAGES_ASTRO="$SITE_REPO/src/content/blog/$SLUG/images"
DEST_IMAGES_PUBLIC="$SITE_REPO/public/articles/$SLUG/images"

if [[ -d "$SRC_IMAGES" ]]; then
  echo "🖼️  Syncing images..."

  mkdir -p "$DEST_IMAGES_ASTRO"
  mkdir -p "$DEST_IMAGES_PUBLIC"

  cp -v "$SRC_IMAGES"/* "$DEST_IMAGES_ASTRO/"
  cp -v "$SRC_IMAGES"/* "$DEST_IMAGES_PUBLIC/"

  # Verify MD5s match across both destinations
  echo ""
  echo "🔍 Verifying MD5s match..."
  for f in "$SRC_IMAGES"/*; do
    fname=$(basename "$f")
    md5_src=$(md5sum "$f" | cut -d' ' -f1)
    md5_astro=$(md5sum "$DEST_IMAGES_ASTRO/$fname" | cut -d' ' -f1)
    md5_public=$(md5sum "$DEST_IMAGES_PUBLIC/$fname" | cut -d' ' -f1)

    if [[ "$md5_src" == "$md5_astro" && "$md5_src" == "$md5_public" ]]; then
      echo "  ✅ $fname — all three locations match"
    else
      echo "  ❌ $fname — MISMATCH!"
      echo "     source:  $md5_src"
      echo "     astro:   $md5_astro"
      echo "     public:  $md5_public"
      exit 1
    fi
  done
else
  echo "⚠️  No images directory found at $SRC_IMAGES"
fi

# === SYNC ARTICLE MARKDOWN (unless --images-only) ===
# NOTE: The site .md has Astro frontmatter that edited.md doesn't have.
# We only sync the BODY content, preserving the site's frontmatter.
if [[ "$IMAGES_ONLY" == false ]]; then
  SRC_MD="$SOURCE/edited.md"
  DEST_MD="$SITE_REPO/src/content/blog/$SLUG.md"

  if [[ -f "$SRC_MD" ]] && [[ -f "$DEST_MD" ]]; then
    echo ""
    echo "📄 Syncing article body (preserving site frontmatter)..."

    # Extract frontmatter from site .md (everything between first pair of ---)
    FRONTMATTER=$(awk '/^---$/{n++; if(n==2){exit} print; if(n==1)next} n==1{print}' "$DEST_MD")

    # Extract body from edited.md (skip the # Title line and cover image line)
    BODY=$(tail -n +2 "$SRC_MD")

    # Combine
    printf '%s\n%s\n' "$FRONTMATTER" "$BODY" > "$DEST_MD"
    echo "  ✅ Body synced, frontmatter preserved"
  elif [[ -f "$SRC_MD" ]]; then
    echo "⚠️  Site .md not found at $DEST_MD — skipping markdown sync"
  else
    echo "⚠️  No edited.md found at $SRC_MD"
  fi
fi

echo ""
echo "✅ Sync complete. Run 'git add -A && git commit && git push' in the site repo."
