import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/result/result.dart';

import 'package:maori_health/data/notification/models/paginated_notification_response.dart';
import 'package:maori_health/domain/notification/entities/notification_response.dart';

abstract class NotificationRepository {
  Future<Result<AppError, PaginatedNotificationResponse>> getNotifications({int page = 1});
  Future<Result<AppError, NotificationResponse>> getNotification(String notificationId);
}
