import 'package:equatable/equatable.dart';
import 'package:maori_health/data/asset/models/asset_response_model.dart';

sealed class AssetState extends Equatable {
  const AssetState();

  @override
  List<Object?> get props => [];
}

class AssetInitialState extends AssetState {
  const AssetInitialState();
}

class AssetLoadingState extends AssetState {
  const AssetLoadingState();
}

class AssetLoadedState extends AssetState {
  final List<AssetResponseModel> assets;

  const AssetLoadedState(this.assets);

  @override
  List<Object?> get props => [assets];
}

class AssetAcceptLoadingState extends AssetLoadedState {
  const AssetAcceptLoadingState(super.assets);
}

class AssetAcceptedState extends AssetState {}

class AssetErrorState extends AssetState {
  final String message;

  const AssetErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
