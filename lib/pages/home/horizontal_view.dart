import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scheduler_frontend/models/nurse/nurse.dart';
import 'package:scheduler_frontend/pages/home/widgets/custom_carousel.dart';
import 'package:scheduler_frontend/pages/home/widgets/header.dart';
import 'package:scheduler_frontend/pages/home/widgets/loading_button.dart';
import 'package:scheduler_frontend/pages/home/widgets/pill.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class HorizontalView extends StatefulWidget {
  const HorizontalView({Key? key, this.constraints}) : super(key: key);
  final BoxConstraints? constraints;

  @override
  _HorizontalViewState createState() => _HorizontalViewState();
}

class _HorizontalViewState extends State<HorizontalView> {
  int currentIndex = 0;
  double pillPosition = 100;
  bool isCurrentCheckedIn = false;
  bool isInBreakTime = false;
  BoxConstraints? constraints;
  Nurse? selectedNurse;

  String? turnTime = "";
  String? breakTime = "";

  late StopWatchTimer _stopWatchTimerTurn; // Create instance.
  late StopWatchTimer _stopWatchTimerBreak; // Create instance.

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimerTurn.dispose(); // Need to call dispose function.
    await _stopWatchTimerBreak.dispose(); // Need to call dispose function.
  }

  @override
  void initState() {
    constraints = widget.constraints;
    _stopWatchTimerBreak = StopWatchTimer(
      onChange: (value) {
        setState(() {
          breakTime = StopWatchTimer.getDisplayTime(value, milliSecond: false);
        });
      },
    );
    _stopWatchTimerTurn = StopWatchTimer(
      onChange: (value) {
        setState(() {
          turnTime = StopWatchTimer.getDisplayTime(value, milliSecond: false);
        });
      },
    );
    super.initState();
  }

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
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.only(top: 220),
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
                      child: AnimatedSwitcher(
                        // transitionBuilder: (child, animation) => SizeTransition(
                        //   sizeFactor: animation,
                        //   child: child,
                        // ),
                        duration: const Duration(milliseconds: 200),
                        child: !isCurrentCheckedIn
                            ? LoadingButton(
                                label: "Iniciar Turno",
                                disabledColor: Colors.blue[300],
                                onComplete: () {
                                  setState(() {
                                    isCurrentCheckedIn = true;
                                    _stopWatchTimerTurn.onExecute
                                        .add(StopWatchExecute.start);
                                  });
                                },
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      LoadingButton(
                                        label: "Terminar Turno",
                                        activeColor: Colors.red[900],
                                        disabledColor: Colors.red[300],
                                        onComplete: () {
                                          setState(() {
                                            isCurrentCheckedIn = false;
                                          });
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(turnTime!,
                                            style:
                                                const TextStyle(fontSize: 27)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      LoadingButton(
                                        label: "Iniciar Descanso",
                                        activeColor: Colors.purple[900],
                                        disabledColor: Colors.purple[300],
                                        onComplete: () {
                                          setState(() {
                                            _stopWatchTimerBreak.onExecute
                                                .add(StopWatchExecute.start);
                                            _stopWatchTimerTurn.onExecute
                                                .add(StopWatchExecute.stop);
                                          });
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(breakTime!,
                                            style:
                                                const TextStyle(fontSize: 27)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      ),
                    ),
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
              setState(() {
                selectedNurse = nurse;
              });
            },
          )
        ],
      ),
    );
  }
}
