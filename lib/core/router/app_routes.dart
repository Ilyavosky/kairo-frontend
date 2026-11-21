abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/iniciar-sesion';
  static const register = '/crear-cuenta';

  static const activities = '/actividades';
  static const newActivity = '/actividades/nueva';

  static const subjects = '/mas/materias';
  static const newSubject = '/mas/materias/nueva';

  static const Set<String> publicRoutes = {splash, login, register};

  static String activity(String id) => '$activities/$id';

  static String homeActivity(String id) => '/inicio/actividad/$id';

  static String subject(String id) => '$subjects/$id';
}
