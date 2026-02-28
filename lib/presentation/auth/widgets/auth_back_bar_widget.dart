import 'package:flutter/material.dart';
import 'package:maori_health/core/utils/extensions.dart';

class AuthBackBarWidget extends StatelessWidget {
  const AuthBackBarWidget({super.key, required this.title, required this.subTitle, this.onBackPressed});
  final String title;
  final String subTitle;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      children: [
        InkWell(
          onTap: onBackPressed ?? () => Navigator.of(context).pop(),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(title, style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
              Text(subTitle, style: context.textTheme.bodySmall?.copyWith(color: context.theme.hintColor)),
            ],
          ),
        ),
      ],
    );
  }
}
