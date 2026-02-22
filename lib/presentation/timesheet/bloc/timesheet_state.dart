import 'package:equatable/equatable.dart';

import 'package:maori_health/domain/timesheet/entities/timesheet.dart';

abstract class TimeSheetState extends Equatable {
  const TimeSheetState();

  @override
  List<Object?> get props => [];
}

class TimeSheetLoadingState extends TimeSheetState {
  const TimeSheetLoadingState();
}

class TimeSheetLoadedState extends TimeSheetState {
  final List<TimeSheet> timeSheets;
  final int currentPage;
  final int lastPage;
  final int totalSchedules;
  final double totalTime;
  final bool isLoadingMore;

  const TimeSheetLoadedState({
    required this.timeSheets,
    required this.currentPage,
    required this.lastPage,
    required this.totalSchedules,
    required this.totalTime,
    this.isLoadingMore = false,
  });

  bool get hasMore => currentPage < lastPage;

  TimeSheetLoadedState copyWith({
    List<TimeSheet>? timeSheets,
    int? currentPage,
    int? lastPage,
    int? totalSchedules,
    double? totalTime,
    bool? isLoadingMore,
  }) {
    return TimeSheetLoadedState(
      timeSheets: timeSheets ?? this.timeSheets,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      totalSchedules: totalSchedules ?? this.totalSchedules,
      totalTime: totalTime ?? this.totalTime,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [timeSheets, currentPage, lastPage, totalSchedules, totalTime, isLoadingMore];
}

class TimeSheetErrorState extends TimeSheetState {
  final String errorMessage;

  const TimeSheetErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
