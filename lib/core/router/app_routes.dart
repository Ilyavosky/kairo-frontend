abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/iniciar-sesion';
  static const register = '/crear-cuenta';

  static const activities = '/actividades';
  static const newActivity = '/actividades/nueva';

  static const subjects = '/mas/materias';
  static const newSubject = '/mas/materias/nueva';

  static const reminders = '/mas/recordatorios';
  static const newReminder = '/mas/recordatorios/nuevo';

  static const selfAssessment = '/mas/autoevaluacion';

  static const telegram = '/mas/telegram';

  static const reports = '/mas/reportes';

  static const account = '/mas/cuenta';

  static String selfAssessmentWeek(String week) => '$selfAssessment/$week';

  static const Set<String> publicRoutes = {splash, login, register};

  static String activity(String id) => '$activities/$id';

  static const capture = '/inicio/capturar';

  static const manualCapture = '/inicio/capturar/manual';

  static String homeActivity(String id) => '/inicio/actividad/$id';

  static const newTimeRecord = '/tiempo/registro/nuevo';

  static const newGoal = '/metas/nueva';

  static String goal(String id) => '/metas/$id';

  static String editGoal(String id) => '/metas/$id/editar';

  static String timeRecord(String id) => '/tiempo/registro/$id';

  static String subject(String id) => '$subjects/$id';
}
