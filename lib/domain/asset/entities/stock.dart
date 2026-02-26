import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final int? id;
  final int? productId;
  final int? categoryTypeId;
  final int? supplierId;
  final String? note;
  final String? uniqueId;
  final double? unitPrice;
  final int? quantity;
  final int? totalStock;
  final String? status;
  final String? macId;
  final DateTime? purchaseDate;
  final DateTime? warrantyDate;
  final DateTime? testingDate;
  final String? location;
  final int? operatorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Stock({
    this.id,
    this.productId,
    this.categoryTypeId,
    this.supplierId,
    this.note,
    this.uniqueId,
    this.unitPrice,
    this.quantity,
    this.totalStock,
    this.status,
    this.macId,
    this.purchaseDate,
    this.warrantyDate,
    this.testingDate,
    this.location,
    this.operatorId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    productId,
    categoryTypeId,
    supplierId,
    note,
    uniqueId,
    unitPrice,
    quantity,
    totalStock,
    status,
    macId,
    purchaseDate,
    warrantyDate,
    testingDate,
    location,
    operatorId,
    createdAt,
    updatedAt,
  ];
}
