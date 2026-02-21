import 'package:flutter/material.dart';

class LoginInputDecoration extends InputDecoration {
  LoginInputDecoration({
    required BuildContext context,
    super.labelText,
    super.hintText,
    super.hintStyle,
    super.suffix,
    super.suffixIcon,
    super.prefix,
    super.prefixIcon,
    int super.errorMaxLines = 1,
    EdgeInsetsGeometry? contentPadding,
    Color? borderColor,
    super.prefixIconConstraints,
    super.suffixIconConstraints,
    bool super.alignLabelWithHint = true,
  }) : super(
         contentPadding: contentPadding ?? const .symmetric(horizontal: 12, vertical: 12),
         border: OutlineInputBorder(
           borderRadius: .circular(10),
           borderSide: BorderSide(color: borderColor ?? Theme.of(context).colorScheme.onPrimary, width: 1),
         ),
         enabledBorder: OutlineInputBorder(
           borderRadius: .circular(10),
           borderSide: BorderSide(color: borderColor ?? Theme.of(context).colorScheme.onPrimary, width: 1),
         ),
         focusedBorder: OutlineInputBorder(
           borderRadius: .circular(10),
           borderSide: BorderSide(color: borderColor ?? Theme.of(context).colorScheme.onPrimary, width: 1),
         ),
         disabledBorder: OutlineInputBorder(
           borderRadius: .circular(10),
           borderSide: BorderSide(color: borderColor ?? Theme.of(context).colorScheme.onPrimary, width: 1),
         ),
         errorBorder: OutlineInputBorder(
           borderRadius: .circular(10),
           borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1),
         ),
         focusedErrorBorder: OutlineInputBorder(
           borderRadius: .circular(10),
           borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1),
         ),
         fillColor: Colors.transparent,
         filled: true,
       );
}
