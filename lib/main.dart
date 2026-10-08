import 'package:flutter/material.dart';

void main() => runApp(const KairoApp());

/// Root widget of the Kairo app (temporary base, replaced in T07).
class KairoApp extends StatelessWidget {
  /// Creates the root widget.
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Kairo'))),
    );
  }
}
