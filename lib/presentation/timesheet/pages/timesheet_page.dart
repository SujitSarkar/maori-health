import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/core/di/injection.dart';
import 'package:maori_health/core/utils/date_converter.dart';
import 'package:maori_health/core/utils/extensions.dart';

import 'package:maori_health/domain/employee/entities/employee.dart';

import 'package:maori_health/presentation/employee/bloc/bloc.dart';
import 'package:maori_health/presentation/employee/widgets/employee_tile_widget.dart';
import 'package:maori_health/presentation/shared/widgets/auto_complete_search_field.dart';
import 'package:maori_health/presentation/shared/widgets/common_app_bar.dart';
import 'package:maori_health/presentation/shared/widgets/error_view_widget.dart';
import 'package:maori_health/presentation/shared/widgets/loading_widget.dart';
import 'package:maori_health/presentation/shared/widgets/no_data_found_widget.dart';
import 'package:maori_health/presentation/shared/widgets/pagination_wrapper.dart';
import 'package:maori_health/presentation/shared/widgets/swipe_refresh_wrapper.dart';
import 'package:maori_health/presentation/timesheet/bloc/bloc.dart';
import 'package:maori_health/presentation/timesheet/widgets/timesheet_tile_widget.dart';
import 'package:maori_health/presentation/timesheet/widgets/timesheet_shimmer.dart';
import 'package:maori_health/presentation/timesheet/widgets/timesheet_summary_header.dart';

class TimeSheetPage extends StatelessWidget {
  const TimeSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TimeSheetBloc>()..add(const TimeSheetDateAndEmployeeChanged()),
      child: const _TimeSheetView(),
    );
  }
}

class _TimeSheetView extends StatefulWidget {
  const _TimeSheetView();

  @override
  State<_TimeSheetView> createState() => _TimeSheetViewState();
}

