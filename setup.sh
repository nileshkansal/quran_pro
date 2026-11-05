#!/usr/bin/env bash
# One-time setup: generates the android/ and ios/ host projects with your
# local Flutter 3.44.8 SDK. Existing files (lib/, assets/, pubspec, test/) are
# kept — `flutter create` only adds files that are missing.
set -euo pipefail
cd "$(dirname "$0")"

flutter --version | head -1
flutter create . --org com.quranpro --project-name quran_pro --platforms android,ios
flutter pub get
flutter analyze
echo
echo "Done. Run:  flutter run"
