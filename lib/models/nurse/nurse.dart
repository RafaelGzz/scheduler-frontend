import 'package:json_annotation/json_annotation.dart';
import 'package:scheduler_frontend/models/TimeFrame/time_frame.dart';
part 'nurse.g.dart';

@JsonSerializable()
class Nurse {
  @JsonKey(name: "_id")
  String? id;
  String? nurseId;
  String? name;
  int? daysOffAvailable;
  TimeFrame? workSchedule;
  TimeFrame? workHours;
  TimeFrame? breakHours;

  Nurse({
    this.id,
    this.name,
    this.nurseId,
    this.daysOffAvailable,
    this.workSchedule,
    this.breakHours,
    this.workHours,
  });

  Map<String, dynamic> toJson() => _$NurseToJson(this);

  factory Nurse.fromJson(Map<String, dynamic> json) => _$NurseFromJson(json);
}
