import 'package:flutter/services.dart';

class OrientationService {
  Future<void> portraitOrientation() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }
}
