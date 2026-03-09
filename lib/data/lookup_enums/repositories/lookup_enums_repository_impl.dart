import 'package:maori_health/core/error/exceptions.dart';
import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/network/network_checker.dart';
import 'package:maori_health/core/result/result.dart';

import 'package:maori_health/data/lookup_enums/datasources/lookup_enums_remote_data_source.dart';
import 'package:maori_health/domain/lookup_enums/entities/lookup_enums.dart';
import 'package:maori_health/domain/lookup_enums/repositories/lookup_enums_repository.dart';

class LookupEnumsRepositoryImpl implements LookupEnumsRepository {
  final LookupEnumsRemoteDataSource _remoteDataSource;
  final NetworkChecker _networkChecker;

  LookupEnumsRepositoryImpl({
    required LookupEnumsRemoteDataSource remoteDataSource,
    required NetworkChecker networkChecker,
  }) : _remoteDataSource = remoteDataSource,
       _networkChecker = networkChecker;

  @override
  Future<Result<AppError, LookupEnums>> getLookupEnums() async {
    if (!await _networkChecker.hasConnection) {
      return const ErrorResult(NetworkError());
    }

    try {
      final lookupEnums = await _remoteDataSource.getLookupEnums();
      return SuccessResult(lookupEnums);
    } on ApiException catch (e) {
      return ErrorResult(ApiError(errorCode: e.statusCode, errorMessage: e.message));
    } catch (e) {
      return ErrorResult(ApiError(errorCode: 0, errorMessage: e.toString()));
    }
  }
}
