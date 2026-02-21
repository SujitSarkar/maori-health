import 'package:flutter/material.dart';

import 'package:maori_health/core/utils/extensions.dart';
import 'package:maori_health/presentation/shared/widgets/loading_widget.dart';

class SolidButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget child;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets? padding;

  const SolidButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = 50,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? colorScheme.primary,
          foregroundColor: foregroundColor ?? colorScheme.onPrimary,
          disabledBackgroundColor: (backgroundColor ?? colorScheme.primary).withAlpha(200),
          disabledForegroundColor: (foregroundColor ?? colorScheme.onPrimary).withAlpha(200),
          shape: RoundedRectangleBorder(borderRadius: .circular(8)),
          elevation: isLoading ? 0 : 2,
          padding: padding,
        ),
        child: isLoading ? LoadingWidget(size: 22, color: foregroundColor ?? colorScheme.onPrimary) : child,
      ),
    );
  }
}
