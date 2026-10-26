import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'app_router.dart';
import 'repositories/fake_sensor_repository.dart';
import 'viewmodels/dashboard_view_model.dart';

void main() {
  final viewModel = DashboardViewModel(repository: FakeSensorRepository());
  viewModel.load();
  runApp(MyApp(dashboardViewModel: viewModel));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.dashboardViewModel});

  final DashboardViewModel dashboardViewModel;

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      title: 'SensorHub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      routerConfig: appRouter.config(
        deepLinkBuilder: (_) => DeepLink([
          DashboardRoute(viewModel: dashboardViewModel),
        ]),
      ),
    );
  }
}
