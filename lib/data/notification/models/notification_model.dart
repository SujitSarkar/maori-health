import 'package:maori_health/domain/notification/entities/notification.dart';
import 'package:maori_health/core/utils/data_parse_util.dart';

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
      type: json['type']?.toString(),
      notifiableType: json['notifiable_type']?.toString(),
      notifiableId: DataParseUtil.parseInt(json['notifiable_id']),
      readAt: json['read_at']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
}
