// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scedule _$SceduleFromJson(Map<String, dynamic> json) => Scedule(
      weekday: json['weekday'] as String,
      time: (json['time'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SceduleToJson(Scedule instance) => <String, dynamic>{
      'weekday': instance.weekday,
      'time': instance.time,
    };
