// Shared building blocks used across screens.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/database.dart';
import 'format.dart';
import 'theme.dart';

/// Loading / error / data for an AsyncValue, with a friendly error.
class AsyncBody<T> extends StatelessWidget {
  const AsyncBody(this.value, {super.key, required this.builder});
  final AsyncValue<T> value;
  final Widget Function(T data) builder;

  @override
  Widget build(BuildContext context) => value.when(
        data: builder,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('$e', style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
        ),
      );
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 56, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 12),
            Text(text, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
          ]),
        ),
      );
}

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.text, {super.key, this.trailing});
  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 12, 6),
        child: Row(children: [
          Expanded(child: Text(text, style: Theme.of(context).textTheme.titleMedium)),
          if (trailing != null) trailing!,
        ]),
      );
}

/// A coloured pill with a word (status, payment state, overdue...).
class Pill extends StatelessWidget {
  const Pill(this.text, {super.key, required this.color, this.icon});
  final String text;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null) ...[Icon(icon, size: 16, color: color), const SizedBox(width: 4)],
          // Long text (e.g. "Owes ₹2,51,000 · 13 days late") wraps instead of overflowing.
          Flexible(child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 14))),
        ]),
      );
}

/// What a customer owes (red), what she holds for them (green), or settled.
class BalancePill extends StatelessWidget {
  const BalancePill(this.balancePaise, {super.key, this.daysLate = 0});
  final int balancePaise;
  final int daysLate;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    if (balancePaise > 0) {
      return Pill(
        daysLate > 0
            ? '${t.owes(formatPaise(balancePaise))} · ${t.daysLate(daysLate)}'
            : t.owes(formatPaise(balancePaise)),
        color: daysLate > 0 ? badColor : warnColor,
        icon: daysLate > 0 ? Icons.schedule : null,
      );
    }
    if (balancePaise < 0) return Pill(t.youHold(formatPaise(-balancePaise)), color: goodColor);
    return Pill(t.settled, color: goodColor, icon: Icons.check);
  }
}

Color statusColor(OrderStatus s) => switch (s) {
      OrderStatus.quote => Colors.blueGrey,
      OrderStatus.confirmed => warnColor,
      OrderStatus.delivered => goodColor,
      OrderStatus.cancelled => badColor,
    };

// --------------------------------------------------------------- inputs

final _decimal = FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'));

class MoneyField extends StatelessWidget {
  const MoneyField(
      {super.key,
      required this.controller,
      required this.label,
      this.autofocus = false,
      this.onChanged,
      this.validator,
      this.helper});
  final TextEditingController controller;
  final String label;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final String? helper;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        autofocus: autofocus,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [_decimal],
        decoration: InputDecoration(labelText: label, prefixText: '₹ ', helperText: helper),
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        onChanged: onChanged,
        validator: validator,
      );
}

class QtyField extends StatelessWidget {
  const QtyField(
      {super.key,
      required this.controller,
      required this.label,
      this.unit,
      this.autofocus = false,
      this.onChanged,
      this.validator});
  final TextEditingController controller;
  final String label;
  final String? unit;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        autofocus: autofocus,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [_decimal],
        decoration: InputDecoration(labelText: label, suffixText: unit),
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        onChanged: onChanged,
        validator: validator,
      );
}

String? requiredAmount(BuildContext context, String? v) =>
    (parseRupees(v ?? '') ?? 0) > 0 ? null : context.t.amountMustBePositive;

String? requiredQty(BuildContext context, String? v) => (parseQty(v ?? '') ?? 0) > 0 ? null : context.t.required;

class MethodChips extends StatelessWidget {
  const MethodChips({super.key, required this.value, required this.onChanged});
  final PaymentMethod value;
  final ValueChanged<PaymentMethod> onChanged;

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final m in const [PaymentMethod.cash, PaymentMethod.upi, PaymentMethod.bank, PaymentMethod.cheque])
            ChoiceChip(label: Text(context.t.method(m)), selected: value == m, onSelected: (_) => onChanged(m)),
        ],
      );
}

/// A tappable row showing a date; opens the date picker.
class DateRow extends StatelessWidget {
  const DateRow(
      {super.key,
      required this.label,
      required this.date,
      required this.onChanged,
      this.allowFuture = false,
      this.clearable = false});
  final String label;
  final DateTime? date;
  final ValueChanged<DateTime?> onChanged;
  final bool allowFuture;
  final bool clearable;

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () async {
          final now = DateTime.now();
          final picked = await showDatePicker(
            context: context,
            initialDate: date ?? now,
            firstDate: DateTime(2020),
            lastDate: allowFuture ? DateTime(now.year + 2) : now,
          );
          if (picked != null) onChanged(DateTime(picked.year, picked.month, picked.day, 12));
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            suffixIcon: clearable && date != null
                ? IconButton(icon: const Icon(Icons.close), onPressed: () => onChanged(null))
                : const Icon(Icons.calendar_today),
          ),
          child: Text(date == null ? '—' : longDate(context, date!), style: const TextStyle(fontSize: 18)),
        ),
      );
}

