import 'dart:async';

import 'package:kairo/features/capture/data/capture_api.dart';
import 'package:kairo/features/capture/data/models/capture.dart';

class FakeCaptureApi implements CaptureApi {
  FakeCaptureApi({this.proposal, this.createError, this.hold});

  final Capture? proposal;
  final Exception? createError;
  final Completer<void>? hold;
  final List<String> sentTexts = [];
  final List<String> confirmed = [];
  final List<String> discarded = [];
  final Map<String, Map<String, dynamic>> corrections = {};

  @override
  Future<Capture> create(String text) async {
    sentTexts.add(text);
    final wait = hold;
    if (wait != null) {
      await wait.future;
    }
    final error = createError;
    if (error != null) {
      throw error;
    }
    return proposal!.copyWith(message: text);
  }

  @override
  Future<Capture> confirm(String id) async {
    confirmed.add(id);
    return proposal!.copyWith(status: 'aceptada', resultId: 'resultado-1');
  }

  @override
  Future<Capture> correct(String id, Map<String, dynamic> fields) async {
    corrections[id] = fields;
    return proposal!.copyWith(status: 'corregida', resultId: 'resultado-1');
  }

  @override
  Future<Capture> discard(String id) async {
    discarded.add(id);
    return proposal!.copyWith(status: 'descartada');
  }
}
