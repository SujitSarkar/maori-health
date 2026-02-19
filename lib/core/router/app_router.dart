import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:maori_health/core/router/route_names.dart';
import 'package:maori_health/presentation/splash/pages/splash_page.dart';
import 'package:maori_health/presentation/shared/widgets/bottom_nav_bar.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router({List<NavigatorObserver>? observers}) {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: RouteNames.splashPath,
      observers: observers ?? [],
      routes: [
        GoRoute(
          name: RouteNames.splash,
          path: RouteNames.splashPath,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          name: RouteNames.home,
          path: RouteNames.homePath,
          builder: (context, state) => const BottomNavBar(),
        ),
      ],
    );
  }
}
