import 'package:flutter/foundation.dart';

import '../models/sensor.dart';
import '../repositories/sensor_repository.dart';
import '../state/async_state.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel({required SensorRepository repository})
    : _repository = repository;

  final SensorRepository _repository;

  AsyncState<Sensor> _state = const Loading();

  AsyncState<Sensor> get state => _state;

  List<Sensor> get sensors => switch (_state) {
    Content(:final values) => List.unmodifiable(values),
    _ => const [],
  };

  int get sensorCount => sensors.length;

  int get onlineCount => sensors.where((sensor) => sensor.isOnline).length;

  bool get hasOfflineSensors => sensors.any((sensor) => !sensor.isOnline);

  Future<void> load() async {
    _setState(const Loading());
    try {
      final values = await _repository.fetchAll();
      _setState(Content(values));
    } catch (error) {
      _setState(Failure(error.toString()));
    }
  }

  void _setState(AsyncState<Sensor> value) {
    _state = value;
    notifyListeners();
  }
}
