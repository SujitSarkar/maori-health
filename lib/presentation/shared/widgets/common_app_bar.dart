import 'package:flutter/material.dart';
import 'package:maori_health/core/utils/extensions.dart';

class CommonAppBar extends AppBar {
  CommonAppBar({
    super.key,
    required BuildContext context,
    super.title,
    super.leading,
    super.actions,
    super.automaticallyImplyLeading = true,
    super.titleSpacing = 0,
    super.centerTitle = false,
  }) : super(
         backgroundColor: context.theme.scaffoldBackgroundColor,
         foregroundColor: context.theme.colorScheme.onSurface,
         titleTextStyle: context.theme.textTheme.titleMedium?.copyWith(
           fontWeight: .w600,
           color: context.theme.colorScheme.onSurface,
         ),
         elevation: 0,
         scrolledUnderElevation: 0,
       );
}
