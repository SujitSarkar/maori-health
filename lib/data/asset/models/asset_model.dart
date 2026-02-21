import 'package:maori_health/domain/asset/entities/asset.dart';

class AssetModel extends Asset {
  const AssetModel({
    required super.id,
    required super.name,
    super.category,
    required super.status,
    super.assignmentDate,
    super.acknowledgementStatus,
    super.operatorName,
    super.acknowledgementBy,
    super.acknowledgementAt,
    super.description,
    super.attachmentUrl,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      category: json['category'] as String?,
      status: _parseStatus(json['status'] as String?),
      assignmentDate: json['assignment_date'] as String?,
      acknowledgementStatus: json['acknowledgement_status'] as String?,
      operatorName: json['operator_name'] as String?,
      acknowledgementBy: json['acknowledgement_by'] as String?,
      acknowledgementAt: json['acknowledgement_at'] as String?,
      description: json['description'] as String?,
      attachmentUrl: json['attachment_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'status': status.name,
      'assignment_date': assignmentDate,
      'acknowledgement_status': acknowledgementStatus,
      'operator_name': operatorName,
      'acknowledgement_by': acknowledgementBy,
      'acknowledgement_at': acknowledgementAt,
      'description': description,
      'attachment_url': attachmentUrl,
    };
  }

  static AssetStatus _parseStatus(String? status) {
    return switch (status?.toLowerCase()) {
      'accepted' => AssetStatus.accepted,
      'returned' => AssetStatus.returned,
      _ => AssetStatus.pending,
    };
  }
}
