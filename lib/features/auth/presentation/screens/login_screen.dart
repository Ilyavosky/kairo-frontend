import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/server_status_card.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: KairoSpacing.page,
            vertical: KairoSpacing.xl,
          ),
          children: [
            const SizedBox(height: KairoSpacing.xl),
            Text(
              'Kairo',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.secondary,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: KairoSpacing.lg),
            Semantics(
              header: true,
              child: Text(
                'Inicio de sesión',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: KairoSpacing.sm),
            Text(
              'Organiza tu carga académica, tu tiempo y tus metas.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: KairoSpacing.xl),
            const ServerStatusCard(),
          ],
        ),
      ),
    );
  }
}
