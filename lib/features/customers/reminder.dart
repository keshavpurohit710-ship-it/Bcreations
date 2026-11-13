import 'package:flutter/widgets.dart';

import '../../app/format.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';

/// Opens WhatsApp with a polite, ready-to-send payment reminder.
Future<void> sendReminder(BuildContext context,
    {required Party party, required int balancePaise, required Setting settings}) {
  final t = context.t;
  final upi = settings.upiId?.trim();
  final text = t.reminderText(
    party.name,
    settings.businessName,
    formatPaise(balancePaise),
    upi == null || upi.isEmpty ? '' : t.reminderUpiLine(upi),
  );
  return openWhatsApp(context, party.phone, text: text);
}
