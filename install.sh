#!/bin/bash

# AI Context Hub Installer
# Copies core rules, docs, and tool adapters into the current project root
# so that all configuration files can be committed directly to Git.

set -e

# Get the directory where this script is located
HUB_DIR="$(cd "$(dirname "$0")" && pwd)"

show_help() {
  echo "Usage: $0 [antigravity|cursor|claude|all]"
  echo ""
  echo "Arguments:"
  echo "  antigravity  Install adapter for Gemini / Antigravity (.agents/)"
  echo "  cursor       Install adapter for Cursor (.cursor/rules/)"
  echo "  claude       Install adapter for Claude Code (CLAUDE.md)"
  echo "  all          Install all of the above"
  echo ""
  echo "Example:"
  echo "  $HUB_DIR/install.sh all"
}

if [ -z "$1" ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  show_help
  exit 1
fi

TOOL=$1

install_core() {
  TARGET_DIR="$(pwd)"
  if [ "$HUB_DIR" != "$TARGET_DIR" ]; then
    echo "📦 Copying core rules and docs to your project root..."
    cp -rf "$HUB_DIR/rules" ./rules
    cp -rf "$HUB_DIR/docs" ./docs
  else
    echo "ℹ️ Running inside ai-context-hub repo root, skipping core rules/docs copy to self."
  fi
}

install_antigravity() {
  echo "🤖 Configuring Antigravity..."
  mkdir -p .agents/skills
  # Clean up old incorrectly nested directory if it exists
  rm -rf .agents/skills/ai-context-hub
  
  # Copy individual skills directly into .agents/skills/
  for skill in "$HUB_DIR"/adapters/antigravity/skills/*; do
    if [ -d "$skill" ]; then
      cp -rf "$skill" .agents/skills/
    fi
  done

  if [ -f "$HUB_DIR/adapters/antigravity/AGENTS.md" ]; then
    cp -f "$HUB_DIR/adapters/antigravity/AGENTS.md" .agents/AGENTS.md
  fi
  echo "✅ Antigravity configured successfully!"
}

install_cursor() {
  echo "💻 Configuring Cursor..."
  mkdir -p .cursor/rules
  for file in "$HUB_DIR"/adapters/cursor/rules/*.mdc; do
    if [ -f "$file" ]; then
      cp -f "$file" .cursor/rules/
    fi
  done
  echo "✅ Cursor configured successfully!"
}

install_claude() {
  echo "💬 Configuring Claude Code..."
  if [ -f "$HUB_DIR/adapters/claude-code/CLAUDE.md" ]; then
    cp -f "$HUB_DIR/adapters/claude-code/CLAUDE.md" ./CLAUDE.md
  fi
  echo "✅ Claude Code configured successfully!"
}

install_core

case "$TOOL" in
  antigravity)
    install_antigravity
    ;;
  
  cursor)
    install_cursor
    ;;

  claude)
    install_claude
    ;;

  all)
    install_antigravity
    install_cursor
    install_claude
    echo "🎉 All adapters installed successfully!"
    ;;

  *)
    echo "❌ Unknown tool: $TOOL"
    show_help
    exit 1
    ;;
esac

