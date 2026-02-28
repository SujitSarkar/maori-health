import 'package:maori_health/core/utils/data_parse_util.dart';
import 'package:maori_health/data/timesheet/models/timesheet_model.dart';
import 'package:maori_health/domain/timesheet/entities/timesheet_response.dart';

class TimesheetResponseModel extends TimeSheetResponse {
  const TimesheetResponseModel({
    required super.timeSheets,
    required super.currentPage,
    required super.lastPage,
    required super.totalSchedules,
    required super.totalTime,
  });
  factory TimesheetResponseModel.fromJson(Map<String, dynamic> json) {
    final schedules = json['schedules'] as Map<String, dynamic>;
    final list = schedules['data'] as List<dynamic>? ?? [];
    return TimesheetResponseModel(
      timeSheets: list.map((e) => TimeSheetModel.fromJson(e as Map<String, dynamic>)).toList(),
      currentPage: DataParseUtil.parseInt(schedules['current_page'], defaultValue: 1),
      lastPage: DataParseUtil.parseInt(schedules['last_page'], defaultValue: 1),
      totalSchedules: DataParseUtil.parseInt(json['total_schedules']),
      totalTime: DataParseUtil.parseDouble(json['total_time']),
    );
  }
}
