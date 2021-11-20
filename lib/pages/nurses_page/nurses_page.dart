import 'package:flutter/material.dart';
import 'package:scheduler_frontend/models/nurse/nurse.dart';
import 'package:scheduler_frontend/pages/nurses_page/add_or_edit_page.dart';
import 'package:scheduler_frontend/services/nurse_service.dart';

class NursesPage extends StatelessWidget {
  const NursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NurseService ns = NurseService();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: fab(context),
      body: SafeArea(
        child: nurseCard(size, ns),
      ),
    );
  }

  FloatingActionButton fab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => AddOrEditNursePage(),
      ),
      backgroundColor: const Color(0xff0A66BF),
      child: const Icon(Icons.add),
    );
  }

  Widget nurseCard(Size size, NurseService ns) {
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
            nurseList(size, ns),
          ],
        ),
      ),
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
                  "Nombre",
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
                  child: Text("Editar",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Color(0xff0A66BF))),
                ),
              ),
              Expanded(
                child: Text(
                  "Eliminar",
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

  Widget nurseList(Size size, NurseService ns) {
    return Container(
      height: size.height * 0.8,
      color: Colors.white,
      child: FutureBuilder(
        future: ns.getAllNurses(),
        builder: (BuildContext context, AsyncSnapshot<List<Nurse>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        height: 10,
                      ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, i) => nurseTile(snapshot.data![i], context));
            } else {
              return const Center(child: Text("No hay enfermeros"));
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget nurseTile(Nurse nurse, BuildContext context) {
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
                  child: Text(nurse.nurseId!.toString(),
                      style: const TextStyle(
                          color: Color(0xff0A66BF), fontSize: 18)),
                ),
              ),
              Expanded(
                child: Text(
                  nurse.name!,
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
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => AddOrEditNursePage(
                        nurse: nurse,
                      ),
                    ),
                    child: const Text(
                      "Editar",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                    color: Colors.grey[300],
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
                    onPressed: () {},
                    child: const Text(
                      "Eliminar",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                    color: const Color(0xff0A66BF),
                    height: 50,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
