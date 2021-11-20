import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  const CustomInput(
      {Key? key, this.label, this.controller, this.disabled = false})
      : super(key: key);
  final String? label;
  final TextEditingController? controller;
  final bool? disabled;

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
        child: TextField(
          enabled: !widget.disabled!,
          controller: widget.controller,
          style: const TextStyle(fontSize: 18),
          autocorrect: false,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            labelText: widget.label,
            hintText: widget.label,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
