import 'package:equatable/equatable.dart';

import 'package:maori_health/domain/asset/entities/asset.dart';
import 'package:maori_health/domain/asset/entities/stock.dart';
import 'package:maori_health/domain/auth/entities/user.dart';

class AssetResponse extends Equatable {
  final Asset asset;
  final Stock stock;
  final User user;
  final User? receivedBy;

  const AssetResponse({required this.asset, required this.stock, required this.user, this.receivedBy});

  @override
  List<Object?> get props => [asset, stock, user, receivedBy];
}
