import 'package:flutter/material.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/core/utils/extensions.dart';
import 'package:maori_health/core/utils/form_validators.dart';
import 'package:maori_health/presentation/shared/decorations/outline_input_decoration.dart';
import 'package:maori_health/presentation/shared/widgets/app_dialog.dart';
import 'package:maori_health/presentation/shared/widgets/solid_button.dart';

void showChangePasswordDialog(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  showAppDialog(
    context: context,
    title: StringConstants.changePassword,
    content: Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: oldPasswordController,
            obscureText: true,
            validator: FormValidators.password(),
            decoration: OutlineInputDecoration(context: context, hintText: StringConstants.oldPassword),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: newPasswordController,
            obscureText: true,
            validator: FormValidators.password(),
            decoration: OutlineInputDecoration(context: context, hintText: StringConstants.newPassword),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            validator: (value) {
              final base = FormValidators.password()(value);
              if (base != null) return base;
              if (value != newPasswordController.text) {
                return StringConstants.passwordsDoNotMatch;
              }
              return null;
            },
            decoration: OutlineInputDecoration(context: context, hintText: StringConstants.confirmPassword),
          ),
        ],
      ),
    ),
    actions: [
      SolidButton(
        width: 110,
        height: 42,
        onPressed: () => Navigator.pop(context),
        backgroundColor: context.theme.hintColor,
        child: const Text(StringConstants.close),
      ),
      SolidButton(
        width: 110,
        height: 42,
        onPressed: () {
          if (!formKey.currentState!.validate()) return;
          // TODO: Dispatch change password event
          Navigator.pop(context);
        },
        child: const Text(StringConstants.save),
      ),
    ],
  );
}
