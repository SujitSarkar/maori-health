import 'package:equatable/equatable.dart';

import 'package:maori_health/domain/employee/entities/employee.dart';

abstract class TimeSheetEvent extends Equatable {
  const TimeSheetEvent();

  @override
  List<Object?> get props => [];
}

class TimeSheetDateAndEmployeeChanged extends TimeSheetEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  final Employee? employee;

  const TimeSheetDateAndEmployeeChanged({this.startDate, this.endDate, this.employee});

  @override
  List<Object?> get props => [startDate, endDate, employee];
}

class TimeSheetLoadMore extends TimeSheetEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  final Employee? employee;
  const TimeSheetLoadMore({this.startDate, this.endDate, this.employee});

  @override
  List<Object?> get props => [startDate, endDate, employee];
}
