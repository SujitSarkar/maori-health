import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/result/result.dart';
import 'package:maori_health/domain/client/entities/client.dart';

abstract class ClientRepository {
  Future<Result<AppError, List<Client>>> getClients({int page = 1});
}
