import 'package:flutter/foundation.dart';

@immutable
class ReminderOption {
  const ReminderOption(this.id, this.label, {this.detail});

  final String id;
  final String label;
  final String? detail;

  String get fullLabel {
    final extra = detail;
    return extra == null ? label : '$label · $extra';
  }
}
