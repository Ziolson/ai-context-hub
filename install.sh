#!/bin/bash

# AI Context Hub Installer (Orchestrator)
# Delegates installation to tool-specific adapters

set -e

# Get the directory where this script is located
HUB_DIR="$(cd "$(dirname "$0")" && pwd)"

show_help() {
  echo "Usage: $0 [antigravity|cursor|claude|all]"
  echo ""
  echo "Arguments:"
  echo "  antigravity  Install adapter for Gemini / Antigravity (.agents/)"
  echo "  cursor       Install adapter for Cursor (.cursor/)"
  echo "  claude       Install adapter for Claude Code (CLAUDE.md & .claude/)"
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

case "$TOOL" in
  antigravity)
    "$HUB_DIR/adapters/antigravity/install.sh"
    ;;
  
  cursor)
    "$HUB_DIR/adapters/cursor/install.sh"
    ;;

  claude)
    "$HUB_DIR/adapters/claude-code/install.sh"
    ;;

  all)
    "$HUB_DIR/adapters/antigravity/install.sh"
    "$HUB_DIR/adapters/cursor/install.sh"
    "$HUB_DIR/adapters/claude-code/install.sh"
    echo "🎉 All adapters installed successfully!"
    ;;

  *)
    echo "❌ Unknown tool: $TOOL"
    show_help
    exit 1
    ;;
esac


