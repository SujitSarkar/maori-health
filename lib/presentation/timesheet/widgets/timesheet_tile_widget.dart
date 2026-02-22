import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:maori_health/core/theme/app_colors.dart';
import 'package:maori_health/core/utils/extensions.dart';
import 'package:maori_health/domain/timesheet/entities/timesheet.dart';

class TimeSheetTileWidget extends StatelessWidget {
  final TimeSheet timeSheet;

  const TimeSheetTileWidget({super.key, required this.timeSheet});

  @override
  Widget build(BuildContext context) {
    final startDt = DateTime.tryParse(timeSheet.scheduleStartTime ?? '');
    final endDt = DateTime.tryParse(timeSheet.scheduleEndTime ?? '');

    final dayDate = startDt != null ? DateFormat('EEEE, MMM d').format(startDt) : '-';
    final startFormatted = startDt != null ? DateFormat('hh:mm a').format(startDt) : '-';
    final endFormatted = endDt != null ? DateFormat('hh:mm a').format(endDt) : '-';

    final hours = timeSheet.scheduleTotalTime;
    final hoursLabel = hours == hours.toInt() ? '${hours.toInt()}H' : '${hours}H';

    final jobType = (timeSheet.jobType ?? '').toUpperCase();

    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.theme.dividerColor),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: _parseColor(timeSheet.color) ?? AppColors.primary,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  dayDate,
                                  style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(width: 8),
                              _StatusBadge(status: timeSheet.status),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$startFormatted - $endFormatted',
                            style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                          ),
                          if (jobType.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(jobType, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                          ],
                          if (timeSheet.client != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              timeSheet.client!.fullName,
                              style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Text(hoursLabel, style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color? _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) return null;
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return null;
    }
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.theme.dividerColor),
      ),
      child: Text(
        status,
        style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.onSurfaceVariant, fontSize: 10),
      ),
    );
  }
}
