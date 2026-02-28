import 'package:flutter/material.dart';

import 'package:maori_health/core/utils/extensions.dart';

class AppBottomSheet extends StatelessWidget {
  final Widget child;

  const AppBottomSheet({super.key, required this.child});

  static Future<T?> show<T>({required BuildContext context, required Widget child}) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: .vertical(top: .circular(20))),
      builder: (_) => AppBottomSheet(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: context.theme.dividerColor, borderRadius: .circular(2)),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
