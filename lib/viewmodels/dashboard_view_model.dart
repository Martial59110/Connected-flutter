import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/sensor.dart';
import '../repositories/fake_sensor_repository.dart';
import '../repositories/sensor_repository.dart';
import '../state/async_state.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel({required SensorRepository repository})
    : _repository = repository;

  static const staleAfter = Duration(seconds: 10);

  final SensorRepository _repository;

  AsyncState<Sensor> _state = const Loading();
  bool _inFlight = false;
  DateTime? _lastSuccessfulAt;
  Timer? _staleTimer;

  AsyncState<Sensor> get state => _state;

  bool get isRefreshing => _inFlight;

  DateTime? get lastSuccessfulAt => _lastSuccessfulAt;

  bool get isStale {
    final lastSuccess = _lastSuccessfulAt;
    if (lastSuccess == null) return false;
    return DateTime.now().difference(lastSuccess) > staleAfter;
  }

  String get lastRefreshLabel {
    final lastSuccess = _lastSuccessfulAt;
    if (lastSuccess == null) return 'Aucune actualisation réussie';
    final h = lastSuccess.hour.toString().padLeft(2, '0');
    final m = lastSuccess.minute.toString().padLeft(2, '0');
    final s = lastSuccess.second.toString().padLeft(2, '0');
    return 'Dernière actualisation : $h:$m:$s';
  }

  List<Sensor> get sensors => switch (_state) {
    Content(:final values) => List.unmodifiable(values),
    _ => const [],
  };

  int get sensorCount => sensors.length;

  int get onlineCount => sensors.where((sensor) => sensor.isOnline).length;

  bool get hasOfflineSensors => sensors.any((sensor) => !sensor.isOnline);

  int? get fetchCount {
    final repository = _repository;
    if (repository is FakeSensorRepository) return repository.fetchCount;
    return null;
  }

  Future<void> load() async {
    if (_inFlight) return;
    _inFlight = true;
    if (_state is! Content<Sensor>) {
      _setState(const Loading());
    } else {
      notifyListeners();
    }
    try {
      final values = await _repository.fetchAll();
      _lastSuccessfulAt = DateTime.now();
      _scheduleStaleCheck();
      _setState(Content(values));
    } catch (error) {
      final message = error.toString().replaceFirst('Exception: ', '');
      _setState(Failure(message));
    } finally {
      _inFlight = false;
      notifyListeners();
    }
  }

  void _scheduleStaleCheck() {
    _staleTimer?.cancel();
    _staleTimer = Timer(staleAfter, notifyListeners);
  }

  void _setState(AsyncState<Sensor> value) {
    _state = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _staleTimer?.cancel();
    super.dispose();
  }
}
