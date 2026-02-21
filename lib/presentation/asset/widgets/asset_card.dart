import 'package:flutter/material.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/core/theme/app_colors.dart';
import 'package:maori_health/core/utils/extensions.dart';
import 'package:maori_health/domain/asset/entities/asset.dart';
import 'package:maori_health/presentation/asset/utils/asset_utils.dart';
import 'package:maori_health/presentation/shared/widgets/solid_button.dart';

class AssetCard extends StatelessWidget {
  final Asset asset;
  final VoidCallback? onView;
  final VoidCallback? onAccept;

  const AssetCard({super.key, required this.asset, this.onView, this.onAccept});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final dividerColor = context.theme.dividerColor;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: dividerColor),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          _buildHeader(context, textTheme),
          const SizedBox(height: 12),
          _buildInfoRow(context, icon: Icons.tag, label: StringConstants.id, value: '${asset.id}'),
          const SizedBox(height: 10),
          _buildInfoRow(
            context,
            icon: Icons.calendar_today_outlined,
            label: StringConstants.assignmentDate,
            value: asset.assignmentDate ?? StringConstants.na,
          ),
          const SizedBox(height: 10),
          _buildInfoRow(
            context,
            icon: Icons.calendar_today_outlined,
            label: StringConstants.acknowledgementStatus,
            value: asset.acknowledgementStatus ?? StringConstants.na,
          ),
          const SizedBox(height: 14),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TextTheme textTheme) {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.devices_outlined, size: 22, color: context.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            asset.name,
            style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        _StatusBadge(status: asset.status),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, {required IconData icon, required String label, required String value}) {
    final textTheme = context.textTheme;
    return Row(
      children: [
        Icon(icon, size: 16, color: context.colorScheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Text(label, style: textTheme.bodyMedium),
        const Spacer(),
        Text(value, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    if (asset.status == AssetStatus.pending) {
      return Row(
        children: [
          Expanded(
            child: _ActionButton(
              icon: Icons.visibility_outlined,
              label: StringConstants.view,
              backgroundColor: context.colorScheme.primary,
              foregroundColor: Colors.white,
              onTap: onView,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ActionButton(
              icon: Icons.check,
              label: StringConstants.accept,
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              onTap: onAccept,
            ),
          ),
        ],
      );
    }
    return Center(
      child: OutlinedButton(
        onPressed: onView,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(164, 36),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.transparent,
          foregroundColor: context.colorScheme.onSurface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.visibility_outlined, size: 18, color: context.colorScheme.onSurface),
            const SizedBox(width: 6),
            Text(
              StringConstants.view,
              style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final AssetStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final label = AssetUtils.statusLabel(status);
    final fgColor = AssetUtils.statusColor(status);
    final bgColor = AssetUtils.statusBackgroundColor(status, context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(color: fgColor, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
      child: SolidButton(
        onPressed: onTap,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        height: 36,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: foregroundColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(color: foregroundColor, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
