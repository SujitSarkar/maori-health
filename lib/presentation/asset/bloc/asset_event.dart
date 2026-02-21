import 'package:equatable/equatable.dart';

abstract class AssetEvent extends Equatable {
  const AssetEvent();

  @override
  List<Object?> get props => [];
}

class AssetsFetched extends AssetEvent {
  const AssetsFetched();
}

class AssetAccepted extends AssetEvent {
  final int assetId;

  const AssetAccepted(this.assetId);

  @override
  List<Object?> get props => [assetId];
}
