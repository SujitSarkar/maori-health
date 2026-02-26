import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  final int? id;
  final int? userId;
  final int? stockId;
  final int? assignId;
  final int? quantity;
  final DateTime? assignedDate;
  final String? status;
  final String? actionStatus;
  final int? acknowledgementStatus;
  final int? operatorId;
  final DateTime? receivedAt;
  final String? receivedBy;
  final String? note;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const Asset({
    this.id,
    this.userId,
    this.stockId,
    this.assignId,
    this.quantity,
    this.assignedDate,
    this.status,
    this.actionStatus,
    this.acknowledgementStatus,
    this.operatorId,
    this.receivedAt,
    this.receivedBy,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    stockId,
    quantity,
    assignedDate,
    status,
    acknowledgementStatus,
    operatorId,
    receivedAt,
    receivedBy,
    note,
    createdAt,
    updatedAt,
    deletedAt,
  ];
}
