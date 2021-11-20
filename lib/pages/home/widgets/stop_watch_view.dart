import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler_frontend/models/nurse_status/nurse_status.dart';
import 'package:scheduler_frontend/pages/home/bloc/home_bloc.dart';
import 'package:scheduler_frontend/services/nurse_service.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'loading_button.dart';

class StopWatchView extends StatefulWidget {
  const StopWatchView({
    Key? key,
    required this.nurseId,
  }) : super(key: key);
  final int nurseId;

  @override
  _StopWatchViewState createState() => _StopWatchViewState();
}

class _StopWatchViewState extends State<StopWatchView> {
  late bool isCurrentCheckedIn;
  late bool isInBreakTime;
  NurseStatus? nurseStatus;
  late int nurseId;

  String? turnTime = "";
  String? breakTime = "";

  late DateTime msse;

  late StopWatchTimer _stopWatchTimerTurn; // Create instance.
  late StopWatchTimer _stopWatchTimerBreak; // Create instance.
  NurseService ns = NurseService();

  void _getNurseData({int? id}) {
    nurseStatus = ns.getNurseStatus(id ?? widget.nurseId);
    msse = DateTime.now();

    int breakHours;
    int workedHours;
    try {
      breakHours = (nurseStatus?.endBreak ?? msse)
          .difference(nurseStatus!.initBreak!)
          .inMilliseconds;
    } catch (e) {
      breakHours = 0;
    }

    try {
      workedHours = msse.difference(nurseStatus!.initTurn!).inMilliseconds;
    } catch (e) {
      workedHours = 0;
    }
    initializeTimers(
      autoStartBreakTime: nurseStatus?.breakRunning ?? false,
      autoStartTurnTime: nurseStatus?.turnRunning ?? false,
      startBreakTime: breakHours,
      startTurnTime: workedHours - breakHours,
    );
  }

  @override
  void didChangeDependencies() {
    _getNurseData();
    super.didChangeDependencies();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimerTurn.dispose(); // Need to call dispose function.
    await _stopWatchTimerBreak.dispose(); // Need to call dispose function.
  }

  void initializeTimers({
    int? startTurnTime,
    int? startBreakTime,
    bool autoStartTurnTime = false,
    bool autoStartBreakTime = false,
    bool setCheckedIn = true,
  }) {
    _stopWatchTimerBreak = StopWatchTimer(
      presetMillisecond: startBreakTime ?? 0,
      onChange: (value) {
        setState(() {
          breakTime = StopWatchTimer.getDisplayTime(value, milliSecond: false);
        });
      },
    );
    _stopWatchTimerTurn = StopWatchTimer(
      presetMillisecond: startTurnTime ?? 0,
      onChange: (value) {
        setState(() {
          turnTime = StopWatchTimer.getDisplayTime(value, milliSecond: false);
        });
      },
    );

    if (setCheckedIn) {
      if (autoStartTurnTime || autoStartBreakTime) {
        isCurrentCheckedIn = true;
        isInBreakTime = autoStartBreakTime;
      } else {
        isCurrentCheckedIn = false;
        isInBreakTime = false;
      }
    }

    if (autoStartTurnTime) {
      _stopWatchTimerTurn.onExecute.add(StopWatchExecute.start);
    } else {
      turnTime = StopWatchTimer.getDisplayTime(
        startTurnTime ?? 0,
        milliSecond: false,
      );
    }
    if (autoStartBreakTime) {
      _stopWatchTimerBreak.onExecute.add(StopWatchExecute.start);
    } else {
      breakTime = StopWatchTimer.getDisplayTime(
        startBreakTime ?? 0,
        milliSecond: false,
      );
    }
  }

