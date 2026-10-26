import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:connected/pages/dashboard_page.dart';
import 'package:connected/repositories/fake_sensor_repository.dart';
import 'package:connected/viewmodels/dashboard_view_model.dart';

void main() {
  testWidgets('affiche le dashboard SensorHub', (WidgetTester tester) async {
    final viewModel = DashboardViewModel(
      repository: FakeSensorRepository(
        delay: Duration.zero,
        failOddAttempts: false,
      ),
    );
    await viewModel.load();

    await tester.pumpWidget(
      MaterialApp(home: DashboardPage(viewModel: viewModel)),
    );

    expect(find.text('SensorHub'), findsOneWidget);
    expect(find.text('Mes capteurs'), findsOneWidget);
    expect(find.text('Salon'), findsOneWidget);
    expect(find.text('Garage'), findsOneWidget);
    expect(find.text('Cave'), findsOneWidget);
    expect(find.text('Alerte'), findsOneWidget);
    viewModel.dispose();
  });
}
