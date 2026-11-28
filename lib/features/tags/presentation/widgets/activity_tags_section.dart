import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/tags/data/models/tag.dart';
import 'package:kairo/features/tags/domain/tag_validator.dart';
import 'package:kairo/features/tags/presentation/controllers/tags_controller.dart';

class ActivityTagsSection extends ConsumerWidget {
  const ActivityTagsSection({required this.activityId, super.key});

  final String activityId;

  static const _newTag = '__nueva__';

  void _showError(BuildContext context, WidgetRef ref) {
    final error = ref.read(activityTagsControllerProvider).error;
    if (error == null) {
      return;
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(toAppException(error).message)));
  }

  Future<void> _add(
    BuildContext context,
    WidgetRef ref,
    List<Tag> assigned,
  ) async {
    final all = await ref
        .read(tagsProvider.future)
        .catchError((Object _) => const <Tag>[]);
    if (!context.mounted) {
      return;
    }
    final assignedIds = {for (final tag in assigned) tag.id};
    final available = [
      for (final tag in all)
        if (!assignedIds.contains(tag.id)) tag,
    ];
    final choice = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.6,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              for (final tag in available)
                ListTile(
                  leading: const Icon(Icons.sell_outlined),
                  title: Text(tag.name),
                  onTap: () => Navigator.of(context).pop(tag.id),
                ),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Crear etiqueta nueva'),
                onTap: () => Navigator.of(context).pop(_newTag),
              ),
            ],
          ),
        ),
      ),
    );
    if (choice == null || !context.mounted) {
      return;
    }
    final controller = ref.read(activityTagsControllerProvider.notifier);
    if (choice == _newTag) {
      final name = await _askName(context);
      if (name == null || !context.mounted) {
        return;
      }
      final done = await controller.createAndAssign(activityId, name);
      if (!done && context.mounted) {
        _showError(context, ref);
      }
      return;
    }
    final done = await controller.assign(activityId, choice);
    if (!done && context.mounted) {
      _showError(context, ref);
    }
  }

  Future<String?> _askName(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nueva etiqueta'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            autofocus: true,
            maxLength: TagValidator.nameMaxLength,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(hintText: 'Ej. Urgente'),
            validator: TagValidator.name,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                Navigator.of(context).pop(controller.text.trim());
              }
            },
            style: FilledButton.styleFrom(
              minimumSize: const Size(0, KairoSpacing.touchTarget),
            ),
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }

  Future<void> _remove(BuildContext context, WidgetRef ref, Tag tag) async {
    final done = await ref
        .read(activityTagsControllerProvider.notifier)
        .remove(activityId, tag.id);
    if (!done && context.mounted) {
      _showError(context, ref);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final tags = ref.watch(activityTagsProvider(activityId));
    final busy = ref.watch(activityTagsControllerProvider).isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Etiquetas',
          style: theme.textTheme.titleSmall?.copyWith(fontSize: 16),
        ),
        const SizedBox(height: KairoSpacing.sm),
        switch (tags) {
          AsyncData(:final value) => Wrap(
            spacing: KairoSpacing.sm,
            runSpacing: KairoSpacing.sm,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (final tag in value)
                InputChip(
                  label: Text(tag.name),
                  onDeleted: busy ? null : () => _remove(context, ref, tag),
                  deleteButtonTooltipMessage: 'Quitar ${tag.name}',
                ),
              TextButton.icon(
                onPressed: busy ? null : () => _add(context, ref, value),
                icon: const Icon(Icons.add),
                label: const Text('Agregar etiqueta'),
              ),
            ],
          ),
          AsyncError(:final error) => Row(
            children: [
              Expanded(
                child: Text(
                  toAppException(error).message,
                  style: theme.textTheme.bodySmall,
                ),
              ),
              TextButton(
                onPressed: () =>
                    ref.invalidate(activityTagsProvider(activityId)),
                child: const Text('Reintentar'),
              ),
            ],
          ),
          _ => const Align(
            alignment: Alignment.centerLeft,
            child: SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                semanticsLabel: 'Cargando etiquetas',
              ),
            ),
          ),
        },
      ],
    );
  }
}
