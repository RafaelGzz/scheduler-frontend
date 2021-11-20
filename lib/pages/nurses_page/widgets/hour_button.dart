import 'package:flutter/material.dart';
import 'package:scheduler_frontend/services/nurse_service.dart';

class HourButton extends StatefulWidget {
  const HourButton(
      {Key? key, this.time, this.onSelectTime, this.borderRadius = 10})
      : super(key: key);
  final TimeOfDay? time;
  final double borderRadius;
  final Function(TimeOfDay)? onSelectTime;
  @override
  _HourButtonState createState() => _HourButtonState();
}

class _HourButtonState extends State<HourButton> {
  late TimeOfDay time;
  NurseService ns = NurseService();
  @override
  void initState() {
    time = widget.time!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius)),
          onPressed: () => widget.time != null ? _selectTime(context) : null,
          child: Text(
            time.format(context),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
          ),
          color: const Color(0xff0A66BF),
          height: 50,
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: time,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != time) {
      setState(() {
        time = timeOfDay;
        widget.onSelectTime?.call(time);
      });
    }
  }
}
