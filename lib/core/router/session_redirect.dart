import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/router/app_section.dart';

String? sessionRedirect({
  required AsyncValue<bool> session,
  required String location,
}) {
  if (session.isLoading && !session.hasValue) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }

  final signedIn = session.value ?? false;
  if (!signedIn) {
    return location == AppRoutes.login ? null : AppRoutes.login;
  }

  final onPublicRoute =
      location == AppRoutes.splash || location == AppRoutes.login;
  return onPublicRoute ? AppSection.home.path : null;
}
