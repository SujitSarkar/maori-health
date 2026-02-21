import 'package:equatable/equatable.dart';

class AppNotification extends Equatable {
  final int id;
  final int? jobId;
  final String message;
  final DateTime createdAt;
  final bool isRead;

  const AppNotification({
    required this.id,
    this.jobId,
    required this.message,
    required this.createdAt,
    this.isRead = false,
  });

  @override
  List<Object?> get props => [id, jobId, message, createdAt, isRead];
}
