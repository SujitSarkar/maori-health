import 'package:equatable/equatable.dart';

import 'package:maori_health/domain/asset/entities/asset.dart';

enum AssetPageStatus { initial, loading, loaded, error }

class AssetState extends Equatable {
  final AssetPageStatus status;
  final List<Asset> assets;
  final String? errorMessage;

  const AssetState({this.status = AssetPageStatus.initial, this.assets = const [], this.errorMessage});

  AssetState copyWith({AssetPageStatus? status, List<Asset>? assets, String? errorMessage}) {
    return AssetState(status: status ?? this.status, assets: assets ?? this.assets, errorMessage: errorMessage);
  }

  @override
  List<Object?> get props => [status, assets, errorMessage];
}
