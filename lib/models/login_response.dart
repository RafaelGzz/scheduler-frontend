// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  String? status;
  int? statusCode;
  String? message;
  Data? data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"] as String?,
        statusCode: json["statusCode"] as int?,
        message: json["message"] as String?,
        data: Data.fromJson(json["data"]) as Data?,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.token,
  });

  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
