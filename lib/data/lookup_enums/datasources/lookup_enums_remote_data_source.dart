import 'package:dio/dio.dart';

import 'package:maori_health/core/error/exceptions.dart';
import 'package:maori_health/core/network/api_endpoints.dart';
import 'package:maori_health/core/network/dio_client.dart';
import 'package:maori_health/data/lookup_enums/models/lookup_enums_model.dart';

abstract class LookupEnumsRemoteDataSource {
  Future<LookupEnumsModel> getLookupEnums();
}

class LookupEnumsRemoteDataSourceImpl implements LookupEnumsRemoteDataSource {
  final DioClient _client;

  LookupEnumsRemoteDataSourceImpl({required DioClient client}) : _client = client;

  @override
  Future<LookupEnumsModel> getLookupEnums() async {
    try {
      final response = await _client.get(ApiEndpoints.enums);
      final body = response.data as Map<String, dynamic>;

      if (body['success'] != null && body['success'] != true) {
        throw ApiException(
          statusCode: response.statusCode,
          message: body['message']?.toString() ?? 'Failed to fetch lookup enums',
        );
      }

      final data = (body['data'] is Map<String, dynamic>) ? (body['data'] as Map<String, dynamic>) : body;

      return LookupEnumsModel.fromJson(data);
    } on DioException catch (e) {
      final message = (e.response?.data is Map) ? (e.response!.data as Map)['message']?.toString() : null;
      throw ApiException(
        statusCode: e.response?.statusCode,
        message: message ?? e.message ?? 'Failed to fetch lookup enums',
      );
    }
  }
}
