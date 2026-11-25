import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kairo/features/time_tracking/domain/duration_format.dart';
import 'package:kairo/features/time_tracking/domain/running_timer.dart';

class ElapsedClock extends StatefulWidget {
  const ElapsedClock({required this.running, this.style, super.key});

  final RunningTimer running;
  final TextStyle? style;

  @override
  State<ElapsedClock> createState() => _ElapsedClockState();
}

class _ElapsedClockState extends State<ElapsedClock> {
  late final Timer _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = widget.running.elapsedAt(DateTime.now());
    return Text(
      DurationFormat.clock(elapsed),
      style: widget.style,
      semanticsLabel: 'Tiempo transcurrido ${DurationFormat.short(elapsed)}',
    );
  }
}
