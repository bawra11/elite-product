---
name: diner-qa
description: >-
  On-demand multi-agent diner QA for the Elite Flutter app. Launches eight
  separate diner personas on the iPhone 17 simulator and the elite_pixel
  Android emulator, splitting test/sim_qa/scenarios.md. Use when the user runs
  /diner-qa, says diner-qa, or asks to QA the app with multiple diners on
  iOS and Android simulators. Do not use a cloud schedule.
disable-model-invocation: true
---

# Diner QA (local, on-demand)

Cursor Automations cannot start from a command and cannot boot this Mac's
simulators. This skill is the entry point. You are the relay. Spawn **eight**
diner agents. Do not walk the catalog yourself.

App root: `tech/codebase/elite_app` (or the git toplevel if already there).
Never edit `tech/codebase/BE/**`. Never invent an OTP.

## Arguments

`$ARGUMENTS`

- First bare number → `PHONE`. If missing, ask before launching anyone who
  runs section C.
- `--target N` (default 90), `--max-loops N` (default 5).
- `--only IDs` filters every persona to the intersection with its own IDs.
- `--ios-only` / `--android-only` skip the other platform.

Sign-in is always the real stage WhatsApp OTP. The agent stops at `NEEDS_OTP`.
You relay the code the user reads. Never guess, reuse, or stub it.

## Personas (do not merge)

Same device is sequential. iOS and Android may run at the same time.

| Agent | Device | Type | Scenarios | Install |
|---|---|---|---|---|
| ios-guest | iPhone 17 | `sim-qa` | A1–A4, B1–B8, F1–F3 | Fresh uninstall |
| ios-member | iPhone 17 | `sim-qa` | C1–C5, D1–D3 | Reuse; A1–A4 setup if needed |
| ios-creator | iPhone 17 | `sim-qa` | E1–E6 | Reuse; must already be verified |
| ios-table | iPhone 17 | `sim-qa` | G1–G6 | Reuse; must already be verified |
| and-guest | elite_pixel | generalPurpose | A1–A4, B1–B8, F1–F3 | Fresh uninstall |
| and-member | elite_pixel | generalPurpose | C1–C5, D1–D3 | Reuse; A1–A4 setup if needed |
| and-creator | elite_pixel | generalPurpose | E1–E6 | Reuse; must already be verified |
| and-table | elite_pixel | generalPurpose | G1–G6 | Reuse; must already be verified |

Android **F2**, **F3**, and **G4** use the labeled `adb` commands in
`test/sim_qa/scenarios.md` (not `xcrun simctl`). **F2** / **F3** must restore
night mode (`cmd uimode night no`) and `font_scale` (`1.0`) afterward. **G4**
uses stage table id
`urn:explorex:restaurant_tables:5e448d81-c2b5-4895-9244-698d20e74083`
(not blocked for a missing id). Do not fake a pass.

## Sequence

1. Preflight. If another session owns iPhone 17 or elite_pixel, ask before
   continuing. Never delete those devices, never `simctl delete|erase`, never
   `xcodebuild -downloadPlatform`.
2. From the app repo, if HEAD is not already a `qa/diner-*` branch, add two
   worktrees from current HEAD (never `origin/main`):
   - `.claude/worktrees/diner-ios-<YYYYMMDD-HHMM>` → `qa/diner-ios-<stamp>`
   - `.claude/worktrees/diner-and-<YYYYMMDD-HHMM>` → `qa/diner-and-<stamp>`
   Copy `config/stage.json` from the main checkout into each. Worktrees are
   gitignored.
3. Launch **ios-guest** and **and-guest** in parallel, each in its worktree.
4. When the iOS agent of a pair finishes, start the next iOS persona on that
   same worktree and device. Same for Android. Do not start ios-member until
   ios-guest is done. Do not start a verified Android persona until and-guest
   is done.
5. Relay. On `NEEDS_OTP:`, `NEEDS_PHONE:`, or `needs input:`, show it and
   resume the **same** agent with just the value (`OTP: 482193`). Do not spawn
   a replacement. Do not invent a code. Two platforms may ask at once; relay
   each.
6. When all launched personas finish, report each agent's pass rate, bugs,
   branch, and `SUMMARY.md` / last `REPORT.md`. No OTP in the report.

## Prompt every diner gets

```
APP worktree: <path>
PHONE: <or NEEDS_PHONE>
TARGET: <n>
MAX_LOOPS: <n>
PERSONA: <name>
DEVICE: iPhone 17 | elite_pixel
SCENARIOS: <ids>
INSTALL: fresh | reuse
RUN: test/sim_qa/runs/<YYYY-MM-DD_HHMM>_<persona>
```

iOS agents: `subagent_type: sim-qa`. Follow that agent as written. Add:
`INSTALL=reuse` means skip uninstall; keep `flutter run` if it is still up;
if the app is missing, run A1–A4 as setup (do not score them unless they
fail) then only your SCENARIOS. Do not walk other personas' IDs. Do not
fight another session on iPhone 17.

Android agents: `subagent_type: generalPurpose`. There is no android-qa
agent. Follow the sim-qa loop (reports, bugs, fix, 90%, OTP stop) and the
`run-app` Android path. Do not call this android-qa.

Android-only setup to include in that prompt:

- Boot: `fvm flutter emulators --launch elite_pixel`. Wait until
  `adb shell getprop sys.boot_completed` is `1`, then
  `fvm flutter run -d emulator-5554 --dart-define-from-file=config/stage.json`.
- Package: `co.explorex.elite`. Fresh: `adb -s emulator-5554 uninstall` it.
- Drive UI with `adb` (`uiautomator dump`, `input tap|text|swipe`,
  `screencap`). Not AXe, not `xcrun simctl`.
- Always `fvm flutter` / `fvm dart`. Never touch `main`. Never force-push.
- `verify.sh` green before a fix commit. One bug per commit.
- Privacy: mask the phone; never write an OTP to a file.
- F2 dark: `adb -s emulator-5554 shell cmd uimode night yes`, then restore
  `night no`. F3 large text: `settings put system font_scale 1.3`, then
  restore `1.0`. G4 table link (stage id, raw colons):
  `adb -s emulator-5554 shell am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d 'elite://dine-in/table/urn:explorex:restaurant_tables:5e448d81-c2b5-4895-9244-698d20e74083' co.explorex.elite`
  AndroidManifest has no VIEW intent-filter, so this is the right
  invocation but may not open until that filter exists. Never send a KOT
  or pay. Stop at the cart.
- Leave elite_pixel booted when done.
