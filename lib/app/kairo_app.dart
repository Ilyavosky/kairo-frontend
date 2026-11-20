import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/router/app_router.dart';
import 'package:kairo/core/theme/kairo_theme.dart';

class KairoApp extends ConsumerWidget {
  const KairoApp({super.key});

  static const locale = Locale('es', 'MX');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Kairo',
      debugShowCheckedModeBanner: false,
      theme: KairoTheme.light,
      darkTheme: KairoTheme.dark,
      locale: locale,
      supportedLocales: const [locale],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      routerConfig: router,
    );
  }
}
