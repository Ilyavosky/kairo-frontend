import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';

class TelegramPrivacyCard extends StatelessWidget {
  const TelegramPrivacyCard({super.key});

  static const List<(IconData, String)> _items = [
    (
      Icons.badge_outlined,
      'Tu número de usuario de Telegram, para saber que eres tú. '
          'No recibe tu número de teléfono.',
    ),
    (
      Icons.chat_outlined,
      'Los mensajes que le escribas, para convertirlos en actividades, '
          'registros de tiempo o metas.',
    ),
    (
      Icons.notifications_none,
      'Tus recordatorios, que te llegan como mensajes del bot.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(KairoSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Qué recibe el bot', style: theme.textTheme.titleMedium),
            for (final (icon, text) in _items) ...[
              const SizedBox(height: KairoSpacing.md),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 20, color: scheme.primary),
                  const SizedBox(width: KairoSpacing.md),
                  Expanded(
                    child: Text(text, style: theme.textTheme.bodyMedium),
                  ),
                ],
              ),
            ],
            const SizedBox(height: KairoSpacing.md),
            Text(
              'El bot no ve tu contraseña ni tus otros chats.',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