  @override
  void initState() {
    nurseId = widget.nurseId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.status is NurseChanged) {
          _stopWatchTimerBreak.dispose();
          _stopWatchTimerTurn.dispose();
          nurseId = state.nurseId;

          if (nurseStatus != null) {
            ns.editNurseShift(
              nurseStatus!.shifts!.last.copyWith(
                turnRunning: !isInBreakTime,
                breakRunning: isInBreakTime,
                // totalBreakHours: breakHours,
                // totalWorkedHours: workedHours - breakHours,
              ),
              nurseStatus!.nurseId,
            );
          }
          _getNurseData(id: nurseId);
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => current.status is NurseChanged,
        builder: (context, state) {
          return Expanded(
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
                duration: const Duration(milliseconds: 200),
                child: !isCurrentCheckedIn
                    ? LoadingButton(
                        label: "Iniciar Turno",
                        disabledColor: Colors.blue[300],
                        onComplete: () {
                          setState(() {
                            isCurrentCheckedIn = true;
                          });
                          _stopWatchTimerBreak.dispose();
                          _stopWatchTimerTurn.dispose();

                          initializeTimers(setCheckedIn: false);

                          _stopWatchTimerTurn.onExecute
                              .add(StopWatchExecute.start);

                          if (nurseStatus == null) {
                            nurseStatus = NurseStatus(
                              nurseId: nurseId,
                              shifts: [Shift()],
                            );
                            ns.addNurseStatus = nurseStatus;
                          } else {
                            ns.addNurseShift(
                              nurseStatus!.nurseId,
                            );
                          }
                        },
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    isInBreakTime = false;
                                    _stopWatchTimerTurn.onExecute
                                        .add(StopWatchExecute.reset);
                                    _stopWatchTimerBreak.onExecute
                                        .add(StopWatchExecute.reset);
                                  });

                                  if (nurseStatus != null) {
                                    DateTime endDate = DateTime.now();

                                    ns.editNurseShift(
                                      nurseStatus!.shifts!.last
                                          .copyWith(endTurn: endDate),
                                      nurseId,
                                    );
                                  } else {
                                    print("no joto");
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  turnTime!,
                                  style: const TextStyle(fontSize: 27),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LoadingButton(
                                label: isInBreakTime
                                    ? "Detener Descanso"
                                    : "Iniciar Descanso",
                                activeColor: Colors.purple[900],
                                disabledColor: Colors.purple[300],
                                onComplete: () {
                                  if (!isInBreakTime) {
                                    setState(() {
                                      isInBreakTime = true;
                                      _stopWatchTimerBreak.onExecute
                                          .add(StopWatchExecute.start);
                                      _stopWatchTimerTurn.onExecute
                                          .add(StopWatchExecute.stop);
                                    });
                                    if (nurseStatus != null) {
                                      DateTime dateNow = DateTime.now();

                                      if (nurseStatus?.endBreak == null) {
                                        ns.editNurseShift(
                                          nurseStatus!.shifts!.last.copyWith(
                                            initBreak: dateNow,
                                            turnRunning: !isInBreakTime,
                                            breakRunning: isInBreakTime,
                                          ),
                                          nurseId,
                                        );
                                      } else {
                                        int breakHours = nurseStatus!.endBreak!
                                            .difference(nurseStatus!.initBreak!)
                                            .inMilliseconds;
                                        ns.editNurseShift(
                                          nurseStatus!.shifts!.last.copyWith(
                                            initBreak: dateNow,
                                            forceEndBreakNull: true,
                                            totalBreakHours: breakHours,
                                            turnRunning: !isInBreakTime,
                                            breakRunning: isInBreakTime,
                                          ),
                                          nurseId,
                                        );
                                      }
                                    } else {
                                      print("no joto");
                                    }
                                  } else {
                                    setState(() {
                                      isInBreakTime = false;
                                      _stopWatchTimerBreak.onExecute
                                          .add(StopWatchExecute.stop);
                                      _stopWatchTimerTurn.onExecute
                                          .add(StopWatchExecute.start);
                                    });
                                    if (nurseStatus != null) {
                                      DateTime nowMsse = DateTime.now();

                                      if (nurseStatus?.endBreak == null) {
                                        ns.editNurseShift(
                                          nurseStatus!.shifts!.last.copyWith(
                                            endBreak: nowMsse,
                                            turnRunning: !isInBreakTime,
                                            breakRunning: isInBreakTime,
                                          ),
                                          nurseId,
                                        );
                                      }
                                    } else {
                                      print("no joto");
                                    }
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(breakTime!,
                                    style: const TextStyle(fontSize: 27)),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
