import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/result/result.dart';

import 'package:maori_health/domain/lookup_enums/entities/lookup_enums.dart';
import 'package:maori_health/domain/lookup_enums/repositories/lookup_enums_repository.dart';

class GetLookupEnumsUsecase {
  final LookupEnumsRepository _repository;

  GetLookupEnumsUsecase({required LookupEnumsRepository repository}) : _repository = repository;

  Future<Result<AppError, LookupEnums>> call() async {
    return _repository.getLookupEnums();
  }
}
