---
description: Run the web-qa agent. A lighter /sim-qa. It serves the Elite app as Flutter web, tests it in Chrome (Claude in Chrome) like a diner, records bugs (screenshots + md), fixes them, and repeats until ≥90% of scenarios pass.
argument-hint: "[phone] [--target 90] [--max-loops 5] [--port 8686] [--only A1,B3,…]"
---

Launch the `web-qa` agent and act as its relay to the user.

Arguments: `$ARGUMENTS`

1. **Parse the arguments.**
   - The first bare number is `PHONE`. If it's missing, ask the user for it (AskUserQuestion, or
     a plain question if that tool isn't available) before launching.
   - `--target N` (default 90), `--max-loops N` (default 5), `--port N` (default 8686) →
     `PORT`, and `--only IDs` → `SCENARIOS`.
   - Sign-in is always real: the stage gateway sends a 6-digit WhatsApp code to `PHONE`, and
     the user reads it out when the agent reaches the OTP screen, once per loop.
2. **Preflight.** Check that the `mcp__claude-in-chrome__*` tools are available. If not, tell the
   user to run `/chrome` (or restart with `claude --chrome`) and stop. Run `ListAgents`; if
   another session is running `web-qa` on the same port, tell the user and ask whether to
   proceed.
3. **Launch** the agent with `Agent`, using `subagent_type: "web-qa"` and a short description
   like "Browser QA loop". Pass a prompt containing `PHONE`, `TARGET`,
   `MAX_LOOPS`, `PORT`, and `SCENARIOS` if given, plus the current working
   directory. Tell the user it has started, that it will open its own tab in their Chrome, and
   roughly what it will do.
4. **Relay.** When the agent returns a message starting `NEEDS_OTP:`, `NEEDS_PHONE:` or
   `needs input:`, show it to the user and ask for the value. Then resume the **same** agent
   with `SendMessage`, sending just the value (for example, `OTP: 482193`). Don't start a new
   agent. Codes expire, so relay quickly.
5. **Report.** When the agent finishes, relay its final report: the pass rate per loop, N/A-web
   scenarios, bugs found, fixed and blocked, any web-compat fixes, the branch, and the paths to
   `SUMMARY.md` and the last loop's `REPORT.md`. Don't echo the OTP anywhere.
