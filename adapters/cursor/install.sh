#!/bin/bash
set -e

# Cursor Adapter Installer
# Copies Cursor rule files (.mdc) into .cursor/rules/ and rules/docs into .cursor/context/

HUB_DIR="$(cd "$(dirname "$0")/../.." && pwd)"

echo "💻 Configuring Cursor (.cursor/)..."

mkdir -p .cursor/rules
mkdir -p .cursor/context/rules
mkdir -p .cursor/context/docs

# 1. Copy rules and docs into .cursor/context/
cp -rf "$HUB_DIR/rules/"* .cursor/context/rules/
cp -rf "$HUB_DIR/docs/"* .cursor/context/docs/

# 2. Copy .mdc rules and rewrite references from @rules/ or @docs/ to @.cursor/context/...
for file in "$HUB_DIR"/adapters/cursor/rules/*.mdc; do
  if [ -f "$file" ]; then
    filename="$(basename "$file")"
    sed -e 's|@rules/|@.cursor/context/rules/|g' \
        -e 's|@docs/|@.cursor/context/docs/|g' \
        -e 's|rules/|.cursor/context/rules/|g' \
        -e 's|docs/|.cursor/context/docs/|g' \
        "$file" > ".cursor/rules/$filename"
  fi
done

echo "✅ Cursor adapter installed successfully in .cursor/"
