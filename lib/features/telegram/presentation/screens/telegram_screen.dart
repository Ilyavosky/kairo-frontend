import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/core/widgets/form_error_message.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/features/activities/domain/due_label.dart';
import 'package:kairo/features/telegram/data/models/telegram_link.dart';
import 'package:kairo/features/telegram/domain/telegram_bot.dart';
import 'package:kairo/features/telegram/presentation/controllers/telegram_controller.dart';
import 'package:kairo/features/telegram/presentation/widgets/telegram_privacy_card.dart';

class TelegramScreen extends ConsumerStatefulWidget {
  const TelegramScreen({super.key});

  @override
  ConsumerState<TelegramScreen> createState() => _TelegramScreenState();
}

class _TelegramScreenState extends ConsumerState<TelegramScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(telegramLinkedProvider);
    }
  }

  Future<void> _copy(String command) async {
    await Clipboard.setData(ClipboardData(text: command));
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Comando copiado.')));
  }

  @override
  Widget build(BuildContext context) {
    final linked = ref.watch(telegramLinkedProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KairoHeader(title: 'Telegram', onBack: () => context.pop()),
        Expanded(
          child: switch (linked) {
            AsyncData(:final value) => _content(context, value),
            AsyncError(:final error) => ErrorView(
              message: toAppException(error).message,
              onRetry: () => ref.invalidate(telegramLinkedProvider),
            ),
            _ => const Center(
              child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
            ),
          },
        ),
      ],
    );
  }

  Widget _content(BuildContext context, bool linked) {
    return RefreshIndicator(
      onRefresh: () => ref.refresh(telegramLinkedProvider.future),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          KairoSpacing.page,
          KairoSpacing.md,
          KairoSpacing.page,
          KairoSpacing.xl,
        ),
        children: [
          _StatusCard(linked: linked),
          const SizedBox(height: KairoSpacing.lg),
          if (!linked) ...[
            _LinkSection(onCopy: _copy),
            const SizedBox(height: KairoSpacing.lg),
          ],
          const TelegramPrivacyCard(),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.linked});

  final bool linked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(KairoSpacing.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              linked ? Icons.check_circle : Icons.link_off,
              color: linked ? scheme.primary : scheme.onSurfaceVariant,
            ),
            const SizedBox(width: KairoSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    linked ? 'Vinculado' : 'Sin vincular',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: KairoSpacing.xs),
                  Text(
                    linked
                        ? 'Tu cuenta está conectada con el bot de Kairo. Te '
                              'llegan tus recordatorios y puedes capturar '
                              'mensajes desde Telegram.'
                        : 'Conecta el bot de Kairo para recibir tus '
                              'recordatorios y capturar mensajes desde '
                              'Telegram.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkSection extends ConsumerWidget {
  const _LinkSection({required this.onCopy});

  final ValueChanged<String> onCopy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(telegramLinkControllerProvider);
    final controller = ref.read(telegramLinkControllerProvider.notifier);
    final hasBot =
        TelegramBot.deepLink(ref.watch(telegramBotProvider), 'x') != null;
    final link = state.value;
    final error = state.hasError && !state.isLoading
        ? toAppException(state.error!).message
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton(
          onPressed: state.isLoading ? null : controller.start,
          child: Text(
            state.isLoading
                ? 'Generando código…'
                : link == null
                ? 'Vincular Telegram'
                : 'Generar otro código',
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: KairoSpacing.md),
          FormErrorMessage(message: error),
        ],
        if (link != null) ...[
          const SizedBox(height: KairoSpacing.md),
          _CodeCard(
            link: link,
            hasBot: hasBot,
            onOpen: controller.open,
            onCopy: () => onCopy(link.command),
          ),
        ] else ...[
          const SizedBox(height: KairoSpacing.sm),
          Text(
            hasBot
                ? 'Se abrirá Telegram con el bot. Toca Iniciar y regresa a '
                      'Kairo.'
                : 'Te daremos un código para enviárselo al bot de Kairo.',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}

class _CodeCard extends StatelessWidget {
  const _CodeCard({
    required this.link,
    required this.hasBot,
    required this.onOpen,
    required this.onCopy,
  });

  final TelegramLink link;
  final bool hasBot;
  final VoidCallback onOpen;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final expires = DueLabel.hour(link.expiresAt.toLocal());

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(KairoSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              hasBot
                  ? 'Si Telegram no se abrió, envía este mensaje al bot:'
                  : 'Abre el bot de Kairo en Telegram y envíale este mensaje:',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: KairoSpacing.md),
            SelectableText(
              link.command,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(letterSpacing: 1.5),
            ),
            const SizedBox(height: KairoSpacing.xs),
            Text(
              'El código sirve una sola vez y vence a las $expires.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: KairoSpacing.md),
            OutlinedButton(
              onPressed: onCopy,
              child: const Text('Copiar mensaje'),
            ),
            if (hasBot) ...[
              const SizedBox(height: KairoSpacing.sm),
              OutlinedButton(
                onPressed: onOpen,
                child: const Text('Abrir Telegram'),
              ),
            ],
            const SizedBox(height: KairoSpacing.sm),
            Text(
              'Cuando el bot confirme la vinculación, regresa a Kairo y el '
              'estado se actualiza solo.',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
