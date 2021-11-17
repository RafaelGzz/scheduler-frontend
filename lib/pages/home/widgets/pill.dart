import 'package:flutter/material.dart';

class Pill extends StatelessWidget {
  const Pill({
    Key? key,
    required this.messages,
    required this.currentIndex,
    required this.pillPosition,
  }) : super(key: key);

  final List<String> messages;
  final int currentIndex;
  final double pillPosition;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(30),
            width: 700,
            height: 100,
            child: Text(
              messages[currentIndex],
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
        ),
      ),
      bottom: pillPosition,
      left: 0,
      right: 0,
      duration: Duration(milliseconds: 300),
    );
  }
}
