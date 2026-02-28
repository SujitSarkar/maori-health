import 'package:flutter/material.dart';

import 'package:maori_health/core/theme/app_colors.dart';
import 'package:maori_health/core/utils/extensions.dart';

class StatCard extends StatelessWidget {
  final String value;
  final String label;

  const StatCard({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Container(
      alignment: .center,
      padding: const .symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(color: AppColors.primary.withAlpha(150), borderRadius: .circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Text(value, style: textTheme.headlineMedium?.copyWith(fontWeight: .bold)),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(fontWeight: .w600),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
