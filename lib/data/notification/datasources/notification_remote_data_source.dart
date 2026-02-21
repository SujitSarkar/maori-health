import 'package:dio/dio.dart';

import 'package:maori_health/core/error/exceptions.dart';
import 'package:maori_health/core/network/api_endpoints.dart';
import 'package:maori_health/core/network/dio_client.dart';
import 'package:maori_health/data/notification/models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAsRead(int notificationId);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final DioClient _client;

  NotificationRemoteDataSourceImpl({required DioClient client}) : _client = client;

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = await _client.get(ApiEndpoints.notifications);
      final body = response.data as Map<String, dynamic>;
      if (body['success'] != true) {
        throw ApiException(
          statusCode: response.statusCode,
          message: body['message'] as String? ?? 'Failed to fetch notifications',
        );
      }
      final list = body['data'] as List<dynamic>? ?? [];
      return list.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      final message = (e.response?.data is Map) ? (e.response!.data as Map)['message'] as String? : null;
      throw ApiException(
        statusCode: e.response?.statusCode,
        message: message ?? e.message ?? 'Failed to fetch notifications',
      );
    }
  }

  @override
  Future<void> markAsRead(int notificationId) async {
    try {
      final response = await _client.post(ApiEndpoints.markNotificationRead(notificationId));
      final body = response.data as Map<String, dynamic>;
      if (body['success'] != true) {
        throw ApiException(
          statusCode: response.statusCode,
          message: body['message'] as String? ?? 'Failed to mark notification as read',
        );
      }
    } on DioException catch (e) {
      final message = (e.response?.data is Map) ? (e.response!.data as Map)['message'] as String? : null;
      throw ApiException(
        statusCode: e.response?.statusCode,
        message: message ?? e.message ?? 'Failed to mark notification as read',
      );
    }
  }
}
