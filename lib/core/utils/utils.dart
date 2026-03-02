import 'package:flutter/services.dart';

class Utils {
  static void hideKeyboard() => SystemChannels.textInput.invokeMethod('TextInput.hide');
}
