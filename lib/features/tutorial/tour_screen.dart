// "See all features": a short swipeable tour, one idea per page.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import 'tutorial.dart';

class FeatureTourScreen extends ConsumerStatefulWidget {
  const FeatureTourScreen({super.key, this.fromTutorial = false});

  /// Shown at the end of the tutorial: offers "Start my real shop".
  final bool fromTutorial;

  @override
  ConsumerState<FeatureTourScreen> createState() => _FeatureTourScreenState();
}

class _FeatureTourScreenState extends ConsumerState<FeatureTourScreen> {
  final _pages = PageController();
  int _page = 0;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final pages = [
      (Icons.home, t.tourHomeT, t.tourHomeB),
      (Icons.currency_rupee, t.tourCollectT, t.tourCollectB),
      (Icons.receipt_long, t.tourOrdersT, t.tourOrdersB),
      (Icons.inventory_2, t.tourStockT, t.tourStockB),
      (Icons.handyman, t.tourMakeT, t.tourMakeB),
      (Icons.sell, t.tourPricesT, t.tourPricesB),
      (Icons.account_balance_wallet, t.tourMoneyT, t.tourMoneyB),
      (Icons.family_restroom, t.tourFamilyT, t.tourFamilyB),
      (Icons.undo, t.tourUndoT, t.tourUndoB),
    ];
    final last = _page == pages.length - 1;
    return Scaffold(
      appBar: AppBar(title: Text(t.tutorialTour)),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: PageView(
              controller: _pages,
              onPageChanged: (i) => setState(() => _page = i),
              children: [
                for (final (icon, title, body) in pages)
                  Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      CircleAvatar(radius: 44, child: Icon(icon, size: 44)),
                      const SizedBox(height: 24),
                      Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 14),
                      Text(body, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
                    ]),
                  ),
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            for (var i = 0; i < pages.length; i++)
              Container(
                margin: const EdgeInsets.all(4),
                width: i == _page ? 18 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color:
                      i == _page ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
          ]),
          Padding(
            padding: const EdgeInsets.all(16),
            child: last
                ? Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    if (widget.fromTutorial)
                      FilledButton(
                        onPressed: () => finishTutorialToRealShop(ref),
                        child: Text(t.tutorialStartReal),
                      ),
                    const SizedBox(height: 8),
                    OutlinedButton(onPressed: () => Navigator.pop(context), child: Text(t.done)),
                  ])
                : FilledButton(
                    onPressed: () =>
                        _pages.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut),
                    child: Text(t.tourNext),
                  ),
          ),
        ]),
      ),
    );
  }
}
