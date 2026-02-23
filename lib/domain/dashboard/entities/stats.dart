import 'package:equatable/equatable.dart';

class Stats extends Equatable {
  final int totalJobs;
  final int completedJobs;
  final int cancelledJobs;
  final int activeJobs;
  final int totalClients;
  final int missedTimesheets;

  const Stats({
    this.totalJobs = 0,
    this.completedJobs = 0,
    this.cancelledJobs = 0,
    this.activeJobs = 0,
    this.totalClients = 0,
    this.missedTimesheets = 0,
  });

  @override
  List<Object?> get props => [totalJobs, completedJobs, cancelledJobs, activeJobs, totalClients, missedTimesheets];
}
