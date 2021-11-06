// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nurse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nurse _$NurseFromJson(Map<String, dynamic> json) {
  return Nurse(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    nurseId: json['nurseId'] as String?,
    daysOffAvailable: json['daysOffAvailable'] as int?,
    workSchedule: json['workSchedule'] == null
        ? null
        : TimeFrame.fromJson(json['workSchedule'] as Map<String, dynamic>),
    breakHours: json['breakHours'] == null
        ? null
        : TimeFrame.fromJson(json['breakHours'] as Map<String, dynamic>),
    workHours: json['workHours'] == null
        ? null
        : TimeFrame.fromJson(json['workHours'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NurseToJson(Nurse instance) => <String, dynamic>{
      '_id': instance.id,
      'nurseId': instance.nurseId,
      'name': instance.name,
      'daysOffAvailable': instance.daysOffAvailable,
      'workSchedule': instance.workSchedule,
      'workHours': instance.workHours,
      'breakHours': instance.breakHours,
    };
