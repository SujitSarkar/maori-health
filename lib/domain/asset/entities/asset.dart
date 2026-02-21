import 'package:equatable/equatable.dart';

enum AssetStatus { pending, accepted, returned }

class Asset extends Equatable {
  final int id;
  final String name;
  final String? category;
  final AssetStatus status;
  final String? assignmentDate;
  final String? acknowledgementStatus;
  final String? operatorName;
  final String? acknowledgementBy;
  final String? acknowledgementAt;
  final String? description;
  final String? attachmentUrl;

  const Asset({
    required this.id,
    required this.name,
    this.category,
    required this.status,
    this.assignmentDate,
    this.acknowledgementStatus,
    this.operatorName,
    this.acknowledgementBy,
    this.acknowledgementAt,
    this.description,
    this.attachmentUrl,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    status,
    assignmentDate,
    acknowledgementStatus,
    operatorName,
    acknowledgementBy,
    acknowledgementAt,
    description,
    attachmentUrl,
  ];
}
