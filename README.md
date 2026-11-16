# Bcreations

An offline Android app for running a small handmade craft business: customers and suppliers, orders and quotes, stock and production, payments, expenses and profit.

- **Review & roadmap:** [docs/REVIEW_AND_PLAN.md](docs/REVIEW_AND_PLAN.md)
- **Build & release:** [docs/RELEASE.md](docs/RELEASE.md)
- **Test plan** (automated tests, release checklist, session with the user): [docs/TEST_PLAN.md](docs/TEST_PLAN.md)

## Quick start
```bash
flutter pub get
flutter analyze --no-fatal-infos
flutter test
flutter run
```

Stack: Flutter 3.47 · Riverpod · Drift (SQLite). Code: `lib/data` (database), `lib/domain` (money & stock logic), `lib/app` (theme, wiring, shared widgets), `lib/features` (screens).

App text lives in one table, `tool/strings.mjs` (English + Hindi). After editing it run `node tool/strings.mjs` (then `flutter gen-l10n`, or any build).

After changing tables in `lib/data/tables.dart`, regenerate with `dart run build_runner build`.
