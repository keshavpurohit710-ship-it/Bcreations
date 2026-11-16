// Guided tutorial in the practice shop. Each step asks her to do one real
// thing with prompted sample values; progress is detected from what she
// actually entered, so she learns by doing — not by reading.

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/shell.dart';
import '../../app/theme.dart';
import '../../data/database.dart';
import '../customers/customer_detail_screen.dart';
import '../customers/customer_form_screen.dart';
import '../items/item_form_screen.dart';
import '../money/money_sheets.dart';
import '../orders/order_detail_screen.dart';
import '../orders/order_form_screen.dart';
import 'tour_screen.dart';

enum TutorialStep { addItem, addCustomer, orderWithAdvance, deliver, receivePayment, expense, seeMoney }

/// The app's navigator, so the guide (which sits above all screens) can open them.
final appNavigatorKey = GlobalKey<NavigatorState>();

final tutorialSkippedProvider = StateProvider<Set<TutorialStep>>((ref) => {});
final tutorialSeenMoneyProvider = StateProvider<bool>((ref) => false);
final tutorialCollapsedProvider = StateProvider<bool>((ref) => false);

/// Steps already done in the practice shop (detected from its data).
final tutorialDoneStepsProvider = FutureProvider<Set<TutorialStep>>((ref) async {
  ref.watch(dbTickProvider);
  final db = ref.watch(databaseProvider);
  Future<int> count(String sql) async => (await db.customSelect(sql).getSingle()).data.values.first as int;

  final done = <TutorialStep>{};
  if (await count("SELECT COUNT(*) FROM products WHERE deleted_at IS NULL AND kind != 'rawMaterial'") > 0) {
    done.add(TutorialStep.addItem);
  }
  if (await count('SELECT COUNT(*) FROM parties WHERE deleted_at IS NULL AND opening_balance_paise > 0') > 0) {
    done.add(TutorialStep.addCustomer);
  }
  if (await count('SELECT COUNT(*) FROM payment_allocations WHERE deleted_at IS NULL') > 0) {
    done.add(TutorialStep.orderWithAdvance);
  }
  if (await count("SELECT COUNT(*) FROM orders WHERE deleted_at IS NULL AND status = 'delivered'") > 0) {
    done.add(TutorialStep.deliver);
  }
  if (await count("SELECT COUNT(*) FROM payments WHERE deleted_at IS NULL AND purpose = 'customerPayment'") > 1) {
    done.add(TutorialStep.receivePayment);
  }
  if (await count('SELECT COUNT(*) FROM expenses WHERE deleted_at IS NULL') > 0) done.add(TutorialStep.expense);
  if (ref.watch(tutorialSeenMoneyProvider)) done.add(TutorialStep.seeMoney);
  return done;
});

/// The step to do now, or null when every step is done or skipped.
final tutorialCurrentStepProvider = Provider<TutorialStep?>((ref) {
  final done = ref.watch(tutorialDoneStepsProvider).valueOrNull;
  if (done == null) return TutorialStep.addItem;
  final skipped = ref.watch(tutorialSkippedProvider);
  for (final s in TutorialStep.values) {
    if (!done.contains(s) && !skipped.contains(s)) return s;
  }
  return null;
});

(String, String) stepText(BuildContext context, TutorialStep s) {
  final t = context.t;
  return switch (s) {
    TutorialStep.addItem => (t.t1Title, t.t1Prompt),
    TutorialStep.addCustomer => (t.t2Title, t.t2Prompt),
    TutorialStep.orderWithAdvance => (t.t3Title, t.t3Prompt),
    TutorialStep.deliver => (t.t4Title, t.t4Prompt),
    TutorialStep.receivePayment => (t.t5Title, t.t5Prompt),
    TutorialStep.expense => (t.t6Title, t.t6Prompt),
    TutorialStep.seeMoney => (t.t7Title, t.t7Prompt),
  };
}

