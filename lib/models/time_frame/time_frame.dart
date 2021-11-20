import 'package:flutter/material.dart';

class TimeFrame {
  TimeFrame({
    this.start,
    this.end,
  });

  TimeOfDay? start;
  TimeOfDay? end;

  factory TimeFrame.fromJson(Map<String, dynamic> json) => TimeFrame(
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
      );

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, TimeOfDay? value) {
      if (value != null) {
        val[key] = value.hour.toString() + ":" + value.minute.toString();
      }
    }

    writeNotNull('start', start);
    writeNotNull('end', end);
    return val;
  }
}
