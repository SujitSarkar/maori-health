import 'package:flutter/material.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/core/theme/app_colors.dart';
import 'package:maori_health/core/utils/extensions.dart';

class JobCard extends StatelessWidget {
  final String date;
  final String title;
  final String address;
  final String? startedAt;
  final String startTime;
  final String endTime;
  final String totalHours;
  final bool isActive;

  const JobCard({
    super.key,
    required this.date,
    required this.title,
    required this.address,
    this.startedAt,
    required this.startTime,
    required this.endTime,
    required this.totalHours,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(30),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(date, style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500)),
              ),
              if (isActive == true)
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: isActive ? AppColors.success : Colors.grey),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(address, style: textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
              if (startedAt != null)
                Text(
                  '${StringConstants.startedAt} : $startedAt',
                  style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _TimeColumn(label: StringConstants.startTime, value: startTime),
              const SizedBox(width: 24),
              _TimeColumn(label: StringConstants.endTime, value: endTime),
              const Spacer(),
              _TimeColumn(label: StringConstants.totalHours, value: totalHours),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeColumn extends StatelessWidget {
  final String label;
  final String value;

  const _TimeColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: 2),
        Text(value, style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
