import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/features/reminders/presentation/widgets/reminders_list.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          KairoHeader(title: 'Recordatorios', onBack: () => context.pop()),
          const TabBar(
            tabs: [
              Tab(text: 'Próximos'),
              Tab(text: 'Enviados'),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                const Positioned.fill(
                  child: TabBarView(
                    children: [
                      RemindersList(upcoming: true),
                      RemindersList(upcoming: false),
                    ],
                  ),
                ),
                Positioned(
                  right: KairoSpacing.page,
                  bottom: KairoSpacing.lg,
                  child: FloatingActionButton(
                    onPressed: () => context.go(AppRoutes.newReminder),
                    tooltip: 'Nuevo recordatorio',
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
