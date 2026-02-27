import 'package:maori_health/domain/notification/entities/notification_data.dart';
import 'package:maori_health/core/utils/data_parse_util.dart';

class NotificationDataModel extends NotificationData {
  const NotificationDataModel({
    super.jobScheduleId,
    super.assignTo,
    super.assignedAt,
    super.assignedBy,
    super.title,
    super.message,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationDataModel(
      jobScheduleId: DataParseUtil.parseInt(json['job_schedule_id']),
      assignTo: DataParseUtil.parseInt(json['assign_to']),
      assignedAt: json['assigned_at']?.toString(),
      assignedBy: DataParseUtil.parseInt(json['assigned_by']),
      title: json['title']?.toString(),
      message: json['message']?.toString(),
    );
  }
}
