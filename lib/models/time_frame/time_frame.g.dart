// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_frame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeFrame _$TimeFrameFromJson(Map<String, dynamic> json) {
  return TimeFrame(
    start:
        json['start'] == null ? null : DateTime.parse(json['start'] as String),
    end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
  );
}

Map<String, dynamic> _$TimeFrameToJson(TimeFrame instance) => <String, dynamic>{
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
    };
