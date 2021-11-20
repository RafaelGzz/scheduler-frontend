import 'package:flutter/material.dart';
import 'package:scheduler_frontend/models/nurse/nurse.dart';
import 'package:scheduler_frontend/models/pto/pto.dart';
import 'package:scheduler_frontend/services/nurse_service.dart';
import 'package:scheduler_frontend/services/pto_service.dart';

class AdminPtoPage extends StatefulWidget {
  const AdminPtoPage({Key? key}) : super(key: key);

  @override
  State<AdminPtoPage> createState() => _AdminPtoPageState();
}

class _AdminPtoPageState extends State<AdminPtoPage> {
  PtoService ps = PtoService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: ptoCard(size, ps),
      ),
    );
  }

  Widget ptoCard(Size size, PtoService ns) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        color: Colors.white,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            header(),
            const Divider(height: 30),
            ptoList(size, ns),
          ],
        ),
      ),
    );
  }

  Widget ptoList(Size size, PtoService ns) {
    return Container(
      height: size.height * 0.8,
      color: Colors.white,
      child: FutureBuilder(
        future: ns.getAllPtos(),
        builder: (BuildContext context, AsyncSnapshot<List<Pto>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        height: 10,
                      ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, i) => ptoTile(snapshot.data![i], context));
            } else {
              return const Center(child: Text("No hay pto's"));
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void doProcess(Pto pto, String status) async {
    pto.status = status;
    String message;
    if (await ps.editPto(pto)) {
      message = "Éxito";
    } else {
      message = "Error.";
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          Center(
            child: MaterialButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Aceptar"),
              color: Colors.green,
            ),
          )
        ],
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ptoTile(Pto pto, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(pto.id!.toString(),
                      style: const TextStyle(
                          color: Color(0xff0A66BF), fontSize: 18)),
                ),
              ),
              Expanded(
                child: Text(
                  pto.nurseId.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: pto.status == "pending"
                              ? () => doProcess(pto, "approved")
                              : () {},
                          child: const Text(
                            "Aceptar",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          color: pto.status == "pending"
                              ? const Color(0xff0A66BF)
                              : Colors.grey,
                          height: 50,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: pto.status == "pending"
                              ? () => doProcess(pto, "denied")
                              : () {},
                          child: const Text(
                            "Rechazar",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          color: pto.status == "pending"
                              ? Colors.redAccent
                              : Colors.grey,
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  pto.status.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget header() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("ID",
                      style: TextStyle(color: Color(0xff0A66BF), fontSize: 20)),
                ),
              ),
              Expanded(
                child: Text(
                  "Enfermero",
                  style: TextStyle(fontSize: 20, color: Color(0xff0A66BF)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("Acción",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Color(0xff0A66BF))),
                ),
              ),
              Expanded(
                child: Text(
                  "Status",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Color(0xff0A66BF)),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
