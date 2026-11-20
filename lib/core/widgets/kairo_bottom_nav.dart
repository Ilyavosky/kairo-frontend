import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';

class KairoNavItem {
  const KairoNavItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class KairoBottomNav extends StatelessWidget {
  const KairoBottomNav({
    required this.items,
    required this.currentIndex,
    required this.onSelected,
    super.key,
  });

  final List<KairoNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          KairoSpacing.page,
          0,
          KairoSpacing.page,
          KairoSpacing.md,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            border: Border.all(color: scheme.outlineVariant),
            borderRadius: BorderRadius.circular(KairoSpacing.radiusMd),
          ),
          child: SizedBox(
            height: KairoSpacing.navBarHeight,
            child: Row(
              children: [
                for (var index = 0; index < items.length; index++)
                  Expanded(
                    child: _NavButton(
                      item: items[index],
                      selected: index == currentIndex,
                      onTap: () => onSelected(index),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final KairoNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = selected ? scheme.primary : scheme.onSurfaceVariant;

    return Semantics(
      selected: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(KairoSpacing.radiusMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 22, color: color),
            const SizedBox(height: 6),
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
