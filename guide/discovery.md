# 🔍 Phase 1: Discovery & Specification Guide

> **Transforming raw ideas into approved feature specifications.**

---

## Purpose & Overview

**Phase 1** is the entry point of every SDD cycle. It prevents scope creep and AI architectural assumptions by guiding the developer and AI through a 3-step process: **discover → specify → approve**.

---

## How Discovery Works in Practice

### 1. Interactive Q&A Session
The AI assistant explores the repository to understand existing patterns, data models, and API endpoints, then conducts a structured Q&A session divided into logical thematic blocks (e.g., *Block 1: API Contracts*, *Block 2: Storage & Models*).

### 2. Mandatory AI Recommendations
Instead of asking bare questions (*"What auth method should we use?"*), the AI provides concrete recommendations based on codebase analysis and industry standards:

> *"Based on your stateless REST API, I recommend using **HttpOnly JWT tokens** rather than server sessions. This preserves scale while protecting against XSS attacks. Shall we proceed with this approach?"*

---

## The Approval Gate

```
Drafting spec.md (Status: Draft) ➔ Human Review ➔ Approval ➔ Status: Approved
```

Implementation code **MUST NEVER** be written while `spec.md` is in `Draft` status. Implementation begins only when the developer explicitly approves the specification.

---

::: details Prompt Reference
<<< ../docs/workflows/discovery.md
:::
