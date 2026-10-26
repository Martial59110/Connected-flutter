import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/sensor.dart';

@RoutePage()
class SensorDetailPage extends StatelessWidget {
  const SensorDetailPage({super.key, required this.sensor});

  final Sensor sensor;

  String _formatLastMeasured() {
    final date = sensor.lastMeasuredAt;
    if (date == null) return '—';
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    return '${date.day}/${date.month}/${date.year} à $h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = sensor.isOnline;
    final statusColor = !isOnline
        ? Theme.of(context).colorScheme.outline
        : sensor.hasAlert
        ? Colors.orange
        : Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: Text(sensor.detailTitle),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Icon(Icons.circle, size: 12, color: statusColor),
              const SizedBox(width: 8),
              Text(
                sensor.statusLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _DetailRow(
            label: 'Température',
            value: '${sensor.temperature.toStringAsFixed(1)} °C',
          ),
          _DetailRow(
            label: 'Humidité',
            value: '${sensor.humidity.toStringAsFixed(0)} %',
          ),
          _DetailRow(
            label: 'Batterie',
            value: '${sensor.battery.toStringAsFixed(0)} %',
          ),
          const Divider(height: 32),
          _DetailRow(label: 'État', value: sensor.etatLabel),
          _DetailRow(label: 'Dernière mesure', value: _formatLastMeasured()),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
