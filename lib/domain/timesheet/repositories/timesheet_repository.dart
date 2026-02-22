import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/result/result.dart';
import 'package:maori_health/data/timesheet/datasources/timesheet_remote_data_source.dart';

abstract class TimeSheetRepository {
  Future<Result<AppError, TimeSheetResponse>> getTimeSheets({
    int? clientUserId,
    DateTime? startDate,
    DateTime? endDate,
    int page = 1,
  });
}
