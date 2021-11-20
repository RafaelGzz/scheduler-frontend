import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler_frontend/models/nurse/nurse.dart';
import 'package:scheduler_frontend/pages/home/bloc/home_bloc.dart';
import 'package:scheduler_frontend/pages/home/widgets/custom_carousel.dart';
import 'package:scheduler_frontend/pages/home/widgets/header.dart';
import 'package:scheduler_frontend/pages/home/widgets/pill.dart';
import 'package:scheduler_frontend/pages/home/widgets/stop_watch_view.dart';

class HorizontalView extends StatefulWidget {
  const HorizontalView({Key? key, this.constraints}) : super(key: key);
  final BoxConstraints? constraints;

  @override
  _HorizontalViewState createState() => _HorizontalViewState();
}

class _HorizontalViewState extends State<HorizontalView> {
  int currentIndex = 0;
  double pillPosition = 100;
  BoxConstraints? constraints;
  Nurse? selectedNurse;

  HomeBloc get _bloc => context.read<HomeBloc>();

  @override
  void initState() {
    constraints = widget.constraints;
    super.initState();
  }

  // double headerViewWidth = constraints.maxWidth - sideViewWidth;

  // double partitionedHeigth = constraints.maxHeight * .3;
  // // double headerViewHeigth = partitionedHeigth < 200 ? 200 : partitionedHeigth;

  List<String> messages = [
    "Hospital",
    "Hospital",
    "Cual es su profesion?",
    "la U la U la U",
    "Vamos Tigres",
    "Te quiero ver",
    "Campeoooon",
    "Otra vez"
  ];

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

  @override
  Widget build(BuildContext context) {
    double partitionedWidth = constraints!.maxWidth * .8;
    double headerViewWidth = partitionedWidth < 900 ? 900 : partitionedWidth;
    return SizedBox(
      height: constraints?.maxHeight,
      child: Stack(
        children: [
          if (selectedNurse != null)
            Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  StopWatchView(
                    nurseId: selectedNurse!.nurseId!,
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 35, right: 35),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 80,
                                  spreadRadius: 1,
                                  color: Colors.black.withOpacity(.1),
                                )
                              ],
                            ),
                            child: Center(
                              child: Text(
                                selectedNurse!.name!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 35),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 80,
                                  spreadRadius: 1,
                                  color: Colors.black.withOpacity(.1),
                                )
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "10am - 5pm",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
              _bloc.add(NurseChange(nurseId: nurse.nurseId!));
              setState(() {
                if (selectedNurse != nurse) {
                  selectedNurse = nurse;
                }
              });
            },
          )
        ],
      ),
    );
  }
}