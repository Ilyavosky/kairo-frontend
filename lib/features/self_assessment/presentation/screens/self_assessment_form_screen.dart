import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/core/widgets/form_error_message.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/core/widgets/kairo_text_field.dart';
import 'package:kairo/features/self_assessment/data/models/self_assessment.dart';
import 'package:kairo/features/self_assessment/data/models/self_assessment_input.dart';
import 'package:kairo/features/self_assessment/domain/self_assessment_scale.dart';
import 'package:kairo/features/self_assessment/domain/week.dart';
import 'package:kairo/features/self_assessment/presentation/controllers/self_assessment_controller.dart';
import 'package:kairo/features/self_assessment/presentation/widgets/scale_picker.dart';

class SelfAssessmentFormScreen extends ConsumerWidget {
  const SelfAssessmentFormScreen({
    required this.weekKey,
    this.initial,
    super.key,
  });

  final String weekKey;
  final SelfAssessment? initial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final week = Week.parse(weekKey);
    final assessments = ref.watch(selfAssessmentsProvider);
    SelfAssessment? existing;
    for (final item in assessments.value ?? const <SelfAssessment>[]) {
      if (week != null && Week.same(item.weekStart, week)) {
        existing = item;
      }
    }
    if (existing == null && week != null) {
      final fallback = initial;
      if (fallback != null && Week.same(fallback.weekStart, week)) {
        existing = fallback;
      }
    }
    final error = assessments.error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KairoHeader(
          title: existing == null ? 'Evaluar semana' : 'Editar evaluación',
          onBack: () => context.pop(),
        ),
        Expanded(
          child: week == null
              ? const Center(child: Text('Esta semana no es válida.'))
              : existing != null || assessments.hasValue
              ? _SelfAssessmentForm(week: week, existing: existing)
              : error != null
              ? ErrorView(
                  message: toAppException(error).message,
                  onRetry: () => ref.invalidate(selfAssessmentsProvider),
                )
              : const Center(
                  child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
                ),
        ),
      ],
    );
  }
}

class _SelfAssessmentForm extends ConsumerStatefulWidget {
  const _SelfAssessmentForm({required this.week, required this.existing});

  final DateTime week;
  final SelfAssessment? existing;

  @override
  ConsumerState<_SelfAssessmentForm> createState() =>
      _SelfAssessmentFormState();
}

class _SelfAssessmentFormState extends ConsumerState<_SelfAssessmentForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _noteController = TextEditingController(
    text: widget.existing?.note,
  );
  late int? _mood = widget.existing?.mood;
  late int? _satisfaction = widget.existing?.satisfaction;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    final mood = _mood;
    final satisfaction = _satisfaction;
    if (!(_formKey.currentState?.validate() ?? false) ||
        mood == null ||
        satisfaction == null) {
      return;
    }
    final note = _noteController.text.trim();
    final messenger = ScaffoldMessenger.of(context);
    final saved = await ref
        .read(selfAssessmentFormControllerProvider.notifier)
        .save(
          widget.week,
          SelfAssessmentInput(
            mood: mood,
            satisfaction: satisfaction,
            note: note.isEmpty ? null : note,
          ),
        );
    if (saved && mounted) {
      context.pop();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Autoevaluación guardada.')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final form = ref.watch(selfAssessmentFormControllerProvider);
    final loading = form.isLoading;
    final error = form.hasError && !loading
        ? toAppException(form.error!).message
        : null;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          KairoSpacing.page,
          KairoSpacing.md,
          KairoSpacing.page,
          KairoSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(Week.label(widget.week), style: theme.textTheme.titleMedium),
            if (widget.existing != null) ...[
              const SizedBox(height: KairoSpacing.xs),
              Text(
                'Ya evaluaste esta semana. Lo que cambies reemplaza tu '
                'evaluación anterior.',
                style: theme.textTheme.bodySmall,
              ),
            ],
            const SizedBox(height: KairoSpacing.xl),
            ScalePicker(
              label: 'Estado de ánimo',
              labels: SelfAssessmentScale.mood,
              value: _mood,
              enabled: !loading,
              onChanged: (value) => setState(() => _mood = value),
              validator: (value) => SelfAssessmentScale.level(
                value,
                'Elige cómo estuvo tu ánimo',
              ),
            ),
            const SizedBox(height: KairoSpacing.xl),
            ScalePicker(
              label: 'Satisfacción con tu semana',
              labels: SelfAssessmentScale.satisfaction,
              value: _satisfaction,
              enabled: !loading,
              onChanged: (value) => setState(() => _satisfaction = value),
              validator: (value) => SelfAssessmentScale.level(
                value,
                'Elige qué tan satisfecho estás',
              ),
            ),
            const SizedBox(height: KairoSpacing.xl),
            KairoTextField(
              label: 'Comentario (opcional)',
              controller: _noteController,
              hint: 'Qué salió bien, qué te costó trabajo…',
              minLines: 3,
              maxLines: 6,
              enabled: !loading,
              validator: SelfAssessmentScale.note,
            ),
            if (error != null) ...[
              const SizedBox(height: KairoSpacing.lg),
              FormErrorMessage(message: error),
            ],
            const SizedBox(height: KairoSpacing.xl),
            FilledButton(
              onPressed: loading ? null : _save,
              child: Text(loading ? 'Guardando…' : 'Guardar evaluación'),
            ),
          ],
        ),
      ),
    );
  }
}
