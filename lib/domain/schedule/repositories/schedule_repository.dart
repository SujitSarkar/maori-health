import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/result/result.dart';

import 'package:maori_health/data/dashboard/models/job_model.dart';
import 'package:maori_health/data/schedule/models/paginated_schedule_response.dart';

abstract class ScheduleRepository {
  Future<Result<AppError, PaginatedScheduleResponse>> getSchedules({
    required int page,
    String? clientUserId,
    String? startDate,
    String? endDate,
  });
  Future<Result<AppError, JobModel>> getScheduleById({required int scheduleId});
  Future<Result<AppError, JobModel>> acceptSchedule({required int scheduleId});
  Future<Result<AppError, JobModel>> startSchedule({required int scheduleId});
  Future<Result<AppError, JobModel>> finishSchedule({required int scheduleId});
  Future<Result<AppError, JobModel>> cancelSchedule({required int scheduleId});
}
