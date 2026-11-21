import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/auth/data/timezone_source.dart';
import 'package:kairo/features/auth/domain/timezone_label.dart';

final availableTimezonesProvider = FutureProvider<List<String>>(
  (ref) => ref.watch(timezoneSourceProvider).available(),
);

Future<String?> showTimezonePicker(BuildContext context, String selected) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => TimezonePickerSheet(selected: selected),
  );
}

class TimezonePickerSheet extends ConsumerStatefulWidget {
  const TimezonePickerSheet({required this.selected, super.key});

  final String selected;

  @override
  ConsumerState<TimezonePickerSheet> createState() =>
      _TimezonePickerSheetState();
}

class _TimezonePickerSheetState extends ConsumerState<TimezonePickerSheet> {
  var _query = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timezones = ref.watch(availableTimezonesProvider);

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.75,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KairoSpacing.page,
              ),
              child: Text('Zona horaria', style: theme.textTheme.titleLarge),
            ),
            const SizedBox(height: KairoSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KairoSpacing.page,
              ),
              child: TextField(
                onChanged: (value) => setState(() => _query = value),
                decoration: const InputDecoration(
                  hintText: 'Buscar ciudad o región',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: KairoSpacing.sm),
            Expanded(
              child: switch (timezones) {
                AsyncData(:final value) => _TimezoneList(
                  timezones: [
                    for (final timezone in value)
                      if (TimezoneLabel.matches(timezone, _query)) timezone,
                  ],
                  selected: widget.selected,
                ),
                AsyncError() => const Center(
                  child: Text('No pudimos cargar las zonas horarias.'),
                ),
                _ => const Center(child: CircularProgressIndicator()),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TimezoneList extends StatelessWidget {
  const _TimezoneList({required this.timezones, required this.selected});

  final List<String> timezones;
  final String selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (timezones.isEmpty) {
      return const Center(child: Text('No hay zonas que coincidan.'));
    }

    return ListView.builder(
      itemCount: timezones.length,
      itemBuilder: (context, index) {
        final timezone = timezones[index];
        final isSelected = timezone == selected;
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: KairoSpacing.page,
          ),
          selected: isSelected,
          selectedTileColor: scheme.secondary.withValues(alpha: 0.08),
          title: Text(TimezoneLabel.city(timezone)),
          subtitle: Text(timezone),
          trailing: isSelected
              ? Icon(Icons.check, color: scheme.primary)
              : null,
          onTap: () => Navigator.of(context).pop(timezone),
        );
      },
    );
  }
}
