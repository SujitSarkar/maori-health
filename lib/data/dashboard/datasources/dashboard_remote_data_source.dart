import 'package:dio/dio.dart';

import 'package:maori_health/core/error/exceptions.dart';
import 'package:maori_health/core/network/api_endpoints.dart';
import 'package:maori_health/core/network/dio_client.dart';
import 'package:maori_health/data/dashboard/models/dashboard_response_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardResponseModel> getDashboard();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final DioClient _client;

  DashboardRemoteDataSourceImpl({required DioClient client}) : _client = client;

  @override
  Future<DashboardResponseModel> getDashboard() async {
    try {
      final response = await _client.get(ApiEndpoints.dashboard);
      final body = response.data as Map<String, dynamic>;

      if (body['success'] != true) {
        throw ApiException(
          statusCode: response.statusCode,
          message: body['message']?.toString() ?? 'Failed to fetch dashboard data',
        );
      }

      final data = body['data'] as Map<String, dynamic>;
      return DashboardResponseModel.fromJson(data);
    } on DioException catch (e) {
      final message = (e.response?.data is Map) ? (e.response!.data as Map)['message']?.toString() : null;
      throw ApiException(
        statusCode: e.response?.statusCode,
        message: message ?? e.message ?? 'Failed to fetch dashboard data',
      );
    }
  }
}
