// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<DashboardRouteArgs> {
  DashboardRoute({
    Key? key,
    required DashboardViewModel viewModel,
    List<PageRouteInfo>? children,
  }) : super(
         DashboardRoute.name,
         args: DashboardRouteArgs(key: key, viewModel: viewModel),
         initialChildren: children,
       );

  static const String name = 'DashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DashboardRouteArgs>();
      return DashboardPage(key: args.key, viewModel: args.viewModel);
    },
  );
}

class DashboardRouteArgs {
  const DashboardRouteArgs({this.key, required this.viewModel});

  final Key? key;

  final DashboardViewModel viewModel;

  @override
  String toString() {
    return 'DashboardRouteArgs{key: $key, viewModel: $viewModel}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DashboardRouteArgs) return false;
    return key == other.key && viewModel == other.viewModel;
  }

  @override
  int get hashCode => key.hashCode ^ viewModel.hashCode;
}

/// generated route for
/// [SensorDetailPage]
class SensorDetailRoute extends PageRouteInfo<SensorDetailRouteArgs> {
  SensorDetailRoute({
    Key? key,
    required Sensor sensor,
    List<PageRouteInfo>? children,
  }) : super(
         SensorDetailRoute.name,
         args: SensorDetailRouteArgs(key: key, sensor: sensor),
         initialChildren: children,
       );

  static const String name = 'SensorDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SensorDetailRouteArgs>();
      return SensorDetailPage(key: args.key, sensor: args.sensor);
    },
  );
}

class SensorDetailRouteArgs {
  const SensorDetailRouteArgs({this.key, required this.sensor});

  final Key? key;

  final Sensor sensor;

  @override
  String toString() {
    return 'SensorDetailRouteArgs{key: $key, sensor: $sensor}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SensorDetailRouteArgs) return false;
    return key == other.key && sensor == other.sensor;
  }

  @override
  int get hashCode => key.hashCode ^ sensor.hashCode;
}
