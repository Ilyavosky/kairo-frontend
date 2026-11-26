import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/features/capture/data/shared_text_source.dart';

class SharedTextGate extends ConsumerStatefulWidget {
  const SharedTextGate({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<SharedTextGate> createState() => _SharedTextGateState();
}

class _SharedTextGateState extends ConsumerState<SharedTextGate> {
  StreamSubscription<String>? _subscription;

  @override
  void initState() {
    super.initState();
    final source = ref.read(sharedTextSourceProvider);
    _subscription = source.incoming().listen(_open);
    unawaited(source.initial().then(_openIfAny));
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    super.dispose();
  }

  void _openIfAny(String? text) {
    if (text != null) {
      _open(text);
    }
  }

  void _open(String text) {
    if (!mounted) {
      return;
    }
    ref.read(pendingSharedTextProvider.notifier).text = text;
    unawaited(ref.read(sharedTextSourceProvider).reset());
    context.go(AppRoutes.capture);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
