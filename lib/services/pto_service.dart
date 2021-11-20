import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scheduler_frontend/models/pto/pto.dart';
import 'package:scheduler_frontend/models/ptos_response.dart';
import 'package:scheduler_frontend/services/admin_service.dart';

class PtoService {
  static final PtoService _instance = PtoService._();

  factory PtoService() {
    return _instance;
  }

  PtoService._();

  late List<Pto> _allptos;
  Future<List<Pto>> getAllPtos() async {
    final aS = AdminService();

    final url = Uri.parse("https://schedulerr2-backend.herokuapp.com/api/pto/");
    final resp = await http.get(url,
        headers: {'Content-Type': 'application/json', "auth-token": aS.token!});

    final ptos = ptosResponseFromJson(resp.body);
    _allptos = ptos.data ?? List.empty();

    return _allptos;
  }

  Future<bool> editPto(Pto pto) async {
    final aS = AdminService();
    final url = Uri.parse(
        "https://schedulerr2-backend.herokuapp.com/api/pto/edit/" + pto.id!);
    final body = jsonEncode(pto);

    final resp = await http.put(url,
        headers: {'Content-Type': 'application/json', "auth-token": aS.token!},
        body: body);
    print(resp.body);
    if (resp.statusCode == 200)
      return true;
    else
      return false;
  }
}
