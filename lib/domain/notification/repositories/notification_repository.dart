import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/result/result.dart';
import 'package:maori_health/domain/notification/entities/app_notification.dart';

abstract class NotificationRepository {
  Future<Result<AppError, List<AppNotification>>> getNotifications();
  Future<Result<AppError, void>> markAsRead(int notificationId);
}
