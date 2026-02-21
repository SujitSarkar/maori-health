import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/domain/notification/entities/app_notification.dart';
import 'package:maori_health/domain/notification/repositories/notification_repository.dart';
import 'package:maori_health/presentation/notification/bloc/notification_event.dart';
import 'package:maori_health/presentation/notification/bloc/notification_state.dart';

// TODO: Remove once API is integrated
final _dummyNotifications = [
  AppNotification(id: 1, jobId: 123, message: 'New Job Assigned.\nNew Job Available', createdAt: DateTime.now()),
  AppNotification(
    id: 2,
    jobId: 177,
    message: 'Job Finished\nJob Canceled',
    createdAt: DateTime.now().subtract(const Duration(seconds: 20)),
    isRead: true,
  ),
  AppNotification(
    id: 3,
    jobId: 110,
    message: 'Job Started Now',
    createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  AppNotification(
    id: 4,
    jobId: 7,
    message: 'Job Done at 7.00pm',
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  ),
  AppNotification(
    id: 5,
    jobId: 133,
    message: 'Job Hold on.\nJob Finished at 10.00am',
    createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    isRead: true,
  ),
  AppNotification(
    id: 6,
    jobId: 113,
    message: 'Password has been changed.',
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
  ),
  AppNotification(
    id: 7,
    jobId: 232,
    message: 'New Job Assigned.',
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
  AppNotification(
    id: 8,
    jobId: 432,
    message: 'Job Canceled.',
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    isRead: true,
  ),
  AppNotification(
    id: 9,
    jobId: 210,
    message: 'Job Started Now\nJob Finished at 10.00am',
    createdAt: DateTime.now().subtract(const Duration(days: 20)),
  ),
];

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _repository;

  NotificationBloc({required NotificationRepository repository})
    : _repository = repository,
      super(const NotificationState()) {
    on<NotificationsFetched>(_onFetched);
    on<NotificationMarkedAsRead>(_onMarkedAsRead);
  }

  // TODO: Replace dummy data with repository call once API is ready
  Future<void> _onFetched(NotificationsFetched event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(status: NotificationPageStatus.loading));
    await Future<void>.delayed(const Duration(milliseconds: 2000));
    emit(state.copyWith(status: NotificationPageStatus.loaded, notifications: _dummyNotifications));

    // final result = await _repository.getNotifications();
    // await result.fold(
    //   onFailure: (error) async {
    //     emit(state.copyWith(errorMessage: error.errorMessage ?? StringConstants.somethingWentWrong));
    //   },
    //   onSuccess: (notifications) async {
    //     emit(state.copyWith(status: NotificationPageStatus.loaded, notifications: notifications));
    //   },
    // );
  }

  Future<void> _onMarkedAsRead(NotificationMarkedAsRead event, Emitter<NotificationState> emit) async {
    final result = await _repository.markAsRead(event.notificationId);
    await result.fold(
      onFailure: (error) async {
        emit(state.copyWith(errorMessage: error.errorMessage ?? StringConstants.somethingWentWrong));
      },
      onSuccess: (_) async {
        final updated = state.notifications.map((n) {
          if (n.id == event.notificationId) {
            return AppNotification(id: n.id, message: n.message, createdAt: n.createdAt, isRead: true);
          }
          return n;
        }).toList();
        emit(state.copyWith(notifications: updated));
      },
    );
  }
}
