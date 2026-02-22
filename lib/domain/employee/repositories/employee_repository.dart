import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/result/result.dart';
import 'package:maori_health/domain/employee/entities/employee.dart';

abstract class EmployeeRepository {
  Future<Result<AppError, List<Employee>>> getEmployees({int page = 1});
}
