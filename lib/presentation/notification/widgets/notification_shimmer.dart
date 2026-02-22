import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:maori_health/core/theme/app_colors.dart';
import 'package:maori_health/core/utils/extensions.dart';

import 'package:maori_health/presentation/shared/widgets/app_shimmer.dart';

class NotificationShimmer extends StatelessWidget {
  final int itemCount;

  const NotificationShimmer({super.key, this.itemCount = 12});

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.shimmerBaseDark : AppColors.shimmerBaseLight,
      highlightColor: isDark ? AppColors.shimmerHighlightDark : AppColors.shimmerHighlightLight,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (_, _) => const _ShimmerTile(),
      ),
    );
  }
}

class _ShimmerTile extends StatelessWidget {
  const _ShimmerTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.theme.cardColor),
      ),
      child: const Row(
        crossAxisAlignment: .center,
        children: [
          AppShimmer.circular(size: 22),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                AppShimmer.text(width: double.infinity, height: 14),
                SizedBox(height: 6),
                AppShimmer.text(width: 180, height: 12),
              ],
            ),
          ),
          SizedBox(width: 8),
          AppShimmer.text(width: 40, height: 12),
        ],
      ),
    );
  }
}
