import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/router/app_section.dart';
import 'package:kairo/core/router/app_shell.dart';
import 'package:kairo/core/router/session_redirect.dart';
import 'package:kairo/core/router/splash_screen.dart';
import 'package:kairo/core/storage/session_controller.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/presentation/screens/activities_screen.dart';
import 'package:kairo/features/activities/presentation/screens/activity_form_screen.dart';
import 'package:kairo/features/auth/presentation/screens/login_screen.dart';
import 'package:kairo/features/auth/presentation/screens/register_screen.dart';
import 'package:kairo/features/capture/presentation/screens/capture_screen.dart';
import 'package:kairo/features/goals/data/models/goal.dart';
import 'package:kairo/features/goals/presentation/controllers/goals_controller.dart';
import 'package:kairo/features/goals/presentation/screens/goal_detail_screen.dart';
import 'package:kairo/features/goals/presentation/screens/goal_form_screen.dart';
import 'package:kairo/features/goals/presentation/screens/goals_screen.dart';
import 'package:kairo/features/home/presentation/screens/home_screen.dart';
import 'package:kairo/features/more/presentation/screens/more_screen.dart';
import 'package:kairo/features/reminders/presentation/screens/reminder_form_screen.dart';
import 'package:kairo/features/reminders/presentation/screens/reminders_screen.dart';
import 'package:kairo/features/self_assessment/data/models/self_assessment.dart';
import 'package:kairo/features/self_assessment/presentation/screens/self_assessment_form_screen.dart';
import 'package:kairo/features/self_assessment/presentation/screens/self_assessment_screen.dart';
import 'package:kairo/features/subjects/presentation/screens/subject_form_screen.dart';
import 'package:kairo/features/subjects/presentation/screens/subjects_screen.dart';
import 'package:kairo/features/time_tracking/data/models/time_record.dart';
import 'package:kairo/features/time_tracking/presentation/screens/time_record_form_screen.dart';
import 'package:kairo/features/time_tracking/presentation/screens/time_screen.dart';

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
                if (section == AppSection.more)
                  _moreRoute
                else if (section == AppSection.activities)
                  _activitiesRoute
                else if (section == AppSection.home)
                  _homeRoute
                else if (section == AppSection.time)
                  _timeRoute
                else
                  _goalsRoute,
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

final _goalsRoute = GoRoute(
  path: AppSection.goals.path,
  builder: (context, state) => const GoalsScreen(),
  routes: [
    GoRoute(path: 'nueva', builder: (context, state) => const GoalFormScreen()),
    GoRoute(
      path: ':id',
      builder: (context, state) => GoalDetailScreen(
        goalId: state.pathParameters['id'] ?? '',
        initial: state.extra is GoalWithProgress
            ? state.extra! as GoalWithProgress
            : null,
      ),
      routes: [
        GoRoute(
          path: 'editar',
          builder: (context, state) => GoalFormScreen(
            goalId: state.pathParameters['id'],
            initial: state.extra is Goal ? state.extra! as Goal : null,
          ),
        ),
      ],
    ),
  ],
);

final _timeRoute = GoRoute(
  path: AppSection.time.path,
  builder: (context, state) => const TimeScreen(),
  routes: [
    GoRoute(
      path: 'registro/nuevo',
      builder: (context, state) => const TimeRecordFormScreen(),
    ),
    GoRoute(
      path: 'registro/:id',
      builder: (context, state) => TimeRecordFormScreen(
        recordId: state.pathParameters['id'],
        initial: state.extra is TimeRecord ? state.extra! as TimeRecord : null,
      ),
    ),
  ],
);

final _homeRoute = GoRoute(
  path: AppSection.home.path,
  builder: (context, state) => const HomeScreen(),
  routes: [
    GoRoute(
      path: 'capturar',
      builder: (context, state) => const CaptureScreen(),
      routes: [
        GoRoute(
          path: 'manual',
          builder: (context, state) => ActivityFormScreen(
            draftText: state.extra is String ? state.extra! as String : null,
          ),
        ),
      ],
    ),
    GoRoute(
      path: 'actividad/:id',
      builder: (context, state) => ActivityFormScreen(
        activityId: state.pathParameters['id'],
        initial: state.extra is Activity ? state.extra! as Activity : null,
      ),
    ),
  ],
);

final _activitiesRoute = GoRoute(
  path: AppSection.activities.path,
  builder: (context, state) => const ActivitiesScreen(),
  routes: [
    GoRoute(
      path: 'nueva',
      builder: (context, state) => const ActivityFormScreen(),
    ),
    GoRoute(
      path: ':id',
      builder: (context, state) =>
          ActivityFormScreen(activityId: state.pathParameters['id']),
    ),
  ],
);

final _moreRoute = GoRoute(
  path: AppSection.more.path,
  builder: (context, state) => const MoreScreen(),
  routes: [
    GoRoute(
      path: 'materias',
      builder: (context, state) => const SubjectsScreen(),
      routes: [
        GoRoute(
          path: 'nueva',
          builder: (context, state) => const SubjectFormScreen(),
        ),
        GoRoute(
          path: ':id',
          builder: (context, state) =>
              SubjectFormScreen(subjectId: state.pathParameters['id']),
        ),
      ],
    ),
    GoRoute(
      path: 'recordatorios',
      builder: (context, state) => const RemindersScreen(),
      routes: [
        GoRoute(
          path: 'nuevo',
          builder: (context, state) => const ReminderFormScreen(),
        ),
      ],
    ),
    GoRoute(
      path: 'autoevaluacion',
      builder: (context, state) => const SelfAssessmentScreen(),
      routes: [
        GoRoute(
          path: ':semana',
          builder: (context, state) => SelfAssessmentFormScreen(
            weekKey: state.pathParameters['semana'] ?? '',
            initial: state.extra is SelfAssessment
                ? state.extra! as SelfAssessment
                : null,
          ),
        ),
      ],
    ),
  ],
);
