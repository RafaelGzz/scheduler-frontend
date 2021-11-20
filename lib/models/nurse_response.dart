// To parse this JSON data, do
//
//     final nurseResponse = nurseResponseFromJson(jsonString);

import 'dart:convert';

import 'package:scheduler_frontend/models/nurse/nurse.dart';

NurseResponse nurseResponseFromJson(String str) =>
    NurseResponse.fromJson(json.decode(str));

String nurseResponseToJson(NurseResponse data) => json.encode(data.toJson());

class NurseResponse {
  NurseResponse({
    this.status,
    this.statusCode,
    this.message,
    this.nurse,
  });

  String? status;
  int? statusCode;
  String? message;
  Nurse? nurse;

  factory NurseResponse.fromJson(Map<String, dynamic> json) => NurseResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        nurse: Nurse.fromJson(json["Nurse"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "Nurse": nurse == null ? null : nurse!.toJson(),
      };
}
