import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/result/result.dart';

import 'package:maori_health/data/notification/datasources/notification_remote_data_source.dart';
import 'package:maori_health/domain/notification/entities/notification_response.dart';

abstract class NotificationRepository {
  Future<Result<AppError, PaginatedNotificationResponse>> getNotifications({int page = 1});
  Future<Result<AppError, NotificationResponse>> getNotification(String notificationId);
}
