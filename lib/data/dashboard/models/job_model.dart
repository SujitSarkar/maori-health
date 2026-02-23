import 'dart:convert';

import 'package:maori_health/domain/dashboard/entities/job.dart';

class JobModel extends Job {
  const JobModel({
    required super.id,
    required super.jobListId,
    required super.jobDayId,
    required super.assigneeUserId,
    required super.clientUserId,
    super.funderId,
    super.scheduleStartTime,
    super.scheduleEndTime,
    super.workStartTime,
    super.workEndTime,
    super.scheduleTotalTime,
    super.workTotalTime,
    super.day,
    super.jobType,
    super.payHour,
    super.travelType,
    super.travelTime,
    super.travelDistance,
    super.visitType,
    super.batchCreatedAt,
    super.isChecked,
    super.confirmedAt,
    super.confirmedBy,
    super.status,
    super.isHoliday,
    super.cancelDateTime,
    super.cancelledBy,
    super.cancelReason,
    super.cancelNote,
    super.ibtEtApply,
    super.payableCancelled,
    super.cancelRequestedAt,
    super.operatorId,
    super.color,
    super.childColors,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] as int,
      jobListId: json['job_list_id'] as int,
      jobDayId: json['job_day_id'] as int,
      assigneeUserId: json['assignee_user_id'] as int,
      clientUserId: json['client_user_id'] as int,
      funderId: json['funder_id'] as int?,
      scheduleStartTime: json['schedule_start_time'] as String?,
      scheduleEndTime: json['schedule_end_time'] as String?,
      workStartTime: json['work_start_time'] as String?,
      workEndTime: json['work_end_time'] as String?,
      scheduleTotalTime: (json['schedule_total_time'] as num?)?.toDouble() ?? 0,
      workTotalTime: (json['work_total_time'] as num?)?.toDouble() ?? 0,
      day: json['day'] as String?,
      jobType: json['job_type'] as String?,
      payHour: (json['pay_hour'] as num?)?.toDouble() ?? 0,
      travelType: json['travel_type'] as String?,
      travelTime: json['travel_time']?.toString(),
      travelDistance: json['travel_distance']?.toString(),
      visitType: json['visit_type'] as String?,
      batchCreatedAt: json['batch_created_at'] as String?,
      isChecked: json['is_checked'] as int? ?? 0,
      confirmedAt: json['confirmed_at'] as String?,
      confirmedBy: json['confirmed_by']?.toString(),
      status: json['status'] as String?,
      isHoliday: json['is_holiday'] as int? ?? 0,
      cancelDateTime: json['cancel_date_time'] as String?,
      cancelledBy: json['cancelled_by']?.toString(),
      cancelReason: json['cancel_reason'] as String?,
      cancelNote: json['cancel_note'] as String?,
      ibtEtApply: json['ibt_et_apply'] as int? ?? 0,
      payableCancelled: json['payable_cancelled'] as int? ?? 0,
      cancelRequestedAt: json['cancel_requested_at'] as String?,
      operatorId: json['operator_id'] as int?,
      color: json['color'] as String?,
      childColors: _parseChildColors(json['child_colors']),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }

  static List<String> _parseChildColors(dynamic value) {
    if (value == null) return [];
    if (value is List) return value.map((e) => e.toString()).toList();
    if (value is String) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is List) return decoded.map((e) => e.toString()).toList();
      } catch (_) {}
    }
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job_list_id': jobListId,
      'job_day_id': jobDayId,
      'assignee_user_id': assigneeUserId,
      'client_user_id': clientUserId,
      'funder_id': funderId,
      'schedule_start_time': scheduleStartTime,
      'schedule_end_time': scheduleEndTime,
      'work_start_time': workStartTime,
      'work_end_time': workEndTime,
      'schedule_total_time': scheduleTotalTime,
      'work_total_time': workTotalTime,
      'day': day,
      'job_type': jobType,
      'pay_hour': payHour,
      'travel_type': travelType,
      'travel_time': travelTime,
      'travel_distance': travelDistance,
      'visit_type': visitType,
      'batch_created_at': batchCreatedAt,
      'is_checked': isChecked,
      'confirmed_at': confirmedAt,
      'confirmed_by': confirmedBy,
      'status': status,
      'is_holiday': isHoliday,
      'cancel_date_time': cancelDateTime,
      'cancelled_by': cancelledBy,
      'cancel_reason': cancelReason,
      'cancel_note': cancelNote,
      'ibt_et_apply': ibtEtApply,
      'payable_cancelled': payableCancelled,
      'cancel_requested_at': cancelRequestedAt,
      'operator_id': operatorId,
      'color': color,
      'child_colors': childColors,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
