abstract final class SelfAssessmentScale {
  static const Map<int, String> mood = {
    1: 'Muy mal',
    2: 'Mal',
    3: 'Regular',
    4: 'Bien',
    5: 'Muy bien',
  };

  static const Map<int, String> satisfaction = {
    1: 'Nada',
    2: 'Poco',
    3: 'Regular',
    4: 'Bastante',
    5: 'Mucho',
  };

  static const noteMaxLength = 2000;

  static String summary(int mood, int satisfaction) {
    final moodLabel = SelfAssessmentScale.mood[mood] ?? '$mood';
    final satisfactionLabel =
        SelfAssessmentScale.satisfaction[satisfaction] ?? '$satisfaction';
    return 'Ánimo: $moodLabel · Satisfacción: $satisfactionLabel';
  }

  static String? level(int? value, String message) =>
      value == null ? message : null;

  static String? note(String? value) {
    if ((value?.trim().length ?? 0) > noteMaxLength) {
      return 'No puede tener más de $noteMaxLength caracteres';
    }
    return null;
  }
}
