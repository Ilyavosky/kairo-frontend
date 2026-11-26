import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

abstract interface class SharedTextSource {
  Future<String?> initial();

  Stream<String> incoming();

  Future<void> reset();
}

class DeviceSharedTextSource implements SharedTextSource {
  const DeviceSharedTextSource();

  @override
  Future<String?> initial() async {
    try {
      final files = await ReceiveSharingIntent.instance.getInitialMedia();
      return _textOf(files);
    } on Exception {
      return null;
    }
  }

  @override
  Stream<String> incoming() => ReceiveSharingIntent.instance
      .getMediaStream()
      .handleError((Object _) {})
      .map(_textOf)
      .where((text) => text != null)
      .cast<String>();

  @override
  Future<void> reset() async {
    try {
      await ReceiveSharingIntent.instance.reset();
    } on Exception {
      return;
    }
  }

  String? _textOf(List<SharedMediaFile> files) {
    for (final file in files) {
      if (file.type == SharedMediaType.text ||
          file.type == SharedMediaType.url) {
        final text = file.path.trim();
        if (text.isNotEmpty) {
          return text;
        }
      }
    }
    return null;
  }
}

final sharedTextSourceProvider = Provider<SharedTextSource>(
  (ref) => const DeviceSharedTextSource(),
);

class PendingSharedText extends Notifier<String?> {
  @override
  String? build() => null;

  String? get text => state;

  set text(String? value) => state = value;

  String? take() {
    final text = state;
    state = null;
    return text;
  }
}

final pendingSharedTextProvider = NotifierProvider<PendingSharedText, String?>(
  PendingSharedText.new,
);
