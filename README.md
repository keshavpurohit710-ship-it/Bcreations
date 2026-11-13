# Bcreations

An offline Android app for running a small handmade craft business: customers and suppliers, orders and quotes, stock and production, payments, expenses and profit.

- **Review & roadmap:** [docs/REVIEW_AND_PLAN.md](docs/REVIEW_AND_PLAN.md)
- **Build & release:** [docs/RELEASE.md](docs/RELEASE.md)

## Quick start
```bash
flutter pub get
flutter analyze --no-fatal-infos
flutter test
flutter run
```

Stack: Flutter 3.47 · Riverpod · Drift (SQLite) for the new data layer in `lib/data` + `lib/domain` (the old screens still use Isar until Phase 2).

After changing tables in `lib/data/tables.dart`, regenerate with `dart run build_runner build`.
