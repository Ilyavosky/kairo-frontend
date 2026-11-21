abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/iniciar-sesion';
  static const register = '/crear-cuenta';

  static const subjects = '/mas/materias';
  static const newSubject = '/mas/materias/nueva';

  static const Set<String> publicRoutes = {splash, login, register};

  static String subject(String id) => '$subjects/$id';
}
