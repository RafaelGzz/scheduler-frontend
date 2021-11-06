import 'package:flutter/material.dart';
import 'package:scheduler_frontend/models/nurse/nurse.dart';
import 'package:scheduler_frontend/services/nurse_service.dart';

class NursesPage extends StatelessWidget {
  const NursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NurseService ns = NurseService();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: Material(
                  color: const Color(0xff0A66BF),
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Container(
                    color: Colors.white,
                    margin: const EdgeInsets.only(top: 30),
                    padding: const EdgeInsets.all(20),
                    height: size.height * 0.5,
                    width: size.width * 0.9,
                    child: FutureBuilder(
                      future: ns.getAllNurses(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Nurse>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (_, i) =>
                                    nurseTile(snapshot.data![i]));
                          } else {
                            return const Center(
                                child: Text("No hay enfermeros"));
                          }
                        }
                        return Center(child: const CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(nurse.nurseId!.toString()),
                Text(nurse.name!),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: MaterialButton(
                      onPressed: () {},
                      child:
                          Text("Editar", style: TextStyle(color: Colors.white)),
                      color: Color(0xff0A66BF),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text("Eliminar",
                          style: TextStyle(color: Colors.white)),
                      color: Colors.redAccent,
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
