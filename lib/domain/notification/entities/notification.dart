import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  final String id;
  final String? type;
  final String? notifiableType;
  final int? notifiableId;
  final String? readAt;
  final String? createdAt;
  final String? updatedAt;

  const Notification({
    required this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  bool get isRead => readAt != null;

  @override
  List<Object?> get props => [id, type, notifiableType, notifiableId, readAt, createdAt, updatedAt];
}
