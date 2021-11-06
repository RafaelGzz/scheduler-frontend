import 'package:json_annotation/json_annotation.dart';
import 'package:scheduler_frontend/models/time_frame/time_frame.dart';
part 'nurse.g.dart';

@JsonSerializable()
class Nurse {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "nurse_id")
  int? nurseId;
  String? name;

  @JsonKey(name: "days_off_available")
  int? daysOffAvailable;

  @JsonKey(name: "work_schedule")
  TimeFrame? workSchedule;

  @JsonKey(name: "work_hours")
  TimeFrame? workHours;

  @JsonKey(name: "break_hours")
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
