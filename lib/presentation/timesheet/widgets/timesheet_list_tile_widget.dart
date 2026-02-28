import 'package:flutter/material.dart';

import 'package:maori_health/core/theme/app_colors.dart';
import 'package:maori_health/core/utils/color_utils.dart';
import 'package:maori_health/core/utils/date_converter.dart';
import 'package:maori_health/core/utils/extensions.dart';
import 'package:maori_health/domain/timesheet/entities/timesheet.dart';

class TimeSheetListTileWidget extends StatelessWidget {
  final TimeSheet timeSheet;

  const TimeSheetListTileWidget({super.key, required this.timeSheet});

  @override
  Widget build(BuildContext context) {
    final startDt = DateTime.tryParse(timeSheet.scheduleStartTime ?? '');
    final endDt = DateTime.tryParse(timeSheet.scheduleEndTime ?? '');

    final dayDate = startDt != null ? DateConverter.toWeekMonthDay(startDt) : '-';
    final startTime = startDt != null ? DateConverter.toDisplayTime(startDt) : '-';
    final endTime = endDt != null ? DateConverter.toDisplayTime(endDt) : '-';

    final totalHours = timeSheet.scheduleTotalTime;
    final hoursLabel = totalHours == totalHours.toInt() ? '${totalHours.toInt()}H' : '${totalHours}H';

    final jobType = (timeSheet.jobType ?? '').toUpperCase();

    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: .circular(12),
        border: .all(color: context.theme.dividerColor),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: ColorUtils.hexToColor(timeSheet.color) ?? AppColors.primary,
                borderRadius: const .only(topLeft: .circular(12), bottomLeft: .circular(12)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const .all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(dayDate, style: context.textTheme.titleSmall?.copyWith(fontWeight: .w700)),
                              ),
                              const SizedBox(width: 8),
                              _StatusBadge(status: timeSheet.status),
                              const SizedBox(width: 8),
                              Text(hoursLabel, style: context.textTheme.titleLarge?.copyWith(fontWeight: .w700)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$startTime - $endTime',
                            style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                          ),
                          if (jobType.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(jobType, style: context.textTheme.bodyMedium?.copyWith(fontWeight: .w700)),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: .circular(20),
        border: .all(color: context.theme.dividerColor),
      ),
      child: Text(
        status,
        style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.onSurfaceVariant, fontSize: 10),
      ),
    );
  }
}
