import 'package:flutter_test/flutter_test.dart';

import 'package:connected/models/sensor.dart';
import 'package:connected/repositories/fake_sensor_repository.dart';
import 'package:connected/state/async_state.dart';
import 'package:connected/viewmodels/dashboard_view_model.dart';

void main() {
  test('le premier chargement echoue puis le retry reussit', () async {
    final repository = FakeSensorRepository(delay: Duration.zero);
    final viewModel = DashboardViewModel(repository: repository);

    await viewModel.load();
    expect(viewModel.state, isA<Failure<Sensor>>());
    expect(viewModel.lastRefreshLabel, 'Aucune actualisation réussie');

    await viewModel.load();
    expect(viewModel.state, isA<Content<Sensor>>());
    expect(viewModel.lastSuccessfulAt, isNotNull);
    expect(repository.fetchCount, 2);

    viewModel.dispose();
  });

  test('les actualisations paralleles n executent qu un chargement', () async {
    final repository = FakeSensorRepository(
      delay: const Duration(milliseconds: 30),
      failOddAttempts: false,
    );
    final viewModel = DashboardViewModel(repository: repository);

    final first = viewModel.load();
    final second = viewModel.load();
    await Future.wait([first, second]);

    expect(repository.fetchCount, 1);
    expect(viewModel.state, isA<Content<Sensor>>());

    viewModel.dispose();
  });

  test('une erreur conserve l heure du dernier succes', () async {
    final repository = FakeSensorRepository(delay: Duration.zero);
    final viewModel = DashboardViewModel(repository: repository);

    await viewModel.load();
    await viewModel.load();
    final successAt = viewModel.lastSuccessfulAt;

    await viewModel.load();
    expect(viewModel.state, isA<Failure<Sensor>>());
    expect(viewModel.lastSuccessfulAt, successAt);

    viewModel.dispose();
  });

  test('throwError publie Failure', () async {
    final viewModel = DashboardViewModel(
      repository: FakeSensorRepository(
        delay: Duration.zero,
        failOddAttempts: false,
        throwError: true,
      ),
    );
    await viewModel.load();
    expect(viewModel.state, isA<Failure<Sensor>>());
    viewModel.dispose();
  });
}
