import '../models/sensor.dart';
import 'sensor_repository.dart';

class FakeSensorRepository implements SensorRepository {
  FakeSensorRepository({
    this.delay = const Duration(seconds: 3),
    this.failOddAttempts = true,
    this.throwError = false,
  });

  final Duration delay;
  final bool failOddAttempts;
  final bool throwError;

  int _fetchCount = 0;

  int get fetchCount => _fetchCount;

  static final _sensors = [
    Sensor(
      id: '1',
      name: 'Salon',
      room: 'Pièce de vie',
      temperature: 21.8,
      humidity: 45,
      battery: 82,
      isOnline: true,
      lastMeasuredAt: DateTime(2026, 9, 14, 13, 40),
    ),
    Sensor(
      id: '2',
      name: 'Garage',
      room: 'Extérieur',
      temperature: 29.6,
      humidity: 61,
      battery: 54,
      isOnline: true,
      hasAlert: true,
      lastMeasuredAt: DateTime(2026, 9, 14, 13, 38),
    ),
    Sensor(
      id: '3',
      name: 'Cave',
      room: 'Sous-sol',
      temperature: 14.2,
      humidity: 67,
      battery: 31,
      lastMeasuredAt: DateTime(2026, 9, 14, 12, 10),
    ),
    Sensor(
      id: '4',
      name: 'Cuisine',
      room: 'Pièce de vie',
      temperature: 20.5,
      humidity: 52,
      battery: 78,
      isOnline: false,
      lastMeasuredAt: DateTime(2026, 9, 14, 12, 10),
    ),
  ];

  @override
  Future<List<Sensor>> fetchAll() async {
    _fetchCount++;
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }
    if (throwError || (failOddAttempts && _fetchCount.isOdd)) {
      throw Exception('Impossible de charger les capteurs');
    }
    return List.unmodifiable(_sensors);
  }
}
