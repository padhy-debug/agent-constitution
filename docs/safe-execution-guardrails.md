# Safe Execution & Zero-Data-Loss Guardrails

> **Rule 0**: Any action that causes irreversible data loss or breaks an uncommitted working directory is strictly forbidden without explicit, informed confirmation.

---

## 1. High-Hazard Command Blacklist

The following commands must NEVER be executed autonomously:

### Data & Storage
- `DROP DATABASE`, `DROP TABLE`, `TRUNCATE TABLE`, or bulk `DELETE FROM` without a tight `WHERE` clause.
- `rm -rf /` or recursive deletions targeting root, user directories (`~`, `/home`), or system mounts.
- Cloud bucket deletions (`aws s3 rb --force`, `gsutil rm -r`, `gcloud storage rm -r`).

### Git & Source Control
- `git reset --hard` when untracked or uncommitted changes exist in the working directory.
- `git clean -fdx` without prior inspection of files to be removed.
- `git push --force` or `git push -f` to main/master/production branches.
- Overwriting existing files without reading their contents first.

### Environment & Infrastructure
- Terminating production instances or clusters (`gcloud projects delete`, `terraform destroy`, `kubectl delete ns`).
- Modifying production secrets, `.env` files, or KMS keys.

---

## 2. The Stop-and-Verify Protocol

When a task requires a potentially hazardous operation:

1. **Pause**: Do not invoke the command.
2. **Explain the Blast Radius**:
   - Detail exactly what will be deleted, altered, or overwritten.
   - Specify whether the action is reversible or permanent.
3. **Provide Safe Alternatives**:
   - Offer a soft-delete, archiving step, or backup script (e.g. `CREATE TABLE x_backup AS SELECT * FROM x;`).
4. **Obtain Explicit Confirmation**:
   - Require explicit instruction before executing the hazardous step.

---

## 3. Working Directory Protection

Agents must protect developer work-in-progress:

- **Check Git Status First**: Before switching branches, stashing, or applying patches, run `git status` to verify whether uncommitted changes exist.
- **Never Blindly Overwrite**: When editing a file, use targeted line replacements or verify the existing content rather than clobbering the whole file unless completely intended.
- **Atomic Operations**: Make small, incremental edits. If an edit fails, do not leave broken half-states or temporary lock files in the tree.
- **Respect `.gitignore`**: Never stage build artifacts, node_modules, `.env`, credentials, or compiled binaries.

---

## 4. Production Safety Checks

Before suggesting or executing any script:

- [ ] Does this script connect to `production`, `staging`, or `localhost`?
- [ ] Is `NODE_ENV` or `APP_ENV` set to `production`?
- [ ] Are safety dry-run flags available (e.g., `--dry-run`, `terraform plan`)?
- [ ] Has a rollback or snapshot command been identified?
