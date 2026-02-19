import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

import 'package:maori_health/core/network/api_endpoints.dart';
import 'package:maori_health/core/storage/secure_storage_service.dart';

class RefreshTokenInterceptor extends InterceptorsWrapper {
  final Dio _dio;
  final SecureStorageService _secureStorage;

  RefreshTokenInterceptor({required Dio dio, required SecureStorageService secureStorage})
    : _dio = dio,
      _secureStorage = secureStorage;

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != HttpStatus.unauthorized) {
      return handler.next(err);
    }

    final refreshToken = await _secureStorage.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      await _handleLogout();
      return handler.reject(err);
    }

    if (Jwt.isExpired(refreshToken)) {
      await _handleLogout();
      return handler.reject(err);
    }

    final newAccessToken = await _refreshAccessToken(refreshToken);

    if (newAccessToken != null) {
      final retryResponse = await _retryRequest(err.requestOptions, newAccessToken);
      if (retryResponse != null) {
        return handler.resolve(retryResponse);
      }
    }

    return handler.reject(err);
  }

  Future<String?> _refreshAccessToken(String refreshToken) async {
    try {
      final url = ApiEndpoints.fullUrl(ApiEndpoints.refreshToken);
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'refresh_token': refreshToken}),
      );

      if (response.statusCode >= HttpStatus.ok && response.statusCode <= HttpStatus.resetContent) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final newAccessToken = data['token'] as String;
        final newRefreshToken = data['refresh_token'] as String;

        await _secureStorage.setAccessToken(newAccessToken);
        await _secureStorage.setRefreshToken(newRefreshToken);

        return newAccessToken;
      }

      return null;
    } catch (e) {
      debugPrint('RefreshTokenInterceptor: token refresh failed — $e');
      return null;
    }
  }

  Future<Response<dynamic>?> _retryRequest(RequestOptions requestOptions, String accessToken) async {
    try {
      requestOptions.headers['Authorization'] = 'Bearer $accessToken';
      final options = Options(method: requestOptions.method, headers: requestOptions.headers);

      return await _dio.request<dynamic>(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options,
      );
    } catch (e) {
      debugPrint('RefreshTokenInterceptor: retry failed — $e');
      return null;
    }
  }

  Future<void> _handleLogout() async {
    await _secureStorage.deleteAll();
  }
}
