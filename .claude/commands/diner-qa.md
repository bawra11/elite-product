---
description: On-demand multi-agent diner QA. Eight personas on iPhone 17 and elite_pixel. Run this yourself — not a cloud schedule.
argument-hint: "[phone] [--target 90] [--max-loops 5] [--only A1,B3,…] [--ios-only|--android-only]"
---

Launch eight diner agents and relay OTP. Do not walk the catalog yourself.

Read and follow `.cursor/skills/diner-qa/SKILL.md` in the Elite workspace if
that file exists. If you are already inside `elite_app`, the same command
lives next to `/sim-qa`. Arguments: `$ARGUMENTS`

Cursor Automations have no command trigger and cannot boot this Mac's
simulators. `/diner-qa` is the entry point.

1. **Parse.** First bare number is `PHONE`. `--target`, `--max-loops`, `--only`,
   `--ios-only`, `--android-only` as in the skill. Ask for `PHONE` before any
   section-C persona. Never invent an OTP.
2. **Preflight.** If another session owns iPhone 17 or elite_pixel, ask first.
   Never delete those devices.
3. **Worktrees.** Two `qa/diner-ios-*` and `qa/diner-and-*` worktrees from
   current HEAD (never `origin/main`). Copy `config/stage.json`.
4. **Launch eight agents, do not merge them.**
   - iOS (`sim-qa`, iPhone 17), sequential: ios-guest (A,B,F fresh) →
     ios-member (C,D reuse) → ios-creator (E reuse) → ios-table (G reuse).
   - Android (generalPurpose + `/run-app` on elite_pixel; not a fake
     android-qa), sequential: and-guest (A,B,F fresh) → and-member (C,D) →
     and-creator (E) → and-table (G reuse).
   - Start ios-guest and and-guest in parallel. Next persona on a platform
     only after the previous one on that device finishes.
   - Android F2, F3, G4 use the labeled `adb` commands in
     `test/sim_qa/scenarios.md` (not simctl). Restore night mode and
     `font_scale` after F2/F3. G4 uses the recorded stage table id (not
     blocked for a missing id).
5. **Relay.** On `NEEDS_OTP:` / `NEEDS_PHONE:` / `needs input:`, ask the user
   and resume the **same** agent (`OTP: 482193`). Do not spawn a replacement.
6. **Report.** Each persona's pass rate, bugs, branch, `SUMMARY.md` paths.
   No OTP in the report.
