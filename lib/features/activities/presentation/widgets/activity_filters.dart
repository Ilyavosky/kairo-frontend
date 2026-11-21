import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';
import 'package:kairo/features/activities/presentation/controllers/activities_controller.dart';
import 'package:kairo/features/subjects/data/models/subject.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';

class ActivityFilters extends ConsumerWidget {
  const ActivityFilters({super.key});

  Future<void> _pickSubject(
    BuildContext context,
    WidgetRef ref,
    List<Subject> subjects,
    String? selected,
  ) async {
    final result = await showModalBottomSheet<_SubjectChoice>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            _SubjectTile(
              label: 'Todas las materias',
              selected: selected == null,
              onTap: () =>
                  Navigator.of(context).pop(const _SubjectChoice(null)),
            ),
            for (final subject in subjects)
              _SubjectTile(
                label: subject.name,
                selected: selected == subject.id,
                onTap: () =>
                    Navigator.of(context).pop(_SubjectChoice(subject.id)),
              ),
          ],
        ),
      ),
    );
    if (result != null) {
      ref.read(activityFilterProvider.notifier).setSubject(result.subjectId);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(activityFilterProvider);
    final subjects = ref.watch(subjectsProvider).value ?? const <Subject>[];
    final controller = ref.read(activityFilterProvider.notifier);

    String? subjectName;
    for (final subject in subjects) {
      if (subject.id == filter.subjectId) {
        subjectName = subject.name;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: KairoSpacing.page),
          child: Row(
            children: [
              _StatusChip(
                label: 'Todas',
                selected: filter.status == null,
                onSelected: () => controller.setStatus(null),
              ),
              for (final status in ActivityStatus.filters)
                _StatusChip(
                  label: status.filterLabel,
                  selected: filter.status == status,
                  onSelected: () => controller.setStatus(status),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            KairoSpacing.page - KairoSpacing.sm,
            KairoSpacing.xs,
            KairoSpacing.page,
            0,
          ),
          child: TextButton.icon(
            onPressed: () =>
                _pickSubject(context, ref, subjects, filter.subjectId),
            icon: const Icon(Icons.menu_book, size: 18),
            label: Text(subjectName ?? 'Todas las materias'),
          ),
        ),
      ],
    );
  }
}

class _SubjectChoice {
  const _SubjectChoice(this.subjectId);

  final String? subjectId;
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(right: KairoSpacing.sm),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        showCheckmark: false,
        onSelected: (_) => onSelected(),
        selectedColor: scheme.primary,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
        ),
        side: BorderSide(color: selected ? scheme.primary : scheme.outline),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(
          horizontal: KairoSpacing.sm,
          vertical: KairoSpacing.sm,
        ),
      ),
    );
  }
}

class _SubjectTile extends StatelessWidget {
  const _SubjectTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: KairoSpacing.page),
      title: Text(label),
      selected: selected,
      trailing: selected ? Icon(Icons.check, color: scheme.primary) : null,
      onTap: onTap,
    );
  }
}
