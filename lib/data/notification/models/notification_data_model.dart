import 'package:maori_health/domain/notification/entities/notification_data.dart';

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
      jobScheduleId: json['job_schedule_id'] as int?,
      assignTo: json['assign_to'] as int?,
      assignedAt: json['assigned_at'] as String?,
      assignedBy: json['assigned_by'] as int?,
      title: json['title'] as String?,
      message: json['message'] as String?,
    );
  }
}
