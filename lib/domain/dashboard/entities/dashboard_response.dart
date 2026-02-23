import 'package:equatable/equatable.dart';

import 'package:maori_health/domain/dashboard/entities/job.dart';
import 'package:maori_health/domain/dashboard/entities/stats.dart';

class DashboardResponse extends Equatable {
  final List<Job> availableJobs;
  final List<Job> todaysSchedules;
  final List<Job> upcomingSchedules;
  final Job? nextSchedule;
  final Job? currentSchedule;
  final Stats stats;

  const DashboardResponse({
    this.availableJobs = const [],
    this.todaysSchedules = const [],
    this.upcomingSchedules = const [],
    this.nextSchedule,
    this.currentSchedule,
    this.stats = const Stats(),
  });

  @override
  List<Object?> get props => [availableJobs, todaysSchedules, upcomingSchedules, nextSchedule, currentSchedule, stats];
}
