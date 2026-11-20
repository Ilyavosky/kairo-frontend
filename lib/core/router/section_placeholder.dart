import 'package:flutter/material.dart';
import 'package:kairo/core/router/app_section.dart';
import 'package:kairo/core/widgets/kairo_header.dart';

class SectionPlaceholder extends StatelessWidget {
  const SectionPlaceholder({required this.section, super.key});

  final AppSection section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [KairoHeader(title: section.label)],
    );
  }
}
