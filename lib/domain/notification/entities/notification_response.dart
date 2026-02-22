import 'package:equatable/equatable.dart';

import 'package:maori_health/domain/notification/entities/notification.dart';
import 'package:maori_health/domain/notification/entities/notification_data.dart';

class NotificationResponse extends Equatable {
  final Notification notification;
  final NotificationData data;

  const NotificationResponse({required this.notification, required this.data});

  String get id => notification.id;

  bool get isRead => notification.isRead;

  String get title => data.title ?? '';

  String get message => data.message ?? '';

  @override
  List<Object?> get props => [notification, data];
}
