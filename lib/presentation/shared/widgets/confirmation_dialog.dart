import 'package:flutter/material.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/core/utils/extensions.dart';

Future<bool> showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String message,
  String? confirmText,
  String? cancelText,
  Color? confirmColor,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title, style: context.theme.textTheme.titleLarge),
      content: Text(message, style: context.theme.textTheme.bodyMedium),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(cancelText ?? StringConstants.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text(
            confirmText ?? StringConstants.ok,
            style: confirmColor != null ? TextStyle(color: confirmColor) : null,
          ),
        ),
      ],
    ),
  );

  return result ?? false;
}
