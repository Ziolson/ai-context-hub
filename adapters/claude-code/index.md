# 🧡 Claude Code Adapter

The Claude Code adapter integrates **AI Context Hub** with [Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview) using the native `CLAUDE.md` configuration file.

---

## 📁 Adapter Configuration

| File | Path | Description |
|------|------|-------------|
| **CLAUDE.md** | `adapters/claude-code/CLAUDE.md` | Single entry-point referencing global rules, practice guides, workflows, and templates |

---

## 🚀 Setup for Claude Code

Run the automated installer from your target project root:

```bash
/path/to/ai-context-hub/install.sh claude
```

Or manually symlink `CLAUDE.md`:

```bash
ln -s /path/to/ai-context-hub/rules rules
ln -s /path/to/ai-context-hub/docs docs
ln -s /path/to/ai-context-hub/adapters/claude-code/CLAUDE.md CLAUDE.md
```
