import 'package:flutter/material.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/features/goals/presentation/widgets/active_goals_panel.dart';
import 'package:kairo/features/goals/presentation/widgets/goal_history_panel.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          KairoHeader(title: 'Metas'),
          TabBar(
            tabs: [
              Tab(text: 'Activas'),
              Tab(text: 'Historial'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [ActiveGoalsPanel(), GoalHistoryPanel()],
            ),
          ),
        ],
      ),
    );
  }
}
