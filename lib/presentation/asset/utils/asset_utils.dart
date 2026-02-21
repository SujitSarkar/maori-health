import 'package:flutter/material.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/core/theme/app_colors.dart';
import 'package:maori_health/domain/asset/entities/asset.dart';

abstract class AssetUtils {
  static String statusLabel(AssetStatus status) => switch (status) {
    AssetStatus.pending => StringConstants.pending,
    AssetStatus.accepted => StringConstants.accepted,
    AssetStatus.returned => StringConstants.returned,
  };

  static Color statusColor(AssetStatus status) => switch (status) {
    AssetStatus.pending => Colors.grey,
    AssetStatus.accepted => AppColors.success,
    AssetStatus.returned => AppColors.error,
  };

  static Color statusBackgroundColor(AssetStatus status, BuildContext context) => switch (status) {
    AssetStatus.pending => Theme.of(context).colorScheme.surfaceContainerHighest,
    AssetStatus.accepted => AppColors.success.withAlpha(30),
    AssetStatus.returned => AppColors.error.withAlpha(30),
  };
}
