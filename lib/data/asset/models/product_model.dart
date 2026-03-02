import 'package:maori_health/core/utils/data_parse_util.dart';
import 'package:maori_health/domain/asset/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.categoryId,
    required super.brand,
    required super.description,
    required super.stock,
    required super.isActive,
    required super.model,
    required super.image,
    required super.operatorId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: DataParseUtil.parseInt(json["id"]),
    name: json["name"],
    categoryId: DataParseUtil.parseInt(json["category_id"]),
    brand: json["brand"],
    description: json["description"],
    stock: DataParseUtil.parseInt(json["stock"]),
    isActive: DataParseUtil.parseInt(json["is_active"]),
    model: json["model"],
    image: json["image"],
    operatorId: DataParseUtil.parseInt(json["operator_id"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
