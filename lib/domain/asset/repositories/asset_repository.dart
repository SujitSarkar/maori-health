import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/result/result.dart';
import 'package:maori_health/data/asset/models/asset_response_model.dart';

abstract class AssetRepository {
  Future<Result<AppError, List<AssetResponseModel>>> getAssets();
  Future<Result<AppError, AssetResponseModel>> acceptAsset(int assetId);
}
