import 'package:flutter/material.dart';

import 'package:maori_health/core/utils/date_converter.dart';
import 'package:maori_health/core/utils/extensions.dart';

class NotificationTile extends StatelessWidget {
  final String message;
  final int? jobId;
  final DateTime dateTime;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationTile({
    super.key,
    required this.message,
    this.jobId,
    required this.dateTime,
    required this.isRead,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isRead ? context.theme.cardColor : context.theme.colorScheme.primary.withAlpha(30),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.theme.dividerColor),
        ),
        child: Row(
          crossAxisAlignment: .center,
          children: [
            Icon(Icons.notifications_none, size: 22, color: context.colorScheme.primary.withAlpha(180)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text('$message - ', style: context.textTheme.bodyMedium),
                  if (jobId != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      '#$jobId',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                DateConverter.timeAgo(dateTime),
                style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
