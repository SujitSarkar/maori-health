import 'package:equatable/equatable.dart';

import 'package:maori_health/domain/notification/entities/app_notification.dart';

enum NotificationPageStatus { initial, loading, loaded, error }

class NotificationState extends Equatable {
  final NotificationPageStatus status;
  final List<AppNotification> notifications;
  final String? errorMessage;

  const NotificationState({
    this.status = NotificationPageStatus.initial,
    this.notifications = const [],
    this.errorMessage,
  });

  NotificationState copyWith({
    NotificationPageStatus? status,
    List<AppNotification>? notifications,
    String? errorMessage,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, notifications, errorMessage];
}
