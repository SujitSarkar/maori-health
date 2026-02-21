import 'package:flutter/material.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/core/theme/app_colors.dart';
import 'package:maori_health/core/utils/extensions.dart';
import 'package:maori_health/domain/asset/entities/asset.dart';

import 'package:maori_health/presentation/asset/utils/asset_utils.dart';
import 'package:maori_health/presentation/shared/widgets/common_app_bar.dart';

class AssetDetailsPage extends StatelessWidget {
  final Asset asset;

  const AssetDetailsPage({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context: context, title: Text(StringConstants.viewDetails)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            _buildInfoCard(context),
            const SizedBox(height: 20),
            _buildDescriptionSection(context),
            const SizedBox(height: 20),
            _buildAttachmentSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final textTheme = context.textTheme;
    final labelStyle = textTheme.bodyMedium;
    final valueStyle = textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          _InfoRow(
            label: '${StringConstants.aid} : ',
            value: '${asset.id}',
            labelStyle: labelStyle,
            valueStyle: valueStyle,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: '${StringConstants.statusLabel} :',
            value: AssetUtils.statusLabel(asset.status),
            labelStyle: labelStyle,
            valueStyle: valueStyle?.copyWith(color: AssetUtils.statusColor(asset.status)),
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: '${StringConstants.product} :',
            value: asset.name,
            labelStyle: labelStyle,
            valueStyle: valueStyle,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: '${StringConstants.assignDate} : ',
            value: asset.assignmentDate ?? StringConstants.na,
            labelStyle: labelStyle,
            valueStyle: valueStyle,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: '${StringConstants.operator} : ',
            value: asset.operatorName ?? StringConstants.na,
            labelStyle: labelStyle,
            valueStyle: valueStyle,
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: '${StringConstants.acknowledgement} : ',
            value: asset.acknowledgementBy ?? StringConstants.na,
            labelStyle: labelStyle,
            valueStyle: valueStyle,
          ),
          if (asset.acknowledgementAt != null) ...[
            const SizedBox(height: 8),
            Text(
              '${StringConstants.at} : ${asset.acknowledgementAt}',
              style: textTheme.bodyMedium?.copyWith(color: AppColors.error, fontWeight: FontWeight.w500),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(StringConstants.description, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(
          asset.description ?? StringConstants.na,
          style: textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildAttachmentSection(BuildContext context) {
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(StringConstants.attachment, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        asset.attachmentUrl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  asset.attachmentUrl!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _buildAttachmentPlaceholder(context),
                ),
              )
            : _buildAttachmentPlaceholder(context),
      ],
    );
  }

  Widget _buildAttachmentPlaceholder(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, size: 48, color: context.colorScheme.onSurfaceVariant.withAlpha(120)),
          const SizedBox(height: 8),
          Text(
            StringConstants.noAttachment,
            style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant.withAlpha(150)),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const _InfoRow({required this.label, required this.value, this.labelStyle, this.valueStyle});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: label, style: labelStyle),
          TextSpan(text: value, style: valueStyle),
        ],
      ),
    );
  }
}
