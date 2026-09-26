#!/usr/bin/env bash
# Cloud Agent install step for the Elite product repo.
# Checks out the Flutter app submodule, installs the project-pinned Flutter SDK
# via FVM, resolves dependencies and runs codegen. Idempotent.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP="$ROOT/tech/codebase/elite_app"

# 1. Check out the app submodule. Requires the generated GitHub token to have
#    read access to explorexinc/elite (see repositoryDependencies).
git -C "$ROOT" submodule update --init tech/codebase/elite_app

if [ ! -f "$APP/pubspec.yaml" ]; then
  echo "ERROR: $APP/pubspec.yaml missing after submodule init." >&2
  echo "The token likely lacks read access to explorexinc/elite." >&2
  exit 1
fi

# 2. Install FVM (Flutter Version Manager) if absent, then the SDK pinned in .fvmrc.
if ! command -v fvm >/dev/null 2>&1 && [ ! -x "$HOME/fvm/bin/fvm" ]; then
  curl -fsSL https://fvm.app/install.sh | bash
fi
export PATH="$HOME/fvm/bin:$PATH"

cd "$APP"
fvm install
fvm flutter config --enable-web --no-analytics
fvm flutter precache --web

# 3. Resolve dependencies and run codegen (freezed / json_serializable / retrofit).
fvm flutter pub get
if grep -q build_runner pubspec.yaml; then
  fvm dart run build_runner build --delete-conflicting-outputs
fi
