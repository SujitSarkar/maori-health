import 'package:flutter/material.dart';

import 'package:maori_health/core/config/assets.dart';
import 'package:maori_health/core/theme/app_colors.dart';
import 'package:maori_health/core/utils/extensions.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, required this.child, this.padding});
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenSize.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [_buildHeaderSection(screenHeight), _buildFormSection(screenHeight)]),
      ),
    );
  }

  Widget _buildHeaderSection(double screenHeight) {
    return SizedBox(
      height: screenHeight * 0.5,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(Assets.assetsImagesLoginBg, fit: BoxFit.cover),
          Center(
            child: Padding(
              padding: const .only(bottom: 20),
              child: Image.asset(Assets.assetsImagesBannerLogo, width: 200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(double screenHeight) {
    return Container(
      padding: padding ?? const .fromLTRB(16, 32, 16, 0),
      width: double.infinity,
      color: AppColors.primary,
      child: child,
    );
  }
}
