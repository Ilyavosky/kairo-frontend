import 'package:kairo/features/activities/domain/activity_modality.dart';
import 'package:kairo/features/activities/domain/activity_validator.dart';
import 'package:kairo/features/activities/domain/due_label.dart';
import 'package:kairo/features/capture/data/models/capture.dart';
import 'package:kairo/features/capture/domain/capture_kind.dart';
import 'package:kairo/features/goals/domain/goal_format.dart';
import 'package:kairo/features/goals/domain/goal_period.dart';
import 'package:kairo/features/goals/domain/goal_type.dart';

typedef CaptureLookups = ({
  Map<String, String> categories,
  Map<String, String> subjects,
  Map<String, String> activities,
});

abstract final class CaptureFields {
  static const Map<CaptureKind, List<String>> _order = {
    CaptureKind.activity: [
      'titulo',
      'categoria_id',
      'materia_id',
      'vence_en',
      'prioridad',
      'modalidad',
      'descripcion',
    ],
    CaptureKind.timeRecord: [
      'categoria_id',
      'actividad_id',
      'inicio',
      'fin',
      'nota',
    ],
    CaptureKind.goal: ['categoria_id', 'tipo', 'periodo', 'objetivo'],
  };

  static const Map<String, String> _labels = {
    'titulo': 'Título',
    'descripcion': 'Descripción',
    'categoria_id': 'Categoría',
    'materia_id': 'Materia',
    'actividad_id': 'Actividad',
    'vence_en': 'Fecha de entrega',
    'prioridad': 'Prioridad',
    'modalidad': 'Modalidad',
    'inicio': 'Inicio',
    'fin': 'Fin',
    'nota': 'Nota',
    'tipo': 'Qué se mide',
    'periodo': 'Cada cuándo',
    'objetivo': 'Objetivo',
  };

  static const Map<String, ActivityModality> _modalities = {
    'presencial': ActivityModality.inPerson,
    'en_linea': ActivityModality.online,
    'mixta': ActivityModality.hybrid,
  };

  static const Map<String, GoalType> _goalTypes = {
    'tiempo_acumulado': GoalType.time,
    'numero_eventos': GoalType.events,
  };

  static const Map<String, GoalPeriod> _goalPeriods = {
    'dia': GoalPeriod.day,
    'semana': GoalPeriod.week,
    'mes': GoalPeriod.month,
  };

  static List<String> keysOf(Capture capture) {
    final known = _order[capture.kind] ?? const <String>[];
    return [
      for (final key in known)
        if (capture.fields.containsKey(key) || capture.pending.contains(key))
          key,
    ];
  }

  static String label(String key) => _labels[key] ?? key;

  static bool isPending(Capture capture, String key) =>
      capture.pending.contains(key) || capture.fields[key] == null;

  static String? display(Capture capture, String key, CaptureLookups lookups) {
    final Object? raw = capture.fields[key];
    if (raw == null) {
      return null;
    }
    final value = raw;
    return switch (key) {
      'categoria_id' => lookups.categories[value] ?? 'Categoría',
      'materia_id' => lookups.subjects[value] ?? 'Materia',
      'actividad_id' => lookups.activities[value] ?? 'Actividad',
      'vence_en' || 'inicio' || 'fin' => _dateTime(value),
      'prioridad' => _priority(value),
      'modalidad' => _modalities[value]?.label ?? '$value',
      'tipo' => _goalTypes[value]?.label ?? '$value',
      'periodo' => _goalPeriods[value]?.label ?? '$value',
      'objetivo' => _target(capture, value),
      _ => '$value',
    };
  }

  static String _dateTime(Object value) {
    final parsed = DateTime.tryParse('$value');
    if (parsed == null) {
      return '$value';
    }
    final local = parsed.toLocal();
    return '${DueLabel.shortDate(local)}, ${DueLabel.hour(local)}';
  }

  static String _priority(Object value) {
    final level = value is int ? value : int.tryParse('$value');
    final label = ActivityValidator.priorityLabels[level];
    return label == null ? '$value' : '$level · $label';
  }

  static String _target(Capture capture, Object value) {
    final type = _goalTypes[capture.fields['tipo']];
    final amount = value is num ? value : num.tryParse('$value');
    if (type == null || amount == null) {
      return '$value';
    }
    return GoalFormat.amount(type, amount);
  }
}
