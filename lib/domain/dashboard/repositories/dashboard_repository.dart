import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/result/result.dart';
import 'package:maori_health/domain/dashboard/entities/dashboard_response.dart';

abstract class DashboardRepository {
  Future<Result<AppError, DashboardResponse>> getDashboard();
}
