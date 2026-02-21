import 'package:dio/dio.dart';

import 'package:maori_health/core/error/exceptions.dart';
import 'package:maori_health/core/network/api_endpoints.dart';
import 'package:maori_health/core/network/dio_client.dart';
import 'package:maori_health/data/auth/models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _client;

  AuthRemoteDataSourceImpl({required DioClient client}) : _client = client;

  @override
  Future<LoginResponseModel> login({required String email, required String password}) async {
    try {
      final response = await _client.post(
        ApiEndpoints.login,
        data: FormData.fromMap({'email': email, 'password': password}),
      );

      final body = response.data as Map<String, dynamic>;

      if (body['success'] != true) {
        throw ApiException(statusCode: response.statusCode, message: body['message'] as String? ?? 'Login failed');
      }

      return LoginResponseModel.fromJson(body);
    } on DioException catch (e) {
      final message = (e.response?.data is Map) ? (e.response!.data as Map)['message'] as String? : null;
      throw ApiException(statusCode: e.response?.statusCode, message: message ?? e.message ?? 'Login failed');
    }
  }
}
