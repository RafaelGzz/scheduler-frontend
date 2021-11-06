import 'package:flutter/material.dart';
import 'package:scheduler_frontend/models/nurse/nurse.dart';
import 'package:scheduler_frontend/services/nurse_service.dart';

class NursesPage extends StatefulWidget {
  @override
  State<NursesPage> createState() => _NursesPageState();
}

class _NursesPageState extends State<NursesPage> {
  TimeOfDay selected = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    NurseService ns = NurseService();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
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
                        Container(
                            padding: const EdgeInsets.only(top: 5),
                            child: const Text("Enfermeros",
                                style: TextStyle(
                                    color: Color(0xff0A66BF),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 30))),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.white,
                          height: size.height * 0.4,
                          width: size.width * 0.8,
                          child: nurseList(ns),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
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
                        Container(
                            padding: const EdgeInsets.only(top: 5),
                            child: const Text("Añadir",
                                style: TextStyle(
                                    color: Color(0xff0A66BF),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 30))),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: size.height * 0.4,
                          width: size.width * 0.8,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  customInput("ID"),
                                  customInput("Nombre"),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: MaterialButton(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        onPressed: () => _selectTime(context),
                                        child: Text("Hora de Inicio",
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15)),
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: MaterialButton(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        onPressed: () => _selectTime(context),
                                        child: Text("Hora de Fin",
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15)),
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selected,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selected) {
      setState(() {
        selected = timeOfDay;
      });
    }
  }

  Expanded customInput(String text) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
        child: TextField(
          autocorrect: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            hintText: text,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<Nurse>> nurseList(NurseService ns) {
    return FutureBuilder(
      future: ns.getAllNurses(),
      builder: (BuildContext context, AsyncSnapshot<List<Nurse>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (_, i) => nurseTile(snapshot.data![i]));
          } else {
            return const Center(child: Text("No hay enfermeros"));
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget nurseTile(Nurse nurse) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(nurse.nurseId!.toString(),
                    style: TextStyle(color: Color(0xff0A66BF))),
                Text(nurse.name!),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {},
                      child: const Text("Editar",
                          style: TextStyle(fontWeight: FontWeight.w300)),
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {},
                      child: const Text("Eliminar",
                          style: TextStyle(color: Colors.white)),
                      color: const Color(0xff0A66BF),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
