import 'package:maori_health/data/dashboard/models/job_model.dart';

class PaginatedScheduleResponse {
  final List<JobModel> schedules;
  final int currentPage;
  final int lastPage;

  const PaginatedScheduleResponse({required this.schedules, required this.currentPage, required this.lastPage});

  bool get hasMore => currentPage < lastPage;
}
