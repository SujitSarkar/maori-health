import 'package:maori_health/core/error/exceptions.dart';
import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/network/network_checker.dart';
import 'package:maori_health/core/result/result.dart';
import 'package:maori_health/data/notification/datasources/notification_remote_data_source.dart';
import 'package:maori_health/domain/notification/entities/app_notification.dart';
import 'package:maori_health/domain/notification/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;
  final NetworkChecker _networkChecker;

  NotificationRepositoryImpl({
    required NotificationRemoteDataSource remoteDataSource,
    required NetworkChecker networkChecker,
  }) : _remoteDataSource = remoteDataSource,
       _networkChecker = networkChecker;

  @override
  Future<Result<AppError, List<AppNotification>>> getNotifications() async {
    if (!await _networkChecker.hasConnection) {
      return const ErrorResult(NetworkError());
    }
    try {
      final notifications = await _remoteDataSource.getNotifications();
      return SuccessResult(notifications);
    } on ApiException catch (e) {
      return ErrorResult(
        ApiError(errorCode: 'FETCH_NOTIFICATIONS_FAILED', errorMessage: e.message, statusCode: e.statusCode),
      );
    } catch (e) {
      return ErrorResult(ApiError(errorCode: 'FETCH_NOTIFICATIONS_FAILED', errorMessage: e.toString()));
    }
  }

  @override
  Future<Result<AppError, void>> markAsRead(int notificationId) async {
    if (!await _networkChecker.hasConnection) {
      return const ErrorResult(NetworkError());
    }
    try {
      await _remoteDataSource.markAsRead(notificationId);
      return const SuccessResult(null);
    } on ApiException catch (e) {
      return ErrorResult(ApiError(errorCode: 'MARK_READ_FAILED', errorMessage: e.message, statusCode: e.statusCode));
    } catch (e) {
      return ErrorResult(ApiError(errorCode: 'MARK_READ_FAILED', errorMessage: e.toString()));
    }
  }
}
