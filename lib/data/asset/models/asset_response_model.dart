import 'package:maori_health/data/asset/models/asset_model.dart';
import 'package:maori_health/data/asset/models/stock_model.dart';
import 'package:maori_health/data/auth/models/user_model.dart';
import 'package:maori_health/domain/asset/entities/asset_response.dart';

class AssetResponseModel extends AssetResponse {
  const AssetResponseModel({required super.asset, required super.stock, required super.user, super.receivedBy});

  factory AssetResponseModel.fromJson(Map<String, dynamic> json) => AssetResponseModel(
    asset: AssetModel.fromJson(json),
    stock: StockModel.fromJson(json['stock']),
    user: UserModel.fromJson(json['user']),
    receivedBy: json['received_by'] != null ? UserModel.fromJson(json['received_by']) : null,
  );
}
