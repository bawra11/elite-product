---
description: Run the sim-qa agent. It tests the Elite app on the iOS simulator like a diner, records bugs (screenshots + md), fixes them, and repeats until ≥90% of scenarios pass.
argument-hint: "[phone] [--real-otp] [--target 90] [--max-loops 5] [--refresh-token <t>] [--only A1,B3,…]"
---

Launch the `sim-qa` agent and act as its relay to the user.

Arguments: `$ARGUMENTS`

1. **Parse the arguments.**
   - The first bare number is `PHONE`. If it's missing, ask the user for it (AskUserQuestion, or
     a plain question if that tool isn't available) before launching.
   - `--real-otp` → `OTP_MODE=real`, otherwise `stub`. Debug builds use stub OTP today, and
     the app has no real OTP endpoint yet.
   - `--target N` (default 90), `--max-loops N` (default 5), `--refresh-token T`, and
     `--only IDs` → `SCENARIOS`.
2. **Preflight.** Run `ListAgents`. If another session is doing simulator work, tell the user
   and ask whether to proceed. The simulator is shared (see CLAUDE.md).
3. **Launch** the agent with `Agent`, using `subagent_type: "sim-qa"` and a short description
   like "Simulator QA loop". Pass a prompt containing `PHONE`, `OTP_MODE`, `TARGET`,
   `MAX_LOOPS`, and `REFRESH_TOKEN` / `SCENARIOS` if given, plus the current working
   directory. Tell the user it has started and roughly what it will do.
4. **Relay.** When the agent returns a message starting `NEEDS_OTP:` or `NEEDS_PHONE:`,
   show it to the user and ask for the value. Then resume the **same** agent with
   `SendMessage` (its id or name), sending just the value (for example, `OTP: 4821`). Don't
   start a new agent. Its simulator session and context live in the old one. Codes expire, so
   relay quickly.
5. **Report.** When the agent finishes, relay its final report: the pass rate per loop, the
   bugs found, fixed and blocked, the branch, and the paths to `SUMMARY.md` and the last loop's
   `REPORT.md`. Don't echo the OTP anywhere.