// ------------------------------------------------------------- dialogs

Future<bool> confirmDialog(BuildContext context, String message, {String? ok, bool danger = false}) async =>
    await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(message, style: const TextStyle(fontSize: 17)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(context.t.cancel)),
          FilledButton(
            style: danger ? FilledButton.styleFrom(backgroundColor: badColor) : null,
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(ok ?? context.t.done),
          ),
        ],
      ),
    ) ??
    false;

void showUndo(BuildContext context, String message, Future<void> Function() onUndo) =>
    UndoNotice.of(context).show(message, onUndo);

/// Captured BEFORE an async save, so the "Undo" message can still be shown
/// after a bottom sheet has closed.
class UndoNotice {
  UndoNotice._(this._messenger, this._undoLabel);
  factory UndoNotice.of(BuildContext context) => UndoNotice._(ScaffoldMessenger.of(context), context.t.undo);
  final ScaffoldMessengerState _messenger;
  final String _undoLabel;

  void show(String message, Future<void> Function() onUndo) {
    _messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 16)),
        duration: const Duration(seconds: 6),
        action: SnackBarAction(label: _undoLabel, onPressed: onUndo),
      ));
  }
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message, style: const TextStyle(fontSize: 16))));
}

/// Opens a scrollable bottom sheet that moves above the keyboard.
Future<T?> showFormSheet<T>(BuildContext context, Widget child) => showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(20, 0, 20, 24), child: child),
      ),
    );

// --------------------------------------------------------- phone & photos

String? _waNumber(String? phone) {
  if (phone == null) return null;
  final digits = phone.replaceAll(RegExp(r'\D'), '');
  if (digits.isEmpty) return null;
  return digits.length == 10 ? '91$digits' : digits;
}

Future<void> callPhone(BuildContext context, String? phone) async {
  if (phone == null || phone.trim().isEmpty) return showMessage(context, context.t.noPhone);
  await launchUrl(Uri(scheme: 'tel', path: phone.replaceAll(' ', '')));
}

Future<void> openWhatsApp(BuildContext context, String? phone, {String? text}) async {
  final number = _waNumber(phone);
  if (number == null) return showMessage(context, context.t.noPhone);
  final uri = Uri.parse('https://wa.me/$number${text == null ? '' : '?text=${Uri.encodeComponent(text)}'}');
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

/// Picks a photo and copies it into the app's own folder (so Android can't
/// clear it, and backups can include it). Returns the saved path.
Future<String?> pickAndSavePhoto(ImageSource source) async {
  final picked = await ImagePicker().pickImage(source: source, imageQuality: 75, maxWidth: 1600);
  if (picked == null) return null;
  final dir = Directory(p.join((await getApplicationDocumentsDirectory()).path, 'photos'));
  await dir.create(recursive: true);
  final target = p.join(dir.path, '${newId()}${p.extension(picked.path).isEmpty ? '.jpg' : p.extension(picked.path)}');
  await File(picked.path).copy(target);
  return target;
}

Future<String?> choosePhoto(BuildContext context) async {
  final source = await showModalBottomSheet<ImageSource>(
    context: context,
    showDragHandle: true,
    builder: (ctx) => SafeArea(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
            leading: const Icon(Icons.photo_camera),
            title: Text(context.t.photoCamera),
            onTap: () => Navigator.pop(ctx, ImageSource.camera)),
        ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(context.t.photoGallery),
            onTap: () => Navigator.pop(ctx, ImageSource.gallery)),
      ]),
    ),
  );
  return source == null ? null : pickAndSavePhoto(source);
}

class PhotoThumb extends StatelessWidget {
  const PhotoThumb(this.path, {super.key, this.size = 72, this.onRemove});
  final String path;
  final double size;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) => Stack(children: [
        GestureDetector(
          onTap: () => showDialog(
              context: context, builder: (_) => Dialog(child: InteractiveViewer(child: Image.file(File(path))))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(File(path),
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    SizedBox(width: size, height: size, child: const Icon(Icons.broken_image))),
          ),
        ),
        if (onRemove != null)
          Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: onRemove,
              child: const CircleAvatar(radius: 12, child: Icon(Icons.close, size: 16)),
            ),
          ),
      ]);
}

/// Keeps a Riverpod family argument stable for "today's month".
DateTime monthKey(DateTime d) => DateTime(d.year, d.month);
