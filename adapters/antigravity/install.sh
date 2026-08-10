#!/bin/bash
set -e

# Antigravity Adapter Installer
# Copies skills, rules, and docs self-containedly into .agents/

HUB_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
TARGET_DIR="$(pwd)"

echo "🤖 Configuring Antigravity (.agents/)..."

# Create .agents directory structure
mkdir -p .agents/skills
mkdir -p .agents/rules
mkdir -p .agents/docs

# Clean up legacy nested directory if present
rm -rf .agents/skills/ai-context-hub

# 1. Copy skills directly into .agents/skills/ and rewrite paths to point to .agents/
if [ -d "$HUB_DIR/adapters/antigravity/skills" ]; then
  for skill in "$HUB_DIR"/adapters/antigravity/skills/*; do
    if [ -d "$skill" ]; then
      skill_name="$(basename "$skill")"
      cp -rf "$skill" .agents/skills/
      for skill_file in ".agents/skills/$skill_name"/*.md; do
        if [ -f "$skill_file" ]; then
          sed -e 's|rules/|.agents/rules/|g' \
              -e 's|docs/|.agents/docs/|g' \
              "$skill_file" > "${skill_file}.tmp" && mv "${skill_file}.tmp" "$skill_file"
        fi
      done
    fi
  done
fi

# 2. Copy rules and docs into .agents/
cp -rf "$HUB_DIR/rules/"* .agents/rules/
cp -rf "$HUB_DIR/docs/"* .agents/docs/

# 3. Copy AGENTS.md and rewrite paths to point to .agents/
if [ -f "$HUB_DIR/adapters/antigravity/AGENTS.md" ]; then
  sed -e 's|rules/|.agents/rules/|g' \
      -e 's|docs/|.agents/docs/|g' \
      "$HUB_DIR/adapters/antigravity/AGENTS.md" > .agents/AGENTS.md
fi

echo "✅ Antigravity adapter installed successfully in .agents/"
