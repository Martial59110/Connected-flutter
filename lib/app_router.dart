import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'models/sensor.dart';
import 'pages/dashboard_page.dart';
import 'pages/sensor_detail_page.dart';
import 'viewmodels/dashboard_view_model.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: DashboardRoute.page, initial: true),
    AutoRoute(page: SensorDetailRoute.page),
  ];
}
