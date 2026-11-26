import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/router/app_section.dart';
import 'package:kairo/core/widgets/kairo_bottom_nav.dart';
import 'package:kairo/features/capture/presentation/widgets/shared_text_gate.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SharedTextGate(child: navigationShell),
      ),
      bottomNavigationBar: KairoBottomNav(
        items: [
          for (final section in AppSection.values)
            KairoNavItem(label: section.label, icon: section.icon),
        ],
        currentIndex: navigationShell.currentIndex,
        onSelected: _onSelected,
      ),
    );
  }
}
