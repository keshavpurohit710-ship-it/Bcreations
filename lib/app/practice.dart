// The practice shop: a separate database where she can learn and experiment.
// The real shop's settings row remembers whether practice is showing and
// whether the tutorial is done; language and theme are kept in step.

import 'package:drift/drift.dart';

import '../data/database.dart';
import '../data/maintenance.dart';

class PracticeService {
  PracticeService(this.real, this._practice);
  final AppDatabase real;
  final AppDatabase Function() _practice;

  Future<Setting> _realSettings() => real.getSettings();

  Future<void> _writeReal(SettingsCompanion c) => (real.update(real.settings)..where((s) => s.id.equals(settingsRowId)))
      .write(c.copyWith(updatedAt: Value(DateTime.now())));

  /// Opens the practice shop. [fresh] wipes it first; [sample] fills it with
  /// two months of sample activity instead of starting empty.
  Future<void> enter({bool fresh = false, bool sample = false}) async {
    final r = await _realSettings();
    final practice = _practice();
    final keep = SettingsCompanion(
      languageCode: Value(r.languageCode),
      themeMode: Value(r.themeMode),
      businessName: Value(r.businessName),
      startDate: Value(DateTime.now()),
    );
    if (sample) {
      await loadDemo(practice, languageCode: r.languageCode);
    } else if (fresh) {
      await resetDatabase(practice, keep: keep);
    } else {
      // Make sure it opens straight to Home, in her language
      await (practice.update(practice.settings)..where((s) => s.id.equals(settingsRowId))).write(SettingsCompanion(
        languageCode: Value(r.languageCode),
        themeMode: Value(r.themeMode),
        startDate: Value((await practice.getSettings()).startDate ?? DateTime.now()),
      ));
    }
    await _writeReal(const SettingsCompanion(practiceActive: Value(true)));
  }

  /// Back to her real shop. [finishTutorial] marks the tutorial as done.
  Future<void> exit({bool finishTutorial = false}) => _writeReal(SettingsCompanion(
        practiceActive: const Value(false),
        tutorialDoneAt: finishTutorial ? Value(DateTime.now()) : const Value.absent(),
      ));

  /// Start the guided tutorial again in an empty practice shop.
  Future<void> restartTutorial() async {
    await _writeReal(const SettingsCompanion(tutorialDoneAt: Value(null)));
    await enter(fresh: true);
  }

  /// "Skip the tutorial" on first run.
  Future<void> skipTutorial() => _writeReal(SettingsCompanion(tutorialDoneAt: Value(DateTime.now())));

  /// Language and theme apply to both shops.
  Future<void> setLanguage(String code) async {
    await _writeReal(SettingsCompanion(languageCode: Value(code)));
    if ((await _realSettings()).practiceActive) {
      final p = _practice();
      await (p.update(p.settings)..where((s) => s.id.equals(settingsRowId)))
          .write(SettingsCompanion(languageCode: Value(code)));
    }
  }

  Future<void> setTheme(String mode) async {
    await _writeReal(SettingsCompanion(themeMode: Value(mode)));
    if ((await _realSettings()).practiceActive) {
      final p = _practice();
      await (p.update(p.settings)..where((s) => s.id.equals(settingsRowId)))
          .write(SettingsCompanion(themeMode: Value(mode)));
    }
  }
}
