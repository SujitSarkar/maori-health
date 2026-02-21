import 'package:flutter/material.dart';

import 'package:maori_health/core/utils/extensions.dart';

Future<T?> showAppDialog<T>({
  required BuildContext context,
  required String title,
  required Widget content,
  List<Widget>? actions,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => AppDialog(title: title, content: content, actions: actions),
  );
}

class AppDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;

  const AppDialog({super.key, required this.title, required this.content, this.actions});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(color: context.theme.colorScheme.primary),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.theme.colorScheme.onPrimary,
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(20, 20, 20, 8), child: content),
          ),
          if (actions != null && actions!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: actions!.expand((w) => [w, const SizedBox(width: 12)]).toList()..removeLast(),
              ),
            ),
        ],
      ),
    );
  }
}
