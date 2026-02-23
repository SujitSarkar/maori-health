import 'package:maori_health/data/dashboard/models/job_model.dart';
import 'package:maori_health/data/dashboard/models/stats_model.dart';
import 'package:maori_health/domain/dashboard/entities/dashboard_response.dart';

class DashboardResponseModel extends DashboardResponse {
  const DashboardResponseModel({
    super.availableJobs,
    super.todaysSchedules,
    super.upcomingSchedules,
    super.nextSchedule,
    super.currentSchedule,
    super.stats,
  });

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    return DashboardResponseModel(
      availableJobs: _parseJobList(json['available_jobs']),
      todaysSchedules: _parseJobList(json['todays_schedules']),
      upcomingSchedules: _parseJobList(json['upcoming_schedules']),
      nextSchedule: json['next_schedule'] != null
          ? JobModel.fromJson(json['next_schedule'] as Map<String, dynamic>)
          : null,
      currentSchedule: json['current_schedule'] != null
          ? JobModel.fromJson(json['current_schedule'] as Map<String, dynamic>)
          : null,
      stats: json['stats'] != null ? StatsModel.fromJson(json['stats'] as Map<String, dynamic>) : const StatsModel(),
    );
  }

  static List<JobModel> _parseJobList(dynamic value) {
    if (value == null || value is! List) return [];
    return value.map((e) => JobModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
