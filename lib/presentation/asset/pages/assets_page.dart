import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/core/di/injection.dart';
import 'package:maori_health/core/router/route_names.dart';
import 'package:maori_health/domain/asset/entities/asset.dart';

import 'package:maori_health/presentation/asset/bloc/bloc.dart';
import 'package:maori_health/presentation/asset/widgets/asset_card.dart';
import 'package:maori_health/presentation/asset/widgets/asset_card_shimmer.dart';
import 'package:maori_health/presentation/shared/widgets/common_app_bar.dart';
import 'package:maori_health/presentation/shared/widgets/error_view_widget.dart';
import 'package:maori_health/presentation/shared/widgets/no_data_found_widget.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => getIt<AssetBloc>()..add(const AssetsFetched()), child: const _AssetsView());
  }
}

class _AssetsView extends StatelessWidget {
  const _AssetsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context: context, title: Text(StringConstants.assets)),
      body: BlocBuilder<AssetBloc, AssetState>(
        builder: (context, state) {
          return switch (state.status) {
            AssetPageStatus.initial || AssetPageStatus.loading => const AssetCardShimmer(),
            AssetPageStatus.error => ErrorViewWidget(
              message: state.errorMessage ?? StringConstants.somethingWentWrong,
              onRetry: () => context.read<AssetBloc>().add(const AssetsFetched()),
            ),
            AssetPageStatus.loaded =>
              state.assets.isEmpty
                  ? const NoDataFoundWidget(message: StringConstants.noDataFound)
                  : _buildAssetList(context, state.assets),
          };
        },
      ),
    );
  }

  Widget _buildAssetList(BuildContext context, List<Asset> assets) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: assets.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (_, index) {
        final asset = assets[index];
        return AssetCard(
          asset: asset,
          onView: () => context.pushNamed(RouteNames.assetDetails, extra: asset),
          onAccept: asset.status == AssetStatus.pending
              ? () => context.read<AssetBloc>().add(AssetAccepted(asset.id))
              : null,
        );
      },
    );
  }
}
