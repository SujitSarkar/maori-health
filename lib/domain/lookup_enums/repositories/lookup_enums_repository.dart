import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/result/result.dart';
import 'package:maori_health/domain/lookup_enums/entities/lookup_enums.dart';

abstract class LookupEnumsRepository {
  Future<Result<AppError, LookupEnums>> getLookupEnums();
}
