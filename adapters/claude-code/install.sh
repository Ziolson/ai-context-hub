#!/bin/bash
set -e

# Claude Code Adapter Installer
# Copies CLAUDE.md and associated rules/docs into .claude/ or project root

HUB_DIR="$(cd "$(dirname "$0")/../.." && pwd)"

echo "💬 Configuring Claude Code..."

mkdir -p .claude/rules
mkdir -p .claude/docs

# 1. Copy rules and docs self-containedly into .claude/
cp -rf "$HUB_DIR/rules/"* .claude/rules/
cp -rf "$HUB_DIR/docs/"* .claude/docs/

# 2. Copy CLAUDE.md and rewrite paths to point to .claude/
if [ -f "$HUB_DIR/adapters/claude-code/CLAUDE.md" ]; then
  sed -e 's|rules/|.claude/rules/|g' \
      -e 's|docs/|.claude/docs/|g' \
      "$HUB_DIR/adapters/claude-code/CLAUDE.md" > ./CLAUDE.md
fi

echo "✅ Claude Code adapter installed successfully!"
