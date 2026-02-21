import 'package:maori_health/domain/notification/entities/app_notification.dart';

class NotificationModel extends AppNotification {
  const NotificationModel({
    required super.id,
    super.jobId,
    required super.message,
    required super.createdAt,
    super.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int,
      jobId: json['job_id'] as int?,
      message: json['message'] as String? ?? '',
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
      isRead: json['is_read'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job_id': jobId,
      'message': message,
      'created_at': createdAt.toIso8601String(),
      'is_read': isRead,
    };
  }
}
