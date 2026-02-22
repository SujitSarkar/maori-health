import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:maori_health/core/router/route_names.dart';
import 'package:maori_health/domain/asset/entities/asset.dart';
import 'package:maori_health/presentation/asset/pages/asset_details_page.dart';
import 'package:maori_health/presentation/asset/pages/assets_page.dart';
import 'package:maori_health/presentation/auth/pages/login_page.dart';
import 'package:maori_health/presentation/dashboard/pages/job_details_page.dart';
import 'package:maori_health/presentation/dashboard/widgets/job_carousel.dart';
import 'package:maori_health/presentation/profile/pages/profile_page.dart';
import 'package:maori_health/presentation/splash/splash_page.dart';
import 'package:maori_health/presentation/timesheet/pages/timesheet_page.dart';
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
        GoRoute(name: RouteNames.splash, path: RouteNames.splashPath, builder: (context, state) => const SplashPage()),
        GoRoute(name: RouteNames.login, path: RouteNames.loginPath, builder: (context, state) => const LoginPage()),
        GoRoute(name: RouteNames.home, path: RouteNames.homePath, builder: (context, state) => const BottomNavBar()),
        GoRoute(
          name: RouteNames.profile,
          path: RouteNames.profilePath,
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(name: RouteNames.assets, path: RouteNames.assetsPath, builder: (context, state) => const AssetsPage()),
        GoRoute(
          name: RouteNames.assetDetails,
          path: RouteNames.assetDetailsPath,
          builder: (context, state) => AssetDetailsPage(asset: state.extra! as Asset),
        ),
        GoRoute(
          name: RouteNames.timeSheets,
          path: RouteNames.timeSheetsPath,
          builder: (context, state) => const TimeSheetPage(),
        ),
        GoRoute(
          name: RouteNames.jobDetails,
          path: RouteNames.jobDetailsPath,
          builder: (context, state) {
            final extra = state.extra;
            if (extra is JobCarouselItem) {
              return JobDetailsPage(job: extra);
            }
            return JobDetailsPage(jobScheduleId: extra as int?);
          },
        ),
      ],
    );
  }
}
