import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/features/time_tracking/presentation/controllers/timer_controller.dart';
import 'package:kairo/features/time_tracking/presentation/widgets/timer_panel.dart';

class TimeScreen extends ConsumerStatefulWidget {
  const TimeScreen({super.key});

  @override
  ConsumerState<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends ConsumerState<TimeScreen> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onResume: () => ref.read(timerControllerProvider.notifier).refresh(),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KairoHeader(title: 'Tiempo'),
        Expanded(child: TimerPanel()),
      ],
    );
  }
}
