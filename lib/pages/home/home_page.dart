import 'package:flutter/material.dart';
import 'package:scheduler_frontend/models/nurse/nurse.dart';
import 'package:scheduler_frontend/pages/home/widgets/custom_carousel.dart';
import 'package:scheduler_frontend/pages/home/widgets/header.dart';
import 'package:scheduler_frontend/pages/home/widgets/pill.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Nurse? selectedNurse;

  int currentIndex = 0;
  double pillPosition = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'login');
        },
        child: const Icon(Icons.admin_panel_settings),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 768) {
            return _horizontalView(constraints);
          } else {
            return _verticalView(constraints);
          }
        },
      ),
    );
  }

  void changeCard(int index) async {
    setState(() {
      currentIndex = index;
      pillPosition = -10;
    });
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      pillPosition = 100;
    });
  }

  Widget _horizontalView(BoxConstraints constraints) {
    double partitionedWidth = constraints.maxWidth * .8;
    double headerViewWidth = partitionedWidth < 900 ? 900 : partitionedWidth;

    // double headerViewWidth = constraints.maxWidth - sideViewWidth;

    // double partitionedHeigth = constraints.maxHeight * .3;
    // // double headerViewHeigth = partitionedHeigth < 200 ? 200 : partitionedHeigth;

    List<String> messages = [
      "Hinchada de",
      "Tigres",
      "Cual es su profesion?",
      "la U la U la U",
      "Vamos Tigres",
      "Te quiero ver",
      "Campeoooon",
      "Otra vez"
    ];

    return SizedBox(
      height: constraints.maxHeight,
      child: Stack(
        children: [
          if (selectedNurse != null)
            Expanded(
              child: Center(
                child: Text(
                  selectedNurse!.name!,
                ),
              ),
            )
          else ...[
            CustomCarousel(onPageChanged: changeCard),
            Pill(
              messages: messages,
              currentIndex: currentIndex,
              pillPosition: pillPosition,
            ),
          ],
          Header(
            width: headerViewWidth,
            onNurseSelected: (Nurse nurse) {
              setState(() {
                selectedNurse = nurse;
              });
            },
          )
        ],
      ),
    );
  }

  Widget _verticalView(BoxConstraints constraints) {
    return Column();
  }
}
