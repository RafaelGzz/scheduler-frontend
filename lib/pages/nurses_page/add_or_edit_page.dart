import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scheduler_frontend/models/nurse/nurse.dart';
import 'package:scheduler_frontend/models/time_frame/time_frame.dart';
import 'package:scheduler_frontend/services/nurse_service.dart';

import 'widgets/custom_input.dart';
import 'widgets/hour_button.dart';

class AddOrEditNursePage extends StatefulWidget {
  const AddOrEditNursePage({Key? key, this.nurse}) : super(key: key);
  final Nurse? nurse;
  @override
  State<AddOrEditNursePage> createState() => _AddOrEditNursePageState();
}

class _AddOrEditNursePageState extends State<AddOrEditNursePage> {
  NurseService ns = NurseService();
  Nurse? nurse;
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  late TimeOfDay shiftStart;
  late TimeOfDay shiftEnd;

  @override
  void initState() {
    nurse = widget.nurse;
    idController.text = widget.nurse?.nurseId.toString() ??
        DateTime.now().millisecondsSinceEpoch.toString();
    nameController.text = widget.nurse?.name ?? "";
    shiftStart = widget.nurse?.workSchedule!.start ??
        TimeOfDay.fromDateTime(DateTime.now());
    shiftEnd = widget.nurse?.workSchedule!.end ??
        TimeOfDay.fromDateTime(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                header(),
                const Divider(),
                body(context),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Column body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        inputs(),
        const Divider(),
        workShift(),
        const SizedBox(
          height: 15,
        ),
        if (widget.nurse != null) workDays(size),
        const SizedBox(
          height: 15,
        ),
        buttons(context),
      ],
    );
  }

  Widget workDays(Size size) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              child: Text(
                "Dias de trabajo",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 300,
          width: size.width,
          child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                    height: 10,
                  ),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  workDayTile(nurse!.workDays![index]),
              itemCount: nurse!.workDays!.length),
        ),
      ],
    );
  }

  Widget workDayTile(WorkDay workDay) {
    List<String> weekDays = [
      "Lunes",
      "Martes",
      "Miercoles",
      "Jueves",
      "Viernes",
      "Sabado",
      "Domingo"
    ];
    List<String> months = [
      "Enero",
      "Febrero",
      "Marzo",
      "Abril",
      "Mayo",
      "Junio",
      "Julio",
      "Agosto",
      "Septiembre",
      "Octubre",
      "Noviembre",
      "Diciembre"
    ];
    DateTime date = DateTime.parse(workDay.date!);
    String fecha = weekDays[date.weekday] +
        " " +
        date.day.toString() +
        " de " +
        months[date.month - 1];
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 50,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Color(0xff0A66BF),
          ),
          child: Text(
            fecha,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          alignment: Alignment.center,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: workDay.workHours!.length,
          itemBuilder: (context, index) => WorkHourTile(
            workHour: workDay.workHours![index],
            onAnyChanged: (WorkHour wh) {
              workDay.workHours![index] = wh;
            },
          ),
        )
      ],
    );
  }

  Widget workShift() {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              child: Text(
                "Inicio de turno",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ),
            Expanded(
              child: Text(
                "Fin de turno",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            HourButton(
              time: shiftStart,
              onSelectTime: (TimeOfDay time) {
                shiftStart = time;
              },
            ),
            HourButton(
              time: shiftEnd,
              onSelectTime: (TimeOfDay time) {
                shiftEnd = time;
              },
            )
          ],
        ),
      ],
    );
  }

  Column inputs() {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              child: Text(
                "ID",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ),
            Expanded(
              child: Text(
                "Nombre",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            )
          ],
        ),
        Row(
          children: [
            CustomInput(label: "ID", controller: idController, disabled: true),
            CustomInput(label: "Nombre", controller: nameController),
          ],
        ),
      ],
    );
  }

  void doProcess() async {
    String id = idController.text;
    String name = nameController.text;
    bool edit = true;

    if (widget.nurse == null) {
      edit = false;
      nurse = Nurse();
      nurse!.workSchedule = TimeFrame();
      nurse!.nurseId = int.parse(id);
    }
    nurse!.name = name;
    nurse!.workSchedule!.start = shiftStart;
    nurse!.workSchedule!.end = shiftEnd;

    String message;
    bool success = false;
    if (edit) {
      if (await ns.editNurse(nurse!)) {
        success = true;
        message = "Éxito";
      } else {
        message = "Error en la edición.";
      }
    } else {
      if (await ns.addNurse(nurse!)) {
        success = true;
        message = "Exito";
      } else {
        message = "Error al añadir";
      }
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          Center(
            child: MaterialButton(
              onPressed: () => Navigator.of(context).popUntil(
                ModalRoute.withName("adminPage"),
              ),
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

  Row buttons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: doProcess,
              child: Text(
                widget.nurse == null ? "Añadir" : "Editar",
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
              color: Colors.grey[300],
              height: 50,
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.redAccent, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15)),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancelar",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Text header() {
    return const Text(
      "Enfermero",
      style: TextStyle(
          color: Color(0xff0A66BF), fontWeight: FontWeight.w300, fontSize: 30),
    );
  }
}

class WorkHourTile extends StatefulWidget {
  const WorkHourTile({Key? key, required this.workHour, this.onAnyChanged})
      : super(key: key);
  final WorkHour workHour;
  final Function(WorkHour)? onAnyChanged;
  @override
  _WorkHourTileState createState() => _WorkHourTileState();
}

class _WorkHourTileState extends State<WorkHourTile> {
  TextEditingController breakTime = TextEditingController();
  TextEditingController workHours = TextEditingController();
  late WorkHour workHour;
  @override
  void initState() {
    workHour = widget.workHour;
    breakTime.text = workHour.breakTime?.toString() ?? "";
    workHours.text = workHour.workedHours?.toString() ?? "";

    breakTime.addListener(() {
      workHour.breakTime =
          int.parse(breakTime.text != "" ? breakTime.text : "0");
      widget.onAnyChanged?.call(workHour);
    });
    workHours.addListener(() {
      workHour.workedHours =
          int.parse(workHours.text != "" ? workHours.text : "0");
      widget.onAnyChanged?.call(workHour);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HourButton(
          time: workHour.start,
          borderRadius: 0,
          onSelectTime: (TimeOfDay time) {
            workHour.start = time;
            widget.onAnyChanged?.call(workHour);
          },
        ),
        HourButton(
          time: workHour.end,
          borderRadius: 0,
          onSelectTime: (TimeOfDay time) {
            workHour.end = time;
            widget.onAnyChanged?.call(workHour);
          },
        ),
        CustomInput(label: "Minutos de descanso", controller: breakTime),
        CustomInput(label: "Horas trabajadas", controller: workHours)
      ],
    );
  }
}
