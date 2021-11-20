import 'dart:convert';

import 'package:scheduler_frontend/models/nurse/nurse.dart';

import 'package:http/http.dart' as http;
import 'package:scheduler_frontend/models/nurse_status/nurse_status.dart';
import 'package:scheduler_frontend/models/nurses_response.dart';

class NurseService {
  static final NurseService _instance = NurseService._();

  factory NurseService() {
    return _instance;
  }

  NurseService._();

  List<NurseStatus?> _nursesStatus = [];
  set addNurseStatus(status) {
    _nursesStatus.add(status);
  }

  set nursesStatus(status) {
    _nursesStatus = status;
  }

  get nursesStatus => _nursesStatus;

  NurseStatus? getNurseStatus(int id) {
    return _nursesStatus.firstWhere(
      (nurse) => nurse?.nurseId == id,
      orElse: () => null,
    );
  }

  void editNurseShift(Shift shift, int nurseId) {
    print(_nursesStatus.first?.shifts?.length);
    for (int i = 0; i < _nursesStatus.length; i++) {
      if (nurseId == _nursesStatus[i]?.nurseId) {
        _nursesStatus[i]?.shifts?.last = shift;
        // _nursesStatus[i]?.shifts?.forEach((shift) {
        //   print("---------------");
        //   print(_nursesStatus[i]?.nurseId);
        //   print("break");
        //   print(shift.totalBreakHours);
        //   print("initTurn");
        //   print(shift.initTurn?.second ?? 0);
        //   print("endTurn");
        //   print(shift.endTurn?.second ?? 0);
        //   print("initBreak");
        //   print(shift.initBreak?.second ?? 0);
        //   print("endBreak");
        //   print(shift.endBreak?.second ?? 0);
        //   print("---------------");
        // });
      }
    }
  }

  void addNurseShift(int nurseId) {
    for (int i = 0; i < _nursesStatus.length; i++) {
      if (nurseId == _nursesStatus[i]?.nurseId) {
        _nursesStatus[i]?.shifts?.add(Shift());
      }
    }
  }

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
