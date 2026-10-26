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
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('SensorHub'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            actions: [
              IconButton(
                icon: viewModel.isRefreshing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.refresh),
                onPressed: viewModel.isRefreshing ? null : viewModel.load,
              ),
            ],
          ),
          body: Column(
            children: [
              if (viewModel.isRefreshing) const LinearProgressIndicator(),
              Expanded(child: _buildBody()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return switch (viewModel.state) {
      Loading() => _DashboardMeta(
        viewModel: viewModel,
        child: const Center(child: CircularProgressIndicator()),
      ),
      Failure(:final message) => _ErrorBody(
        message: message,
        lastRefreshLabel: viewModel.lastRefreshLabel,
        fetchCount: viewModel.fetchCount,
        onRetry: viewModel.isRefreshing ? null : viewModel.load,
      ),
      Content(values: []) => _DashboardMeta(
        viewModel: viewModel,
        child: const Center(child: Text('Aucun capteur')),
      ),
      Content(:final values) => _SensorList(
        sensors: values,
        viewModel: viewModel,
      ),
    };
  }
}

class _DashboardMeta extends StatelessWidget {
  const _DashboardMeta({required this.viewModel, required this.child});

  final DashboardViewModel viewModel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(viewModel.lastRefreshLabel),
              if (viewModel.isStale)
                Text(
                  'Données anciennes',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (viewModel.fetchCount != null)
                Text('Chargements : ${viewModel.fetchCount}'),
            ],
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({
    required this.message,
    required this.lastRefreshLabel,
    required this.fetchCount,
    required this.onRetry,
  });

  final String message;
  final String lastRefreshLabel;
  final int? fetchCount;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text(lastRefreshLabel, textAlign: TextAlign.center),
          if (fetchCount != null) Text('Chargements : $fetchCount'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: onRetry,
            child: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }
}

class _SensorList extends StatelessWidget {
  const _SensorList({required this.sensors, required this.viewModel});

  final List<Sensor> sensors;
  final DashboardViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return _DashboardMeta(
      viewModel: viewModel,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Mes capteurs', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ...sensors.map(
            (sensor) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SensorCard(
                sensor: sensor,
                onTap: () =>
                    context.pushRoute(SensorDetailRoute(sensor: sensor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
