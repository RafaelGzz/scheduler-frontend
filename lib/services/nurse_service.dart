import 'dart:convert';

import 'package:scheduler_frontend/models/nurse/nurse.dart';

import 'package:http/http.dart' as http;
import 'package:scheduler_frontend/models/nurses_response.dart';

class NurseService {
  static final NurseService _instance = NurseService._();

  factory NurseService() {
    return _instance;
  }

  NurseService._();

  Future<List<Nurse>> getAllNurses() async {
    final url =
        Uri.parse("https://schedulerr2-backend.herokuapp.com/api/nurse/");

    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    final nurses = nursesResponseFromJson(resp.body);

    return nurses.data ?? List.empty();
  }

  Future<bool> editNurse(Nurse nurse) async {
    final url =
        Uri.parse("https://schedulerr2-backend.herokuapp.com/api/nurse/edit");

    final resp = await http.put(url,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(nurse));

    print("RESPUESTA: " + resp.body);
    if (resp.statusCode == 200)
      return true;
    else
      return false;
  }

  Future<bool> addNurse(Nurse nurse) async {
    final url =
        Uri.parse("https://schedulerr2-backend.herokuapp.com/api/nurse/add");
    final body = jsonEncode(nurse);

    print(body);

    final resp = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: body);

    print("RESPUESTA: " + resp.body);
    if (resp.statusCode == 200)
      return true;
    else
      return false;
  }
}
