import 'package:flutter/material.dart';
import 'package:scheduler_frontend/models/time_frame/time_frame.dart';

class Nurse {
  Nurse({
    this.nurseId,
    this.name,
    this.daysOffAvailable,
    this.weekHours,
    this.workSchedule,
    this.workDays,
  });

  int? nurseId;
  String? name;
  int? daysOffAvailable = 1;
  int? weekHours;
  TimeFrame? workSchedule;
  List<WorkDay>? workDays;

  factory Nurse.fromJson(Map<String, dynamic> json) => Nurse(
        nurseId: json["nurse_id"],
        name: json["name"],
        daysOffAvailable: json["days_off_available"],
        weekHours: json["week_hours"],
        workSchedule: TimeFrame.fromJson(json["work_schedule"]),
        workDays: json["work_days"] != null
            ? List<WorkDay>.from(
                json["work_days"].map((x) => WorkDay.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "nurse_id": nurseId,
        "name": name,
        "days_off_available": daysOffAvailable,
        "week_hours": weekHours,
        "work_schedule": workSchedule?.toJson(),
        "work_days": workDays == null
            ? null
            : List<dynamic>.from(workDays!.map((x) => x.toJson())),
      };
}

class WorkDay {
  WorkDay({
    this.workHours,
    this.date,
  });

  List<WorkHour>? workHours;
  String? date;

  factory WorkDay.fromJson(Map<String, dynamic> json) => WorkDay(
        workHours: List<WorkHour>.from(
            json["work_hours"].map((x) => WorkHour.fromJson(x))),
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "work_hours": workHours == null
            ? null
            : List<dynamic>.from(workHours!.map((x) => x.toJson())),
        "date": date,
      };
}

class WorkHour {
  WorkHour({
    this.start,
    this.end,
    this.breakTime,
    this.workedHours,
  });

  TimeOfDay? start;
  TimeOfDay? end;
  int? breakTime;
  int? workedHours;

  factory WorkHour.fromJson(Map<String, dynamic> json) => WorkHour(
        start: json['start'] == null
            ? null
            : TimeOfDay(
                hour: int.parse(json['start'].toString().split(":")[0]),
                minute: int.parse(json['start'].toString().split(":")[1])),
        end: json['end'] == null
            ? null
            : TimeOfDay(
                hour: int.parse(json['end'].toString().split(":")[0]),
                minute: int.parse(json['end'].toString().split(":")[1])),
        breakTime: json["break_time"],
        workedHours: json["worked_hours"],
      );

  Map<String, dynamic> toJson() => {
        "start": start != null
            ? start!.hour.toString() + ":" + start!.minute.toString()
            : null,
        "end": end != null
            ? end!.hour.toString() + ":" + end!.minute.toString()
            : null,
        "break_time": breakTime,
        "worked_hours": workedHours,
      };
}
