import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class NotificationsLoadEvent extends NotificationEvent {
  const NotificationsLoadEvent();
}

class NotificationLoadMoreEvent extends NotificationEvent {
  const NotificationLoadMoreEvent();
}

class NotificationReadEvent extends NotificationEvent {
  final String notificationId;

  const NotificationReadEvent(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}
