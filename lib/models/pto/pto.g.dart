// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pto _$PtoFromJson(Map<String, dynamic> json) {
  return Pto(
    id: json['_id'] as String?,
    nurseId: json['nurseId'] as int?,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    status: json['status'] as String?,
  );
}

Map<String, dynamic> _$PtoToJson(Pto instance) => <String, dynamic>{
      '_id': instance.id,
      'nurseId': instance.nurseId,
      'date': instance.date?.toIso8601String(),
      'status': instance.status,
    };
