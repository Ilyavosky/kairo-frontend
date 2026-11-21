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
    final onAuthRoute =
        location == AppRoutes.login || location == AppRoutes.register;
    return onAuthRoute ? null : AppRoutes.login;
  }

  return AppRoutes.publicRoutes.contains(location)
      ? AppSection.home.path
      : null;
}
