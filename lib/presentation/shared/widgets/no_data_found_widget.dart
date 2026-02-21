import 'package:flutter/material.dart';

import 'package:maori_health/core/utils/extensions.dart';

class NoDataFoundWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final double iconSize;

  const NoDataFoundWidget({super.key, required this.message, this.icon = Icons.inbox_outlined, this.iconSize = 48});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Center(
      child: Column(
        mainAxisSize: .min,
        children: [
          Icon(icon, size: iconSize, color: theme.hintColor),
          const SizedBox(height: 12),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
            textAlign: .center,
          ),
        ],
      ),
    );
  }
}