/// Opens the screen where this step is done.
Future<void> showMe(WidgetRef ref, TutorialStep step) async {
  final nav = appNavigatorKey.currentState;
  if (nav == null) return;
  final db = ref.read(databaseProvider);
  nav.popUntil((r) => r.isFirst);
  void push(Widget screen) => nav.push(MaterialPageRoute(builder: (_) => screen));

  Future<Party?> owingCustomer() async {
    for (final p in await (db.select(db.parties)..where((p) => p.deletedAt.isNull())).get()) {
      if (p.role != PartyRole.supplier && await ref.read(ledgerProvider).customerBalance(p.id) > 0) return p;
    }
    return null;
  }

  switch (step) {
    case TutorialStep.addItem:
      push(const ItemFormScreen());
    case TutorialStep.addCustomer:
      push(const CustomerFormScreen());
    case TutorialStep.orderWithAdvance:
      final customer = await (db.select(db.parties)
            ..where((p) => p.deletedAt.isNull() & p.openingBalancePaise.isBiggerThanValue(0))
            ..limit(1))
          .getSingleOrNull();
      push(OrderFormScreen(partyId: customer?.id));
    case TutorialStep.deliver:
      final open = await (db.select(db.orders)
            ..where((o) => o.deletedAt.isNull() & o.status.equalsValue(OrderStatus.confirmed))
            ..orderBy([(o) => OrderingTerm.desc(o.createdAt)])
            ..limit(1))
          .getSingleOrNull();
      if (open != null) {
        push(OrderDetailScreen(orderId: open.id));
      } else {
        ref.read(shellTabProvider.notifier).state = 1;
      }
    case TutorialStep.receivePayment:
      final p = await owingCustomer();
      if (p != null) {
        push(CustomerDetailScreen(partyId: p.id));
      } else {
        ref.read(shellTabProvider.notifier).state = 2;
      }
    case TutorialStep.expense:
      if (nav.mounted) await showExpenseSheet(nav.context);
    case TutorialStep.seeMoney:
      ref.read(shellTabProvider.notifier).state = 4;
  }
}

/// The guide shown at the top of every screen while the tutorial runs.
class TutorialCoach extends ConsumerWidget {
  const TutorialCoach({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final step = ref.watch(tutorialCurrentStepProvider);
    final collapsed = ref.watch(tutorialCollapsedProvider);
    final scheme = Theme.of(context).colorScheme;

    Widget box(List<Widget> children) => Material(
          color: scheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 6, 8),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: children),
          ),
        );

    if (step == null) {
      return box([
        Text(t.tutorialAllDone, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 6),
        Wrap(spacing: 8, runSpacing: 4, children: [
          FilledButton.tonal(
            onPressed: () => appNavigatorKey.currentState
                ?.push(MaterialPageRoute(builder: (_) => const FeatureTourScreen(fromTutorial: true))),
            child: Text(t.tutorialTour),
          ),
          FilledButton(
            onPressed: () => finishTutorialToRealShop(ref),
            child: Text(t.tutorialStartReal),
          ),
        ]),
      ]);
    }

    final index = TutorialStep.values.indexOf(step) + 1;
    final (title, prompt) = stepText(context, step);
    return box([
      Row(children: [
        Expanded(
          child: Text('${t.tutorialStepOf(index, TutorialStep.values.length)} · $title',
              style: Theme.of(context).textTheme.titleSmall),
        ),
        IconButton(
          visualDensity: VisualDensity.compact,
          icon: Icon(collapsed ? Icons.expand_more : Icons.expand_less),
          onPressed: () => ref.read(tutorialCollapsedProvider.notifier).state = !collapsed,
        ),
      ]),
      if (!collapsed) ...[
        Text(prompt, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4),
        Wrap(spacing: 8, children: [
          FilledButton.icon(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 40)),
            onPressed: () => showMe(ref, step),
            icon: const Icon(Icons.touch_app, size: 18),
            label: Text(t.tutorialShowMe),
          ),
          if (step == TutorialStep.seeMoney)
            TextButton(
              onPressed: () => ref.read(tutorialSeenMoneyProvider.notifier).state = true,
              child: Text(t.tutorialSeen),
            )
          else
            TextButton(
              onPressed: () => ref.read(tutorialSkippedProvider.notifier).update((s) => {...s, step}),
              child: Text(t.tutorialSkipStep),
            ),
        ]),
      ],
    ]);
  }
}

/// Leaves the practice shop; the real shop's setup comes next if not done yet.
Future<void> finishTutorialToRealShop(WidgetRef ref) async {
  appNavigatorKey.currentState?.popUntil((r) => r.isFirst);
  ref.read(shellTabProvider.notifier).state = 0;
  await ref.read(practiceProvider).exit(finishTutorial: true);
}

/// Orange strip at the very top while the practice shop is showing.
class PracticeBanner extends ConsumerWidget {
  const PracticeBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    return Material(
      color: warnColor,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 2, 4, 2),
          child: Row(children: [
            const Icon(Icons.school, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(t.practiceBanner,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.white, visualDensity: VisualDensity.compact),
              onPressed: () async {
                appNavigatorKey.currentState?.popUntil((r) => r.isFirst);
                ref.read(shellTabProvider.notifier).state = 0;
                await ref.read(practiceProvider).exit();
              },
              child: Text(t.practiceExit, style: const TextStyle(fontSize: 13, decoration: TextDecoration.underline)),
            ),
          ]),
        ),
      ),
    );
  }
}
