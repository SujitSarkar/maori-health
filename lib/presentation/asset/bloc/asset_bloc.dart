import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/domain/asset/entities/asset.dart';
import 'package:maori_health/domain/asset/repositories/asset_repository.dart';
import 'package:maori_health/presentation/asset/bloc/asset_event.dart';
import 'package:maori_health/presentation/asset/bloc/asset_state.dart';

// TODO: Remove once API is integrated
const _dummyAssets = [
  Asset(
    id: 23990,
    name: 'Samsung Galaxy A16 Smartphone IT',
    status: AssetStatus.pending,
    assignmentDate: '01/01/2026',
    operatorName: 'Jhone Deo',
    description:
        '"Discription" is a common misspelling of description, which is a detailed account or portrayal of something Discription is a common misspelling of description, which is a detailed',
  ),
  Asset(
    id: 1501,
    name: '5XL Hooded Jacket OPS',
    status: AssetStatus.accepted,
    assignmentDate: '01-01-2025',
    acknowledgementStatus: 'Accepted',
    operatorName: 'Jhone Deo',
    acknowledgementBy: 'Apon',
    acknowledgementAt: '31-08-2023 11:54 AM',
    description: 'Hooded jacket for outdoor operations.',
  ),
  Asset(
    id: 1502,
    name: '10 Pack of Masks',
    status: AssetStatus.returned,
    assignmentDate: '01/01/2026',
    acknowledgementStatus: 'Returned',
    operatorName: 'Jhone Deo',
    acknowledgementBy: 'Apon',
    acknowledgementAt: '31-08-2023 11:54 AM',
    description:
        '"Discription" is a common misspelling of description, which is a detailed account or portrayal of something Discription is a common misspelling of description, which is a detailed',
  ),
];

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final AssetRepository _assetRepository;

  AssetBloc({required AssetRepository assetRepository})
    : _assetRepository = assetRepository,
      super(const AssetState()) {
    on<AssetsFetched>(_onFetched);
    on<AssetAccepted>(_onAccepted);
  }

  // TODO: Replace dummy data with repository call once API is ready
  Future<void> _onFetched(AssetsFetched event, Emitter<AssetState> emit) async {
    emit(state.copyWith(status: AssetPageStatus.loading));

    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: AssetPageStatus.loaded, assets: _dummyAssets));
    // final result = await _assetRepository.getAssets();
    // await result.fold(
    //   onFailure: (error) async {
    //     emit(
    //       state.copyWith(
    //         status: AssetPageStatus.error,
    //         errorMessage: error.errorMessage ?? StringConstants.somethingWentWrong,
    //       ),
    //     );
    //   },
    //   onSuccess: (assets) async {
    //     emit(state.copyWith(status: AssetPageStatus.loaded, assets: assets));
    //   },
    // );
  }

  Future<void> _onAccepted(AssetAccepted event, Emitter<AssetState> emit) async {
    final result = await _assetRepository.acceptAsset(event.assetId);
    await result.fold(
      onFailure: (error) async {
        emit(state.copyWith(errorMessage: error.errorMessage ?? StringConstants.somethingWentWrong));
      },
      onSuccess: (updatedAsset) async {
        final updatedList = state.assets.map((a) {
          return a.id == updatedAsset.id ? updatedAsset : a;
        }).toList();
        emit(state.copyWith(assets: updatedList));
      },
    );
  }
}
