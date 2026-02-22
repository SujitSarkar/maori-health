import 'package:maori_health/data/notification/models/notification_data_model.dart';
import 'package:maori_health/data/notification/models/notification_model.dart';
import 'package:maori_health/domain/notification/entities/notification_response.dart';

class NotificationResponseModel extends NotificationResponse {
  const NotificationResponseModel({required super.notification, required super.data});

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationResponseModel(
      notification: NotificationModel.fromJson(json),
      data: json['data'] != null
          ? NotificationDataModel.fromJson(json['data'] as Map<String, dynamic>)
          : const NotificationDataModel(),
    );
  }
}
