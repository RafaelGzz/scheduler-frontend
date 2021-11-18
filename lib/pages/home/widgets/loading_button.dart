import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  const LoadingButton({
    Key? key,
    required this.onComplete,
    required this.label,
    this.activeColor,
    this.disabledColor,
  }) : super(key: key);

  final Function onComplete;
  final String label;
  final Color? activeColor;
  final Color? disabledColor;

  @override
  LoadingButtonState createState() => LoadingButtonState();
}

class LoadingButtonState extends State<LoadingButton>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Color textColor = Colors.black;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    controller?.addListener(() {
      setState(() {});
      int value = ((controller?.value ?? 0) * 255).ceil();
      textColor = Color.fromRGBO(value, value, value, 1);
      print(value);
      print(textColor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapDown: (_) => controller?.forward(),
        onTapUp: (_) {
          if (controller?.status == AnimationStatus.forward) {
            controller?.reverse();
          }
          if (controller?.status == AnimationStatus.completed) {
            controller?.reset();
            widget.onComplete();
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  margin: const EdgeInsets.all(10),
                  height: 194,
                  width: 194,
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color:
                        widget.activeColor?.withOpacity(controller?.value ?? 0) ??
                            Colors.blue.withOpacity(controller?.value ?? 0),
                  ),
                ),
                SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    value: 1.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      widget.disabledColor ?? Colors.grey,
                    ),
                  ),
                  height: 200.0,
                  width: 200.0,
                ),
                SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    value: controller?.value,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      widget.activeColor ?? Colors.blue,
                    ),
                  ),
                  height: 200.0,
                  width: 200.0,
                ),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 20,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
