import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int? id;
  final String? name;
  final int? categoryId;
  final String? brand;
  final String? description;
  final int? stock;
  final int? isActive;
  final String? model;
  final String? image;
  final int? operatorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Product({
    this.id,
    this.name,
    this.categoryId,
    this.brand,
    this.description,
    this.stock,
    this.isActive,
    this.model,
    this.image,
    this.operatorId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    categoryId,
    brand,
    description,
    stock,
    isActive,
    model,
    image,
    operatorId,
    createdAt,
    updatedAt,
  ];
}
