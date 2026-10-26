import 'package:freezed_annotation/freezed_annotation.dart';

part 'sensor.freezed.dart';
part 'sensor.g.dart';

@freezed
abstract class Sensor with _$Sensor {
  const Sensor._();

  const factory Sensor({
    required String id,
    required String name,
    required String room,
    required double temperature,
    required double humidity,
    required double battery,
    DateTime? lastMeasuredAt,
    @Default(false) bool isOnline,
    @Default(false) bool hasAlert,
  }) = _Sensor;

  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);

  String get detailTitle => 'Capteur du ${name.toLowerCase()}';

  String get statusLabel {
    if (!isOnline) return 'Hors ligne';
    if (hasAlert) return 'Alerte';
    return 'En ligne';
  }

  String get etatLabel {
    if (!isOnline) return 'Hors ligne';
    if (hasAlert) return 'Alerte';
    return 'OK';
  }
}
