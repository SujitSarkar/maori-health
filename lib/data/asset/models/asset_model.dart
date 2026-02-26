import 'package:maori_health/core/utils/data_parse_util.dart';
import 'package:maori_health/domain/asset/entities/asset.dart';

class AssetModel extends Asset {
  const AssetModel({
    required super.id,
    required super.userId,
    required super.stockId,
    required super.assignId,
    required super.quantity,
    required super.assignedDate,
    required super.status,
    required super.actionStatus,
    required super.acknowledgementStatus,
    required super.operatorId,
    required super.receivedAt,
    required super.receivedBy,
    required super.note,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
    id: DataParseUtil.parseInt(json["id"]),
    userId: DataParseUtil.parseInt(json["user_id"]),
    stockId: DataParseUtil.parseInt(json["stock_id"]),
    assignId: DataParseUtil.parseInt(json["assign_id"]),
    quantity: DataParseUtil.parseInt(json["quantity"]),
    assignedDate: json["assigned_date"] == null ? null : DateTime.parse(json["assigned_date"]),
    status: json["status"]?.toString(),
    actionStatus: json["action_status"]?.toString(),
    acknowledgementStatus: DataParseUtil.parseInt(json["acknowledgement_status"]),
    operatorId: DataParseUtil.parseInt(json["operator_id"]),
    receivedAt: json["received_at"] == null ? null : DateTime.parse(json["received_at"]),
    receivedBy: json["received_by"]?.toString(),
    note: json["note"]?.toString(),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "stock_id": stockId,
    "assign_id": assignId,
    "quantity": quantity,
    "assigned_date": assignedDate,
    "status": status,
    "action_status": actionStatus,
    "acknowledgement_status": acknowledgementStatus,
    "operator_id": operatorId,
    "received_at": receivedAt?.toIso8601String(),
    "received_by": receivedBy,
    "note": note,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt?.toIso8601String(),
  };
}
