import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduler_frontend/models/nurse/nurse.dart';
import 'package:scheduler_frontend/services/nurse_service.dart';

class HeaderContent extends StatefulWidget {
  const HeaderContent({
    Key? key,
    required this.searchKey,
    this.onKeyChanged,
    this.onNurseSelected,
  }) : super(key: key);

  final String searchKey;
  final Function(String)? onKeyChanged;
  final Function(Nurse)? onNurseSelected;

  @override
  _HeaderContentState createState() => _HeaderContentState();
}

class _HeaderContentState extends State<HeaderContent> {
  NurseService nurseService = NurseService();

  Nurse? selectedNurse;

  @override
  Widget build(BuildContext context) {
    Widget _nurseCodeTile(Nurse nurse) {
      return Padding(
        padding: const EdgeInsets.only(left: 25),
        child: InkWell(
          onTap: () {
            setState(() {
              selectedNurse = nurse;
              print(selectedNurse);
              widget.onKeyChanged?.call(selectedNurse!.nurseId!.toString());
            });
          },
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: const Icon(
                Icons.local_hospital,
                size: 40,
                color: Colors.blue,
              ),
              title: Text(
                nurse.nurseId.toString(),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: FutureBuilder(
              future: nurseService.getAllNurses(),
              builder: (context, AsyncSnapshot<List<Nurse>> snapshot) {
                List<Nurse> nurses = [];
                Widget? child;
                if (snapshot.hasData && snapshot.data?.isNotEmpty == true) {
                  if (widget.searchKey != '') {
                    nurses = snapshot.data!
                        .where((nurse) =>
                            nurse.nurseId.toString().contains(widget.searchKey))
                        .toList();
                  } else {
                    nurses = snapshot.data!;
                  }

                  if (nurses.isNotEmpty) {
                    child = ListView.builder(
                      itemBuilder: (context, index) =>
                          _nurseCodeTile(nurses[index]),
                      itemCount: nurses.length,
                    );
                  } else {
                    child = const Text(
                        "No hay enfermeras que coincidan con esa clave");
                  }
                } else {
                  child = const CupertinoActivityIndicator(
                    radius: 25,
                  );
                }

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  child: child,
                );
              },
            ),
          ),
          if (selectedNurse != null)
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedNurse!.name!,
                    style: const TextStyle(fontSize: 27),
                  ),
                  const Divider(),
                  const Text(
                    "Horario: 10 a 20",
                    style: TextStyle(fontSize: 27),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: MaterialButton(
                      minWidth: 400,
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.blue,
                      onPressed: () {
                        widget.onNurseSelected?.call(selectedNurse!);
                        // FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: const Text(
                        "Ingresar",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
