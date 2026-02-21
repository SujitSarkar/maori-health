import 'package:flutter/material.dart';
import 'package:maori_health/presentation/shared/widgets/top_snack_bar.dart';

OverlayEntry? _activeTopSnackBar;

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Size get screenSize => MediaQuery.sizeOf(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  void showSnackBar(String message, {bool isError = false, bool onTop = false}) {
    if (onTop) {
      _dismissActiveTopSnackBar();
      late OverlayEntry entry;
      entry = OverlayEntry(
        builder: (_) => TopSnackBar(
          message: message,
          isError: isError,
          onDismiss: () {
            entry.remove();
            if (_activeTopSnackBar == entry) _activeTopSnackBar = null;
          },
        ),
      );
      _activeTopSnackBar = entry;
      Overlay.of(this).insert(entry);
      return;
    }

    scaffoldMessenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), backgroundColor: isError ? theme.colorScheme.error : null));
  }

  void _dismissActiveTopSnackBar() {
    _activeTopSnackBar?.remove();
    _activeTopSnackBar = null;
  }
}
