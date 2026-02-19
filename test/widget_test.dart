import 'package:flutter_test/flutter_test.dart';

import 'package:maori_health/presentation/app/view/app.dart';
import 'package:maori_health/core/di/injection.dart';

void main() {
  testWidgets('App renders successfully', (WidgetTester tester) async {
    await registerDependencies();
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
  });
}
