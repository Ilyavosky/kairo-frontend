import 'package:kairo/features/capture/domain/capture_fields.dart';

abstract final class CaptureCorrection {
  static Map<String, dynamic> changes(
    Map<String, dynamic> original,
    Map<String, Object?> edited,
  ) => {
    for (final entry in edited.entries)
      if (!_same(entry.key, original[entry.key], entry.value))
        entry.key: entry.value,
  };

  static bool _same(String key, Object? before, Object? after) {
    if (before == after) {
      return true;
    }
    if (before == null || after == null) {
      return false;
    }
    if (CaptureFields.isDate(key)) {
      final first = DateTime.tryParse('$before');
      final second = DateTime.tryParse('$after');
      if (first != null && second != null) {
        return first.isAtSameMomentAs(second);
      }
    }
    if (before is num && after is num) {
      return before == after;
    }
    return '$before' == '$after';
  }
}