class _TimeSheetViewState extends State<_TimeSheetView> {
  DateTime? _startDate;
  DateTime? _endDate;
  Employee? _selectedEmployee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context: context, title: Text(StringConstants.timeSheets)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            children: [
              _FilterRow(
                startDate: _startDate,
                endDate: _endDate,
                selectedEmployee: _selectedEmployee,
                onDateRangeChanged: (start, end) {
                  setState(() {
                    _startDate = start;
                    _endDate = end;
                  });
                  context.read<TimeSheetBloc>().add(
                    TimeSheetDateAndEmployeeChanged(startDate: start, endDate: end, employee: _selectedEmployee),
                  );
                },
                onDateRangeCleared: () {
                  setState(() {
                    _startDate = null;
                    _endDate = null;
                  });
                  context.read<TimeSheetBloc>().add(TimeSheetDateAndEmployeeChanged(employee: _selectedEmployee));
                },
                onEmployeeChanged: (employee) {
                  setState(() => _selectedEmployee = employee);
                  context.read<TimeSheetBloc>().add(
                    TimeSheetDateAndEmployeeChanged(startDate: _startDate, endDate: _endDate, employee: employee),
                  );
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<TimeSheetBloc, TimeSheetState>(
                  builder: (context, state) {
                    return switch (state) {
                      TimeSheetLoadingState() => const TimeSheetShimmer(),
                      TimeSheetErrorState(:final errorMessage) => ErrorViewWidget(
                        message: errorMessage,
                        onRetry: () => context.read<TimeSheetBloc>().add(const TimeSheetDateAndEmployeeChanged()),
                      ),
                      TimeSheetLoadedState() => _buildContent(context, state),
                      _ => const SizedBox.shrink(),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<TimeSheetBloc>().add(
      TimeSheetDateAndEmployeeChanged(startDate: _startDate, endDate: _endDate, employee: _selectedEmployee),
    );
  }

  Widget _buildContent(BuildContext context, TimeSheetLoadedState state) {
    return Column(
      children: [
        TimeSheetSummaryHeader(totalHours: state.totalTime, totalAppointments: state.totalSchedules),
        const SizedBox(height: 16),
        Expanded(
          child: state.timeSheets.isEmpty
              ? SwipeRefreshWrapper(
                  onRefresh: () => _onRefresh(context),
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [SliverFillRemaining(child: NoDataFoundWidget(message: StringConstants.noDataFound))],
                  ),
                )
              : PaginationWrapper(
                  hasMore: state.hasMore,
                  isLoadingMore: state.isLoadingMore,
                  onLoadMore: () => context.read<TimeSheetBloc>().add(
                    TimeSheetLoadMore(startDate: _startDate, endDate: _endDate, employee: _selectedEmployee),
                  ),
                  child: SwipeRefreshWrapper(
                    onRefresh: () => _onRefresh(context),
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: state.timeSheets.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (_, index) => TimeSheetTileWidget(timeSheet: state.timeSheets[index]),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class _FilterRow extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Employee? selectedEmployee;
  final void Function(DateTime start, DateTime end) onDateRangeChanged;
  final VoidCallback onDateRangeCleared;
  final void Function(Employee? employee) onEmployeeChanged;

  const _FilterRow({
    required this.startDate,
    required this.endDate,
    required this.selectedEmployee,
    required this.onDateRangeChanged,
    required this.onDateRangeCleared,
    required this.onEmployeeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final hasDateRange = startDate != null && endDate != null;
    final dateRangeText = hasDateRange
        ? '${DateConverter.format(startDate!)} - ${DateConverter.format(endDate!)}'
        : StringConstants.selectDateRange;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _EmployeeAutoComplete(selectedEmployee: selectedEmployee, onSelected: onEmployeeChanged),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: () => _pickDateRange(context),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.theme.dividerColor),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(dateRangeText, style: context.textTheme.bodySmall, overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.calendar_today_outlined, size: 18, color: context.colorScheme.onSurfaceVariant),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickDateRange(BuildContext context) async {
    final now = DateTime.now();
    bool cleared = false;

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: now.add(const Duration(days: 365)),
      initialDateRange: (startDate != null && endDate != null) ? DateTimeRange(start: startDate!, end: endDate!) : null,
      saveText: StringConstants.apply,
      cancelText: StringConstants.clear,
      builder: (dialogContext, child) {
        return Theme(
          data: dialogContext.theme.copyWith(
            colorScheme: dialogContext.colorScheme.copyWith(primary: dialogContext.colorScheme.primary),
          ),
          child: Column(
            children: [
              Expanded(child: child!),
              if (startDate != null && endDate != null)
                SafeArea(
                  top: false,
                  child: Container(
                    width: double.infinity,
                    alignment: .center,
                    padding: const EdgeInsets.only(bottom: 8),
                    color: context.colorScheme.surface,
                    child: Center(
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: context.colorScheme.error,
                          foregroundColor: context.colorScheme.onError,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          cleared = true;
                          Navigator.of(dialogContext).pop();
                        },
                        icon: Icon(Icons.clear, size: 20),
                        label: Text(
                          StringConstants.clear,
                          style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onError),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );

    if (cleared) {
      onDateRangeCleared();
    } else if (picked != null) {
      onDateRangeChanged(picked.start, picked.end);
    }
  }
}

class _EmployeeAutoComplete extends StatelessWidget {
  final Employee? selectedEmployee;
  final void Function(Employee? employee) onSelected;

  const _EmployeeAutoComplete({this.selectedEmployee, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, employeeState) {
        final employees = employeeState is EmployeeLoadedState ? employeeState.employees : <Employee>[];
        final isLoading = employeeState is EmployeeLoadingState;

        return AutoCompleteSearchField<Employee>(
          items: employees,
          title: StringConstants.selectEmployee,
          searchHint: StringConstants.searchEmployee,
          initialQuery: selectedEmployee?.fullName,
          itemFilter: (employee, query) => employee.fullName.toLowerCase().contains(query.toLowerCase()),
          itemSorter: (a, b) => a.fullName.compareTo(b.fullName),
          itemBuilder: (employee) => EmployeeTileWidget(employee: employee),
          onSelected: onSelected,
          onClear: () {
            onSelected(null);
          },
          builder: (onTap) {
            return InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.theme.dividerColor),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: isLoading
                          ? const Center(child: SizedBox(height: 16, width: 16, child: LoadingWidget()))
                          : Text(
                              selectedEmployee?.fullName ?? StringConstants.employee,
                              style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: context.colorScheme.onSurface,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
                    Icon(Icons.keyboard_arrow_down, size: 20, color: context.colorScheme.onSurfaceVariant),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
