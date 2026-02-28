import 'package:equatable/equatable.dart';
import 'package:maori_health/domain/timesheet/entities/timesheet.dart';

class TimeSheetResponse extends Equatable {
  final List<TimeSheet> timeSheets;
  final int currentPage;
  final int lastPage;
  final int totalSchedules;
  final double totalTime;

  const TimeSheetResponse({
    required this.timeSheets,
    required this.currentPage,
    required this.lastPage,
    required this.totalSchedules,
    required this.totalTime,
  });

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [timeSheets, currentPage, lastPage, totalSchedules, totalTime];
}
