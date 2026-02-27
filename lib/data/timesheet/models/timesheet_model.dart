import 'package:maori_health/data/employee/models/employee_model.dart';
import 'package:maori_health/domain/timesheet/entities/timesheet.dart';
import 'package:maori_health/core/utils/data_parse_util.dart';

class TimeSheetModel extends TimeSheet {
  const TimeSheetModel({
    required super.id,
    super.jobListId,
    super.jobDayId,
    super.assigneeUserId,
    super.clientUserId,
    super.funderId,
    super.scheduleStartTime,
    super.scheduleEndTime,
    super.workStartTime,
    super.workEndTime,
    required super.scheduleTotalTime,
    super.workTotalTime,
    super.day,
    super.jobType,
    super.payHour,
    super.travelType,
    super.travelTime,
    super.travelDistance,
    super.visitType,
    required super.status,
    super.isHoliday,
    super.color,
    super.operatorId,
    super.createdAt,
    super.updatedAt,
    super.client,
    super.assignee,
  });

  factory TimeSheetModel.fromJson(Map<String, dynamic> json) {
    return TimeSheetModel(
      id: DataParseUtil.parseInt(json['id']),
      jobListId: DataParseUtil.parseInt(json['job_list_id']),
      jobDayId: DataParseUtil.parseInt(json['job_day_id']),
      assigneeUserId: DataParseUtil.parseInt(json['assignee_user_id']),
      clientUserId: DataParseUtil.parseInt(json['client_user_id']),
      funderId: DataParseUtil.parseInt(json['funder_id']),
      scheduleStartTime: json['schedule_start_time']?.toString(),
      scheduleEndTime: json['schedule_end_time']?.toString(),
      workStartTime: json['work_start_time']?.toString(),
      workEndTime: json['work_end_time']?.toString(),
      scheduleTotalTime: DataParseUtil.parseDouble(json['schedule_total_time']),
      workTotalTime: DataParseUtil.parseDouble(json['work_total_time']),
      day: json['day']?.toString(),
      jobType: json['job_type']?.toString(),
      payHour: DataParseUtil.parseDouble(json['pay_hour']),
      travelType: json['travel_type']?.toString(),
      travelTime: DataParseUtil.parseDouble(json['travel_time']),
      travelDistance: DataParseUtil.parseDouble(json['travel_distance']),
      visitType: json['visit_type']?.toString(),
      status: json['status']?.toString() ?? '',
      isHoliday: DataParseUtil.parseInt(json['is_holiday']),
      color: json['color']?.toString(),
      operatorId: DataParseUtil.parseInt(json['operator_id']),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      client: json['client'] != null ? EmployeeModel.fromJson(json['client'] as Map<String, dynamic>) : null,
      assignee: json['assignee'] != null ? EmployeeModel.fromJson(json['assignee'] as Map<String, dynamic>) : null,
    );
  }
}
