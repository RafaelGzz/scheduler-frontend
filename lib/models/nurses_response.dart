// To parse this JSON data, do
//
//     final nursesResponse = nursesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:scheduler_frontend/models/nurse/nurse.dart';

NursesResponse nursesResponseFromJson(String str) =>
    NursesResponse.fromJson(json.decode(str));

String nursesResponseToJson(NursesResponse data) => json.encode(data.toJson());

class NursesResponse {
  NursesResponse({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  String? status;
  int? statusCode;
  String? message;
  List<Nurse>? data;

  factory NursesResponse.fromJson(Map<String, dynamic> json) => NursesResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<Nurse>.from(json["data"].map((x) => Nurse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
