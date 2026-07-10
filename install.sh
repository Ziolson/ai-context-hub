#!/bin/bash

# AI Context Hub Installer
# Creates symlinks from the current project to your local ai-context-hub clone.

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

# 1. Always link core directories (rules and docs)
echo "🔗 Linking core rules and docs to your project root..."
ln -sf "$HUB_DIR/rules" ./rules
ln -sf "$HUB_DIR/docs" ./docs

# 2. Link tool-specific adapters
case "$TOOL" in
  antigravity)
    echo "🤖 Configuring Antigravity..."
    mkdir -p .agents/skills
    ln -sf "$HUB_DIR/adapters/antigravity/skills" .agents/skills/ai-context-hub
    cp -f "$HUB_DIR/adapters/antigravity/AGENTS.md" .agents/AGENTS.md
    echo "✅ Antigravity configured successfully!"
    ;;
  
  cursor)
    echo "💻 Configuring Cursor..."
    mkdir -p .cursor/rules
    # Create symlinks for all .mdc files
    for file in "$HUB_DIR"/adapters/cursor/rules/*.mdc; do
      if [ -f "$file" ]; then
        ln -sf "$file" .cursor/rules/
      fi
    done
    echo "✅ Cursor configured successfully!"
    ;;

  claude)
    echo "💬 Configuring Claude Code..."
    ln -sf "$HUB_DIR/adapters/claude-code/CLAUDE.md" ./CLAUDE.md
    echo "✅ Claude Code configured successfully!"
    ;;

  all)
    echo "🤖 Configuring Antigravity..."
    mkdir -p .agents/skills
    ln -sf "$HUB_DIR/adapters/antigravity/skills" .agents/skills/ai-context-hub
    cp -f "$HUB_DIR/adapters/antigravity/AGENTS.md" .agents/AGENTS.md

    echo "💻 Configuring Cursor..."
    mkdir -p .cursor/rules
    for file in "$HUB_DIR"/adapters/cursor/rules/*.mdc; do
      if [ -f "$file" ]; then
        ln -sf "$file" .cursor/rules/
      fi
    done

    echo "💬 Configuring Claude Code..."
    ln -sf "$HUB_DIR/adapters/claude-code/CLAUDE.md" ./CLAUDE.md
    
    echo "✅ All adapters configured successfully!"
    ;;

  *)
    echo "❌ Unknown tool: $TOOL"
    show_help
    exit 1
    ;;
esac
