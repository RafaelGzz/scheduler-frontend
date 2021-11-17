import 'package:flutter/material.dart';
import 'package:scheduler_frontend/services/nurse_service.dart';

class AddOrEditNursePage extends StatefulWidget {
  AddOrEditNursePage({Key? key, this.shiftStart, this.shiftEnd})
      : super(key: key);
  TimeOfDay? shiftStart;
  TimeOfDay? shiftEnd;
  @override
  State<AddOrEditNursePage> createState() => _AddOrEditNursePageState();
}

class _AddOrEditNursePageState extends State<AddOrEditNursePage> {
  NurseService ns = NurseService();

  @override
  Widget build(BuildContext context) {
    widget.shiftStart =
        widget.shiftStart ?? TimeOfDay.fromDateTime(DateTime.now());
    widget.shiftEnd = widget.shiftEnd ?? TimeOfDay.fromDateTime(DateTime.now());
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: addNurse(size, context),
          ),
        ),
      ),
    );
  }

  Widget addNurse(Size size, BuildContext context) {
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
            Container(
              padding: const EdgeInsets.only(top: 5),
              child: const Text(
                "Añadir",
                style: TextStyle(
                    color: Color(0xff0A66BF),
                    fontWeight: FontWeight.w300,
                    fontSize: 30),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      customInput("ID"),
                      customInput("Nombre"),
                    ],
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          "Inicio de turno",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Fin de turno",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      HourButton(time: widget.shiftStart!),
                      HourButton(time: widget.shiftEnd!)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded customInput(String text) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
        child: TextField(
          autocorrect: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            labelText: text,
            hintText: text,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class HourButton extends StatefulWidget {
  HourButton({Key? key, required this.time}) : super(key: key);
  TimeOfDay time;
  @override
  _HourButtonState createState() => _HourButtonState();
}

class _HourButtonState extends State<HourButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () => _selectTime(context),
          child: Text(
            widget.time.format(context),
            style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w400,
                fontSize: 15),
          ),
          color: Colors.grey[300],
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: widget.time,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != widget.time) {
      setState(() {
        widget.time = timeOfDay;
      });
    }
  }
}
