part of 'schedule_bloc.dart';

sealed class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object?> get props => [];
}

class SchedulesLoadEvent extends ScheduleEvent {
  final int? clientUserId;
  final String? startDate;
  final String? endDate;

  const SchedulesLoadEvent({this.clientUserId, this.startDate, this.endDate});

  @override
  List<Object?> get props => [clientUserId, startDate, endDate];
}

class SchedulesLoadMoreEvent extends ScheduleEvent {
  final int? clientUserId;
  final String? startDate;
  final String? endDate;

  const SchedulesLoadMoreEvent({this.clientUserId, this.startDate, this.endDate});

  @override
  List<Object?> get props => [clientUserId, startDate, endDate];
}

class ScheduleDetailsLoadEvent extends ScheduleEvent {
  final int scheduleId;

  const ScheduleDetailsLoadEvent({required this.scheduleId});

  @override
  List<Object> get props => [scheduleId];
}

class ScheduleAcceptEvent extends ScheduleEvent {
  final int scheduleId;

  const ScheduleAcceptEvent({required this.scheduleId});

  @override
  List<Object> get props => [scheduleId];
}

class ScheduleStartEvent extends ScheduleEvent {
  final int scheduleId;

  const ScheduleStartEvent({required this.scheduleId});

  @override
  List<Object> get props => [scheduleId];
}

class ScheduleFinishEvent extends ScheduleEvent {
  final int scheduleId;

  const ScheduleFinishEvent({required this.scheduleId});

  @override
  List<Object> get props => [scheduleId];
}

class ScheduleCancelEvent extends ScheduleEvent {
  final int scheduleId;
  final String cancelBy;
  final String reason;
  final String? reasonType;
  final int hour;
  final int minute;

  const ScheduleCancelEvent({
    required this.scheduleId,
    required this.cancelBy,
    required this.reason,
    this.reasonType,
    required this.hour,
    required this.minute,
  });
  @override
  List<Object?> get props => [scheduleId, cancelBy, reason, reasonType, hour, minute];
}
