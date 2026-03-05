import 'package:flutter/material.dart';

import 'package:maori_health/core/config/app_strings.dart';
import 'package:maori_health/core/enums/schedule.enum.dart';
import 'package:maori_health/core/utils/extensions.dart';

import 'package:maori_health/presentation/schedule/pages/schedule_page.dart';
import 'package:maori_health/presentation/shared/decorations/outline_input_decoration.dart';

class ScheduleHeaderWidget extends StatelessWidget {
  final Function(ScheduleFilter value) onFilterChanged;
  final ScheduleFilter selectedFilter;
  const ScheduleHeaderWidget({super.key, required this.onFilterChanged, required this.selectedFilter});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: const .fromLTRB(12, 12, 12, 0),
      child: Row(
        crossAxisAlignment: .center,
        children: [
          Expanded(
            flex: 3,
            child: Text(AppStrings.schedule, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: .bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 40,
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<ScheduleFilter>(
                  initialValue: selectedFilter,
                  items: scheduleFilters
                      .map(
                        (ScheduleFilter value) =>
                            DropdownMenuItem<ScheduleFilter>(value: value, child: Text(value.value)),
                      )
                      .toList(),
                  onChanged: (ScheduleFilter? value) => onFilterChanged(value ?? ScheduleFilter.daily),
                  decoration: OutlineInputDecoration(
                    context: context,
                    hintText: AppStrings.select,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
