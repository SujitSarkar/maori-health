import 'package:flutter/material.dart';

import 'package:maori_health/core/di/injection.dart';
import 'package:maori_health/presentation/app/view/app.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencies();
  runApp(const App());
}
