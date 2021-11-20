// To parse this JSON data, do
//
//     final ptosResponse = ptosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:scheduler_frontend/models/pto/pto.dart';

PtosResponse ptosResponseFromJson(String str) =>
    PtosResponse.fromJson(json.decode(str));

String ptosResponseToJson(PtosResponse data) => json.encode(data.toJson());

class PtosResponse {
  PtosResponse({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  String? status;
  int? statusCode;
  String? message;
  List<Pto>? data;

  factory PtosResponse.fromJson(Map<String, dynamic> json) => PtosResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<Pto>.from(json["data"].map((x) => Pto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
