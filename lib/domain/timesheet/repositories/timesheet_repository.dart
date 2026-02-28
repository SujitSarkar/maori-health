import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/result/result.dart';
import 'package:maori_health/data/timesheet/models/timesheet_response_model.dart';

abstract class TimeSheetRepository {
  Future<Result<AppError, TimesheetResponseModel>> getTimeSheets({
    int? clientUserId,
    DateTime? startDate,
    DateTime? endDate,
    int page = 1,
  });
}
