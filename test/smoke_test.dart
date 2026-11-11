// Placeholder smoke test so `flutter test` runs in CI.
// Real unit tests for money and stock calculations arrive with the
// new data layer in Phase 1 (see docs/REVIEW_AND_PLAN.md).
import 'package:bcreations/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('app theme is configured', () {
    expect(AppTheme.darkTheme.brightness, Brightness.dark);
    expect(AppTheme.darkTheme.scaffoldBackgroundColor, AppTheme.backgroundDark);
  });
}
