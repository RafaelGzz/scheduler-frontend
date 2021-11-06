import 'package:flutter/material.dart';
import 'package:scheduler_frontend/models/nurse/nurse.dart';
import 'package:scheduler_frontend/pages/home/widgets/header_content.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
    required this.width,
    this.onNurseSelected,
  }) : super(key: key);

  final double width;
  final Function(Nurse)? onNurseSelected;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool isActive = false;

  TextEditingController keyController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: 0,
      right: 0,
      top: isActive ? -30 : -320,
      duration: const Duration(milliseconds: 300),
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.all(30),
          width: widget.width,
          height: 500,
          child: Focus(
            onFocusChange: (hasFocus) {
              if (!hasFocus) {
                setState(() {
                  isActive = false;
                });
              } else {
                setState(() {
                  isActive = true;
                });
              }
            },
            child: Column(
              mainAxisAlignment:
                  !isActive ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                const Text(
                  "Escribe aqui tu Clave",
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xff0A66BF),
                      fontWeight: FontWeight.w300),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: TextField(
                      controller: keyController,
                      style: const TextStyle(fontSize: 26),
                      textAlign: TextAlign.center,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        hintText: "Clave de enfermera",
                      ),
                      onChanged: (_) {
                        setState(() {});
                      }),
                ),
                if (isActive)
                  HeaderContent(
                    searchKey: keyController.text,
                    onKeyChanged: (String nurseId) {
                      setState(() {
                        keyController.text = nurseId;
                      });
                    },
                    onNurseSelected: widget.onNurseSelected,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
