import 'package:equatable/equatable.dart';

class NotificationData extends Equatable {
  final int? jobScheduleId;
  final int? assignTo;
  final String? assignedAt;
  final int? assignedBy;
  final String? title;
  final String? message;

  const NotificationData({
    this.jobScheduleId,
    this.assignTo,
    this.assignedAt,
    this.assignedBy,
    this.title,
    this.message,
  });

  @override
  List<Object?> get props => [jobScheduleId, assignTo, assignedAt, assignedBy, title, message];
}
