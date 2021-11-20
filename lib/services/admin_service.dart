import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scheduler_frontend/models/login_response.dart';

class AdminService {
  static final AdminService _instance = AdminService._();

  factory AdminService() {
    return _instance;
  }

  AdminService._();

  String? token;

  Future<bool> login(String user, String password) async {
    final data = {
      "username": user,
      "password": password,
    };

    final url =
        Uri.parse("https://schedulerr2-backend.herokuapp.com/api/auth/login");

    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    final loginResponse = loginResponseFromJson(resp.body);
    if (loginResponse.statusCode == 200) {
      token = loginResponse.data!.token;
      return true;
    } else {
      return false;
    }
  }
}
