// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nurse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nurse _$NurseFromJson(Map<String, dynamic> json) {
  return Nurse(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    nurseId: json['nurse_id'] as int?,
    daysOffAvailable: json['days_off_available'] as int?,
    workSchedule: json['work_schedule'] == null
        ? null
        : TimeFrame.fromJson(json['work_schedule'] as Map<String, dynamic>),
    breakHours: json['break_hours'] == null
        ? null
        : TimeFrame.fromJson(json['break_hours'] as Map<String, dynamic>),
    workHours: json['work_hours'] == null
        ? null
        : TimeFrame.fromJson(json['work_hours'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NurseToJson(Nurse instance) => <String, dynamic>{
      '_id': instance.id,
      'nurse_id': instance.nurseId,
      'name': instance.name,
      'days_off_available': instance.daysOffAvailable,
      'work_schedule': instance.workSchedule,
      'work_hours': instance.workHours,
      'break_hours': instance.breakHours,
    };
