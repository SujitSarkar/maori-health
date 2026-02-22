import 'package:equatable/equatable.dart';

import 'package:maori_health/domain/employee/entities/employee.dart';

class TimeSheet extends Equatable {
  final int id;
  final int? jobListId;
  final int? jobDayId;
  final int? assigneeUserId;
  final int? clientUserId;
  final int? funderId;
  final String? scheduleStartTime;
  final String? scheduleEndTime;
  final String? workStartTime;
  final String? workEndTime;
  final double scheduleTotalTime;
  final double workTotalTime;
  final String? day;
  final String? jobType;
  final double? payHour;
  final String? travelType;
  final double? travelTime;
  final double? travelDistance;
  final String? visitType;
  final String status;
  final int isHoliday;
  final String? color;
  final int? operatorId;
  final String? createdAt;
  final String? updatedAt;
  final Employee? client;
  final Employee? assignee;

  const TimeSheet({
    required this.id,
    this.jobListId,
    this.jobDayId,
    this.assigneeUserId,
    this.clientUserId,
    this.funderId,
    this.scheduleStartTime,
    this.scheduleEndTime,
    this.workStartTime,
    this.workEndTime,
    required this.scheduleTotalTime,
    this.workTotalTime = 0,
    this.day,
    this.jobType,
    this.payHour,
    this.travelType,
    this.travelTime,
    this.travelDistance,
    this.visitType,
    required this.status,
    this.isHoliday = 0,
    this.color,
    this.operatorId,
    this.createdAt,
    this.updatedAt,
    this.client,
    this.assignee,
  });

  @override
  List<Object?> get props => [id, scheduleStartTime, scheduleEndTime, status];
}
