import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class NotificationsFetched extends NotificationEvent {
  const NotificationsFetched();
}

class NotificationMarkedAsRead extends NotificationEvent {
  final int notificationId;

  const NotificationMarkedAsRead(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}
