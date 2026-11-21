import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/confirm_dialog.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/core/widgets/form_error_message.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/core/widgets/kairo_text_field.dart';
import 'package:kairo/features/subjects/data/models/subject.dart';
import 'package:kairo/features/subjects/data/models/subject_input.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';
import 'package:kairo/features/subjects/domain/subject_validator.dart';
import 'package:kairo/features/subjects/presentation/controllers/subject_form_controller.dart';

class SubjectFormScreen extends ConsumerWidget {
  const SubjectFormScreen({this.subjectId, super.key});

  final String? subjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = subjectId;
    final title = id == null ? 'Nueva materia' : 'Editar materia';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KairoHeader(title: title, onBack: () => context.pop()),
        Expanded(
          child: id == null
              ? const _SubjectForm()
              : switch (ref.watch(subjectsProvider)) {
                  AsyncData(:final value) => _findSubject(value, id),
                  AsyncError(:final error) => ErrorView(
                    message: toAppException(error).message,
                    onRetry: () => ref.invalidate(subjectsProvider),
                  ),
                  _ => const Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Cargando',
                    ),
                  ),
                },
        ),
      ],
    );
  }
}

Widget _findSubject(List<Subject> subjects, String id) {
  for (final subject in subjects) {
    if (subject.id == id) {
      return _SubjectForm(subject: subject);
    }
  }
  return const Center(child: Text('Esta materia ya no está disponible.'));
}

class _SubjectForm extends ConsumerStatefulWidget {
  const _SubjectForm({this.subject});

  final Subject? subject;

  @override
  ConsumerState<_SubjectForm> createState() => _SubjectFormState();
}

class _SubjectFormState extends ConsumerState<_SubjectForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _codeController;
  late final TextEditingController _teacherController;
  late final TextEditingController _periodController;

  @override
  void initState() {
    super.initState();
    final subject = widget.subject;
    _nameController = TextEditingController(text: subject?.name);
    _codeController = TextEditingController(text: subject?.code);
    _teacherController = TextEditingController(text: subject?.teacher);
    _periodController = TextEditingController(text: subject?.period);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _teacherController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final saved = await ref
        .read(subjectFormControllerProvider.notifier)
        .save(
          subjectId: widget.subject?.id,
          input: SubjectInput(
            name: _nameController.text.trim(),
            period: _periodController.text.trim(),
            code: SubjectValidator.clean(_codeController.text),
            teacher: SubjectValidator.clean(_teacherController.text),
          ),
        );
    if (saved && mounted) {
      context.pop();
    }
  }

  Future<void> _archive(Subject subject) async {
    final confirmed = await showConfirmDialog(
      context,
      title: '¿Archivar esta materia?',
      message:
          '${subject.name} dejará de aparecer en tu lista. '
          'Sus actividades no se borran.',
      confirmLabel: 'Archivar',
    );
    if (!confirmed || !mounted) {
      return;
    }
    final archived = await ref
        .read(subjectFormControllerProvider.notifier)
        .archive(subject.id);
    if (archived && mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final subject = widget.subject;
    final form = ref.watch(subjectFormControllerProvider);
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
            KairoTextField(
              label: 'Nombre',
              controller: _nameController,
              hint: 'Ej. Seguridad informática',
              icon: Icons.menu_book,
              textInputAction: TextInputAction.next,
              validator: SubjectValidator.name,
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            KairoTextField(
              label: 'Clave (opcional)',
              controller: _codeController,
              hint: 'Ej. SEG-701',
              icon: Icons.tag,
              textInputAction: TextInputAction.next,
              validator: SubjectValidator.optional,
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            KairoTextField(
              label: 'Docente (opcional)',
              controller: _teacherController,
              hint: 'Nombre del docente',
              icon: Icons.person,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: SubjectValidator.optional,
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            KairoTextField(
              label: 'Periodo',
              controller: _periodController,
              hint: 'Ej. Ago - Dic 2026',
              icon: Icons.date_range,
              textInputAction: TextInputAction.done,
              validator: SubjectValidator.period,
              onFieldSubmitted: (_) => _save(),
              enabled: !loading,
            ),
            if (error != null) ...[
              const SizedBox(height: KairoSpacing.lg),
              FormErrorMessage(message: error),
            ],
            const SizedBox(height: KairoSpacing.xl),
            FilledButton(
              onPressed: loading ? null : _save,
              child: loading
                  ? SizedBox.square(
                      dimension: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Theme.of(context).colorScheme.onPrimary,
                        semanticsLabel: 'Guardando',
                      ),
                    )
                  : Text(
                      subject == null ? 'Guardar materia' : 'Guardar cambios',
                    ),
            ),
            if (subject != null) ...[
              const SizedBox(height: KairoSpacing.md),
              OutlinedButton.icon(
                onPressed: loading ? null : () => _archive(subject),
                icon: const Icon(Icons.archive_outlined),
                label: const Text('Archivar materia'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
