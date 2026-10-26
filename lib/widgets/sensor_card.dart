import 'package:flutter/material.dart';

import '../models/sensor.dart';

class SensorCard extends StatelessWidget {
  const SensorCard({super.key, required this.sensor, this.onTap});

  final Sensor sensor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOnline = sensor.isOnline;
    final statusColor = !isOnline
        ? theme.colorScheme.outline
        : sensor.hasAlert
        ? Colors.orange
        : Colors.green;

    return Opacity(
      opacity: isOnline ? 1 : 0.55,
      child: Card(
        color: isOnline ? null : theme.colorScheme.surfaceContainerHighest,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sensor.name,
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      '${sensor.temperature.toStringAsFixed(1)}°',
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${sensor.humidity.toStringAsFixed(0)} %'),
                    Text(
                      sensor.statusLabel,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
