import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../app_router.dart';
import '../models/sensor.dart';
import '../state/async_state.dart';
import '../viewmodels/dashboard_view_model.dart';
import '../widgets/sensor_card.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.viewModel});

  final DashboardViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SensorHub'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: viewModel.load,
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return switch (viewModel.state) {
            Loading() => const Center(child: CircularProgressIndicator()),
            Failure(:final message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(message, textAlign: TextAlign.center),
              ),
            ),
            Content(values: []) => const Center(child: Text('Aucun capteur')),
            Content(:final values) => _SensorList(sensors: values),
          };
        },
      ),
    );
  }
}

class _SensorList extends StatelessWidget {
  const _SensorList({required this.sensors});

  final List<Sensor> sensors;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Mes capteurs', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        ...sensors.map(
          (sensor) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SensorCard(
              sensor: sensor,
              onTap: () => context.pushRoute(SensorDetailRoute(sensor: sensor)),
            ),
          ),
        ),
      ],
    );
  }
}
