import 'package:flutter/material.dart';

OverlayEntry? _activeTopSnackBar;

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Size get screenSize => MediaQuery.sizeOf(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  void showSnackBar(String message, {bool isError = false}) {
    scaffoldMessenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), backgroundColor: isError ? theme.colorScheme.error : null));
  }

  void dismissActiveTopSnackBar() {
    _activeTopSnackBar?.remove();
    _activeTopSnackBar = null;
  }
}
