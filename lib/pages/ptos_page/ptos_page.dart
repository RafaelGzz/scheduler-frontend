import 'package:flutter/material.dart';
import 'package:scheduler_frontend/models/nurse/nurse.dart';
import 'package:scheduler_frontend/models/pto/pto.dart';
import 'package:scheduler_frontend/services/pto_service.dart';

class PtosPage extends StatefulWidget {
  const PtosPage({Key? key, required this.nurse}) : super(key: key);
  final Nurse nurse;

  @override
  State<PtosPage> createState() => _PtosPageState();
}

class _PtosPageState extends State<PtosPage> {
  DateTime? date;
  late List<Pto>? ptos;

  PtoService pts = PtoService();

  Future getPtos() async {
    ptos = await pts.getPtosByNurse(widget.nurse.nurseId!);
    print(ptos);
  }

  @override
  void initState() {
    getPtos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 35, right: 35, top: 70),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 500,
                    margin: const EdgeInsets.only(top: 35, right: 35),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 80,
                          spreadRadius: 1,
                          color: Colors.black.withOpacity(.1),
                        )
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.person_sharp,
                              size: 100,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.nurse.name!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 80,
                          spreadRadius: 1,
                          color: Colors.black.withOpacity(.1),
                        )
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Vacaciones disponibles",
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              widget.nurse.daysOffAvailable.toString(),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 35, right: 35),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 80,
                          spreadRadius: 1,
                          color: Colors.black.withOpacity(.1),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 35, bottom: 35),
                  height: 300,
                  width: 800,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 80,
                        spreadRadius: 1,
                        color: Colors.black.withOpacity(.1),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: const Text(
                          "Solicitud de Vacaciones",
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 120,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.calendar_today,
                                      size: 100,
                                    ),
                                    onPressed: () async {
                                      date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now().add(
                                          const Duration(days: 365),
                                        ),
                                      );
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    date != null
                                        ? date!
                                            .toLocal()
                                            .toString()
                                            .substring(0, 10)
                                        : "Seleccione un dia para solicitarlo",
                                    style: TextStyle(
                                        fontSize: date != null ? 40 : 25),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: MaterialButton(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    onPressed: () async {},
                                    color: const Color(0xff0A66BF),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 25.0, vertical: 10),
                                      child: Text(
                                        "Solicitar",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 40),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(top: 35, bottom: 70),
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 80,
                        spreadRadius: 1,
                        color: Colors.black.withOpacity(.1),
                      )
                    ],
                  ),
                  child: ptos?.isNotEmpty == true
                      ? ListView.builder(
                          itemBuilder: (_, index) => Text(
                              "${ptos?[index].date!.toLocal().toString().substring(0, 10)} | Estatus: ${ptos?[index].status}"),
                          itemCount: ptos?.length,
                        )
                      : Center(
                          child: Text("No hay solicitudes previas"),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
