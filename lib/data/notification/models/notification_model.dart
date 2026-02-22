import 'package:maori_health/domain/notification/entities/notification.dart';

class NotificationModel extends Notification {
  const NotificationModel({
    required super.id,
    super.type,
    super.notifiableType,
    super.notifiableId,
    super.readAt,
    super.createdAt,
    super.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      type: json['type'] as String?,
      notifiableType: json['notifiable_type'] as String?,
      notifiableId: json['notifiable_id'] as int?,
      readAt: json['read_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
