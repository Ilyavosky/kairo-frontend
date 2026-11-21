import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/router/app_section.dart';
import 'package:kairo/core/router/app_shell.dart';
import 'package:kairo/core/router/section_placeholder.dart';
import 'package:kairo/core/router/session_redirect.dart';
import 'package:kairo/core/router/splash_screen.dart';
import 'package:kairo/core/storage/session_controller.dart';
import 'package:kairo/features/auth/presentation/screens/login_screen.dart';
import 'package:kairo/features/auth/presentation/screens/register_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final session = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
  ref.listen(
    sessionControllerProvider,
    (_, next) => session.value = next,
    fireImmediately: true,
  );

  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: session,
    redirect: (context, state) => sessionRedirect(
      session: session.value,
      location: state.matchedLocation,
    ),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          for (final section in AppSection.values)
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: section.path,
                  builder: (context, state) =>
                      SectionPlaceholder(section: section),
                ),
              ],
            ),
        ],
      ),
    ],
  );

  ref.onDispose(() {
    router.dispose();
    session.dispose();
  });
  return router;
});
