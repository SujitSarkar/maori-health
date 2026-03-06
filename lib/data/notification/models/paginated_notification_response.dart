import 'package:maori_health/data/notification/models/notification_response_model.dart';

class PaginatedNotificationResponse {
  final List<NotificationResponseModel> notifications;
  final int unreadCount;
  final int currentPage;
  final int lastPage;

  const PaginatedNotificationResponse({
    required this.notifications,
    required this.unreadCount,
    required this.currentPage,
    required this.lastPage,
  });

  bool get hasMore => currentPage < lastPage;
}
