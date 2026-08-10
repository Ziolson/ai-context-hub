# 🛡️ Security Baseline Guide

> **Non-negotiable security standards, OWASP Top 10 mitigation, secret management, and input validation.**

---

## 🎯 Purpose & Overview

Security vulnerabilities in production code can lead to data breaches, compliance violations, and severe financial losses. AI coding assistants, if left unconstrained, may incorporate insecure code snippets found in legacy online repositories (e.g. hardcoding API keys, concatenating raw SQL strings, or disabling TLS verification).

This guide outlines **Security Minimums** that must be enforced in every codebase.

---

## 🏛️ Core Architectural Principles

### 1. Zero Hardcoded Secrets Policy
- **Never Commit Credentials**: API keys, database passwords, JWT signing secrets, or private certificates MUST NEVER be hardcoded in source code or committed to version control.
- **Environment Variables**: Load secrets exclusively via environment variables (`process.env.DB_PASSWORD`) or secret management infrastructure (HashiCorp Vault, AWS Secrets Manager).

### 2. Defense in Depth & Input Sanitization
- **Assume Hostile Input**: Treat all data received from HTTP request bodies, query strings, headers, file uploads, and third-party webhooks as untrusted.
- **Strict Schema Validation**: Validate input payloads against rigid schemas (Zod, Joi, Valibot) before passing them to application domain services.
- **Output Encoding**: Encode HTML outputs to prevent Cross-Site Scripting (XSS) attacks.

### 3. Least Privilege & Authentication Security
- **Secure Password Hashing**: Use modern adaptive hashing algorithms (Argon2id or bcrypt with cost factor ≥ 12) for password storage.
- **HttpOnly Cookies**: Store sensitive authentication tokens in `HttpOnly`, `SameSite=Strict`, `Secure` cookies to mitigate XSS session hijacking.

---

## 👥 Human Developer vs. AI Assistant Roles

| Area | Human Developer Role | AI Assistant Role |
|------|----------------------|-------------------|
| **Secret Management** | Provisions production secrets in cloud infrastructure | References environment variables without logging or hardcoding secrets |
| **Vulnerability Audit**| Conducts penetration testing and OWASP compliance audits | Sanitizes input DTOs, uses parameterized queries, & flags security risks |
| **Access Control** | Defines role-based authorization matrix (RBAC) | Implements permission check guards on controller routes |

---

## 💡 Code Examples: Good vs. Bad Practices

### Anti-Pattern: Hardcoded Secrets & Raw Shell Execution ❌
```typescript
// BAD: Hardcoded secret key and vulnerable string concatenation
const JWT_SECRET = "super_secret_key_12345"; // ❌ Hardcoded secret

export function executeCommand(input: string) {
  // ❌ Command injection vulnerability
  exec("cat /tmp/logs/" + input); 
}
```

### Production-Grade Pattern: Secure Configuration & Safe API Usage ✅
```typescript
// GOOD: Reading secrets from environment and using safe argument arrays
const JWT_SECRET = process.env.JWT_SECRET;
if (!JWT_SECRET) {
  throw new Error("FATAL: JWT_SECRET environment variable is missing.");
}

export function readLogFile(filename: string) {
  // Safe validation against path traversal
  const sanitizedFilename = path.basename(filename);
  return fs.readFileSync(path.join("/tmp/logs", sanitizedFilename), "utf8");
}
```

---

## 📋 Code Review Checklist for Security

- [ ] **Zero Secrets in Diff**: Are there any hardcoded keys, tokens, or passwords anywhere in the pull request diff?
- [ ] **SQL & Command Parameterization**: Are all database queries and shell executions using safe parameterized arguments?
- [ ] **Input Validation**: Is user input validated against a strict schema (e.g. Zod DTO schema) at the entry handler?
- [ ] **Secure Storage**: Are sensitive authentication tokens saved in `HttpOnly`, `Secure` cookies rather than `localStorage`?

---

::: details Prompt Reference
<<< ../rules/practices/security.md
:::
