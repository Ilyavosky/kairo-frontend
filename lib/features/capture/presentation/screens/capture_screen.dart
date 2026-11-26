import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/form_error_message.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/features/capture/data/models/capture.dart';
import 'package:kairo/features/capture/data/shared_text_source.dart';
import 'package:kairo/features/capture/domain/capture_validator.dart';
import 'package:kairo/features/capture/presentation/controllers/capture_controller.dart';
import 'package:kairo/features/capture/presentation/widgets/capture_correction_form.dart';
import 'package:kairo/features/capture/presentation/widgets/capture_review_card.dart';

class CaptureScreen extends ConsumerStatefulWidget {
  const CaptureScreen({super.key});

  @override
  ConsumerState<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends ConsumerState<CaptureScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  var _correcting = false;

  @override
  void initState() {
    super.initState();
    final shared = ref.read(pendingSharedTextProvider);
    if (shared != null) {
      _textController.text = shared;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(pendingSharedTextProvider.notifier).take();
        }
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text?.trim() ?? '';
    if (!mounted) {
      return;
    }
    if (text.isEmpty) {
      _showMessage('No hay texto copiado para pegar.');
      return;
    }
    _textController.text = text;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    await ref
        .read(captureControllerProvider.notifier)
        .submit(_textController.text);
    if (!mounted) {
      return;
    }
    if (ref.read(captureControllerProvider).error
        is ServiceUnavailableException) {
      await _openManual();
    }
  }

  Future<void> _openManual() async {
    final messenger = ScaffoldMessenger.of(context);
    final saved = await context.push<bool>(
      AppRoutes.manualCapture,
      extra: _textController.text.trim(),
    );
    if (saved != true || !mounted) {
      return;
    }
    context.pop();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Guardado como actividad.')));
  }

  Future<void> _confirm() =>
      _finish(ref.read(captureControllerProvider.notifier).confirm);

  Future<void> _saveCorrection(Map<String, dynamic> fields) => _finish(
    () => ref.read(captureControllerProvider.notifier).correct(fields),
  );

  Future<void> _finish(Future<Capture?> Function() action) async {
    final messenger = ScaffoldMessenger.of(context);
    final result = await action();
    if (result != null && mounted) {
      context.pop();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Guardado como ${result.kind.label.toLowerCase()}.'),
          ),
        );
    }
  }

  Future<void> _discard() async {
    final result = await ref.read(captureControllerProvider.notifier).discard();
    if (result != null && mounted) {
      setState(() => _correcting = false);
      _textController.clear();
      ref.read(captureControllerProvider.notifier).startOver();
      _showMessage('Mensaje descartado. Puedes escribir otro.');
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(pendingSharedTextProvider, (_, next) {
      if (next == null) {
        return;
      }
      final text = ref.read(pendingSharedTextProvider.notifier).take();
      if (text != null) {
        _textController.text = text;
        setState(() => _correcting = false);
        ref.read(captureControllerProvider.notifier).startOver();
      }
    });
    final state = ref.watch(captureControllerProvider);
    final capture = state.capture;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KairoHeader(title: 'Capturar mensaje', onBack: () => context.pop()),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              KairoSpacing.page,
              KairoSpacing.md,
              KairoSpacing.page,
              KairoSpacing.xl,
            ),
            child: capture == null
                ? _input(context, state)
                : _review(context, state, capture),
          ),
        ),
      ],
    );
  }

  Widget _input(BuildContext context, CaptureState state) {
    final theme = Theme.of(context);
    final error = state.error;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Escribe o pega un aviso, por ejemplo de WhatsApp, y Kairo lo '
            'convierte en una actividad, un registro de tiempo o una meta.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: KairoSpacing.lg),
          TextFormField(
            controller: _textController,
            enabled: !state.busy,
            minLines: 6,
            maxLines: 10,
            maxLength: CaptureValidator.maxLength,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            validator: CaptureValidator.text,
            decoration: const InputDecoration(
              hintText:
                  'Ej. Entregar el reporte de redes el viernes antes de las 11',
              alignLabelWithHint: true,
            ),
          ),
          Row(
            children: [
              TextButton.icon(
                onPressed: state.busy ? null : _paste,
                icon: const Icon(Icons.content_paste),
                label: const Text('Pegar'),
              ),
              TextButton.icon(
                onPressed: state.busy ? null : _textController.clear,
                icon: const Icon(Icons.clear),
                label: const Text('Limpiar'),
              ),
            ],
          ),
          if (error != null) ...[
            const SizedBox(height: KairoSpacing.md),
            FormErrorMessage(message: error.message),
          ],
          if (error is ServiceUnavailableException) ...[
            const SizedBox(height: KairoSpacing.sm),
            OutlinedButton(
              onPressed: state.busy ? null : _openManual,
              child: const Text('Llenar formulario manual'),
            ),
          ],
          const SizedBox(height: KairoSpacing.lg),
          FilledButton(
            onPressed: state.busy ? null : _submit,
            child: Text(state.busy ? 'Interpretando…' : 'Interpretar mensaje'),
          ),
        ],
      ),
    );
  }

  Widget _review(BuildContext context, CaptureState state, Capture capture) {
    final error = state.error;
    final message = error == null
        ? null
        : Padding(
            padding: const EdgeInsets.only(top: KairoSpacing.md),
            child: FormErrorMessage(message: error.message),
          );

    if (_correcting) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CaptureCorrectionForm(
            capture: capture,
            busy: state.busy,
            onSave: _saveCorrection,
            onCancel: () => setState(() => _correcting = false),
          ),
          ?message,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CaptureReviewCard(capture: capture),
        ?message,
        const SizedBox(height: KairoSpacing.lg),
        FilledButton(
          onPressed: state.busy ? null : _confirm,
          child: const Text('Confirmar'),
        ),
        const SizedBox(height: KairoSpacing.sm),
        OutlinedButton(
          onPressed: state.busy
              ? null
              : () => setState(() => _correcting = true),
          child: const Text('Corregir'),
        ),
        const SizedBox(height: KairoSpacing.sm),
        TextButton(
          onPressed: state.busy ? null : _discard,
          child: const Text('Rechazar'),
        ),
      ],
    );
  }
}
