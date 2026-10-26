import 'package:flutter_test/flutter_test.dart';

import 'package:connected/models/sensor.dart';
import 'package:connected/repositories/fake_sensor_repository.dart';
import 'package:connected/state/async_state.dart';
import 'package:connected/viewmodels/dashboard_view_model.dart';

void main() {
  test('load publie Loading puis Content', () async {
    final viewModel = DashboardViewModel(
      repository: FakeSensorRepository(delay: Duration.zero),
    );
    final states = <AsyncState<Sensor>>[];
    viewModel.addListener(() => states.add(viewModel.state));

    await viewModel.load();

    expect(states.first, isA<Loading<Sensor>>());
    expect(states.last, isA<Content<Sensor>>());
    expect((states.last as Content<Sensor>).values, isNotEmpty);

    viewModel.dispose();
  });

  test('load publie Failure en cas d erreur', () async {
    final viewModel = DashboardViewModel(
      repository: FakeSensorRepository(delay: Duration.zero, throwError: true),
    );
    final states = <AsyncState<Sensor>>[];
    viewModel.addListener(() => states.add(viewModel.state));

    await viewModel.load();

    expect(states.last, isA<Failure<Sensor>>());

    viewModel.dispose();
  });
}
