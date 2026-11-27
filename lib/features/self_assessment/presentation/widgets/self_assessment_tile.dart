import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/self_assessment/data/models/self_assessment.dart';
import 'package:kairo/features/self_assessment/domain/self_assessment_scale.dart';
import 'package:kairo/features/self_assessment/domain/week.dart';

class SelfAssessmentTile extends StatelessWidget {
  const SelfAssessmentTile({
    required this.assessment,
    required this.onTap,
    super.key,
  });

  final SelfAssessment assessment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final note = assessment.note;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(KairoSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Week.label(assessment.weekStart),
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: KairoSpacing.xs),
                    Text(
                      SelfAssessmentScale.summary(
                        assessment.mood,
                        assessment.satisfaction,
                      ),
                      style: theme.textTheme.bodySmall,
                    ),
                    if (note != null && note.isNotEmpty) ...[
                      const SizedBox(height: KairoSpacing.xs),
                      Text(
                        note,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
