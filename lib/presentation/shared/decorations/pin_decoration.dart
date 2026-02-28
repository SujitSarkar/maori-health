import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class DefaultPinTheme extends PinTheme {
  DefaultPinTheme()
    : super(
        width: 44,
        height: 48,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
      );
}

class FocusedPinTheme extends PinTheme {
  FocusedPinTheme()
    : super(
        width: 44,
        height: 48,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      );
}
