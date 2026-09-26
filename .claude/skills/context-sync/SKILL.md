---
name: context-sync
description: Refresh every project context doc in the Elite product repo, then commit and push it to git@github.com:bawra11/elite-product.git. Use before ANY push of the root /Elite repo ("commit to remote", "push product repo", "sync context", "/context-sync"). The push hook blocks product-repo pushes until this skill has run on the current HEAD.
---

# context-sync

The root `/Elite` folder is the **product repo** (`bawra11/elite-product`). The code lives in
git submodules under `tech/codebase/`. This skill makes the context docs describe the real current
state before anything goes to the remote.

## Access rules (never break them)

- `tech/codebase/BE/**` is **read-only**: its five submodules and `tech/codebase/BE/README.md`.
  Never edit, commit or push inside it. `git pull` inside a BE repo is fine. BE drift gets
  recorded in `tech/common/`, never in the BE folder.
- Everything else (product/, tech/common/, tech/codebase/elite_app, .claude/, root files) is
  fully writable.
- Search with graphify first (`~/.local/bin/graphify query "…"`), then grep/Read.

## Steps

1. **Take stock** (from the repo root):
   ```bash
   git status --short
   git submodule status
   git fetch -q origin && git diff --stat origin/main...HEAD
   git diff --submodule=log origin/main -- tech/codebase   # submodule commits since last push
   ```
   Also note uncommitted changes inside `tech/codebase/elite_app`.

2. **BE safety check.** For each `tech/codebase/BE/*`, `git -C <repo> status --porcelain` must be
   empty (graphify-out is git-excluded), and its HEAD must exist on its remote
   (`git -C <repo> branch -r --contains HEAD`). Any local edit means stop and tell the user.
   Don't revert it yourself.

3. **Submodule pointers.** A submodule HEAD that isn't on its remote would break the recorded
   gitlink for anyone who clones, so warn and don't stage it. `elite_app` changes are committed
   and pushed in *its own* repo first; only then does its new pointer get staged here.

4. **Refresh the context docs.** Read the diffs from step 1, then update only the files whose
   facts changed. Keep each file's voice and density.

   | Changed | Update |
   | --- | --- |
   | folder layout, submodules, branches | `README.md` (tree + submodule table), `CLAUDE.md` |
   | elite_app architecture, routes, state | `tech/common/architecture.md` |
   | entities, API usage, BE contract drift (gateway/feed/catalog/protos commits) | `tech/common/api-reference.md`, `tech/common/domain-model.md`, `tech/common/README.md` |
   | product decisions, scope | `product/business/product-requirements.md` (dated decision log) |
   | Claude Design pulls, screen coverage | `product/design/README.md`, `product/design/mockups/README.md` (flow table + status column), `product/design/claude-design/README.md` |
   | agents, skills, hooks | `README.md` "Working here" section, `CLAUDE.md` |

   Screen status in `mockups/README.md` comes from what `tech/codebase/elite_app/lib/features/`
   actually implements. Check with graphify, and don't guess.

5. **Refresh graphs** (local only, git-ignored): `graphify update .` in each submodule whose
   commits moved. That covers BE too, since graphify-out is excluded there and isn't an edit.

6. **Commit** the root repo. Stage explicit paths, never `.DS_Store`. The message says what context
   changed and why, and ends with the session's attribution line. Then stamp and push:
   ```bash
   git rev-parse HEAD > .claude/.context-synced
   git push -u origin HEAD
   ```
   Never force-push. If the push is rejected, fetch and rebase onto `origin/<branch>`, then re-run
   from step 4.

7. **Report** which docs changed, the pushed commit and branch, and any warnings from steps 2–3.
