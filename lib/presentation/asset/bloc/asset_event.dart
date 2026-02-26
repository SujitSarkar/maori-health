import 'package:equatable/equatable.dart';

abstract class AssetEvent extends Equatable {
  const AssetEvent();

  @override
  List<Object?> get props => [];
}

class AssetsLoadEvent extends AssetEvent {
  const AssetsLoadEvent();
}

class AssetAcceptEvent extends AssetEvent {
  final int assetId;

  const AssetAcceptEvent(this.assetId);

  @override
  List<Object?> get props => [assetId];
}
