import 'package:dio/dio.dart';

import 'package:maori_health/core/error/exceptions.dart';
import 'package:maori_health/core/network/api_endpoints.dart';
import 'package:maori_health/core/network/dio_client.dart';
import 'package:maori_health/data/asset/models/asset_model.dart';

abstract class AssetRemoteDataSource {
  Future<List<AssetModel>> getAssets();
  Future<AssetModel> acceptAsset(int assetId);
}

class AssetRemoteDataSourceImpl implements AssetRemoteDataSource {
  final DioClient _client;

  AssetRemoteDataSourceImpl({required DioClient client}) : _client = client;

  @override
  Future<List<AssetModel>> getAssets() async {
    try {
      final response = await _client.get(ApiEndpoints.assets);
      final body = response.data as Map<String, dynamic>;
      if (body['success'] != true) {
        throw ApiException(
          statusCode: response.statusCode,
          message: body['message'] as String? ?? 'Failed to fetch assets',
        );
      }
      final list = body['data'] as List<dynamic>? ?? [];
      return list.map((e) => AssetModel.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      final message = (e.response?.data is Map) ? (e.response!.data as Map)['message'] as String? : null;
      throw ApiException(statusCode: e.response?.statusCode, message: message ?? e.message ?? 'Failed to fetch assets');
    }
  }

  @override
  Future<AssetModel> acceptAsset(int assetId) async {
    try {
      final response = await _client.post(ApiEndpoints.acceptAsset(assetId));
      final body = response.data as Map<String, dynamic>;
      if (body['success'] != true) {
        throw ApiException(
          statusCode: response.statusCode,
          message: body['message'] as String? ?? 'Failed to accept asset',
        );
      }
      return AssetModel.fromJson(body['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      final message = (e.response?.data is Map) ? (e.response!.data as Map)['message'] as String? : null;
      throw ApiException(statusCode: e.response?.statusCode, message: message ?? e.message ?? 'Failed to accept asset');
    }
  }
}
