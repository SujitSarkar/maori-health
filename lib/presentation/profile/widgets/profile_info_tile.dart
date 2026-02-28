import 'package:flutter/material.dart';

import 'package:maori_health/core/utils/extensions.dart';

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Widget? trailing;

  const ProfileInfoTile({super.key, required this.icon, required this.label, this.value, this.trailing});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Padding(
      padding: const .symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: context.colorScheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Text(label, style: textTheme.bodyMedium),
          const Spacer(),
          if (trailing != null)
            trailing!
          else
            Text(value ?? '-', style: textTheme.bodyMedium?.copyWith(fontWeight: .w600)),
        ],
      ),
    );
  }
}
