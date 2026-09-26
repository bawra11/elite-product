# Wispr Flow → Claude Code

Dictating prompts into Claude Code with Wispr Flow (v1.6.x, installed at
`/Applications/Wispr Flow.app`). Wispr types into whatever text field is focused, so
Claude Code needs no plugin — this file is the setup that makes dictated prompts land
cleanly for Elite work.

## 1. One-time Wispr setup (Wispr Flow → Settings)

- **Permissions:** System Settings → Privacy & Security → allow Wispr Flow under
  *Accessibility* and *Microphone*, and make sure your terminal/IDE isn't blocked in
  Wispr's app list.
- **Hotkey:** default is hold `fn` (push-to-talk) / double-tap `fn` (hands-free). Avoid
  binding anything Claude Code uses (`Esc`, `Ctrl+C`, `Shift+Tab`, `Ctrl+R`).
- **Style for the terminal/IDE:** pick the plain/"Very casual" style for your terminal
  app so Wispr doesn't add greeting/sign-off formatting or rewrite code-ish terms.
- **Submitting:** Wispr only inserts text; press `Enter` yourself (or use Wispr's
  "press enter" voice command if enabled) to send. `Shift+Enter`/`\` + Enter gives
  a newline in Claude Code without sending.
- **Secure input:** if dictation silently fails, some app has Secure Keyboard Entry on
  (Terminal/iTerm menu → turn off *Secure Keyboard Entry*).

## 2. Dictionary (Wispr Flow → Dictionary → Add new)

Add these so Wispr spells project terms correctly. Left side = say it / what Wispr
tends to write; right side = what to add (use a *replacement* where given).

| Add word / replacement | Commonly misheard as |
|---|---|
| Elite | a light, elight |
| graphify | graph if I, graphy fy |
| Flutter | flutter (lowercase fine) |
| FVM | FBM, FVN |
| fvm flutter | — |
| BLoC | block |
| Cubit | cube it |
| BlocBuilder | block builder |
| get_it | get it |
| go_router | go router |
| dio | Dio, D.O. |
| retrofit | retro fit |
| freezed | frozen |
| json_serializable | JSON serializable |
| flutter_animate | flutter animate |
| flutter_secure_storage | flutter secure storage |
| hive | Hive |
| drift | Drift |
| pubspec.yaml | pub spec |
| protos | protose, pro toes |
| buf | buff |
| gRPC | GRPC, G RPC |
| customer_gateway | customer gateway |
| restaurant_catalog_svc | restaurant catalog service |
| feed_svc / user_svc / order_svc / booking_svc / payment_svc | "<name> service" |
| explorex_pay_svc | Explorex pay service |
| Explorex | explore X |
| sim-qa | sim QA, SIMQA |
| web-qa | web QA |
| FeedPost | feed post |
| FeedMedia | feed media |
| DinerProfile | diner profile |
| RestaurantStory | restaurant story |
| ExperiencePayload | experience payload |
| OTP | O.T.P. |
| JWT | J.W.T., jot |
| OneSignal | one signal |
| Figma | figma |

Tip: Wispr also auto-learns words you correct after dictating — fix a term once in the
prompt box and it usually sticks.

## 3. Snippets (Wispr Flow → Snippets)

Voice shortcuts that expand into common Claude Code prompts:

| Say | Expands to |
|---|---|
| "run sim QA" | `/sim-qa` |
| "run web QA" | `/web-qa` |
| "fvm run" | `cd tech/codebase/elite_app && fvm flutter run` |
| "graphify first" | `Search via graphify first, then fall back to grep.` |
| "review my diff" | `/code-review` |

## 4. Claude Code side

Claude has a memory note that your prompts may be dictated, so it reads obvious
homophones ("graph if I", "block", "a light app") as the project terms above instead
of asking. Nothing else to install.

Separately, the **Wispr Flow connector** (claude.ai) is already signed in, so you can
ask Claude about your Wispr meetings, scratchpad notes and calendar from this session.
