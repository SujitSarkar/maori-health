import 'package:maori_health/domain/dashboard/entities/stats.dart';

class StatsModel extends Stats {
  const StatsModel({
    super.totalJobs,
    super.completedJobs,
    super.cancelledJobs,
    super.activeJobs,
    super.totalClients,
    super.missedTimesheets,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      totalJobs: json['total_jobs'] as int? ?? 0,
      completedJobs: json['completed_jobs'] as int? ?? 0,
      cancelledJobs: json['cancelled_jobs'] as int? ?? 0,
      activeJobs: json['active_jobs'] as int? ?? 0,
      totalClients: json['total_clients'] as int? ?? 0,
      missedTimesheets: json['missed_timesheets'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_jobs': totalJobs,
      'completed_jobs': completedJobs,
      'cancelled_jobs': cancelledJobs,
      'active_jobs': activeJobs,
      'total_clients': totalClients,
      'missed_timesheets': missedTimesheets,
    };
  }
}
