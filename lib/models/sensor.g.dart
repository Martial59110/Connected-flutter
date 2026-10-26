// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Sensor _$SensorFromJson(Map<String, dynamic> json) => _Sensor(
  id: json['id'] as String,
  name: json['name'] as String,
  room: json['room'] as String,
  temperature: (json['temperature'] as num).toDouble(),
  humidity: (json['humidity'] as num).toDouble(),
  battery: (json['battery'] as num).toDouble(),
  lastMeasuredAt: json['lastMeasuredAt'] == null
      ? null
      : DateTime.parse(json['lastMeasuredAt'] as String),
  isOnline: json['isOnline'] as bool? ?? false,
  hasAlert: json['hasAlert'] as bool? ?? false,
);

Map<String, dynamic> _$SensorToJson(_Sensor instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'room': instance.room,
  'temperature': instance.temperature,
  'humidity': instance.humidity,
  'battery': instance.battery,
  'lastMeasuredAt': instance.lastMeasuredAt?.toIso8601String(),
  'isOnline': instance.isOnline,
  'hasAlert': instance.hasAlert,
};
