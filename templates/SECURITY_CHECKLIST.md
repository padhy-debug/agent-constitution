# Pre-Merge Security Audit Checklist

To be completed by the Agent or Reviewer before opening or merging a PR touching critical code.

---

### 1. Identity, Auth & Permissions
- [ ] Authentication is strictly enforced on all new/modified endpoints.
- [ ] Object-level / Resource-level permissions are checked (user A cannot access user B's resource by guessing IDs - BOLA/IDOR protection).
- [ ] Session tokens, cookies, and JWTs have appropriate expirations and security flags (`HttpOnly`, `Secure`, `SameSite`).

### 2. Injection & Input Validation
- [ ] All inputs (query params, body fields, headers, path variables) are validated via schemas (Zod, Pydantic, Bean Validation).
- [ ] Database queries are 100% parameterized (no string interpolation into SQL/NoSQL).
- [ ] Shell/OS commands use parameter arrays, never raw string concatenation with user variables.

### 3. Data Protection & Secrets
- [ ] No API keys, passwords, bearer tokens, or connection strings are hardcoded.
- [ ] Sensitive fields (passwords, tokens, credit cards, PII) are excluded from log outputs.
- [ ] Data at rest and in transit is encrypted using industry-standard TLS / AES-GCM.

### 4. Denial of Service & Resource Caps
- [ ] Public endpoints implement rate limiting or proof-of-work where susceptible to abuse.
- [ ] Upload endpoints validate maximum file sizes and MIME types.
- [ ] Unbounded database queries have default pagination limits (`LIMIT` / `take`).
