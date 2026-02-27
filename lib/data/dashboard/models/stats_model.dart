import 'package:maori_health/domain/dashboard/entities/stats.dart';
import 'package:maori_health/core/utils/data_parse_util.dart';

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
      totalJobs: DataParseUtil.parseInt(json['total_jobs']),
      completedJobs: DataParseUtil.parseInt(json['completed_jobs']),
      cancelledJobs: DataParseUtil.parseInt(json['cancelled_jobs']),
      activeJobs: DataParseUtil.parseInt(json['active_jobs']),
      totalClients: DataParseUtil.parseInt(json['total_clients']),
      missedTimesheets: DataParseUtil.parseInt(json['missed_timesheets']),
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
