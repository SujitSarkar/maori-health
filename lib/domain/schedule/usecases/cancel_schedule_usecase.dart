import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/result/result.dart';

import 'package:maori_health/data/dashboard/models/schedule_model.dart';
import 'package:maori_health/domain/schedule/repositories/schedule_repository.dart';

class CancelScheduleUsecase {
  final ScheduleRepository _repository;

  CancelScheduleUsecase({required ScheduleRepository repository}) : _repository = repository;

  Future<Result<AppError, ScheduleModel>> call({
    required int scheduleId,
    required String cancelBy,
    required String reason,
    String? reasonType,
    required int hour,
    required int minute,
  }) async {
    return _repository.cancelSchedule(
      scheduleId: scheduleId,
      cancelBy: cancelBy,
      reason: reason,
      reasonType: reasonType,
      hour: hour,
      minute: minute,
    );
  }
}
