import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/result/result.dart';
import 'package:maori_health/domain/asset/entities/asset.dart';

abstract class AssetRepository {
  Future<Result<AppError, List<Asset>>> getAssets();
  Future<Result<AppError, Asset>> acceptAsset(int assetId);
}
