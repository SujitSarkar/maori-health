import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maori_health/core/di/injection.dart';
import 'package:maori_health/core/enums/schedule.enum.dart';
import 'package:maori_health/core/utils/date_converter.dart';
import 'package:maori_health/core/utils/schedule_utils.dart';
import 'package:maori_health/domain/client/entities/client.dart';

import 'package:maori_health/presentation/schedule/bloc/schedule_bloc.dart';
import 'package:maori_health/presentation/schedule/widgets/schedule_filter_widget.dart';
import 'package:maori_health/presentation/schedule/widgets/schedule_header_widget.dart';
import 'package:maori_health/presentation/shared/widgets/horizontal_week_calender.dart';

const List<ScheduleFilter> scheduleFilters = [ScheduleFilter.daily, ScheduleFilter.weekly, ScheduleFilter.client];

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => getIt<ScheduleBloc>(), child: _ScheduleView());
  }
}

class _ScheduleView extends StatefulWidget {
  const _ScheduleView();

  @override
  State<_ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<_ScheduleView> {
  final ValueNotifier<ScheduleFilter> selectedFilter = ValueNotifier(scheduleFilters.first);
  final ValueNotifier<Client?> selectedClient = ValueNotifier(null);
  final ValueNotifier<DateTime?> selectedDate = ValueNotifier(DateTime.now());
  final ValueNotifier<List<DateTime>> selectedWeek = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    selectedWeek.value = ScheduleUtils.getWeekDates(weekStartFrom: WeekStartFrom.monday);

    // Load initial schedules by Daily filter
    context.read<ScheduleBloc>().add(
      SchedulesLoadEvent(
        startDate: DateConverter.toIsoDate(selectedDate.value ?? DateTime.now()),
        endDate: DateConverter.toIsoDate(selectedDate.value ?? DateTime.now()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: selectedFilter,
              builder: (context, value, child) {
                return ScheduleHeaderWidget(
                  onFilterChanged: (ScheduleFilter filter) {
                    selectedDate.value = null;
                    selectedClient.value = null;
                    selectedWeek.value = [];
                    selectedFilter.value = filter;
                  },
                  selectedFilter: value,
                );
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<ScheduleBloc, ScheduleState>(
                builder: (context, state) {
                  return switch (state) {
                    ScheduleInitial() => const SizedBox.shrink(),
                    ScheduleLoadingState() => const SizedBox.shrink(),
                    ScheduleErrorState() => const SizedBox.shrink(),
                    ScheduleLoadedState() => ValueListenableBuilder(
                      valueListenable: selectedFilter,
                      builder: (context, value, child) {
                        return ScheduleFilterWidget(
                          selectedFilter: value,
                          onFilterChanged: (DateTime? date, List<DateTime> week, Client? client) {
                            selectedDate.value = date;
                            selectedWeek.value = week;
                            selectedClient.value = client;

                            print('date: ${date?.toIso8601String()}');
                            print('week: ${week.map((e) => e.toIso8601String()).join(', ')}');
                            print('client: ${client?.fullName}');
                          },
                        );
                      },
                    ),
                    _ => const SizedBox.shrink(),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
