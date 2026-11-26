import 'dart:async';

import 'package:kairo/features/capture/data/shared_text_source.dart';

class FakeSharedTextSource implements SharedTextSource {
  FakeSharedTextSource({this.initialText});

  final String? initialText;
  final StreamController<String> _incoming = StreamController.broadcast();
  int resets = 0;

  void share(String text) => _incoming.add(text);

  @override
  Future<String?> initial() async => initialText;

  @override
  Stream<String> incoming() => _incoming.stream;

  @override
  Future<void> reset() async => resets++;
}
